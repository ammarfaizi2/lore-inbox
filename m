Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264726AbUJNOLx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264726AbUJNOLx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 10:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265127AbUJNOLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 10:11:53 -0400
Received: from elektron.ikp.physik.tu-darmstadt.de ([130.83.24.72]:42513 "EHLO
	elektron.ikp.physik.tu-darmstadt.de") by vger.kernel.org with ESMTP
	id S264726AbUJNOLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 10:11:48 -0400
From: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16750.35107.162305.289840@hertz.ikp.physik.tu-darmstadt.de>
Date: Thu, 14 Oct 2004 16:11:47 +0200
To: linux-kernel@vger.kernel.org
Subject: [RESENT] FIONREAD on  SOCK_STREAM socketpairs 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

a small test program (appended) shows that Linux returns only the number of
Bytes written with the first write call (here 11 bytes ) to the queue of a
socketpair, opened with SOCK_STREAM.  Other systems (tested on AIX, FreeBSD,
HPUX, Solaris) return the number of all byte (here 32) written by the repeated
calls to write().

The latter result is also consistant with the explanation for FIONREAD,
e.g. given on
http://docsun.cites.uiuc.edu/sun_docs/C/solaris_9/SUNWdev/STREAMS/p39.html:

> FIONREAD
>
> The FIONREAD ioctl returns the number of data bytes (in all data messages
> queued) in the location pointed to by the arg parameter.


For 2.4, I applied following patch:
====
--- linux/net/unix/af_unix.c.org	2004-08-12 16:47:00.000000000 +0200
+++ linux/net/unix/af_unix.c	2004-10-12 12:19:44.000000000 +0200
@@ -1692,8 +1692,12 @@
 				err = -EINVAL;
 				break;
 			}
-
 			spin_lock(&sk->receive_queue.lock);
+			if (sk->type == SOCK_STREAM)
+			  skb_queue_walk(&sk->receive_queue, skb) {
+			  amount+=skb->len;
+			}
+			else
 			if((skb=skb_peek(&sk->receive_queue))!=NULL)
 				amount=skb->len;
 			spin_unlock(&sk->receive_queue.lock);
========
and for 2.6:
========
--- linux-2.6.9-rc4/net/unix/af_unix.c.org	2004-10-11 04:58:07.000000000 +0200
+++ linux-2.6.9-rc4/net/unix/af_unix.c	2004-10-12 19:33:38.000000000 +0200
@@ -1840,9 +1840,16 @@
 			}
 
 			spin_lock(&sk->sk_receive_queue.lock);
+			if (sk->sk_type == SOCK_STREAM)
+			  skb_queue_walk(&sk->sk_receive_queue, skb) {
+			  amount+=skb->len;
+			}
+			else
+			  {
 			skb = skb_peek(&sk->sk_receive_queue);
 			if (skb)
 				amount=skb->len;
+			  }
 			spin_unlock(&sk->sk_receive_queue.lock);
 			err = put_user(amount, (int __user *)arg);
 			break;
=====

Any comments on this behaviour and patch?

Thanks

-- 
Uwe Bonnes                bon@elektron.ikp.physik.tu-darmstadt.de

Institut fuer Kernphysik  Schlossgartenstrasse 9  64289 Darmstadt
--------- Tel. 06151 162516 -------- Fax. 06151 164321 ----------
#include <stdio.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <unistd.h>

int main()
{
    int fds[2];
    const char obuf[] =  "Bit Bucket";
    const char obuf2[] = "More bits";
    char ibuf[34];
    int i, avail;

    if( !socketpair( PF_UNIX, SOCK_STREAM, 0, fds ) ) {
        printf("Success\n");
        
        write(fds[0], obuf, sizeof(obuf));
        write(fds[0], obuf2, sizeof(obuf2));
        write(fds[0], obuf, sizeof(obuf));
        i = ioctl(fds[1], FIONREAD, &avail);
        printf("FIONREAD: %d bytes avail\n", avail);
        i = read(fds[1], ibuf, sizeof(ibuf));
        printf("Read: %d bytes - %s\n", i, ibuf);
        
        close(fds[0]);
        close(fds[1]);
    }
    else
        printf("Fail\n");
    return 0;
}
