Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262583AbUKQWYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262583AbUKQWYy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 17:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262643AbUKQWUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 17:20:35 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:31656 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262632AbUKQWM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 17:12:57 -0500
Message-ID: <419BCCE4.8060905@mvista.com>
Date: Wed, 17 Nov 2004 16:12:52 -0600
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH} Network interface for IPMI
References: <419BB646.3070805@mvista.com> <20041117125114.0c8fdf62.akpm@osdl.org>
In-Reply-To: <20041117125114.0c8fdf62.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------060909000500040805010503"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060909000500040805010503
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Here is a patch that fixed the problems you mentioned.

Thanks,

-Corey

--------------060909000500040805010503
Content-Type: text/plain;
 name="af_ipmi.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="af_ipmi.diff"

Index: linux-ipmi/Documentation/IPMI.txt
===================================================================
--- linux-ipmi.orig/Documentation/IPMI.txt	2004-10-25 08:08:19.000000000 -0500
+++ linux-ipmi/Documentation/IPMI.txt	2004-11-17 16:10:41.000000000 -0600
@@ -104,7 +104,7 @@
 af_ipmi - A network socket interface to IPMI.  This doesn't take up
 a character device in your system.
 
-Note that the KCS-only interface ahs been removed.
+Note that the KCS-only interface has been removed.
 
 Much documentation for the interface is in the include files.  The
 IPMI include files are:
@@ -218,6 +218,125 @@
 appropriately.
 
 
+Using the Socket Interface
+--------------------------
+
+The socket interface to IPMI removes a lot of the evils of the ioctl
+interface, including taking a character device and passing pointers
+between userland and the kernel in ioctl structures.  Plus, IPMI is
+really kind of a network, you have addressing, message options, and
+things of that nature that fit naturally into the socket interface.  I
+should have done that from the beginning.
+
+This is the recommended interface to use for IPMI.  It is a lot
+cleaner than the ioctl interface.
+
+To create an IPMI socket, do something like the following:
+
+    int                  fd;
+    int                  rv;
+    struct sockaddr_ipmi addr;
+
+    fd = socket(PF_IPMI, SOCK_DGRAM, 0);
+    if (fd == -1)
+	<return error>
+    addr.sipmi_family = AF_IPMI;
+    addr.if_num = if_num;
+    rv = bind(fd, (struct sockaddr *) &addr, sizeof(addr));
+    if (rv != -1) {
+        close(fd)
+	<return error>
+    }
+
+The "if_num" variable above is which IPMI interface you are binding
+to, generally zero.  To send a message, do something like:
+
+    struct sockaddr_ipmi     saddr;
+    char                     smsg_data[sizeof(struct ipmi_sock_msg)
+                                       + IPMI_MAX_MSG_LENGTH];
+    struct ipmi_sock_msg     *smsg = (void *) smsg_data;
+
+    saddr.sipmi_family = AF_IPMI;
+    memcpy(&saddr.ipmi_addr, addr, addr_len);
+
+    smsg->netfn = netfn;
+    smsg->cmd = cmd;
+    smsg->data_len = data_len;
+    smsg->msgid = msgid;
+    memcpy(smsg->data, data, smsg->data_len);
+
+    rv = sendto(fd, smsg, sizeof(*smsg) + msg->data_len, 0,
+                (struct sockaddr *) &saddr,
+                addr_len + SOCKADDR_IPMI_OVERHEAD);
+
+The "addr" variable here is an address as described by the addressing
+section above.  The message data is the same as described in the
+messaging section above.
+
+    struct sockaddr_ipmi addr;
+    socklen_t            addr_len;
+    struct ipmi_sock_msg *smsg;
+    unsigned char        data[MAX_IPMI_DATA_SIZE + sizeof(*smsg)];
+    
+
+    addr_len = sizeof(addr);
+    rv = recvfrom(fd, data, sizeof(data), 0,
+		  (struct sockaddr *) &addr, &addr_len);
+    if (rv < 0) {
+        <handle error>
+    }
+
+    if (rv < sizeof(*smsg)) {
+        <handle error, msg too short>
+    }
+
+    smsg = (struct ipmi_sock_msg *) data;
+    if (rv < (sizeof(*smsg) + smsg->data_len)) {
+        <handle error, msg too short>
+    }
+
+    recv_type = smsg->recv_type;
+    ipmi_addr = (struct ipmi_addr *) &addr.ipmi_addr;
+    ipmi_addr_len = addr_len - SOCKADDR_IPMI_OVERHEAD;
+    msgid = smsg->msgid;
+    msg.netfn = smsg->netfn;
+    msg.cmd = smsg->cmd;
+    msg.data = smsg->data;
+    msg.data_len = smsg->data_len;
+
+You must handle the received message based upon the receive type.
+
+There are a few other things that are ioctls for the socket.  This is
+a few things that cannot be done in any easy way besides an ioctl, but
+these don't contain any nasty things like pointers.
+
+The following sets the local address for the BMC.  IPMI provides no
+way for the driver to discover what the IPMB address for the BMC
+should be.  So this has to be set by the software using it.
+
+    unsigned int slave_addr;
+    rv = ioctl(fd, SIOCIPMISETADDR, &slave_addr);
+
+The following enabled events to be received from the interface.  If
+you set this to true, incoming events will be delivered to the fd.
+
+    int enable_events;
+    rv = ioctl(fd, SIOCIPMIGETEVENT, &enable_events);
+
+To receive external command addressed to LUN 2 of the BMC, register
+with the following ioctl:
+
+    struct ipmi_cmdspec reg;
+    reg.netfn = netfn;
+    reg.cmd = cmd;
+    rv = ioctl(fd, SIOCIPMIREGCMD, &reg);
+
+The deregistration call is:
+
+    rv = ioctl(fd, SIOCIPMIUNREGCMD, &reg);
+
+
+
 The Upper Layer Interface (Message Handler)
 -------------------------------------------
 
@@ -293,6 +412,7 @@
 
 
 Events and Incoming Commands
+----------------------------
 
 The driver takes care of polling for IPMI events and receiving
 commands (commands are messages that are not responses, they are
Index: linux-ipmi/include/linux/net.h
===================================================================
--- linux-ipmi.orig/include/linux/net.h	2004-11-17 15:19:30.000000000 -0600
+++ linux-ipmi/include/linux/net.h	2004-11-17 15:19:37.000000000 -0600
@@ -26,7 +26,7 @@
 struct poll_table_struct;
 struct inode;
 
-#define NPROTO		32		/* should be enough for now..	*/
+#define NPROTO		33		/* should be enough for now..	*/
 
 #define SYS_SOCKET	1		/* sys_socket(2)		*/
 #define SYS_BIND	2		/* sys_bind(2)			*/
Index: linux-ipmi/include/linux/socket.h
===================================================================
--- linux-ipmi.orig/include/linux/socket.h	2004-11-17 15:19:30.000000000 -0600
+++ linux-ipmi/include/linux/socket.h	2004-11-17 15:19:37.000000000 -0600
@@ -177,7 +177,8 @@
 #define AF_WANPIPE	25	/* Wanpipe API Sockets */
 #define AF_LLC		26	/* Linux LLC			*/
 #define AF_BLUETOOTH	31	/* Bluetooth sockets 		*/
-#define AF_MAX		32	/* For now.. */
+#define AF_IPMI		32	/* IPMI sockers 		*/
+#define AF_MAX		33	/* For now.. */
 
 /* Protocol families, same as address families. */
 #define PF_UNSPEC	AF_UNSPEC
@@ -209,6 +210,7 @@
 #define PF_WANPIPE	AF_WANPIPE
 #define PF_LLC		AF_LLC
 #define PF_BLUETOOTH	AF_BLUETOOTH
+#define PF_IPMI		AF_IPMI
 #define PF_MAX		AF_MAX
 
 /* Maximum queue length specifiable by listen.  */
Index: linux-ipmi/include/net/af_ipmi.h
===================================================================
--- linux-ipmi.orig/include/net/af_ipmi.h	1969-12-31 18:00:00.000000000 -0600
+++ linux-ipmi/include/net/af_ipmi.h	2004-11-17 15:19:37.000000000 -0600
@@ -0,0 +1,59 @@
+/* 
+ * IPMI Socket Glue
+ *
+ * Author:	Louis Zhuang <louis.zhuang@linux.intel.com>
+ * Copyright by Intel Corp., 2003
+ */
+#ifndef _NET_IPMI_H
+#define _NET_IPMI_H
+
+#include <linux/ipmi.h>
+
+/*
+ * This is ipmi address for socket
+ */
+struct sockaddr_ipmi {
+	sa_family_t      sipmi_family; /* AF_IPMI */
+	int              if_num; /* IPMI interface number */
+	struct ipmi_addr ipmi_addr;
+};
+#define SOCKADDR_IPMI_OVERHEAD (sizeof(struct sockaddr_ipmi) \
+				- sizeof(struct ipmi_addr))
+
+/* A msg_control item, this takes a 'struct ipmi_timing_parms' */
+#define IPMI_CMSG_TIMING_PARMS	0x01
+
+/* 
+ * This is ipmi message for socket
+ */
+struct ipmi_sock_msg {
+	int                   recv_type;
+	long                  msgid;
+
+	unsigned char         netfn;
+	unsigned char         cmd;
+	int                   data_len;
+	unsigned char         data[0];
+};
+
+#define IPMI_MAX_SOCK_MSG_LENGTH (sizeof(struct ipmi_sock_msg)+IPMI_MAX_MSG_LENGTH)
+
+/* Register/unregister to receive specific commands.  Uses struct
+   ipmi_cmdspec from linux/ipmi.h */
+#define SIOCIPMIREGCMD		(SIOCPROTOPRIVATE + 0)
+#define SIOCIPMIUNREGCMD	(SIOCPROTOPRIVATE + 1)
+
+/* Register to receive events.  Takes an integer */
+#define SIOCIPMIGETEVENT	(SIOCPROTOPRIVATE + 2)
+
+/* Set the default timing parameters for the socket.  Takes a struct
+   ipmi_timing_parms from linux/ipmi.h */
+#define SIOCIPMISETTIMING	(SIOCPROTOPRIVATE + 3)
+#define SIOCIPMIGETTIMING	(SIOCPROTOPRIVATE + 4)
+
+/* Set/Get the IPMB address of the MC we are connected to, takes an
+   unsigned int. */
+#define SIOCIPMISETADDR		(SIOCPROTOPRIVATE + 5)
+#define SIOCIPMIGETADDR		(SIOCPROTOPRIVATE + 6)
+
+#endif/*_NET_IPMI_H*/
Index: linux-ipmi/net/ipmi/af_ipmi.c
===================================================================
--- linux-ipmi.orig/net/ipmi/af_ipmi.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-ipmi/net/ipmi/af_ipmi.c	2004-11-17 15:19:37.000000000 -0600
@@ -0,0 +1,608 @@
+/* 
+ * IPMI Socket Glue
+ *
+ * Author:	Louis Zhuang <louis.zhuang@linux.intel.com>
+ * Copyright by Intel Corp., 2003
+ */
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/major.h>
+#include <linux/signal.h>
+#include <linux/sched.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/stat.h>
+#include <linux/socket.h>
+#include <linux/fcntl.h>
+#include <linux/sockios.h>
+#include <linux/net.h>
+#include <linux/in.h>
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include <asm/uaccess.h>
+#include <linux/skbuff.h>
+#include <linux/tcp.h>
+#include <net/sock.h>
+#include <linux/proc_fs.h>
+#include <linux/init.h>
+#include <linux/poll.h>
+#include <linux/smp_lock.h>
+#include <linux/mount.h>
+#include <linux/security.h>
+#include <linux/ipmi.h>
+#include <net/af_ipmi.h>
+
+#define IPMI_SOCKINTF_VERSION "v33"
+
+#ifdef CONFIG_DEBUG_KERNEL
+static int debug = 0;
+#define dbg(format, arg...)                                     \
+        do {                                                    \
+                if(debug)                                    \
+                        printk (KERN_DEBUG "%s: " format "\n",  \
+                                __FUNCTION__, ## arg);          \
+        } while(0)
+#else
+#define dbg(format, arg...)
+#endif /* CONFIG_DEBUG_KERNEL */
+
+#define err(format, arg...) \
+                printk(KERN_ERR "%s: " format "\n", \
+                       __FUNCTION__ , ## arg)
+#define info(format, arg...) \
+                printk(KERN_INFO "%s: " format "\n", \
+                       __FUNCTION__ , ## arg)
+#define warn(format, arg...) \
+                printk(KERN_WARNING "%s: " format "\n", \
+                       __FUNCTION__ , ## arg)
+#define trace(format, arg...) \
+                printk(KERN_INFO "%s(" format ")\n", \
+                       __FUNCTION__ , ## arg)
+
+struct ipmi_sock {
+	/* WARNING: sk has to be the first member */
+	struct sock sk;
+
+	ipmi_user_t user;
+	struct sockaddr_ipmi addr;
+	struct list_head msg_list;
+	
+	wait_queue_head_t wait;	
+	spinlock_t lock;
+
+	int          default_retries;
+	unsigned int default_retry_time_ms;
+};
+
+static kmem_cache_t *ipmi_sk_cachep = NULL;
+
+static atomic_t ipmi_nr_socks = ATOMIC_INIT(0);
+
+
+
+/*
+ * utility functions
+ */
+static inline struct ipmi_sock *to_ipmi_sock(struct sock *sk) 
+{
+	return container_of(sk, struct ipmi_sock, sk);
+}
+
+static inline void ipmi_release_sock(struct sock *sk, int embrion)
+{
+	struct ipmi_sock *i = to_ipmi_sock(sk);
+	struct sk_buff   *skb;
+	
+	if (i->user) {
+		ipmi_destroy_user(i->user);
+		i->user = NULL;
+	}
+
+	sock_orphan(&i->sk);
+	sk->sk_shutdown = SHUTDOWN_MASK;
+	sk->sk_state = TCP_CLOSE;
+
+	while((skb=skb_dequeue(&sk->sk_receive_queue))!=NULL)
+		kfree_skb(skb);
+
+	sock_put(sk);
+}
+
+static inline long ipmi_wait_for_queue(struct ipmi_sock *i, long timeo) 
+{
+	
+	DECLARE_WAITQUEUE(wait, current);
+	
+	set_current_state(TASK_INTERRUPTIBLE);
+	add_wait_queue_exclusive(&i->wait, &wait);
+	timeo = schedule_timeout(timeo);
+	remove_wait_queue(&i->wait, &wait);
+	return timeo;
+}
+
+/*
+ * IPMI operation functions
+ */
+static void sock_receive_handler(struct ipmi_recv_msg *msg,
+				 void                 *handler_data)
+{
+	struct ipmi_sock *i = (struct ipmi_sock *)handler_data;
+	unsigned long    flags;
+	
+	spin_lock_irqsave(&i->lock, flags);
+	list_add_tail(&msg->link, &i->msg_list);
+	spin_unlock_irqrestore(&i->lock, flags);
+
+	wake_up_interruptible(&i->wait);
+}
+
+/*
+ * protocol operation functions
+ */
+static int ipmi_release(struct socket *sock)
+{
+	struct sock *sk = sock->sk;
+	
+	if (!sk)
+		return 0;
+
+	sock->sk=NULL;
+	ipmi_release_sock(sk, 0);
+	return 0;
+}
+
+static struct ipmi_user_hndl ipmi_hnd = {
+	.ipmi_recv_hndl = sock_receive_handler
+};
+
+static int ipmi_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
+{
+	struct ipmi_sock *i = to_ipmi_sock(sock->sk);
+	struct sockaddr_ipmi *addr = (struct sockaddr_ipmi *)uaddr;
+	int err = -EINVAL;
+	
+	if (i->user != NULL) {
+		dbg("Cannot bind twice: %p", i->user);
+		return -EINVAL;
+	}
+	
+	err = ipmi_create_user(addr->if_num, &ipmi_hnd, i, &i->user);
+	if (err) {
+		dbg("Cannot create user for the socket: %p", i->user);
+		return err;
+	}
+
+	memcpy(&i->addr, addr, sizeof(i->addr));
+	return 0;
+}
+
+static int ipmi_getname(struct socket *sock, struct sockaddr *uaddr, int *uaddr_len, int peer)
+{
+	struct ipmi_sock *i = to_ipmi_sock(sock->sk);
+	memcpy(uaddr, &i->addr, sizeof(i->addr));
+	return 0;
+}
+
+static unsigned int ipmi_poll(struct file * file, struct socket *sock, poll_table *wait)
+{
+	unsigned int     has_msg = 0;
+	struct ipmi_sock *i = to_ipmi_sock(sock->sk);
+	unsigned long    flags;
+	
+	poll_wait(file, &i->wait, wait);
+	spin_lock_irqsave(&i->lock, flags);
+	if (!list_empty(&i->msg_list))
+		has_msg = 1;
+	spin_unlock_irqrestore(&i->lock, flags);
+
+	if (has_msg)
+		return POLLIN | POLLRDNORM;
+	return 0;
+}
+
+static int ipmi_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
+{
+	struct ipmi_sock    *i = to_ipmi_sock(sock->sk);
+	struct ipmi_cmdspec val; 
+	int                 ival;
+	unsigned int        uival;
+	int                 err;
+	
+	dbg("cmd=%#x, arg=%#lx", cmd, arg);
+	switch(cmd) {
+	case SIOCIPMIREGCMD:
+		err = copy_from_user((void *)&val, (void *)arg,
+				     sizeof(cmd));
+		if (err) {
+			err = -EFAULT;
+			break;
+		}
+		
+		err = ipmi_register_for_cmd(i->user, val.netfn,
+					    val.cmd);
+		break;
+			
+	case SIOCIPMIUNREGCMD:
+		err = copy_from_user((void *)&val, (void *)arg,
+				     sizeof(cmd));
+		if (err) {
+			err = -EFAULT;
+			break;
+		}
+		
+		err = ipmi_unregister_for_cmd(i->user, val.netfn,
+					      val.cmd);
+		break;
+			
+	case SIOCIPMIGETEVENT:
+		err = copy_from_user((void *)&ival, (void *)arg,
+				     sizeof(ival));
+		if (err) {
+			err = -EFAULT;
+			break;
+		}
+		
+		err = ipmi_set_gets_events(i->user, ival);
+		break;
+			
+	case SIOCIPMISETADDR:
+		err = copy_from_user((void *)&uival, (void *)arg,
+				     sizeof(uival));
+		if (err) {
+			err = -EFAULT;
+			break;
+		}
+		
+		ipmi_set_my_address(i->user, uival);
+		break;
+			
+	case SIOCIPMIGETADDR:
+		uival = ipmi_get_my_address(i->user);
+
+		if (copy_to_user((void *) arg, &uival, sizeof(uival))) {
+			err = -EFAULT;
+			break;
+		}
+		err = 0;
+		break;
+			
+	case SIOCIPMISETTIMING:
+	{
+		struct ipmi_timing_parms parms;
+
+		if (copy_from_user(&parms, (void *) arg, sizeof(parms))) {
+			err = -EFAULT;
+			break;
+		}
+		
+		i->default_retries = parms.retries;
+		i->default_retry_time_ms = parms.retry_time_ms;
+		err = 0;
+		break;
+	}
+
+	case SIOCIPMIGETTIMING:
+	{
+		struct ipmi_timing_parms parms;
+
+		parms.retries = i->default_retries;
+		parms.retry_time_ms = i->default_retry_time_ms;
+
+		if (copy_to_user((void *) arg, &parms, sizeof(parms))) {
+			err = -EFAULT;
+			break;
+		}
+
+		err = 0;
+		break;
+	}
+
+	default:
+		err = dev_ioctl(cmd, (void *)arg);
+		break;
+	}
+	
+	return err;
+}
+
+static int ipmi_recvmsg(struct kiocb *iocb, struct socket *sock,
+			struct msghdr *msg, size_t size,
+			int rflags)
+{
+	struct ipmi_sock     *i = to_ipmi_sock(sock->sk);
+	long                 timeo;
+	struct ipmi_recv_msg *rcvmsg;
+	struct sockaddr_ipmi addr;
+	char                 buf[IPMI_MAX_SOCK_MSG_LENGTH];
+	struct ipmi_sock_msg *smsg = (struct ipmi_sock_msg *)buf; 
+	int                  err;
+	unsigned long        flags;
+
+
+	timeo = sock_rcvtimeo(&i->sk, rflags & MSG_DONTWAIT);
+
+	while (1) {
+		spin_lock_irqsave(&i->lock, flags);
+		if (!list_empty(&i->msg_list)) 
+			break;
+		spin_unlock_irqrestore(&i->lock, flags);
+		if (!timeo) {
+			return -EAGAIN;
+		} else if (signal_pending (current)) {
+			dbg("Signal pending: %d", 1);
+			return -EINTR;
+		}
+				
+		timeo = ipmi_wait_for_queue(i, timeo);
+	}
+
+	rcvmsg = list_entry(i->msg_list.next, struct ipmi_recv_msg, link);
+	list_del(&rcvmsg->link);	
+	spin_unlock_irqrestore(&i->lock, flags);
+
+	memcpy(&addr.ipmi_addr, &rcvmsg->addr, sizeof(addr.ipmi_addr));
+	addr.if_num = i->addr.if_num;
+	addr.sipmi_family = i->addr.sipmi_family;
+	memcpy(msg->msg_name, &addr, sizeof(addr));
+	msg->msg_namelen = (SOCKADDR_IPMI_OVERHEAD
+			    + ipmi_addr_length(rcvmsg->addr.addr_type));
+
+	smsg->recv_type		= rcvmsg->recv_type;
+	smsg->msgid		= rcvmsg->msgid;
+	smsg->netfn		= rcvmsg->msg.netfn;
+	smsg->cmd		= rcvmsg->msg.cmd;
+	smsg->data_len		= rcvmsg->msg.data_len;
+	memcpy(smsg->data, rcvmsg->msg.data, smsg->data_len);
+	
+	ipmi_free_recv_msg(rcvmsg);
+	
+	err = memcpy_toiovec(msg->msg_iov, (void *)smsg, 
+			     sizeof(struct ipmi_sock_msg) + smsg->data_len);
+	if (err) {
+		dbg("Cannot copy data to user: %p", i->user);
+		return err;
+	}
+	
+	dbg("user=%p", i->user);
+	dbg("addr_type=%x, channel=%x",
+	    addr.ipmi_addr.addr_type, addr.ipmi_addr.channel);
+	dbg("netfn=%#02x, cmd=%#02x, data=%p, data_len=%x", 
+	    smsg->netfn, smsg->cmd, smsg->data, smsg->data_len);
+
+	return (sizeof(struct ipmi_sock_msg) + smsg->data_len);
+}
+
+static int ipmi_sendmsg(struct kiocb *iocb, struct socket *sock,
+			struct msghdr *msg, size_t len)
+{
+	struct ipmi_sock         *i = to_ipmi_sock(sock->sk);
+	struct sockaddr_ipmi     *addr = (struct sockaddr_ipmi *)msg->msg_name;
+	struct kernel_ipmi_msg   imsg;
+	unsigned char            buf[IPMI_MAX_SOCK_MSG_LENGTH];
+	struct ipmi_sock_msg     *smsg = (struct ipmi_sock_msg *) buf;
+	int                      err;
+	struct ipmi_timing_parms tparms;
+	struct cmsghdr           *cmsg;
+
+	err = ipmi_validate_addr(&addr->ipmi_addr,
+				 msg->msg_namelen - SOCKADDR_IPMI_OVERHEAD);
+	if (err) {
+		dbg("Invalid IPMI address: %p", i->user);
+		goto err;
+	}
+
+	if (len > IPMI_MAX_SOCK_MSG_LENGTH) {
+		err = -EINVAL;
+		dbg("Message too long: %p", i->user);
+		goto err;
+	}
+	
+	if (len < sizeof(struct ipmi_sock_msg)) {
+		err = -EINVAL;
+		dbg("Msg data too small for header: %p", i->user);
+		goto err;
+	}
+
+	err = memcpy_fromiovec((void *)smsg, msg->msg_iov, len);
+	if (err) {
+		dbg("Cannot copy data to kernel: %p", i->user);
+		goto err;
+	}
+	
+	if (len < smsg->data_len+sizeof(struct ipmi_sock_msg)) {
+		err = -EINVAL;
+		dbg("Msg data is out of bound: %p", i->user);
+		goto err;
+	}
+
+	/* Set defaults. */
+	tparms.retries = i->default_retries;
+	tparms.retry_time_ms = i->default_retry_time_ms;
+
+	for (cmsg=CMSG_FIRSTHDR(msg);
+	     cmsg;
+	     cmsg = CMSG_NXTHDR(msg, cmsg))
+	{
+		if (cmsg->cmsg_len < sizeof(struct cmsghdr)) {
+			err = -EINVAL;
+			dbg("cmsg length too short: %p", i->user);
+			goto err;
+		}
+
+		if (cmsg->cmsg_level != SOL_SOCKET)
+			continue;
+
+		if (cmsg->cmsg_type == IPMI_CMSG_TIMING_PARMS) {
+			struct ipmi_timing_parms *pparms;
+
+			if (cmsg->cmsg_len != CMSG_LEN(sizeof(*pparms))) {
+				err = -EINVAL;
+				dbg("timing parms cmsg not right size: %p",
+				    i->user);
+				goto err;
+			}
+			pparms = (struct ipmi_timing_parms *) CMSG_DATA(cmsg);
+			tparms.retries = pparms->retries;
+			tparms.retry_time_ms = pparms->retry_time_ms;
+		}
+	}
+	
+	imsg.netfn 	= smsg->netfn;
+	imsg.cmd	= smsg->cmd;
+	imsg.data 	= smsg->data;
+	imsg.data_len 	= smsg->data_len;
+
+	dbg("user=%p", i->user);
+	dbg("addr_type=%x, channel=%x",
+	    addr->ipmi_addr.addr_type, addr->ipmi_addr.channel);
+	dbg("netfn=%#02x, cmd=%#02x, data=%p, data_len=%x", 
+	    imsg.netfn, imsg.cmd, imsg.data, imsg.data_len);
+	err = ipmi_request_settime(i->user, &addr->ipmi_addr,
+				   smsg->msgid, &imsg, NULL, 0,
+				   tparms.retries, tparms.retry_time_ms);
+	if (err) {
+		dbg("Cannot send message: %p", i->user);
+		goto err;
+	}
+	
+err:
+	return err;
+}
+
+static struct proto_ops ipmi_ops = {
+	.family =	PF_IPMI,
+	.owner =	THIS_MODULE,
+	.release =	ipmi_release,
+	.bind =		ipmi_bind,
+	.connect =	sock_no_connect,
+	.socketpair =	sock_no_socketpair,
+	.accept =	sock_no_accept,
+	.getname =	ipmi_getname,
+	.poll =		ipmi_poll,
+	.ioctl =	ipmi_ioctl,
+	.listen =	sock_no_listen,
+	.shutdown =	sock_no_shutdown,
+	.setsockopt =	sock_no_setsockopt,
+	.getsockopt =	sock_no_getsockopt,
+	.sendmsg =	ipmi_sendmsg,
+	.recvmsg =	ipmi_recvmsg,
+	.mmap =		sock_no_mmap,
+	.sendpage =	sock_no_sendpage
+};
+
+
+static void ipmi_sock_destructor(struct sock *sk)
+{
+	skb_queue_purge(&sk->sk_receive_queue);
+
+	BUG_TRAP(!atomic_read(&sk->sk_wmem_alloc));
+	BUG_TRAP(sk_unhashed(sk));
+	BUG_TRAP(!sk->sk_socket);
+	if (!sock_flag(sk, SOCK_DEAD)) {
+		printk("Attempt to release alive ipmi socket: %p\n", sk);
+		return;
+	}
+
+	atomic_dec(&ipmi_nr_socks);
+}
+
+/*
+ * net protocol functions
+ */
+static struct ipmi_sock *ipmi_socket_create1(struct socket *sock)
+{
+	struct ipmi_sock *i;
+
+	i = (struct ipmi_sock *)sk_alloc(PF_IPMI, GFP_KERNEL, 
+					 sizeof(struct ipmi_sock), ipmi_sk_cachep);
+	if (!i) {
+		return NULL;
+	}
+	
+	sock_init_data(sock, &i->sk);
+	sk_set_owner(&i->sk, THIS_MODULE);
+	i->sk.sk_destruct = ipmi_sock_destructor;
+	i->sk.sk_rcvtimeo = 5*HZ;
+	spin_lock_init(&i->lock);
+	INIT_LIST_HEAD(&i->msg_list);
+	init_waitqueue_head(&i->wait);
+
+	/* Set to use default values. */
+	i->default_retries = -1;
+	i->default_retry_time_ms = 0;
+
+	atomic_inc(&ipmi_nr_socks);
+	return i;
+}
+
+static int ipmi_socket_create(struct socket *sock, int protocol)
+{
+	if (!capable(CAP_NET_RAW))
+		return -EPERM;
+	if (protocol && protocol != PF_IPMI)
+		return -EPROTONOSUPPORT;
+
+	sock->state = SS_UNCONNECTED;
+
+	switch (sock->type) {
+	case SOCK_RAW:
+		sock->type=SOCK_DGRAM;	
+	case SOCK_DGRAM:
+		sock->ops = &ipmi_ops;
+		break;
+	default:
+		return -EPROTONOSUPPORT;
+	}
+	
+	return ipmi_socket_create1(sock)? 0 : -ENOMEM;
+}
+
+static struct net_proto_family ipmi_family_ops = {
+	.family = PF_IPMI,
+	.create = ipmi_socket_create,
+	.owner	= THIS_MODULE,
+};
+
+
+/* 
+ * init/exit functions
+ */
+static int __init ipmi_socket_init(void)
+{
+
+	int err=0;
+	
+	printk(KERN_INFO "ipmi socket interface version "
+	       IPMI_SOCKINTF_VERSION "\n");
+
+	ipmi_sk_cachep = kmem_cache_create("ipmi_sock",
+					   sizeof(struct ipmi_sock), 0,
+					   SLAB_HWCACHE_ALIGN, 0, 0);
+	if (!ipmi_sk_cachep) {
+		printk(KERN_CRIT "%s: Unable to create ipmi_sock SLAB cache!\n", __func__);
+		err = -ENOMEM;
+		goto out;
+	}
+	
+	err = sock_register(&ipmi_family_ops);
+	if (err)
+		kmem_cache_destroy(ipmi_sk_cachep);
+out:
+	return err;
+}
+
+static void __exit ipmi_socket_exit(void)
+{
+	sock_unregister(PF_IPMI);
+	kmem_cache_destroy(ipmi_sk_cachep);
+}
+
+#ifdef CONFIG_DEBUG_KERNEL
+module_param(debug, int, 0);
+#endif
+module_init(ipmi_socket_init);
+module_exit(ipmi_socket_exit);
+
+MODULE_LICENSE("GPL");
Index: linux-ipmi/net/ipmi/Makefile
===================================================================
--- linux-ipmi.orig/net/ipmi/Makefile	1969-12-31 18:00:00.000000000 -0600
+++ linux-ipmi/net/ipmi/Makefile	2004-11-17 15:19:37.000000000 -0600
@@ -0,0 +1 @@
+obj-$(CONFIG_IPMI_SOCKET) = af_ipmi.o
Index: linux-ipmi/net/Kconfig
===================================================================
--- linux-ipmi.orig/net/Kconfig	2004-11-17 15:19:30.000000000 -0600
+++ linux-ipmi/net/Kconfig	2004-11-17 15:19:37.000000000 -0600
@@ -71,6 +71,17 @@
 
 	  Say Y unless you know what you are doing.
 
+config IPMI_SOCKET
+	tristate "IPMI sockets"
+	depends on IPMI_HANDLER
+	---help---
+	  If you say Y here, you will include support for IPMI sockets;
+	  This way you don't have to use devices to access IPMI.  You
+	  must also enable the IPMI message handler and a low-level
+	  driver in the Character Drivers if you enable this.
+	  
+	  If unsure, say N.
+
 config NET_KEY
 	tristate "PF_KEY sockets"
 	select XFRM
Index: linux-ipmi/net/Makefile
===================================================================
--- linux-ipmi.orig/net/Makefile	2004-11-17 15:19:30.000000000 -0600
+++ linux-ipmi/net/Makefile	2004-11-17 15:19:37.000000000 -0600
@@ -42,6 +42,7 @@
 obj-$(CONFIG_ECONET)		+= econet/
 obj-$(CONFIG_VLAN_8021Q)	+= 8021q/
 obj-$(CONFIG_IP_SCTP)		+= sctp/
+obj-$(CONFIG_IPMI_SOCKET)	+= ipmi/
 
 ifeq ($(CONFIG_NET),y)
 obj-$(CONFIG_SYSCTL)		+= sysctl_net.o

--------------060909000500040805010503--
