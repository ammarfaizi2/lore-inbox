Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130355AbRAIOFp>; Tue, 9 Jan 2001 09:05:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129853AbRAIOF2>; Tue, 9 Jan 2001 09:05:28 -0500
Received: from dsl081-146-215-chi1.dsl-isp.net ([64.81.146.215]:4616 "EHLO
	manetheren.eigenray.com") by vger.kernel.org with ESMTP
	id <S129226AbRAIOFJ>; Tue, 9 Jan 2001 09:05:09 -0500
Date: Tue, 9 Jan 2001 08:03:18 -0600 (CST)
From: Paul Cassella <pwc@speakeasy.net>
To: Andrew Morton <andrewm@uow.edu.au>, Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
        "David S. Miller" <davem@redhat.com>
Subject: Re: 2.4.0-ac3 write() to tcp socket returning errno of -3 (ESRCH:
 "No such process")
In-Reply-To: <3A5B0A59.1EB60A88@uow.edu.au>
Message-ID: <Pine.LNX.4.21.0101090727000.834-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2001, Andrew Morton wrote:

> is this still reproducible?  If so can I send you a debugging
> patch to diagnose a bit further?

Yes to both.  If I get a patch in the next hour or so, I can have it
running before I go to work.  Otherwise I won't be able to try it until
this evening.


With the appended patch, I got these logged, and the
application produces the expected error, all with the same timestamp:

tcp.c:1165:tcp_sendmsg: err is unexpectedly -375.
tcp.c:963:tcp_sendmsg: err is unexpectedly -375.
tcp_sendmsg:991: copy = -375, mss_now = 512, skb->len = 887, skb_tailroom(skb) = 521, seglen = 37. 

The second message is misleading; err is not -375 at this point, copied
is.

I'm looking at how these were produced, and they seem to be in the
opposite order that the code produces them?

If you're trying to find these in an unpatched file, The first (line 1165
above) printk() is in the err = copied case of do_fault2.  The second is
in the if(err) goto do_fault2 check.  The last is right after this in
tcp_sendmsg.

  if(copy > seglen) 
      copy = seglen;


This is kind of frightening; the printk on line 991 is effectively inside

  if(mss_now - skb->len > 0)

and mss_now seems to be less than skb->len when the printk happens.  My
copy of K&R is at work; could that comparison be being done unsigned
because of skb->len?  I wouldn't think so, but the alternative seems
somewhat worse...

Most of this patch is to tcp_sendmsg.

diff -ru linux-2.4.0-ac3/net/ipv4/tcp.c linux-2.4.0-ac3-debugging/net/ipv4/tcp.c
--- linux-2.4.0-ac3/net/ipv4/tcp.c	Mon Jan  8 22:41:14 2001
+++ linux-2.4.0-ac3-debugging/net/ipv4/tcp.c	Mon Jan  8 23:02:03 2001
@@ -451,6 +451,23 @@
 
 #define TCP_PAGES(amt) (((amt)+TCP_MEM_QUANTUM-1)/TCP_MEM_QUANTUM)
 
+#define CHECK_TCP_RET() check_tcp_ret(err, __FILE__, __LINE__, __FUNCTION__)
+
+void check_tcp_ret(int ret, char *file, int line, char *func) {
+  if(ret < 0) {
+	switch(-ret) {
+	  case EAGAIN: case EBADF: case EPIPE: case ENOSPC: case EIO: case ECONNRESET:
+	  case EINTR: case ETIMEDOUT: case EFAULT: case EINVAL: case EMSGSIZE: case ENOMEM:
+	  case ENOBUFS: case ENOTCONN: case ECONNREFUSED: case ERESTARTSYS: case EHOSTUNREACH:
+		break;
+
+	  default:
+		printk(KERN_ERR "%s:%d:%s: err is unexpectedly %d.\n", file, line, func, ret);
+	}
+  }
+}
+
+
 int tcp_mem_schedule(struct sock *sk, int size, int kind)
 {
 	int amt = TCP_PAGES(size);
@@ -883,6 +900,8 @@
 	}
 	current->state = TASK_RUNNING;
 	remove_wait_queue(sk->sleep, &wait);
+	if(timeo < 0)
+	  printk(KERN_ERR "wait_for_tcp_memory: timeo == %ld\n", timeo);
 	return timeo;
 }
 
@@ -916,8 +935,10 @@
 
 	/* Wait for a connection to finish. */
 	if ((1 << sk->state) & ~(TCPF_ESTABLISHED | TCPF_CLOSE_WAIT))
-		if((err = wait_for_tcp_connect(sk, flags, &timeo)) != 0)
-			goto out_unlock;
+	  if((err = wait_for_tcp_connect(sk, flags, &timeo)) != 0) {
+		CHECK_TCP_RET();
+		goto out_unlock;
+	  }
 
 	/* This should be in poll */
 	clear_bit(SOCK_ASYNC_NOSPACE, &sk->socket->flags);
@@ -938,8 +959,11 @@
 		while (seglen > 0) {
 			int copy, tmp, queue_it;
 
-			if (err)
-				goto do_fault2;
+			if (err) {
+			  if(copied) check_tcp_ret(copied, __FILE__, __LINE__, __FUNCTION__);
+			  else CHECK_TCP_RET();
+			  goto do_fault2;
+			}
 
 			/* Stop on errors. */
 			if (sk->err)
@@ -948,7 +972,7 @@
 			/* Make sure that we are established. */
 			if (sk->shutdown & SEND_SHUTDOWN)
 				goto do_shutdown;
-	
+
 			/* Now we need to check if we have a half
 			 * built packet we can tack some data onto.
 			 */
@@ -964,6 +988,7 @@
 						copy = skb_tailroom(skb);
 					if(copy > seglen)
 						copy = seglen;
+					if(copy < 0) printk(KERN_ERR "tcp_sendmsg:%d: copy = %d, mss_now = %d, skb->len = %d, skb_tailroom(skb) = %d, seglen = %d.\n", __LINE__ copy, mss_now, skb->len, skb_tailroom(skb), seglen);
 					if(last_byte_was_odd) {
 						if(copy_from_user(skb_put(skb, copy),
 								  from, copy))
@@ -975,6 +1000,7 @@
 							csum_and_copy_from_user(
 							from, skb_put(skb, copy),
 							copy, skb->csum, &err);
+						CHECK_TCP_RET();
 					}
 					/*
 					 * FIXME: the *_user functions should
@@ -1042,6 +1068,7 @@
 				}
 				if (signal_pending(current)) {
 					err = sock_intr_errno(timeo);
+			  CHECK_TCP_RET();
 					goto do_interrupted;
 				}
 				timeo = wait_for_tcp_memory(sk, timeo);
@@ -1078,8 +1105,11 @@
 			skb->csum = csum_and_copy_from_user(from,
 					skb_put(skb, copy), copy, 0, &err);
 
-			if (err)
-				goto do_fault;
+			if (err) {
+			  if(copied) check_tcp_ret(copied, __FILE__, __LINE__, __FUNCTION__);
+			  else CHECK_TCP_RET();
+			  goto do_fault;
+			}
 
 			from += copy;
 			copied += copy;
@@ -1092,6 +1122,7 @@
 		}
 	}
 	err = copied;
+			  CHECK_TCP_RET();
 out:
 	__tcp_push_pending_frames(sk, tp, mss_now, tp->nonagle);
 out_unlock:
@@ -1100,14 +1131,20 @@
 	return err;
 
 do_sock_err:
-	if (copied)
+	if (copied) {
 		err = copied;
-	else
+		CHECK_TCP_RET();
+
+	} else {
 		err = sock_error(sk);
+		CHECK_TCP_RET();
+	}
 	goto out;
 do_shutdown:
-	if (copied)
+	if (copied) {
 		err = copied;
+		CHECK_TCP_RET();
+	}
 	else {
 		if (!(flags&MSG_NOSIGNAL))
 			send_sig(SIGPIPE, current, 0);
@@ -1115,14 +1152,18 @@
 	}
 	goto out;
 do_interrupted:
-	if (copied)
+	if (copied) {
 		err = copied;
+		CHECK_TCP_RET();
+	}
 	goto out_unlock;
 do_fault:
 	__kfree_skb(skb);
 do_fault2:
-	if (copied)
+	if (copied) {
 		err = copied;
+		CHECK_TCP_RET();
+	}
 	else
 		err = -EFAULT;
 	goto out;
@@ -1283,6 +1324,8 @@
 
 	remove_wait_queue(sk->sleep, &wait);
 	__set_current_state(TASK_RUNNING);
+	if(timeo < 0)
+	  printk(KERN_ERR "tcp_data_wait: timeo == %ld.\n", timeo);
 	return timeo;
 }
 
@@ -2026,8 +2069,10 @@
 		if (sk->state != TCP_LISTEN)
 			break;
 		err = sock_intr_errno(timeo);
-		if (signal_pending(current))
+		if (signal_pending(current)) {
+  		    CHECK_TCP_RET();
 			break;
+		}
 		err = -EAGAIN;
 		if (!timeo)
 			break;


-- 
Paul Cassella

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
