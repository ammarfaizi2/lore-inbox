Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262898AbTC0Gu5>; Thu, 27 Mar 2003 01:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262897AbTC0Gu5>; Thu, 27 Mar 2003 01:50:57 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:29327 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S262894AbTC0Gud>; Thu, 27 Mar 2003 01:50:33 -0500
Message-ID: <3E82A1CB.7090408@nortelnetworks.com>
Date: Thu, 27 Mar 2003 02:01:31 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com, linux-net@vger.kernel.org
Subject: [RFC|PATCH] AF_UNIX multicast capability for 2.5.66
Content-Type: multipart/mixed;
 boundary="------------020204070109060409000206"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020204070109060409000206
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


For those who didn't read the first couple threads, this patch adds multicast 
functionality to unix sockets, in similar fashion (and using a similar API) as 
UDP multicast, but easier to use.

To use the functionality, in userspace you would allocate and bind a socket as 
normal in the AF_UNIX family, and then you would use setsockop() to associate 
yourself with one or more multicast addresses, also in the AF_UNIX family.  Any 
message sent to a multicast address gets duplicated by the kernel and 
distributed to all processes associated with that address.

If an address already exists and is not multicast, you cannot associate yourself 
with it using setsockopt(), and if it exists and is multicast, you cannot bind() 
do it.  All AF_UNIX addresses exist in the same namespace and must be either 
multicast or unicast.

It does not make sense to allow streaming to a multicast address, so I plan on 
disallowing this (and other similar things) in a future release of the patch. 
I'm not sure about allowing datagram sockets to connect() to a multicast 
address, I haven't looked at the code in depth.

At any rate, here are the results of some testing on the latest kernel comparing 
kernel multicast against a userspace solution.  There is a sender program which 
sends messages of various sizes to various numbers of listeners.  Each message 
has a timestamp embedded within it, and the listeners determine the latency 
between the sending and receiving of the message.  In the userspace solution, 
the list of listeners is kept in a shared memory area, which is faster than 
using a distributor process.

In the interests of figuring out the best possible performance I've changed the 
testing methodology from the last bunch of tests, and the organization of the 
results is slightly different to make it easier to add new results. In this test 
sequence the sender and receiver processes have been run with nice -20 to 
minimize interference from other entities in the system.  These are best-case 
results from a number of runs, but the numbers are fairly consistant across runs.


data size and kernel                 number of listeners
44 bytes                   10       20          50          100        200
2.5.66 userspace        134,297    206,561   416,1401     761,2824    1500,5711
2.5.66 kernelspace      75,232     119,457   213,1142     356,2308    679,4710

236 bytes
2.5.66 userspace       143,306    218,584    447,1472     814,3013    1399,6007
2.5.66 kernelspace      80,244    115,469    216,1176     365,2371    682,4893

40036 bytes
2.5.66 userspace        478,3613  497,7405  496,18114    487,36759    518,74566
2.5.66 kernelspace      287,1672  327,3299  444,8129     663,16125   1000,31937


The numbers definately favour a kernel-space solution.  That said, it would be 
possible to implement this using UDP messaging, but UDP latency is generally 
about 30 percent higher than AF_UNIX on my 1.8GHz P4, and it's more of a hassle 
to configure UDP multicast.

I would appreciate any comments on the patch, if you see any technical bugs or 
if you think there is a better way to do something please do let me know.  I'm 
sure there's some fine point about locking that I missed, or something similar.

Thanks,

Chris




-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

--------------020204070109060409000206
Content-Type: text/plain;
 name="unixmcast-2.5.66.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="unixmcast-2.5.66.patch"

diff -Nru a/include/linux/un.h b/include/linux/un.h
--- a/include/linux/un.h	Thu Mar 27 01:53:11 2003
+++ b/include/linux/un.h	Thu Mar 27 01:53:11 2003
@@ -8,4 +8,12 @@
 	char sun_path[UNIX_PATH_MAX];	/* pathname */
 };
 
+#ifdef CONFIG_UNIX_MULTICAST
+
+#define UNIX_ADD_MEMBERSHIP   35
+#define UNIX_DROP_MEMBERSHIP  36
+
+#endif
+
+
 #endif /* _LINUX_UN_H */
diff -Nru a/include/net/af_unix.h b/include/net/af_unix.h
--- a/include/net/af_unix.h	Thu Mar 27 01:53:11 2003
+++ b/include/net/af_unix.h	Thu Mar 27 01:53:11 2003
@@ -61,6 +61,20 @@
 #define unix_state_wunlock(s)	write_unlock(&unix_sk(s)->lock)
 
 #ifdef __KERNEL__
+
+#ifdef CONFIG_UNIX_MULTICAST
+struct unix_mcast
+{
+	unix_socket *listener;
+	unix_socket *addr;
+	struct unix_mcast *nextlistener;
+	struct unix_mcast *prevlistener;
+	struct unix_mcast *nextaddr;
+	struct unix_mcast *prevaddr;
+};
+
+#endif
+
 /* The AF_UNIX socket */
 struct unix_sock {
 	/* WARNING: sk has to be the first member */
@@ -75,6 +89,10 @@
         atomic_t                inflight;
         rwlock_t                lock;
         wait_queue_head_t       peer_wait;
+#ifdef CONFIG_UNIX_MULTICAST
+	int                     is_mcast_addr;
+	struct unix_mcast       *mcastnode;
+#endif
 };
 #define unix_sk(__sk) ((struct unix_sock *)__sk)
 #endif
diff -Nru a/net/Kconfig b/net/Kconfig
--- a/net/Kconfig	Thu Mar 27 01:53:11 2003
+++ b/net/Kconfig	Thu Mar 27 01:53:11 2003
@@ -157,6 +157,19 @@
 
 	  Say Y unless you know what you are doing.
 
+config UNIX_MULTICAST
+	bool "Unix domain multicasting (EXPERIMENTAL)"
+	depends on UNIX && EXPERIMENTAL
+	---help---
+	  If you say Y here you will include support for multicast unix domain
+	  sockets.  Multiple sockets can add themselves to a multicast address 
+	  group, and any packet sent to the multicast address will be distributed
+	  to all unix sockets that have associated themselves with the multicast
+	  address.
+
+	  This code is experimental.  Say N unless you want to try efficient
+	  one-sender many-listeners messaging.
+
 config NET_KEY
 	tristate "PF_KEY sockets"
 	---help---
diff -Nru a/net/unix/af_unix.c b/net/unix/af_unix.c
--- a/net/unix/af_unix.c	Thu Mar 27 01:53:11 2003
+++ b/net/unix/af_unix.c	Thu Mar 27 01:53:11 2003
@@ -172,6 +172,28 @@
 		kfree(addr);
 }
 
+#ifdef CONFIG_UNIX_MULTICAST
+//call with write locks held on both sockets that have links to the node
+static void unlink_mcast_node(struct unix_mcast *node)
+{
+	if (node->prevlistener==NULL)
+		unix_sk(node->addr)->mcastnode = node->nextlistener;
+	else
+		node->prevlistener->nextlistener = node->nextlistener;
+		
+	if (node->nextlistener!=NULL)
+		node->nextlistener->prevlistener = node->prevlistener;
+	
+	if (node->prevaddr==NULL)
+		unix_sk(node->listener)->mcastnode = node->nextaddr;
+	else
+		node->prevaddr->nextaddr = node->nextaddr;
+	if (node->nextaddr!=NULL)
+		node->nextaddr->prevaddr = node->prevaddr;
+}
+#endif
+
+
 /*
  *	Check unix socket name:
  *		- should be not zero length.
@@ -342,7 +364,7 @@
 static void unix_sock_destructor(struct sock *sk)
 {
 	struct unix_sock *u = unix_sk(sk);
-
+	
 	skb_queue_purge(&sk->receive_queue);
 
 	BUG_TRAP(atomic_read(&sk->wmem_alloc) == 0);
@@ -363,6 +385,60 @@
 	MOD_DEC_USE_COUNT;
 }
 
+#ifdef CONFIG_UNIX_MULTICAST
+//must hold wlock on sk before calling
+static void unix_release_mcast(unix_socket *sk)
+{
+	struct unix_sock *u = unix_sk(sk);
+	struct unix_mcast *node;
+	struct unix_mcast *oldnode;
+	unix_socket *other;
+	struct unix_sock *o;
+	struct socket *releasesock;
+	
+	if (!u->mcastnode)
+		return;
+	
+	//otherwise we want to walk the chain and unlink from any multicast
+	//addresses with which we are registered
+	node = u->mcastnode;
+	
+	while(node!=NULL){
+		other=node->addr;
+		o = unix_sk(other);
+		unix_state_wlock(other);
+		
+		unlink_mcast_node(node);
+		
+		sock_put(sk);
+		sock_put(other);
+		
+		//if the socket has no more listeners, clean it up
+		if (!o->mcastnode)
+			releasesock=o->sk.socket;
+		else
+			releasesock=NULL;
+			
+		unix_state_wunlock(other);
+		
+		oldnode=node;
+		node=node->nextaddr;
+		
+		//printk("freeing multicast node at %p\n",oldnode);
+		kfree(oldnode);
+		
+		if (releasesock) {
+			//printk("releasing multicast socket at %p\n",releasesock);
+			sock_release(releasesock);
+		}
+	}
+	
+	return;
+}
+#endif
+
+
+
 static int unix_release_sock (unix_socket *sk, int embrion)
 {
 	struct unix_sock *u = unix_sk(sk);
@@ -376,6 +452,10 @@
 
 	/* Clear state */
 	unix_state_wlock(sk);
+	
+#ifdef CONFIG_UNIX_MULTICAST
+	unix_release_mcast(sk);
+#endif
 	sock_orphan(sk);
 	sk->shutdown = SHUTDOWN_MASK;
 	dentry	     = u->dentry;
@@ -509,6 +589,10 @@
 	init_MUTEX(&u->readsem); /* single task reading lock */
 	init_waitqueue_head(&u->peer_wait);
 	unix_insert_socket(&unix_sockets_unbound, sk);
+#ifdef CONFIG_UNIX_MULTICAST
+	u->is_mcast_addr = 0;
+	u->mcastnode = NULL;
+#endif	
 
 	return sk;
 }
@@ -1204,6 +1288,13 @@
 	unsigned hash;
 	struct sk_buff *skb;
 	long timeo;
+#ifdef CONFIG_UNIX_MULTICAST
+	struct unix_sock *o;
+	struct unix_mcast *node=NULL;
+	unix_socket *addr=NULL;
+	int sentmsgs=0;
+	struct sk_buff *dupskb=NULL;
+#endif
 	struct scm_cookie tmp_scm;
 
 	if (NULL == siocb->scm)
@@ -1262,10 +1353,11 @@
 			goto out_free;
 	}
 
+mcastrestart:
 	unix_state_rlock(other);
 	err = -EPERM;
 	if (!unix_may_send(sk, other))
-		goto out_unlock;
+		goto mcast_out_unlock;
 
 	if (test_bit(SOCK_DEAD, &other->flags)) {
 		/*
@@ -1290,48 +1382,143 @@
 
 		other = NULL;
 		if (err)
-			goto out_free;
+			goto mcast_out_unlock;
+#ifdef CONFIG_UNIX_MULTICAST
+		if (addr!=NULL)
+			goto mcast_out_unlock;
+#endif
 		goto restart;
 	}
 
 	err = -EPIPE;
 	if (other->shutdown&RCV_SHUTDOWN)
-		goto out_unlock;
+		goto mcast_out_unlock;
 
 	err = security_unix_may_send(sk->socket, other->socket);
 	if (err)
-		goto out_unlock;
+		goto mcast_out_unlock;
 
 	if (unix_peer(other) != sk &&
 	    skb_queue_len(&other->receive_queue) > other->max_ack_backlog) {
 		if (!timeo) {
 			err = -EAGAIN;
-			goto out_unlock;
+			printk("unable to send to socket\n");
+			goto mcast_out_unlock;
 		}
 
 		timeo = unix_wait_for_peer(other, timeo);
+		other=NULL;
 
 		err = sock_intr_errno(timeo);
 		if (signal_pending(current))
 			goto out_free;
 
+#ifdef CONFIG_UNIX_MULTICAST
+		if (addr!=NULL)
+			goto mcast_out_unlock;
+#endif
 		goto restart;
 	}
+	
+#ifdef CONFIG_UNIX_MULTICAST
+	//works but could be better.  for multicast we hit two conditionals for each time through
+	o=unix_sk(other);
+	if (o->mcastnode) {
+		if ((addr==NULL) && (o->is_mcast_addr)) {
+			//printk("setting up initial real dest\n");
+			addr=other;
+			node=o->mcastnode;
+			if (node!=NULL) {
+				other=node->listener;
+				//printk("going back to mcastrestart\n");
+				goto mcastrestart;
+			} else {
+				err=-ECONNREFUSED;
+				goto out_unlock;
+			}
+		}	
 
+		if (node->nextlistener != NULL) {
+			//printk("duping skb\n");
+			dupskb=skb_clone(skb,GFP_ATOMIC);
+			
+			//note: does atomic_add(skb->truesize, &sk->wmem_alloc);
+			//do we want to charge the sender for the skb?
+			skb_set_owner_w(dupskb, sk);
+
+		}
+	}
+#endif
+
+	//if (addr!=NULL)
+		//printk("queueing skb\n");
 	skb_queue_tail(&other->receive_queue, skb);
 	unix_state_runlock(other);
 	other->data_ready(other, len);
+	
+#ifdef CONFIG_UNIX_MULTICAST
+	if (addr!=NULL) {
+		sentmsgs++;
+		//printk("incrementing sentmsgs\n");
+		
+		if (dupskb!=NULL) {
+			node=node->nextlistener;
+			other=node->listener;
+			skb=dupskb;
+			dupskb=NULL;
+			//printk("setting skb to dup, going to next listener, back to mcastrestart\n");
+			goto mcastrestart;
+		}			
+		other=addr;
+		unix_state_runlock(other);
+		//printk("unlocking real address, putting other, and returning len\n");
+	}
+#endif
 	sock_put(other);
 	scm_destroy(siocb->scm);
 	return len;
 
+mcast_out_unlock:
+#ifdef CONFIG_UNIX_MULTICAST
+	//something bad happened, were unable to send to a final destination
+	if (addr!=NULL) {
+		//printk("handling error\n");
+		if (other) {
+			//printk("unlocking real address\n");
+			unix_state_runlock(other);
+		}
+		//we are sending to a multicast address
+		if (node->nextlistener != NULL) {
+			//if there are any more listeners, keep going.
+			node=node->nextlistener;
+			other=node->listener;
+			//printk("going to next listener, back to mcastrestart\n");
+			goto mcastrestart;			
+		} else {
+			//oops, no more listeners.  If any listeners got it treat is
+			//as successful
+			//printk("setting other to addr\n");
+			other=addr;
+			if (sentmsgs) {
+				//printk("setting err to len\n");
+				err=len;
+			}
+		}
+	}
+#endif
+
 out_unlock:
-	unix_state_runlock(other);
+	if (other) {
+		//printk("unlocking fake address\n");
+		unix_state_runlock(other);
+	}
 out_free:
 	kfree_skb(skb);
 out:
-	if (other)
+	if (other) {
+		//printk("putting fake address and returning err\n");
 		sock_put(other);
+	}
 	scm_destroy(siocb->scm);
 	return err;
 }
@@ -1883,6 +2070,230 @@
 }
 #endif
 
+#ifdef CONFIG_UNIX_MULTICAST
+static int unix_mc_attach(unix_socket *sk , int optlen, struct sockaddr_un *mreq)
+{
+	int err=0;
+	struct unix_sock *u = unix_sk(sk);
+	struct unix_mcast *node;
+	unix_socket *other;
+	struct socket *newsocket;
+	struct sockaddr_un *sunaddr;
+	int namelen;
+	unsigned hash;	
+		
+	//now see if the address we're trying to join already has a socket
+	sunaddr=mreq;
+	err = unix_mkname(sunaddr, optlen, &hash);
+	if (err < 0)
+		return err;
+		
+	namelen = err;	
+
+	other = unix_find_other(sunaddr, namelen, SOCK_DGRAM, hash, &err);
+	if (other==NULL) {
+		//allocate a socket for the listening address
+		err=sock_create(AF_UNIX, SOCK_DGRAM, 0, &newsocket);
+		if (err<0)
+			return err;
+			
+		//printk("created multicast socket at %p\n",newsocket);
+				
+		//okay, have to set up a new multicast destination socket
+		err = newsocket->ops->bind(newsocket,(struct sockaddr*) sunaddr, optlen);
+		if (err<0)
+			goto release_out;
+		
+		other=newsocket->sk;
+		unix_state_wlock(other);
+		unix_sk(other)->mcastnode=NULL;
+		unix_sk(other)->is_mcast_addr=1;
+		unix_state_wunlock(other);
+	} else {
+		//if the address exists but isn't a multicast address, we can't attach to it
+		if (!unix_sk(other)->is_mcast_addr)
+			return -EADDRINUSE;
+	}
+	
+	//try and allocate a multicast node
+	node=(struct unix_mcast *)kmalloc(sizeof(struct unix_mcast), GFP_KERNEL);
+	if (!node) {
+		err = -ENOMEM;
+		goto release_out;
+	}
+		
+	//printk("allocated multicast node at %p\n",node);
+	
+	//now set up the multicast node
+	//this node sits on two linked lists, one for the multicast address
+	//containing nodes pointing to all the sockets associated with the address,
+	//and one for each userspace socket containing nodes pointing to all the
+	//multicast addresses that the userspace socket is listening to
+	
+	//take holds on both sockets for the node references
+	sock_hold(sk);
+	sock_hold(other);
+	
+	node->listener = sk;
+	node->addr = other;
+		
+	unix_state_wlock(sk);
+	unix_state_wlock(other);
+	
+	//insert node at head of list from other
+	node->nextlistener = unix_sk(other)->mcastnode;
+	node->prevlistener = NULL;
+	unix_sk(other)->mcastnode = node;
+	if (node->nextlistener!=NULL)
+		node->nextlistener->prevlistener = node;
+	
+	//insert node at head of list from sk
+	node->nextaddr = u->mcastnode;
+	node->prevaddr = NULL;
+	u->mcastnode = node;
+	if (node->nextaddr!=NULL)
+		node->nextaddr->prevaddr = node;
+	
+	unix_state_wunlock(other);
+	unix_state_wunlock(sk);
+	
+	return 0;
+	
+release_out:
+	//printk("releasing socket at %p\n",newsocket);
+	sock_release(newsocket);
+
+	return err;
+}
+
+static int unix_mc_detach(unix_socket *sk , int optlen, struct sockaddr_un *mreq)
+{
+	int err=0;
+	struct unix_mcast *node;
+	struct socket *releasesock=NULL;
+	unix_socket *other;
+	struct unix_sock *o;
+	struct sockaddr_un *sunaddr;
+	int namelen;
+	unsigned hash;
+	
+	//try and find the socket belonging to the address
+	sunaddr=mreq;
+	err = unix_mkname(sunaddr, optlen, &hash);
+	if (err < 0)
+		goto out;
+	namelen = err;
+
+	other = unix_find_other(sunaddr, namelen, SOCK_DGRAM, hash, &err);
+	o=unix_sk(other);
+	
+	if (other==NULL) {
+		//strange, trying to leave a group that doesn't exist.
+		//should probably log it
+		return 0;
+	} else {
+		//if the address exists but isn't a multicast address, we can't detach from it
+		if (!o->is_mcast_addr) {
+			err=-ENOENT;
+			goto out;
+		}
+	}
+	
+	
+	unix_state_wlock(other);
+	unix_state_wlock(sk);
+	
+	node = o->mcastnode;
+	
+	while(node)
+	{
+		if (node->listener == sk)
+			break;
+		node=node->nextlistener;
+	}
+	
+	
+	if (node->listener != sk) {
+		//not actually a group member
+		err=-EINVAL;
+		goto out;
+	}
+		
+	unlink_mcast_node(node);
+	
+	if (o->mcastnode==NULL)
+		//can I call sock_release here with the locks held since I've got
+		//a refcount on other here?
+		releasesock=o->sk.socket;
+
+	unix_state_wunlock(sk);
+	unix_state_wunlock(other);
+	
+	//give up refcounts since we're getting rid of the node
+	sock_put(sk);
+	sock_put(other);
+	
+	kfree(node);
+	
+	if (releasesock)
+		sock_release(releasesock);
+			
+out:
+	return err;
+}
+#endif
+
+
+static int unix_setsockopt(struct socket *sock, int level, int optname,
+                    char *optval, int optlen)
+{
+#ifndef CONFIG_UNIX_MULTICAST
+	return -EOPNOTSUPP;
+#else
+	int err=0;
+	struct sock *sk=sock->sk;
+	lock_sock(sk);
+	
+	if (sk->type != SOCK_DGRAM)
+		goto e_inval;
+
+	switch (optname) {
+		case UNIX_ADD_MEMBERSHIP:
+		case UNIX_DROP_MEMBERSHIP:
+		{
+			struct sockaddr_un mreq;
+
+			if (optlen > sizeof(struct sockaddr_un))
+				goto e_inval;
+			err = -EFAULT;
+
+			memset(&mreq, 0, sizeof(mreq));
+			if (copy_from_user(&mreq,optval,optlen))
+				break;
+
+			if (optname == UNIX_ADD_MEMBERSHIP)
+				err = unix_mc_attach(sk,optlen,&mreq);
+			else
+				err = unix_mc_detach(sk,optlen,&mreq);
+			break;
+		}
+		default:
+			err = -ENOPROTOOPT;
+			break;
+	}
+	release_sock(sk);
+	return err;
+
+e_inval:
+	release_sock(sk);
+	return -EINVAL;
+	
+#endif
+}
+
+
+
+
 struct proto_ops unix_stream_ops = {
 	.family =	PF_UNIX,
 	
@@ -1917,7 +2328,7 @@
 	.ioctl =	unix_ioctl,
 	.listen =	sock_no_listen,
 	.shutdown =	unix_shutdown,
-	.setsockopt =	sock_no_setsockopt,
+	.setsockopt =	unix_setsockopt,
 	.getsockopt =	sock_no_getsockopt,
 	.sendmsg =	unix_dgram_sendmsg,
 	.recvmsg =	unix_dgram_recvmsg,

--------------020204070109060409000206--

