Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbTFIN1D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 09:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264277AbTFIN1D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 09:27:03 -0400
Received: from relax.cmf.nrl.navy.mil ([134.207.10.227]:128 "EHLO
	relax.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S261852AbTFINZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 09:25:51 -0400
Date: Sun, 8 Jun 2003 21:51:21 -0400
From: chas williams <chas@cmf.nrl.navy.mil>
Message-Id: <200306090151.h591pLC07310@relax.cmf.nrl.navy.mil>
To: linux-kernel@vger.kernel.org
Subject: [RFC] assorted changes to atm protocol stack
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the following diff make the following changes:

- puts vcc's into a global list instead of per interface.
  it now has some of the typical functions like insert
  and remove that do the appropriate locking.  vcc
  destruction is handled via ref counts (making svc_close
  a touch easier to write).
- rename's various functions to vcc_ isntead of atm_ to
  better indicate their relationship.  eventually 
  most of the functions will be prefixed svc_, pvc_,
  vcc_, to atm_dev_.
- the he driver tries to do locking proper locking
  during the recv operation by holding a read_lock
  on the vcc sklist.  other drivers will need to do
  this as well.
- got rid of SOCKOPS_WRAPPED and would like someone to
  tell me if i have enough lock_sock()'s in place.
  i am probably missing one around the getsockopt's
  and sendmsg.  its being used to protect sock->state
  in sendmsg (et al) typically right?  and apparently
  the backlog counter in listen/accept.
- rewrote recvmsg to use the existing skb network
  functions.  i did rewrite sendmsg but that might
  need to wait since any skb from the network stack
  will need to be skb_clone'd and that means 
  changing some things i cant easily test (pppoatm,
  br2684, etc)
- split atm_ioctl into vcc_ioctl and atm_dev_ioctl.
  ATM_GETNAMES probably should be in atm_dev_ioctl
  though.  this would get almost all the atm_dev_lock
  references inside resources.c.
- should ATM_ITF_ANY go away?  its quite difficult to 
  do right.  if i put rtnl locks around device 
  registration then could i hold rtnl during device 
  open?  (while searching though the list) i cant hold
  atm_dev_lock since the device open might sleep.  on
  on the other hand, perhaps this idea should just go
  away.  no one uses it and it is perhaps 'useless'.
  (there is one possible use--'load balancing'.  
  however, this feature doesnt have any smarts. are
  all the interfaces the same speed?  are they all
  on the same atm network?  how should interfaces 
  be grouped?  and yes, we have a alpha version of
  load balancing here.)

other general comments welcome.

===== include/linux/atmdev.h 1.13 vs edited =====
--- 1.13/include/linux/atmdev.h	Thu May 15 20:20:17 2003
+++ edited/include/linux/atmdev.h	Sat Jun  7 11:38:22 2003
@@ -293,7 +293,6 @@
 	struct k_atm_aal_stats *stats;	/* pointer to AAL stats group */
 	wait_queue_head_t sleep;	/* if socket is busy */
 	struct sock	*sk;		/* socket backpointer */
-	struct atm_vcc	*prev,*next;
 	/* SVC part --- may move later ------------------------------------- */
 	short		itf;		/* interface number */
 	struct sockaddr_atmsvc local;
@@ -320,8 +319,6 @@
 					/* (NULL) */
 	const char	*type;		/* device type name */
 	int		number;		/* device index */
-	struct atm_vcc	*vccs;		/* VCC table (or NULL) */
-	struct atm_vcc	*last;		/* last VCC (or undefined) */
 	void		*dev_data;	/* per-device data */
 	void		*phy_data;	/* private PHY date */
 	unsigned long	flags;		/* device flags (ATM_DF_*) */
@@ -390,6 +387,9 @@
 	unsigned long	atm_options;	/* ATM layer options */
 };
 
+extern struct sock *vcc_sklist;
+extern rwlock_t vcc_sklist_lock;
+
 #define ATM_SKB(skb) (((struct atm_skb_data *) (skb)->cb))
 
 struct atm_dev *atm_dev_register(const char *type,const struct atmdev_ops *ops,
@@ -397,7 +397,8 @@
 struct atm_dev *atm_dev_lookup(int number);
 void atm_dev_deregister(struct atm_dev *dev);
 void shutdown_atm_dev(struct atm_dev *dev);
-void bind_vcc(struct atm_vcc *vcc,struct atm_dev *dev);
+void vcc_insert_socket(struct sock *sk);
+void vcc_remove_socket(struct sock *sk);
 
 
 /*
@@ -435,7 +436,7 @@
 }
 
 
-static inline void atm_dev_release(struct atm_dev *dev)
+static inline void atm_dev_put(struct atm_dev *dev)
 {
 	atomic_dec(&dev->refcnt);
 
@@ -443,6 +444,19 @@
 	    test_bit(ATM_DF_CLOSE,&dev->flags))
 		shutdown_atm_dev(dev);
 }
+
+
+static inline void vcc_hold(struct atm_vcc *vcc)
+{
+	sock_hold(vcc->sk);
+}
+
+
+static inline void vcc_put(struct atm_vcc *vcc)
+{
+	sock_put(vcc->sk);
+}
+
 
 
 int atm_charge(struct atm_vcc *vcc,int truesize);
===== net/atm/atm_misc.c 1.3 vs edited =====
--- 1.3/net/atm/atm_misc.c	Thu May 15 20:20:17 2003
+++ edited/net/atm/atm_misc.c	Sat Jun  7 11:38:23 2003
@@ -45,15 +45,20 @@
 
 static int check_ci(struct atm_vcc *vcc,short vpi,int vci)
 {
+	struct sock *s;
 	struct atm_vcc *walk;
 
-	for (walk = vcc->dev->vccs; walk; walk = walk->next)
+	for (s = vcc_sklist; s; s = s->next) {
+		walk = atm_sk(s);
+		if (walk->dev != vcc->dev)
+			continue;
 		if (test_bit(ATM_VF_ADDR,&walk->flags) && walk->vpi == vpi &&
 		    walk->vci == vci && ((walk->qos.txtp.traffic_class !=
 		    ATM_NONE && vcc->qos.txtp.traffic_class != ATM_NONE) ||
 		    (walk->qos.rxtp.traffic_class != ATM_NONE &&
 		    vcc->qos.rxtp.traffic_class != ATM_NONE)))
 			return -EADDRINUSE;
+	}
 		/* allow VCCs with same VPI/VCI iff they don't collide on
 		   TX/RX (but we may refuse such sharing for other reasons,
 		   e.g. if protocol requires to have both channels) */
@@ -63,17 +68,16 @@
 
 int atm_find_ci(struct atm_vcc *vcc,short *vpi,int *vci)
 {
-	unsigned long flags;
 	static short p = 0; /* poor man's per-device cache */
 	static int c = 0;
 	short old_p;
 	int old_c;
 	int err;
 
-	spin_lock_irqsave(&vcc->dev->lock, flags);
+	read_lock(&vcc_sklist_lock);
 	if (*vpi != ATM_VPI_ANY && *vci != ATM_VCI_ANY) {
 		err = check_ci(vcc,*vpi,*vci);
-		spin_unlock_irqrestore(&vcc->dev->lock, flags);
+		read_unlock(&vcc_sklist_lock);
 		return err;
 	}
 	/* last scan may have left values out of bounds for current device */
@@ -88,7 +92,7 @@
 		if (!check_ci(vcc,p,c)) {
 			*vpi = p;
 			*vci = c;
-			spin_unlock_irqrestore(&vcc->dev->lock, flags);
+			read_unlock(&vcc_sklist_lock);
 			return 0;
 		}
 		if (*vci == ATM_VCI_ANY) {
@@ -103,7 +107,7 @@
 		}
 	}
 	while (old_p != p || old_c != c);
-	spin_unlock_irqrestore(&vcc->dev->lock, flags);
+	read_unlock(&vcc_sklist_lock);
 	return -EADDRINUSE;
 }
 
===== net/atm/clip.c 1.12 vs edited =====
--- 1.12/net/atm/clip.c	Thu May 15 20:20:17 2003
+++ edited/net/atm/clip.c	Sat Jun  7 11:38:23 2003
@@ -737,7 +737,8 @@
 	set_bit(ATM_VF_META,&vcc->flags);
 	set_bit(ATM_VF_READY,&vcc->flags);
 	    /* allow replies and avoid getting closed if signaling dies */
-	bind_vcc(vcc,&atmarpd_dev);
+	vcc->dev = &atmarpd_dev;
+	vcc_insert_socket(vcc->sk);
 	vcc->push = NULL;
 	vcc->pop = NULL; /* crash */
 	vcc->push_oam = NULL; /* crash */
===== net/atm/common.c 1.28 vs edited =====
--- 1.28/net/atm/common.c	Sat Jun  7 10:53:52 2003
+++ edited/net/atm/common.c	Sun Jun  8 13:53:26 2003
@@ -11,7 +11,6 @@
 #include <linux/atmdev.h>
 #include <linux/atmclip.h>	/* CLIP_*ENCAP */
 #include <linux/atmarp.h>	/* manifest constants */
-#include <linux/sonet.h>	/* for ioctls */
 #include <linux/socket.h>	/* SOL_SOCKET */
 #include <linux/errno.h>	/* error codes */
 #include <linux/capability.h>
@@ -157,6 +156,38 @@
 #endif
 
 
+struct sock *vcc_sklist;
+rwlock_t vcc_sklist_lock = RW_LOCK_UNLOCKED;
+
+void __vcc_insert_socket(struct sock *sk)
+{
+	sk->next = vcc_sklist;
+	if (sk->next)
+		vcc_sklist->pprev = &sk->next;
+	vcc_sklist = sk;
+	sk->pprev = &vcc_sklist;
+}
+
+void vcc_insert_socket(struct sock *sk)
+{
+	write_lock_irq(&vcc_sklist_lock);
+	__vcc_insert_socket(sk);
+	write_unlock_irq(&vcc_sklist_lock);
+}
+
+void vcc_remove_socket(struct sock *sk)
+{
+	write_lock_irq(&vcc_sklist_lock);
+	if (sk->pprev) {
+		if (sk->next)
+			sk->next->pprev = sk->pprev;
+		*sk->pprev = sk->next;
+		sk->pprev = NULL;
+	}
+	write_unlock_irq(&vcc_sklist_lock);
+}
+
+
 static struct sk_buff *alloc_tx(struct atm_vcc *vcc,unsigned int size)
 {
 	struct sk_buff *skb;
@@ -172,24 +203,51 @@
 	return skb;
 }
 
+EXPORT_SYMBOL(vcc_sklist);
+EXPORT_SYMBOL(vcc_sklist_lock);
+EXPORT_SYMBOL(vcc_insert_socket);
+EXPORT_SYMBOL(vcc_remove_socket);
 
-int atm_create(struct socket *sock,int protocol,int family)
+static void vcc_sock_destruct(struct sock *sk)
+{
+	struct atm_vcc *vcc = atm_sk(sk);
+
+
+	if (atomic_read(&vcc->sk->rmem_alloc))
+		printk(KERN_DEBUG "vcc_sock_destruct: rmem leakage (%d bytes) detected.\n", atomic_read(&sk->rmem_alloc));
+
+	if (atomic_read(&vcc->sk->wmem_alloc))
+		printk(KERN_DEBUG "vcc_sock_destruct: wmem leakage (%d bytes) detected.\n", atomic_read(&sk->wmem_alloc));
+
+	kfree(sk->protinfo);
+}
+
+int vcc_create(struct socket *sock, int protocol, int family)
 {
 	struct sock *sk;
 	struct atm_vcc *vcc;
 
 	sock->sk = NULL;
-	if (sock->type == SOCK_STREAM) return -EINVAL;
-	if (!(sk = alloc_atm_vcc_sk(family))) return -ENOMEM;
-	vcc = atm_sk(sk);
-	memset(&vcc->flags,0,sizeof(vcc->flags));
+	if (sock->type == SOCK_STREAM)
+		return -EINVAL;
+	sk = sk_alloc(family, GFP_KERNEL, 1, NULL);
+	if (!sk)
+		return -ENOMEM;
+	sock_init_data(NULL, sk);
+
+	vcc = atm_sk(sk) = kmalloc(sizeof(*vcc), GFP_KERNEL);
+	if (!vcc) {
+		sk_free(sk);
+		return -ENOMEM;
+	}
+
+	memset(vcc, 0, sizeof(*vcc));
+	vcc->sk = sk;
 	vcc->dev = NULL;
 	vcc->callback = NULL;
 	memset(&vcc->local,0,sizeof(struct sockaddr_atmsvc));
 	memset(&vcc->remote,0,sizeof(struct sockaddr_atmsvc));
 	vcc->qos.txtp.max_sdu = 1 << 16; /* for meta VCs */
-	atomic_set(&vcc->sk->wmem_alloc,0);
-	atomic_set(&vcc->sk->rmem_alloc,0);
 	vcc->push = NULL;
 	vcc->pop = NULL;
 	vcc->push_oam = NULL;
@@ -197,42 +255,49 @@
 	vcc->atm_options = vcc->aal_options = 0;
 	init_waitqueue_head(&vcc->sleep);
 	sk->sleep = &vcc->sleep;
+	sk->destruct = vcc_sock_destruct;
 	sock->sk = sk;
 	return 0;
 }
 
 
-void atm_release_vcc_sk(struct sock *sk,int free_sk)
+static void vcc_destroy_socket(struct sock *sk)
 {
 	struct atm_vcc *vcc = atm_sk(sk);
 	struct sk_buff *skb;
 
-	clear_bit(ATM_VF_READY,&vcc->flags);
+	clear_bit(ATM_VF_READY, &vcc->flags);
 	if (vcc->dev) {
-		if (vcc->dev->ops->close) vcc->dev->ops->close(vcc);
-		if (vcc->push) vcc->push(vcc,NULL); /* atmarpd has no push */
+		if (vcc->dev->ops->close)
+			vcc->dev->ops->close(vcc);
+		if (vcc->push)
+			vcc->push(vcc, NULL); /* atmarpd has no push */
+
+		vcc_remove_socket(sk);	/* no more receive */
+
 		while ((skb = skb_dequeue(&vcc->sk->receive_queue))) {
 			atm_return(vcc,skb->truesize);
 			kfree_skb(skb);
 		}
 
 		module_put(vcc->dev->ops->owner);
-		atm_dev_release(vcc->dev);
-		if (atomic_read(&vcc->sk->rmem_alloc))
-			printk(KERN_WARNING "atm_release_vcc: strange ... "
-			    "rmem_alloc == %d after closing\n",
-			    atomic_read(&vcc->sk->rmem_alloc));
-		bind_vcc(vcc,NULL);
+		atm_dev_put(vcc->dev);
 	}
-
-	if (free_sk) free_atm_vcc_sk(sk);
 }
 
 
-int atm_release(struct socket *sock)
+int vcc_release(struct socket *sock)
 {
-	if (sock->sk)
-		atm_release_vcc_sk(sock->sk,1);
+	struct sock *sk = sock->sk;
+
+	if (sk) {
+		sock_orphan(sk);
+		lock_sock(sk);
+		vcc_destroy_socket(sock->sk);
+		release_sock(sk);
+		sock_put(sk);
+	}
+
 	return 0;
 }
 
@@ -241,6 +306,7 @@
 {
 	set_bit(ATM_VF_CLOSE,&vcc->flags);
 	vcc->reply = reply;
+	vcc->sk->err = EPIPE;
 	wake_up(&vcc->sleep);
 }
 
@@ -274,8 +340,7 @@
 }
 
 
-static int atm_do_connect_dev(struct atm_vcc *vcc,struct atm_dev *dev,int vpi,
-    int vci)
+static int __vcc_connect(struct atm_vcc *vcc, struct atm_dev *dev, int vpi, int vci)
 {
 	int error;
 
@@ -286,7 +351,8 @@
 	if (vci > 0 && vci < ATM_NOT_RSV_VCI && !capable(CAP_NET_BIND_SERVICE))
 		return -EPERM;
 	error = 0;
-	bind_vcc(vcc,dev);
+	vcc->dev = dev;
+	vcc_insert_socket(vcc->sk);
 	switch (vcc->qos.aal) {
 		case ATM_AAL0:
 			error = atm_init_aal0(vcc);
@@ -307,10 +373,12 @@
 		default:
 			error = -EPROTOTYPE;
 	}
-	if (!error) error = adjust_tp(&vcc->qos.txtp,vcc->qos.aal);
-	if (!error) error = adjust_tp(&vcc->qos.rxtp,vcc->qos.aal);
+	if (!error)
+		error = adjust_tp(&vcc->qos.txtp,vcc->qos.aal);
+	if (!error)
+		error = adjust_tp(&vcc->qos.rxtp,vcc->qos.aal);
 	if (error) {
-		bind_vcc(vcc,NULL);
+		vcc_remove_socket(vcc->sk);
 		return error;
 	}
 	DPRINTK("VCC %d.%d, AAL %d\n",vpi,vci,vcc->qos.aal);
@@ -324,7 +392,7 @@
 		error = dev->ops->open(vcc,vpi,vci);
 		if (error) {
 			module_put(dev->ops->owner);
-			bind_vcc(vcc,NULL);
+			vcc_remove_socket(vcc->sk);
 			return error;
 		}
 	}
@@ -332,29 +400,27 @@
 }
 
 
-static int atm_do_connect(struct atm_vcc *vcc,int itf,int vpi,int vci)
+int vcc_connect(struct socket *sock, int itf, short vpi, int vci)
 {
+	int error;
 	struct atm_dev *dev;
-	int return_val;
-
-	dev = atm_dev_lookup(itf);
-	if (!dev)
-		return_val =  -ENODEV;
-	else {
-		return_val = atm_do_connect_dev(vcc,dev,vpi,vci);
-		if (return_val) atm_dev_release(dev);
-	}
-
-	return return_val;
-}
+	struct atm_vcc *vcc = ATM_SD(sock);
 
+	DPRINTK("atm_connect (vpi %d, vci %d)\n",vpi,vci);
+	if (sock->state == SS_CONNECTED)
+		return -EISCONN;
+	if (sock->state != SS_UNCONNECTED)
+		return -EINVAL;
+	if (!(vpi || vci))
+		return -EINVAL;
 
-int atm_connect_vcc(struct atm_vcc *vcc,int itf,short vpi,int vci)
-{
 	if (vpi != ATM_VPI_UNSPEC && vci != ATM_VCI_UNSPEC)
-		clear_bit(ATM_VF_PARTIAL,&vcc->flags);
-	else if (test_bit(ATM_VF_PARTIAL,&vcc->flags)) return -EINVAL;
-	DPRINTK("atm_connect (TX: cl %d,bw %d-%d,sdu %d; "
+		clear_bit(ATM_VF_PARTIAL, &vcc->flags);
+	else
+		if (test_bit(ATM_VF_PARTIAL, &vcc->flags))
+			return -EINVAL;
+
+	DPRINTK("vcc_connect (TX: cl %d,bw %d-%d,sdu %d; "
 	    "RX: cl %d,bw %d-%d,sdu %d,AAL %s%d)\n",
 	    vcc->qos.txtp.traffic_class,vcc->qos.txtp.min_pcr,
 	    vcc->qos.txtp.max_pcr,vcc->qos.txtp.max_sdu,
@@ -366,107 +432,86 @@
 	if (vcc->qos.txtp.traffic_class == ATM_ANYCLASS ||
 	    vcc->qos.rxtp.traffic_class == ATM_ANYCLASS)
 		return -EINVAL;
-	if (itf != ATM_ITF_ANY) {
-		int error;
 
-		error = atm_do_connect(vcc,itf,vpi,vci);
-		if (error) return error;
-	}
-	else {
-		struct atm_dev *dev = NULL;
+	if (itf != ATM_ITF_ANY) {
+		dev = atm_dev_lookup(itf);
+		error = __vcc_connect(vcc, dev, vpi, vci);
+		if (error) {
+			atm_dev_put(dev);
+			return error;
+		}
+	} else {
+		printk(KERN_ERR "vcc_connect(): used obselete ATM_ITF_ANY\n");
+		return -ENODEV;
+#ifdef obselete /* not particularly meaingful really */
 		struct list_head *p, *next;
 
 		spin_lock(&atm_dev_lock);
+		dev = NULL;
 		list_for_each_safe(p, next, &atm_devs) {
 			dev = list_entry(p, struct atm_dev, dev_list);
 			atm_dev_hold(dev);
 			spin_unlock(&atm_dev_lock);
-			if (!atm_do_connect_dev(vcc,dev,vpi,vci))
+			if (!__vcc_connect(vcc, dev, vpi, vci))
 				break;
-			atm_dev_release(dev);
+			atm_dev_put(dev);
 			dev = NULL;
 			spin_lock(&atm_dev_lock);
 		}
 		spin_unlock(&atm_dev_lock);
-		if (!dev) return -ENODEV;
+		if (!dev)
+			return -ENODEV;
+#endif
 	}
+
 	if (vpi == ATM_VPI_UNSPEC || vci == ATM_VCI_UNSPEC)
 		set_bit(ATM_VF_PARTIAL,&vcc->flags);
-	return 0;
-}
-
-
-int atm_connect(struct socket *sock,int itf,short vpi,int vci)
-{
-	int error;
-
-	DPRINTK("atm_connect (vpi %d, vci %d)\n",vpi,vci);
-	if (sock->state == SS_CONNECTED) return -EISCONN;
-	if (sock->state != SS_UNCONNECTED) return -EINVAL;
-	if (!(vpi || vci)) return -EINVAL;
-	error = atm_connect_vcc(ATM_SD(sock),itf,vpi,vci);
-	if (error) return error;
 	if (test_bit(ATM_VF_READY,&ATM_SD(sock)->flags))
 		sock->state = SS_CONNECTED;
 	return 0;
 }
 
 
-int atm_recvmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *m,
-		int total_len, int flags)
+int vcc_recvmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *msg,
+		int size, int flags)
 {
-	DECLARE_WAITQUEUE(wait,current);
+	struct sock *sk = sock->sk;
 	struct atm_vcc *vcc;
 	struct sk_buff *skb;
-	int eff_len,error;
-	void *buff;
-	int size;
+	int copied, error = -EINVAL;
 
-	if (sock->state != SS_CONNECTED) return -ENOTCONN;
-	if (flags & ~MSG_DONTWAIT) return -EOPNOTSUPP;
-	if (m->msg_iovlen != 1) return -ENOSYS; /* fix this later @@@ */
-	buff = m->msg_iov->iov_base;
-	size = m->msg_iov->iov_len;
+	if (sock->state != SS_CONNECTED)
+		return -ENOTCONN;
+	if (flags & ~MSG_DONTWAIT)	/* only handle MSG_DONTWAIT */
+		return -EOPNOTSUPP;
 	vcc = ATM_SD(sock);
-	add_wait_queue(&vcc->sleep,&wait);
-	set_current_state(TASK_INTERRUPTIBLE);
-	error = 1; /* <= 0 is error */
-	while (!(skb = skb_dequeue(&vcc->sk->receive_queue))) {
-		if (test_bit(ATM_VF_RELEASED,&vcc->flags) ||
-		    test_bit(ATM_VF_CLOSE,&vcc->flags)) {
-			error = vcc->reply;
-			break;
-		}
-		if (!test_bit(ATM_VF_READY,&vcc->flags)) {
-			error = 0;
-			break;
-		}
-		if (flags & MSG_DONTWAIT) {
-			error = -EAGAIN;
-			break;
-		}
-		schedule();
-		set_current_state(TASK_INTERRUPTIBLE);
-		if (signal_pending(current)) {
-			error = -ERESTARTSYS;
-			break;
-		}
+	if (test_bit(ATM_VF_RELEASED,&vcc->flags) ||
+	    test_bit(ATM_VF_CLOSE,&vcc->flags)) {
+		return vcc->reply;
 	}
-	set_current_state(TASK_RUNNING);
-	remove_wait_queue(&vcc->sleep,&wait);
-	if (error <= 0) return error;
-	sock_recv_timestamp(m, vcc->sk, skb);
-	eff_len = skb->len > size ? size : skb->len;
-	if (skb->len > size) /* Not fit ?  Report it... */
-		m->msg_flags |= MSG_TRUNC;
+	if (!test_bit(ATM_VF_READY, &vcc->flags))	/* ??? */
+		return 0;
+	skb = skb_recv_datagram(sk, flags, flags & MSG_DONTWAIT, &error);
+	if (!skb)
+		return error;
+
+	copied = skb->len;
+	if (copied > size) {
+		copied = size;
+		msg->msg_flags |= MSG_TRUNC;
+	}
+
+	error = skb_copy_datagram_iovec(skb, 0, msg->msg_iov, copied);
+	if (error)
+		return error;
+	sock_recv_timestamp(msg, sk, skb);
 	if (vcc->dev->ops->feedback)
-		vcc->dev->ops->feedback(vcc,skb,(unsigned long) skb->data,
-		    (unsigned long) buff,eff_len);
-	DPRINTK("RcvM %d -= %d\n",atomic_read(&vcc->sk->rmem_alloc),skb->truesize);
-	atm_return(vcc,skb->truesize);
-	error = copy_to_user(buff,skb->data,eff_len) ? -EFAULT : 0;
-	kfree_skb(skb);
-	return error ? error : eff_len;
+		vcc->dev->ops->feedback(vcc, skb, (unsigned long) skb->data,
+		    (unsigned long) msg->msg_iov->iov_base, copied);
+	DPRINTK("RcvM %d -= %d\n", atomic_read(&vcc->sk->rmem_alloc), skb->truesize);
+	atm_return(vcc, skb->truesize);
+	skb_free_datagram(sk, skb);
+	return copied;
 }
 
 
@@ -559,50 +604,16 @@
 }
 
 
-static void copy_aal_stats(struct k_atm_aal_stats *from,
-    struct atm_aal_stats *to)
-{
-#define __HANDLE_ITEM(i) to->i = atomic_read(&from->i)
-	__AAL_STAT_ITEMS
-#undef __HANDLE_ITEM
-}
-
-
-static void subtract_aal_stats(struct k_atm_aal_stats *from,
-    struct atm_aal_stats *to)
-{
-#define __HANDLE_ITEM(i) atomic_sub(to->i,&from->i)
-	__AAL_STAT_ITEMS
-#undef __HANDLE_ITEM
-}
-
-
-static int fetch_stats(struct atm_dev *dev,struct atm_dev_stats *arg,int zero)
-{
-	struct atm_dev_stats tmp;
-	int error = 0;
-
-	copy_aal_stats(&dev->stats.aal0,&tmp.aal0);
-	copy_aal_stats(&dev->stats.aal34,&tmp.aal34);
-	copy_aal_stats(&dev->stats.aal5,&tmp.aal5);
-	if (arg) error = copy_to_user(arg,&tmp,sizeof(tmp));
-	if (zero && !error) {
-		subtract_aal_stats(&dev->stats.aal0,&tmp.aal0);
-		subtract_aal_stats(&dev->stats.aal34,&tmp.aal34);
-		subtract_aal_stats(&dev->stats.aal5,&tmp.aal5);
-	}
-	return error ? -EFAULT : 0;
-}
 
 
-int atm_ioctl(struct socket *sock,unsigned int cmd,unsigned long arg)
+int vcc_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 {
 	struct atm_dev *dev;
 	struct list_head *p;
 	struct atm_vcc *vcc;
 	int *tmp_buf, *tmp_p;
 	void *buf;
-	int error,len,size,number, ret_val;
+	int error, len, size, ret_val;
 
 	ret_val = 0;
 	vcc = ATM_SD(sock);
@@ -895,167 +906,7 @@
 			goto done;
 	}
 #endif
-	if (get_user(buf,&((struct atmif_sioc *) arg)->arg)) {
-		ret_val = -EFAULT;
-		goto done;
-	}
-	if (get_user(len,&((struct atmif_sioc *) arg)->length)) {
-		ret_val = -EFAULT;
-		goto done;
-	}
-	if (get_user(number,&((struct atmif_sioc *) arg)->number)) {
-		ret_val = -EFAULT;
-		goto done;
-	}
-	if (!(dev = atm_dev_lookup(number))) {
-		ret_val = -ENODEV;
-		goto done;
-	}
-	
-	size = 0;
-	switch (cmd) {
-		case ATM_GETTYPE:
-			size = strlen(dev->type)+1;
-			if (copy_to_user(buf,dev->type,size)) {
-				ret_val = -EFAULT;
-				goto done_release;
-			}
-			break;
-		case ATM_GETESI:
-			size = ESI_LEN;
-			if (copy_to_user(buf,dev->esi,size)) {
-				ret_val = -EFAULT;
-				goto done_release;
-			}
-			break;
-		case ATM_SETESI:
-			{
-				int i;
-
-				for (i = 0; i < ESI_LEN; i++)
-					if (dev->esi[i]) {
-						ret_val = -EEXIST;
-						goto done_release;
-					}
-			}
-			/* fall through */
-		case ATM_SETESIF:
-			{
-				unsigned char esi[ESI_LEN];
-
-				if (!capable(CAP_NET_ADMIN)) {
-					ret_val = -EPERM;
-					goto done_release;
-				}
-				if (copy_from_user(esi,buf,ESI_LEN)) {
-					ret_val = -EFAULT;
-					goto done_release;
-				}
-				memcpy(dev->esi,esi,ESI_LEN);
-				ret_val =  ESI_LEN;
-				goto done_release;
-			}
-		case ATM_GETSTATZ:
-			if (!capable(CAP_NET_ADMIN)) {
-				ret_val = -EPERM;
-				goto done_release;
-			}
-			/* fall through */
-		case ATM_GETSTAT:
-			size = sizeof(struct atm_dev_stats);
-			error = fetch_stats(dev,buf,cmd == ATM_GETSTATZ);
-			if (error) {
-				ret_val = error;
-				goto done_release;
-			}
-			break;
-		case ATM_GETCIRANGE:
-			size = sizeof(struct atm_cirange);
-			if (copy_to_user(buf,&dev->ci_range,size)) {
-				ret_val = -EFAULT;
-				goto done_release;
-			}
-			break;
-		case ATM_GETLINKRATE:
-			size = sizeof(int);
-			if (copy_to_user(buf,&dev->link_rate,size)) {
-				ret_val = -EFAULT;
-				goto done_release;
-			}
-			break;
-		case ATM_RSTADDR:
-			if (!capable(CAP_NET_ADMIN)) {
-				ret_val = -EPERM;
-				goto done_release;
-			}
-			atm_reset_addr(dev);
-			break;
-		case ATM_ADDADDR:
-		case ATM_DELADDR:
-			if (!capable(CAP_NET_ADMIN)) {
-				ret_val = -EPERM;
-				goto done_release;
-			}
-			{
-				struct sockaddr_atmsvc addr;
-
-				if (copy_from_user(&addr,buf,sizeof(addr))) {
-					ret_val = -EFAULT;
-					goto done_release;
-				}
-				if (cmd == ATM_ADDADDR)
-					ret_val = atm_add_addr(dev,&addr);
-				else
-					ret_val = atm_del_addr(dev,&addr);
-				goto done_release;
-			}
-		case ATM_GETADDR:
-			size = atm_get_addr(dev,buf,len);
-			if (size < 0)
-				ret_val = size;
-			else
-			/* may return 0, but later on size == 0 means "don't
-			   write the length" */
-				ret_val = put_user(size,
-						   &((struct atmif_sioc *) arg)->length) ? -EFAULT : 0;
-			goto done_release;
-		case ATM_SETLOOP:
-			if (__ATM_LM_XTRMT((int) (long) buf) &&
-			    __ATM_LM_XTLOC((int) (long) buf) >
-			    __ATM_LM_XTRMT((int) (long) buf)) {
-				ret_val = -EINVAL;
-				goto done_release;
-			}
-			/* fall through */
-		case ATM_SETCIRANGE:
-		case SONET_GETSTATZ:
-		case SONET_SETDIAG:
-		case SONET_CLRDIAG:
-		case SONET_SETFRAMING:
-			if (!capable(CAP_NET_ADMIN)) {
-				ret_val = -EPERM;
-				goto done_release;
-			}
-			/* fall through */
-		default:
-			if (!dev->ops->ioctl) {
-				ret_val = -EINVAL;
-				goto done_release;
-			}
-			size = dev->ops->ioctl(dev,cmd,buf);
-			if (size < 0) {
-				ret_val = (size == -ENOIOCTLCMD ? -EINVAL : size);
-				goto done_release;
-			}
-	}
-	
-	if (size)
-		ret_val =  put_user(size,&((struct atmif_sioc *) arg)->length) ?
-			-EFAULT : 0;
-	else
-		ret_val = 0;
-done_release:
-	atm_dev_release(dev);
+	ret_val = atm_dev_ioctl(cmd, arg);
 
 done:
 	return ret_val;
@@ -1117,12 +968,17 @@
 }
 
 
-static int atm_do_setsockopt(struct socket *sock,int level,int optname,
-    void *optval,int optlen)
+
+
+int vcc_setsockopt(struct socket *sock,int level,int optname,char *optval,
+    int optlen)
 {
 	struct atm_vcc *vcc;
 	unsigned long value;
-	int error;
+	int error = 0;
+
+	if (__SO_LEVEL_MATCH(optname, level) && optlen != __SO_SIZE(optname))
+		return -EINVAL;
 
 	vcc = ATM_SD(sock);
 	switch (optname) {
@@ -1133,26 +989,31 @@
 				if (copy_from_user(&qos,optval,sizeof(qos)))
 					return -EFAULT;
 				error = check_qos(&qos);
-				if (error) return error;
+				if (error)
+					return error;
 				if (sock->state == SS_CONNECTED)
-					return atm_change_qos(vcc,&qos);
+					return atm_change_qos(vcc, &qos);
 				if (sock->state != SS_UNCONNECTED)
 					return -EBADFD;
 				vcc->qos = qos;
-				set_bit(ATM_VF_HASQOS,&vcc->flags);
+				set_bit(ATM_VF_HASQOS, &vcc->flags);
 				return 0;
 			}
 		case SO_SETCLP:
-			if (get_user(value,(unsigned long *) optval))
+			if (get_user(value, (unsigned long *) optval))
 				return -EFAULT;
-			if (value) vcc->atm_options |= ATM_ATMOPT_CLP;
-			else vcc->atm_options &= ~ATM_ATMOPT_CLP;
+			if (value)
+				vcc->atm_options |= ATM_ATMOPT_CLP;
+			else
+				vcc->atm_options &= ~ATM_ATMOPT_CLP;
 			return 0;
 		default:
-			if (level == SOL_SOCKET) return -EINVAL;
+			if (level == SOL_SOCKET)
+				return -EINVAL;
 			break;
 	}
-	if (!vcc->dev || !vcc->dev->ops->setsockopt) return -EINVAL;
+	if (!vcc->dev || !vcc->dev->ops->setsockopt)
+		return -EINVAL;
 	return vcc->dev->ops->setsockopt(vcc,level,optname,optval,optlen);
 }
 
@@ -1192,15 +1053,6 @@
 	}
 	if (!vcc->dev || !vcc->dev->ops->getsockopt) return -EINVAL;
 	return vcc->dev->ops->getsockopt(vcc,level,optname,optval,optlen);
-}
-
-
-int atm_setsockopt(struct socket *sock,int level,int optname,char *optval,
-    int optlen)
-{
-	if (__SO_LEVEL_MATCH(optname, level) && optlen != __SO_SIZE(optname))
-		return -EINVAL;
-	return atm_do_setsockopt(sock,level,optname,optval,optlen);
 }
 
 
===== net/atm/common.h 1.4 vs edited =====
--- 1.4/net/atm/common.h	Fri May 16 00:12:28 2003
+++ edited/net/atm/common.h	Sun Jun  8 08:58:22 2003
@@ -10,22 +10,21 @@
 #include <linux/poll.h> /* for poll_table */
 
 
-int atm_create(struct socket *sock,int protocol,int family);
-int atm_release(struct socket *sock);
-int atm_connect(struct socket *sock,int itf,short vpi,int vci);
-int atm_recvmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *m,
+void __vcc_insert_socket(struct sock *sk);
+int vcc_create(struct socket *sock, int protocol, int family);
+int vcc_release(struct socket *sock);
+int vcc_connect(struct socket *sock,int itf,short vpi,int vci);
+int vcc_recvmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *m,
 		int total_len, int flags);
 int atm_sendmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *m,
 		int total_len);
 unsigned int atm_poll(struct file *file,struct socket *sock,poll_table *wait);
-int atm_ioctl(struct socket *sock,unsigned int cmd,unsigned long arg);
-int atm_setsockopt(struct socket *sock,int level,int optname,char *optval,
+int vcc_ioctl(struct socket *sock,unsigned int cmd,unsigned long arg);
+int vcc_setsockopt(struct socket *sock, int level, int optname, char *optval,
     int optlen);
 int atm_getsockopt(struct socket *sock,int level,int optname,char *optval,
     int *optlen);
 
-int atm_connect_vcc(struct atm_vcc *vcc,int itf,short vpi,int vci);
-void atm_release_vcc_sk(struct sock *sk,int free_sk);
 void atm_shutdown_dev(struct atm_dev *dev);
 
 int atmpvc_init(void);
===== net/atm/lec.c 1.23 vs edited =====
--- 1.23/net/atm/lec.c	Sun May 18 18:23:52 2003
+++ edited/net/atm/lec.c	Sat Jun  7 11:38:25 2003
@@ -48,7 +48,7 @@
 
 #include "lec.h"
 #include "lec_arpc.h"
-#include "resources.h"  /* for bind_vcc() */
+#include "resources.h"
 
 #if 0
 #define DPRINTK printk
@@ -810,7 +810,8 @@
         lec_arp_init(priv);
 	priv->itfnum = i;  /* LANE2 addition */
         priv->lecd = vcc;
-        bind_vcc(vcc, &lecatm_dev);
+        vcc->dev = &lecatm_dev;
+        vcc_insert_socket(vcc->sk);
         
         vcc->proto_data = dev_lec[i];
 	set_bit(ATM_VF_META,&vcc->flags);
===== net/atm/mpc.c 1.16 vs edited =====
--- 1.16/net/atm/mpc.c	Sun May 18 18:26:13 2003
+++ edited/net/atm/mpc.c	Sat Jun  7 11:38:26 2003
@@ -28,7 +28,7 @@
 
 #include "lec.h"
 #include "mpc.h"
-#include "resources.h"  /* for bind_vcc() */
+#include "resources.h"
 
 /*
  * mpc.c: Implementation of MPOA client kernel part 
@@ -788,7 +788,8 @@
 	}
 
 	mpc->mpoad_vcc = vcc;
-	bind_vcc(vcc, &mpc_dev);
+	vcc->dev = &mpc_dev;
+	vcc_insert_socket(vcc->sk);
 	set_bit(ATM_VF_META,&vcc->flags);
 	set_bit(ATM_VF_READY,&vcc->flags);
 
===== net/atm/proc.c 1.17 vs edited =====
--- 1.17/net/atm/proc.c	Sat Jun  7 10:53:52 2003
+++ edited/net/atm/proc.c	Sat Jun  7 11:57:30 2003
@@ -334,9 +334,7 @@
 
 static int atm_pvc_info(loff_t pos,char *buf)
 {
-	unsigned long flags;
-	struct atm_dev *dev;
-	struct list_head *p;
+	struct sock *s;
 	struct atm_vcc *vcc;
 	int left, clip_info = 0;
 
@@ -349,24 +347,20 @@
 	if (try_atm_clip_ops())
 		clip_info = 1;
 #endif
-	spin_lock(&atm_dev_lock);
-	list_for_each(p, &atm_devs) {
-		dev = list_entry(p, struct atm_dev, dev_list);
-		spin_lock_irqsave(&dev->lock, flags);
-		for (vcc = dev->vccs; vcc; vcc = vcc->next)
-			if (vcc->sk->family == PF_ATMPVC && vcc->dev && !left--) {
-				pvc_info(vcc,buf,clip_info);
-				spin_unlock_irqrestore(&dev->lock, flags);
-				spin_unlock(&atm_dev_lock);
+	read_lock(&vcc_sklist_lock);
+	for(s = vcc_sklist; s; s = s->next) {
+		vcc = atm_sk(s);
+		if (vcc->sk->family == PF_ATMPVC && vcc->dev && !left--) {
+			pvc_info(vcc,buf,clip_info);
+			read_unlock(&vcc_sklist_lock);
 #if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
-				if (clip_info)
-					module_put(atm_clip_ops->owner);
+			if (clip_info)
+				module_put(atm_clip_ops->owner);
 #endif
-				return strlen(buf);
-			}
-		spin_unlock_irqrestore(&dev->lock, flags);
+			return strlen(buf);
+		}
 	}
-	spin_unlock(&atm_dev_lock);
+	read_unlock(&vcc_sklist_lock);
 #if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
 	if (clip_info)
 		module_put(atm_clip_ops->owner);
@@ -377,10 +371,8 @@
 
 static int atm_vc_info(loff_t pos,char *buf)
 {
-	unsigned long flags;
-	struct atm_dev *dev;
-	struct list_head *p;
 	struct atm_vcc *vcc;
+	struct sock *s;
 	int left;
 
 	if (!pos)
@@ -388,20 +380,16 @@
 		    "Address"," Itf VPI VCI   Fam Flags Reply Send buffer"
 		    "     Recv buffer\n");
 	left = pos-1;
-	spin_lock(&atm_dev_lock);
-	list_for_each(p, &atm_devs) {
-		dev = list_entry(p, struct atm_dev, dev_list);
-		spin_lock_irqsave(&dev->lock, flags);
-		for (vcc = dev->vccs; vcc; vcc = vcc->next)
-			if (!left--) {
-				vc_info(vcc,buf);
-				spin_unlock_irqrestore(&dev->lock, flags);
-				spin_unlock(&atm_dev_lock);
-				return strlen(buf);
-			}
-		spin_unlock_irqrestore(&dev->lock, flags);
+	read_lock(&vcc_sklist_lock);
+	for(s = vcc_sklist; s; s = s->next) {
+		vcc = atm_sk(s);
+		if (!left--) {
+			vc_info(vcc,buf);
+			read_unlock(&vcc_sklist_lock);
+			return strlen(buf);
+		}
 	}
-	spin_unlock(&atm_dev_lock);
+	read_unlock(&vcc_sklist_lock);
 
 	return 0;
 }
@@ -409,29 +397,23 @@
 
 static int atm_svc_info(loff_t pos,char *buf)
 {
-	unsigned long flags;
-	struct atm_dev *dev;
-	struct list_head *p;
+	struct sock *s;
 	struct atm_vcc *vcc;
 	int left;
 
 	if (!pos)
 		return sprintf(buf,"Itf VPI VCI           State      Remote\n");
 	left = pos-1;
-	spin_lock(&atm_dev_lock);
-	list_for_each(p, &atm_devs) {
-		dev = list_entry(p, struct atm_dev, dev_list);
-		spin_lock_irqsave(&dev->lock, flags);
-		for (vcc = dev->vccs; vcc; vcc = vcc->next)
-			if (vcc->sk->family == PF_ATMSVC && !left--) {
-				svc_info(vcc,buf);
-				spin_unlock_irqrestore(&dev->lock, flags);
-				spin_unlock(&atm_dev_lock);
-				return strlen(buf);
-			}
-		spin_unlock_irqrestore(&dev->lock, flags);
+	read_lock(&vcc_sklist_lock);
+	for(s = vcc_sklist; s; s = s->next) {
+		vcc = atm_sk(s);
+		if (vcc->sk->family == PF_ATMSVC && !left--) {
+			svc_info(vcc,buf);
+			read_unlock(&vcc_sklist_lock);
+			return strlen(buf);
+		}
 	}
-	spin_unlock(&atm_dev_lock);
+	read_unlock(&vcc_sklist_lock);
 
 	return 0;
 }
===== net/atm/pvc.c 1.8 vs edited =====
--- 1.8/net/atm/pvc.c	Fri May 16 00:54:16 2003
+++ edited/net/atm/pvc.c	Sun Jun  8 09:06:07 2003
@@ -31,20 +31,33 @@
 static int pvc_bind(struct socket *sock,struct sockaddr *sockaddr,
     int sockaddr_len)
 {
+	struct sock *sk = sock->sk;
 	struct sockaddr_atmpvc *addr;
 	struct atm_vcc *vcc;
+	int error;
 
-	if (sockaddr_len != sizeof(struct sockaddr_atmpvc)) return -EINVAL;
+	if (sockaddr_len != sizeof(struct sockaddr_atmpvc))
+		return -EINVAL;
 	addr = (struct sockaddr_atmpvc *) sockaddr;
-	if (addr->sap_family != AF_ATMPVC) return -EAFNOSUPPORT;
+	if (addr->sap_family != AF_ATMPVC)
+		return -EAFNOSUPPORT;
+	lock_sock(sk);
 	vcc = ATM_SD(sock);
-	if (!test_bit(ATM_VF_HASQOS,&vcc->flags)) return -EBADFD;
-	if (test_bit(ATM_VF_PARTIAL,&vcc->flags)) {
-		if (vcc->vpi != ATM_VPI_UNSPEC) addr->sap_addr.vpi = vcc->vpi;
-		if (vcc->vci != ATM_VCI_UNSPEC) addr->sap_addr.vci = vcc->vci;
+	if (!test_bit(ATM_VF_HASQOS, &vcc->flags)) {
+		error = -EBADFD;
+		goto out;
 	}
-	return atm_connect(sock,addr->sap_addr.itf,addr->sap_addr.vpi,
+	if (test_bit(ATM_VF_PARTIAL, &vcc->flags)) {
+		if (vcc->vpi != ATM_VPI_UNSPEC)
+			addr->sap_addr.vpi = vcc->vpi;
+		if (vcc->vci != ATM_VCI_UNSPEC)
+			addr->sap_addr.vci = vcc->vci;
+	}
+	error = vcc_connect(sock, addr->sap_addr.itf, addr->sap_addr.vpi,
 	    addr->sap_addr.vci);
+out:
+	release_sock(sk);
+	return error;
 }
 
 
@@ -55,6 +68,20 @@
 }
 
 
+static int pvc_setsockopt(struct socket *sock,int level,int optname,
+		    char *optval,int optlen)
+{
+	struct sock *sk = sock->sk;
+	struct atm_vcc *vcc;
+	int error;
+
+	lock_sock(sk);
+	error = vcc_setsockopt(sock, level, optname, optval, optlen);
+	release_sock(sk);
+	return error;
+}
+
+
 static int pvc_getname(struct socket *sock,struct sockaddr *sockaddr,
     int *sockaddr_len,int peer)
 {
@@ -72,36 +99,32 @@
 }
 
 
-static struct proto_ops SOCKOPS_WRAPPED(pvc_proto_ops) = {
+static struct proto_ops pvc_proto_ops = {
 	.family =	PF_ATMPVC,
 
-	.release =	atm_release,
+	.release =	vcc_release,
 	.bind =		pvc_bind,
 	.connect =	pvc_connect,
 	.socketpair =	sock_no_socketpair,
 	.accept =	sock_no_accept,
 	.getname =	pvc_getname,
 	.poll =		atm_poll,
-	.ioctl =	atm_ioctl,
+	.ioctl =	vcc_ioctl,
 	.listen =	sock_no_listen,
 	.shutdown =	pvc_shutdown,
-	.setsockopt =	atm_setsockopt,
+	.setsockopt =	vcc_setsockopt,
 	.getsockopt =	atm_getsockopt,
 	.sendmsg =	atm_sendmsg,
-	.recvmsg =	atm_recvmsg,
+	.recvmsg =	vcc_recvmsg,
 	.mmap =		sock_no_mmap,
 	.sendpage =	sock_no_sendpage,
 };
 
 
-#include <linux/smp_lock.h>
-SOCKOPS_WRAP(pvc_proto, PF_ATMPVC);
-
-
 static int pvc_create(struct socket *sock,int protocol)
 {
 	sock->ops = &pvc_proto_ops;
-	return atm_create(sock,protocol,PF_ATMPVC);
+	return vcc_create(sock, protocol, PF_ATMPVC);
 }
 
 
===== net/atm/resources.c 1.11 vs edited =====
--- 1.11/net/atm/resources.c	Sat Jun  7 10:53:52 2003
+++ edited/net/atm/resources.c	Sat Jun  7 12:17:39 2003
@@ -12,6 +12,7 @@
 #include <linux/ctype.h>
 #include <linux/string.h>
 #include <linux/atmdev.h>
+#include <linux/sonet.h>
 #include <linux/kernel.h> /* for barrier */
 #include <linux/module.h>
 #include <linux/bitops.h>
@@ -19,11 +20,7 @@
 
 #include "common.h"
 #include "resources.h"
-
-
-#ifndef NULL
-#define NULL 0
-#endif
+#include "addr.h"
 
 
 LIST_HEAD(atm_devs);
@@ -89,7 +86,7 @@
 	spin_lock(&atm_dev_lock);
 	if (number != -1) {
 		if ((inuse = __atm_dev_lookup(number))) {
-			atm_dev_release(inuse);
+			atm_dev_put(inuse);
 			spin_unlock(&atm_dev_lock);
 			__free_atm_dev(dev);
 			return NULL;
@@ -98,7 +95,7 @@
 	} else {
 		dev->number = 0;
 		while ((inuse = __atm_dev_lookup(dev->number))) {
-			atm_dev_release(inuse);
+			atm_dev_put(inuse);
 			dev->number++;
 		}
 	}
@@ -171,73 +168,215 @@
 	atm_dev_deregister(dev);
 }
 
-struct sock *alloc_atm_vcc_sk(int family)
+
+static void copy_aal_stats(struct k_atm_aal_stats *from,
+    struct atm_aal_stats *to)
 {
-	struct sock *sk;
-	struct atm_vcc *vcc;
+#define __HANDLE_ITEM(i) to->i = atomic_read(&from->i)
+	__AAL_STAT_ITEMS
+#undef __HANDLE_ITEM
+}
 
-	sk = sk_alloc(family, GFP_KERNEL, 1, NULL);
-	if (!sk)
-		return NULL;
-	vcc = atm_sk(sk) = kmalloc(sizeof(*vcc), GFP_KERNEL);
-	if (!vcc) {
-		sk_free(sk);
-		return NULL;
-	}
-	sock_init_data(NULL, sk);
-	memset(vcc, 0, sizeof(*vcc));
-	vcc->sk = sk;
 
-	return sk;
+static void subtract_aal_stats(struct k_atm_aal_stats *from,
+    struct atm_aal_stats *to)
+{
+#define __HANDLE_ITEM(i) atomic_sub(to->i,&from->i)
+	__AAL_STAT_ITEMS
+#undef __HANDLE_ITEM
 }
 
 
-static void unlink_vcc(struct atm_vcc *vcc)
+static int fetch_stats(struct atm_dev *dev,struct atm_dev_stats *arg,int zero)
 {
-	unsigned long flags;
-	if (vcc->dev) {
-		spin_lock_irqsave(&vcc->dev->lock, flags);
-		if (vcc->prev)
-			vcc->prev->next = vcc->next;
-		else
-			vcc->dev->vccs = vcc->next;
+	struct atm_dev_stats tmp;
+	int error = 0;
 
-		if (vcc->next)
-			vcc->next->prev = vcc->prev;
-		else
-			vcc->dev->last = vcc->prev;
-		spin_unlock_irqrestore(&vcc->dev->lock, flags);
+	copy_aal_stats(&dev->stats.aal0,&tmp.aal0);
+	copy_aal_stats(&dev->stats.aal34,&tmp.aal34);
+	copy_aal_stats(&dev->stats.aal5,&tmp.aal5);
+	if (arg)
+		error = copy_to_user(arg,&tmp,sizeof(tmp));
+	if (zero && !error) {
+		subtract_aal_stats(&dev->stats.aal0,&tmp.aal0);
+		subtract_aal_stats(&dev->stats.aal34,&tmp.aal34);
+		subtract_aal_stats(&dev->stats.aal5,&tmp.aal5);
 	}
+	return error ? -EFAULT : 0;
 }
 
 
-void free_atm_vcc_sk(struct sock *sk)
-{
-	unlink_vcc(atm_sk(sk));
-	sk_free(sk);
-}
-
-void bind_vcc(struct atm_vcc *vcc,struct atm_dev *dev)
+int atm_dev_ioctl(unsigned int cmd, unsigned long arg)
 {
-	unsigned long flags;
+	void *buf;
+	int error, len, size, number, ret_val;
+	struct atm_dev *dev;
 
-	unlink_vcc(vcc);
-	vcc->dev = dev;
-	if (dev) {
-		spin_lock_irqsave(&dev->lock, flags);
-		vcc->next = NULL;
-		vcc->prev = dev->last;
-		if (dev->vccs)
-			dev->last->next = vcc;
-		else
-			dev->vccs = vcc;
-		dev->last = vcc;
-		spin_unlock_irqrestore(&dev->lock, flags);
+	if (get_user(buf, &((struct atmif_sioc *) arg)->arg))
+		return -EFAULT;
+	if (get_user(len, &((struct atmif_sioc *) arg)->length))
+		return -EFAULT;
+	if (get_user(number, &((struct atmif_sioc *) arg)->number))
+		return -EFAULT;
+
+	if (!(dev = atm_dev_lookup(number)))
+		return -ENODEV;
+	
+	size = 0;
+	switch (cmd) {
+		case ATM_GETTYPE:
+			size = strlen(dev->type)+1;
+			if (copy_to_user(buf,dev->type,size)) {
+				ret_val = -EFAULT;
+				goto done;
+			}
+			break;
+		case ATM_GETESI:
+			size = ESI_LEN;
+			if (copy_to_user(buf,dev->esi,size)) {
+				ret_val = -EFAULT;
+				goto done;
+			}
+			break;
+		case ATM_SETESI:
+			{
+				int i;
+
+				for (i = 0; i < ESI_LEN; i++)
+					if (dev->esi[i]) {
+						ret_val = -EEXIST;
+						goto done;
+					}
+			}
+			/* fall through */
+		case ATM_SETESIF:
+			{
+				unsigned char esi[ESI_LEN];
+
+				if (!capable(CAP_NET_ADMIN)) {
+					ret_val = -EPERM;
+					goto done;
+				}
+				if (copy_from_user(esi,buf,ESI_LEN)) {
+					ret_val = -EFAULT;
+					goto done;
+				}
+				memcpy(dev->esi,esi,ESI_LEN);
+				ret_val =  ESI_LEN;
+				goto done;
+			}
+		case ATM_GETSTATZ:
+			if (!capable(CAP_NET_ADMIN)) {
+				ret_val = -EPERM;
+				goto done;
+			}
+			/* fall through */
+		case ATM_GETSTAT:
+			size = sizeof(struct atm_dev_stats);
+			error = fetch_stats(dev,buf,cmd == ATM_GETSTATZ);
+			if (error) {
+				ret_val = error;
+				goto done;
+			}
+			break;
+		case ATM_GETCIRANGE:
+			size = sizeof(struct atm_cirange);
+			if (copy_to_user(buf,&dev->ci_range,size)) {
+				ret_val = -EFAULT;
+				goto done;
+			}
+			break;
+		case ATM_GETLINKRATE:
+			size = sizeof(int);
+			if (copy_to_user(buf,&dev->link_rate,size)) {
+				ret_val = -EFAULT;
+				goto done;
+			}
+			break;
+		case ATM_RSTADDR:
+			if (!capable(CAP_NET_ADMIN)) {
+				ret_val = -EPERM;
+				goto done;
+			}
+			atm_reset_addr(dev);
+			break;
+		case ATM_ADDADDR:
+		case ATM_DELADDR:
+			if (!capable(CAP_NET_ADMIN)) {
+				ret_val = -EPERM;
+				goto done;
+			}
+			{
+				struct sockaddr_atmsvc addr;
+
+				if (copy_from_user(&addr,buf,sizeof(addr))) {
+					ret_val = -EFAULT;
+					goto done;
+				}
+				if (cmd == ATM_ADDADDR)
+					ret_val = atm_add_addr(dev,&addr);
+				else
+					ret_val = atm_del_addr(dev,&addr);
+				goto done;
+			}
+		case ATM_GETADDR:
+			size = atm_get_addr(dev,buf,len);
+			if (size < 0)
+				ret_val = size;
+			else
+			/* may return 0, but later on size == 0 means "don't
+			   write the length" */
+				ret_val = put_user(size,
+						   &((struct atmif_sioc *) arg)->length) ? -EFAULT : 0;
+			goto done;
+		case ATM_SETLOOP:
+			if (__ATM_LM_XTRMT((int) (long) buf) &&
+			    __ATM_LM_XTLOC((int) (long) buf) >
+			    __ATM_LM_XTRMT((int) (long) buf)) {
+				ret_val = -EINVAL;
+				goto done;
+			}
+			/* fall through */
+		case ATM_SETCIRANGE:
+		case SONET_GETSTATZ:
+		case SONET_SETDIAG:
+		case SONET_CLRDIAG:
+		case SONET_SETFRAMING:
+			if (!capable(CAP_NET_ADMIN)) {
+				ret_val = -EPERM;
+				goto done;
+			}
+			/* fall through */
+		default:
+			if (!dev->ops->ioctl) {
+				ret_val = -EINVAL;
+				goto done;
+			}
+			if (!try_module_get(dev->ops->owner)) {
+				ret_val = -ENODEV;
+				goto done;
+			}
+			size = dev->ops->ioctl(dev,cmd,buf);
+			module_put(dev->ops->owner);
+			if (size < 0) {
+				ret_val = (size == -ENOIOCTLCMD ? -EINVAL : size);
+				goto done;
+			}
 	}
+	
+	if (size)
+		ret_val =  put_user(size, &((struct atmif_sioc *) arg)->length) ?
+			-EFAULT : 0;
+	else
+		ret_val = 0;
+
+done:
+	atm_dev_put(dev);
+	return ret_val;
 }
 
+
 EXPORT_SYMBOL(atm_dev_register);
 EXPORT_SYMBOL(atm_dev_deregister);
 EXPORT_SYMBOL(atm_dev_lookup);
 EXPORT_SYMBOL(shutdown_atm_dev);
-EXPORT_SYMBOL(bind_vcc);
===== net/atm/resources.h 1.3 vs edited =====
--- 1.3/net/atm/resources.h	Thu May 15 20:20:17 2003
+++ edited/net/atm/resources.h	Sat Jun  7 12:05:39 2003
@@ -14,8 +14,7 @@
 extern spinlock_t atm_dev_lock;
 
 
-struct sock *alloc_atm_vcc_sk(int family);
-void free_atm_vcc_sk(struct sock *sk);
+int atm_dev_ioctl(unsigned int cmd, unsigned long arg);
 
 
 #ifdef CONFIG_PROC_FS
===== net/atm/signaling.c 1.10 vs edited =====
--- 1.10/net/atm/signaling.c	Sat Jun  7 10:53:52 2003
+++ edited/net/atm/signaling.c	Sun Jun  8 11:48:17 2003
@@ -128,9 +128,10 @@
 		case as_indicate:
 			vcc = *(struct atm_vcc **) &msg->listen_vcc;
 			DPRINTK("as_indicate!!!\n");
+			lock_sock(vcc->sk);
 			if (vcc->sk->ack_backlog == vcc->sk->max_ack_backlog) {
 				sigd_enq(0,as_reject,vcc,NULL,NULL);
-				return 0;
+				goto as_indicate_complete;
 			}
 			vcc->sk->ack_backlog++;
 			skb_queue_tail(&vcc->sk->receive_queue,skb);
@@ -139,11 +140,14 @@
 				    &vcc->sleep);
 				vcc->callback(vcc);
 			}
+as_indicate_complete:
+			release_sock(vcc->sk);
 			return 0;
 		case as_close:
 			set_bit(ATM_VF_RELEASED,&vcc->flags);
 			clear_bit(ATM_VF_READY,&vcc->flags);
 			vcc->reply = msg->reply;
+			vcc->sk->err = EPIPE;
 			break;
 		case as_modify:
 			modify_qos(vcc,msg);
@@ -194,25 +198,21 @@
 }
 
 
-static void purge_vccs(struct atm_vcc *vcc)
+static void purge_vcc(struct atm_vcc *vcc)
 {
-	while (vcc) {
-		if (vcc->sk->family == PF_ATMSVC &&
-		    !test_bit(ATM_VF_META,&vcc->flags)) {
-			set_bit(ATM_VF_RELEASED,&vcc->flags);
-			vcc->reply = -EUNATCH;
-			wake_up(&vcc->sleep);
-		}
-		vcc = vcc->next;
+	if (vcc->sk->family == PF_ATMSVC &&
+	    !test_bit(ATM_VF_META,&vcc->flags)) {
+		set_bit(ATM_VF_RELEASED,&vcc->flags);
+		vcc->reply = -EUNATCH;
+		vcc->sk->err = EUNATCH;
+		wake_up(&vcc->sleep);
 	}
 }
 
 
 static void sigd_close(struct atm_vcc *vcc)
 {
-	unsigned long flags;
-	struct atm_dev *dev;
-	struct list_head *p;
+	struct sock *s;
 
 	DPRINTK("sigd_close\n");
 	sigd = NULL;
@@ -220,14 +220,14 @@
 		printk(KERN_ERR "sigd_close: closing with requests pending\n");
 	skb_queue_purge(&vcc->sk->receive_queue);
 
-	spin_lock(&atm_dev_lock);
-	list_for_each(p, &atm_devs) {
-		dev = list_entry(p, struct atm_dev, dev_list);
-		spin_lock_irqsave(&dev->lock, flags);
-		purge_vccs(dev->vccs);
-		spin_unlock_irqrestore(&dev->lock, flags);
+	read_lock(&vcc_sklist_lock);
+	for(s = vcc_sklist; s; s = s->next) {
+		struct atm_vcc *vcc = atm_sk(s);
+
+		if (vcc->dev)
+			purge_vcc(vcc);
 	}
-	spin_unlock(&atm_dev_lock);
+	read_unlock(&vcc_sklist_lock);
 }
 
 
@@ -250,7 +250,8 @@
 	if (sigd) return -EADDRINUSE;
 	DPRINTK("sigd_attach\n");
 	sigd = vcc;
-	bind_vcc(vcc,&sigd_dev);
+	vcc->dev = &sigd_dev;
+	vcc_insert_socket(vcc->sk);
 	set_bit(ATM_VF_META,&vcc->flags);
 	set_bit(ATM_VF_READY,&vcc->flags);
 	wake_up(&sigd_sleep);
===== net/atm/svc.c 1.9 vs edited =====
--- 1.9/net/atm/svc.c	Fri May 16 00:54:16 2003
+++ edited/net/atm/svc.c	Sun Jun  8 13:36:50 2003
@@ -89,17 +89,19 @@
 static int svc_release(struct socket *sock)
 {
 	struct atm_vcc *vcc;
+	struct sock *sk = sock->sk;
 
-	if (!sock->sk) return 0;
-	vcc = ATM_SD(sock);
-	DPRINTK("svc_release %p\n",vcc);
-	clear_bit(ATM_VF_READY,&vcc->flags);
-	atm_release_vcc_sk(sock->sk,0);
-	svc_disconnect(vcc);
-	    /* VCC pointer is used as a reference, so we must not free it
-	       (thereby subjecting it to re-use) before all pending connections
-	        are closed */
-	free_atm_vcc_sk(sock->sk);
+	if (sk) {
+		vcc = ATM_SD(sock);
+		DPRINTK("svc_release %p\n",vcc);
+		sock_hold(sk);
+		vcc_release(sock);
+		svc_disconnect(vcc);
+		/* VCC pointer is used as a reference, so we must not free it
+		   (thereby subjecting it to re-use) before all pending connections
+		   are closed */
+		sock_put(sk);
+	}
 	return 0;
 }
 
@@ -107,66 +109,121 @@
 static int svc_bind(struct socket *sock,struct sockaddr *sockaddr,
     int sockaddr_len)
 {
+	struct sock *sk = sock->sk;
 	DECLARE_WAITQUEUE(wait,current);
 	struct sockaddr_atmsvc *addr;
 	struct atm_vcc *vcc;
+	int error;
 
-	if (sockaddr_len != sizeof(struct sockaddr_atmsvc)) return -EINVAL;
-	if (sock->state == SS_CONNECTED) return -EISCONN;
-	if (sock->state != SS_UNCONNECTED) return -EINVAL;
+	if (sockaddr_len != sizeof(struct sockaddr_atmsvc))
+		return -EINVAL;
+	lock_sock(sk);
+	if (sock->state == SS_CONNECTED) {
+		error = -EISCONN;
+		goto out;
+	}
+	if (sock->state != SS_UNCONNECTED) {
+		error = -EINVAL;
+		goto out;
+	}
 	vcc = ATM_SD(sock);
-	if (test_bit(ATM_VF_SESSION,&vcc->flags)) return -EINVAL;
+	if (test_bit(ATM_VF_SESSION,&vcc->flags)) {
+		error = -EINVAL;
+		goto out;
+	}
 	addr = (struct sockaddr_atmsvc *) sockaddr;
-	if (addr->sas_family != AF_ATMSVC) return -EAFNOSUPPORT;
-	clear_bit(ATM_VF_BOUND,&vcc->flags);
+	if (addr->sas_family != AF_ATMSVC) {
+		error = -EAFNOSUPPORT;
+		goto out;
+	}
+	clear_bit(ATM_VF_BOUND, &vcc->flags);
 	    /* failing rebind will kill old binding */
 	/* @@@ check memory (de)allocation on rebind */
-	if (!test_bit(ATM_VF_HASQOS,&vcc->flags)) return -EBADFD;
+	if (!test_bit(ATM_VF_HASQOS,&vcc->flags)) {
+		error = -EBADFD;
+		goto out;
+	}
 	vcc->local = *addr;
 	vcc->reply = WAITING;
-	add_wait_queue(&vcc->sleep,&wait);
-	sigd_enq(vcc,as_bind,NULL,NULL,&vcc->local);
+	add_wait_queue(&vcc->sleep, &wait);
+	sigd_enq(vcc, as_bind, NULL, NULL, &vcc->local);
 	while (vcc->reply == WAITING && sigd) {
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule();
 	}
-	remove_wait_queue(&vcc->sleep,&wait);
-	clear_bit(ATM_VF_REGIS,&vcc->flags); /* doesn't count */
-	if (!sigd) return -EUNATCH;
-        if (!vcc->reply) set_bit(ATM_VF_BOUND,&vcc->flags);
-	return vcc->reply;
+	remove_wait_queue(&vcc->sleep, &wait);
+	clear_bit(ATM_VF_REGIS, &vcc->flags); /* doesn't count */
+	if (!sigd) {
+		error = -EUNATCH;
+		goto out;
+	}
+        if (!vcc->reply)
+		set_bit(ATM_VF_BOUND, &vcc->flags);
+	error = vcc->reply;
+out:
+	release_sock(sk);
+	return error;
 }
 
 
 static int svc_connect(struct socket *sock,struct sockaddr *sockaddr,
     int sockaddr_len,int flags)
 {
+	struct sock *sk = sock->sk;
 	DECLARE_WAITQUEUE(wait,current);
 	struct sockaddr_atmsvc *addr;
 	struct atm_vcc *vcc = ATM_SD(sock);
 	int error;
 
 	DPRINTK("svc_connect %p\n",vcc);
-	if (sockaddr_len != sizeof(struct sockaddr_atmsvc)) return -EINVAL;
-	if (sock->state == SS_CONNECTED) return -EISCONN;
-	if (sock->state == SS_CONNECTING) {
-		if (vcc->reply == WAITING) return -EALREADY;
-		sock->state = SS_UNCONNECTED;
-		if (vcc->reply) return vcc->reply;
+	lock_sock(sk);
+	if (sockaddr_len != sizeof(struct sockaddr_atmsvc)) {
+		error = -EINVAL;
+		goto out;
 	}
-	else {
-		int error;
 
-		if (sock->state != SS_UNCONNECTED) return -EINVAL;
-		if (test_bit(ATM_VF_SESSION,&vcc->flags)) return -EINVAL;
+	switch (sock->state) {
+	default:
+		error = -EINVAL;
+		goto out;
+	case SS_CONNECTED: 
+		error = -EISCONN;
+		goto out;
+	case SS_CONNECTING:
+		if (vcc->reply == WAITING) {
+			error = -EALREADY;
+			goto out;
+		}
+		sock->state = SS_UNCONNECTED;
+		if (vcc->reply) {
+			error = vcc->reply;
+			goto out;
+		}
+		break;
+	case SS_UNCONNECTED:
+		if (test_bit(ATM_VF_SESSION,&vcc->flags)) {
+			error = -EINVAL;
+			goto out;
+		}
 		addr = (struct sockaddr_atmsvc *) sockaddr;
-		if (addr->sas_family != AF_ATMSVC) return -EAFNOSUPPORT;
-		if (!test_bit(ATM_VF_HASQOS,&vcc->flags)) return -EBADFD;
+		if (addr->sas_family != AF_ATMSVC) {
+			error = -EAFNOSUPPORT;
+			goto out;
+		}
+		if (!test_bit(ATM_VF_HASQOS,&vcc->flags)) {
+			error = -EBADFD;
+			goto out;
+		}
 		if (vcc->qos.txtp.traffic_class == ATM_ANYCLASS ||
-		    vcc->qos.rxtp.traffic_class == ATM_ANYCLASS)
-			return -EINVAL;
+		    vcc->qos.rxtp.traffic_class == ATM_ANYCLASS) {
+			error = -EINVAL;
+			goto out;
+		}
 		if (!vcc->qos.txtp.traffic_class &&
-		    !vcc->qos.rxtp.traffic_class) return -EINVAL;
+		    !vcc->qos.rxtp.traffic_class) {
+			error = -EINVAL;
+			goto out;
+		}
 		vcc->remote = *addr;
 		vcc->reply = WAITING;
 		add_wait_queue(&vcc->sleep,&wait);
@@ -174,7 +231,8 @@
 		if (flags & O_NONBLOCK) {
 			remove_wait_queue(&vcc->sleep,&wait);
 			sock->state = SS_CONNECTING;
-			return -EINPROGRESS;
+			error = -EINPROGRESS;
+			goto out;
 		}
 		error = 0;
 		while (vcc->reply == WAITING && sigd) {
@@ -213,9 +271,16 @@
 			break;
 		}
 		remove_wait_queue(&vcc->sleep,&wait);
-		if (error) return error;
-		if (!sigd) return -EUNATCH;
-		if (vcc->reply) return vcc->reply;
+		if (error)
+			goto out;
+		if (!sigd) {
+			error = -EUNATCH;
+			goto out;
+		}
+		if (vcc->reply) {
+			error = vcc->reply;
+			goto out;
+		}
 	}
 /*
  * Not supported yet
@@ -228,47 +293,65 @@
 /*
  * #endif
  */
-	if (!(error = atm_connect(sock,vcc->itf,vcc->vpi,vcc->vci)))
+	if (!(error = vcc_connect(sock,vcc->itf,vcc->vpi,vcc->vci)))
 		sock->state = SS_CONNECTED;
-	else (void) svc_disconnect(vcc);
+	else
+		svc_disconnect(vcc);
+out:
+	release_sock(sk);
 	return error;
 }
 
 
-static int svc_listen(struct socket *sock,int backlog)
+static int svc_listen(struct socket *sock, int backlog)
 {
+	struct sock *sk = sock->sk;
 	DECLARE_WAITQUEUE(wait,current);
 	struct atm_vcc *vcc = ATM_SD(sock);
+	int error;
 
 	DPRINTK("svc_listen %p\n",vcc);
+	lock_sock(sk);
 	/* let server handle listen on unbound sockets */
-	if (test_bit(ATM_VF_SESSION,&vcc->flags)) return -EINVAL;
+	if (test_bit(ATM_VF_SESSION, &vcc->flags)) {
+		error = -EINVAL;
+		goto out;
+	}
 	vcc->reply = WAITING;
-	add_wait_queue(&vcc->sleep,&wait);
-	sigd_enq(vcc,as_listen,NULL,NULL,&vcc->local);
+	add_wait_queue(&vcc->sleep, &wait);
+	sigd_enq(vcc, as_listen, NULL, NULL, &vcc->local);
 	while (vcc->reply == WAITING && sigd) {
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule();
 	}
-	remove_wait_queue(&vcc->sleep,&wait);
-	if (!sigd) return -EUNATCH;
-	set_bit(ATM_VF_LISTEN,&vcc->flags);
+	remove_wait_queue(&vcc->sleep, &wait);
+	if (!sigd) {
+		error = -EUNATCH;
+		goto out;
+	}
+	set_bit(ATM_VF_LISTEN, &vcc->flags);
 	vcc->sk->max_ack_backlog = backlog > 0 ? backlog : ATM_BACKLOG_DEFAULT;
-	return vcc->reply;
+	error = vcc->reply;
+out:
+	release_sock(sk);
+	return error;
 }
 
 
 static int svc_accept(struct socket *sock,struct socket *newsock,int flags)
 {
+	struct sock *sk = sock->sk;
 	struct sk_buff *skb;
 	struct atmsvc_msg *msg;
 	struct atm_vcc *old_vcc = ATM_SD(sock);
 	struct atm_vcc *new_vcc;
 	int error;
 
+	lock_sock(sk);
+
 	error = svc_create(newsock,0);
 	if (error)
-		return error;
+		goto out;
 
 	new_vcc = ATM_SD(newsock);
 
@@ -278,7 +361,8 @@
 
 		add_wait_queue(&old_vcc->sleep,&wait);
 		while (!(skb = skb_dequeue(&old_vcc->sk->receive_queue)) && sigd) {
-			if (test_bit(ATM_VF_RELEASED,&old_vcc->flags)) break;
+			if (test_bit(ATM_VF_RELEASED,&old_vcc->flags))
+				break;
 			if (test_bit(ATM_VF_CLOSE,&old_vcc->flags)) {
 				error = old_vcc->reply;
 				break;
@@ -287,30 +371,37 @@
 				error = -EAGAIN;
 				break;
 			}
+			release_sock(sk);
 			set_current_state(TASK_INTERRUPTIBLE);
 			schedule();
+			lock_sock(sk);
 			if (signal_pending(current)) {
 				error = -ERESTARTSYS;
 				break;
 			}
 		}
 		remove_wait_queue(&old_vcc->sleep,&wait);
-		if (error) return error;
-		if (!skb) return -EUNATCH;
+		if (error)
+			goto out;
+		if (!skb) {
+			error = -EUNATCH;
+			goto out;
+		}
 		msg = (struct atmsvc_msg *) skb->data;
 		new_vcc->qos = msg->qos;
 		set_bit(ATM_VF_HASQOS,&new_vcc->flags);
 		new_vcc->remote = msg->svc;
 		new_vcc->local = msg->local;
 		new_vcc->sap = msg->sap;
-		error = atm_connect(newsock,msg->pvc.sap_addr.itf,
-		    msg->pvc.sap_addr.vpi,msg->pvc.sap_addr.vci);
+		error = vcc_connect(newsock, msg->pvc.sap_addr.itf,
+		    msg->pvc.sap_addr.vpi, msg->pvc.sap_addr.vci);
 		dev_kfree_skb(skb);
 		old_vcc->sk->ack_backlog--;
 		if (error) {
 			sigd_enq2(NULL,as_reject,old_vcc,NULL,NULL,
 			    &old_vcc->qos,error);
-			return error == -EAGAIN ? -EBUSY : error;
+			error = error == -EAGAIN ? -EBUSY : error;
+			goto out;
 		}
 		/* wait should be short, so we ignore the non-blocking flag */
 		new_vcc->reply = WAITING;
@@ -321,12 +412,21 @@
 			schedule();
 		}
 		remove_wait_queue(&new_vcc->sleep,&wait);
-		if (!sigd) return -EUNATCH;
+		if (!sigd) {
+			error = -EUNATCH;
+			goto out;
+		}
 		if (!new_vcc->reply) break;
-		if (new_vcc->reply != -ERESTARTSYS) return new_vcc->reply;
+		if (new_vcc->reply != -ERESTARTSYS) {
+			error = new_vcc->reply;
+			goto out;
+		}
 	}
 	newsock->state = SS_CONNECTED;
-	return 0;
+
+out:
+	release_sock(sk);
+	return error;
 }
 
 
@@ -361,18 +461,28 @@
 }
 
 
-static int svc_setsockopt(struct socket *sock,int level,int optname,
-    char *optval,int optlen)
+static int svc_setsockopt(struct socket *sock, int level, int optname,
+    char *optval, int optlen)
 {
+	struct sock *sk = sock->sk;
 	struct atm_vcc *vcc;
+	int error = 0;
 
+	lock_sock(sk);
 	if (!__SO_LEVEL_MATCH(optname, level) || optname != SO_ATMSAP ||
-	    optlen != sizeof(struct atm_sap))
-		return atm_setsockopt(sock,level,optname,optval,optlen);
+	    optlen != sizeof(struct atm_sap)) {
+		error = vcc_setsockopt(sock, level, optname, optval, optlen);
+		goto out;
+	}
 	vcc = ATM_SD(sock);
-	if (copy_from_user(&vcc->sap,optval,optlen)) return -EFAULT;
-	set_bit(ATM_VF_HASSAP,&vcc->flags);
-	return 0;
+	if (copy_from_user(&vcc->sap, optval, optlen)) {
+		error = -EFAULT;
+		goto out;
+	}
+	set_bit(ATM_VF_HASSAP, &vcc->flags);
+out:
+	release_sock(sk);
+	return error;
 }
 
 
@@ -390,7 +500,7 @@
 }
 
 
-static struct proto_ops SOCKOPS_WRAPPED(svc_proto_ops) = {
+static struct proto_ops svc_proto_ops = {
 	.family =	PF_ATMSVC,
 
 	.release =	svc_release,
@@ -400,28 +510,26 @@
 	.accept =	svc_accept,
 	.getname =	svc_getname,
 	.poll =		atm_poll,
-	.ioctl =	atm_ioctl,
+	.ioctl =	vcc_ioctl,
 	.listen =	svc_listen,
 	.shutdown =	svc_shutdown,
 	.setsockopt =	svc_setsockopt,
 	.getsockopt =	svc_getsockopt,
 	.sendmsg =	atm_sendmsg,
-	.recvmsg =	atm_recvmsg,
+	.recvmsg =	vcc_recvmsg,
 	.mmap =		sock_no_mmap,
 	.sendpage =	sock_no_sendpage,
 };
 
 
-#include <linux/smp_lock.h>
-SOCKOPS_WRAP(svc_proto, PF_ATMSVC);
-
-static int svc_create(struct socket *sock,int protocol)
+static int svc_create(struct socket *sock, int protocol)
 {
 	int error;
 
 	sock->ops = &svc_proto_ops;
-	error = atm_create(sock,protocol,AF_ATMSVC);
-	if (error) return error;
+	error = vcc_create(sock, protocol, AF_ATMSVC);
+	if (error)
+		return error;
 	ATM_SD(sock)->callback = svc_callback;
 	ATM_SD(sock)->local.sas_family = AF_ATMSVC;
 	ATM_SD(sock)->remote.sas_family = AF_ATMSVC;
