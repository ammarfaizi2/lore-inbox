Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136149AbREJMf3>; Thu, 10 May 2001 08:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136161AbREJMfT>; Thu, 10 May 2001 08:35:19 -0400
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:55177 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S136149AbREJMfL>; Thu, 10 May 2001 08:35:11 -0400
From: Ulrich.Weigand@de.ibm.com
X-Lotus-FromDomain: IBMDE
To: alan@lxorguk.ukuu.org.uk
cc: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
Message-ID: <C1256A48.00451BD1.00@d12mta11.de.ibm.com>
Date: Thu, 10 May 2001 14:34:46 +0200
Subject: Deadlock in 2.2 sock_alloc_send_skb?
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi Alan,

we've experienced deadlocks that appear to be caused by the loop in
sock_alloc_send_skb().  To trigger this, you need to combine heavy
network load with memory pressure.  In this situation, sock_wmalloc()
can fail because it really can't allocate any more memory, even though
the send buffer limit for this socket is not yet exhausted.

If that happens, and the socket uses GFP_ATOMIC allocation, the while (1)
loop in sock_alloc_send_skb() will endlessly spin, without ever calling
schedule(), and all the time holding the kernel lock ...

Do you agree that this is a problem?  What do you think about this fix:

diff -ur linux-2.2.19/net/core/sock.c linux-2.2.19-s390/net/core/sock.c
--- linux-2.2.19/net/core/sock.c   Sun Mar 25 18:37:41 2001
+++ linux-2.2.19-s390/net/core/sock.c    Thu May 10 14:02:11 2001
@@ -752,9 +752,11 @@
                    break;
               try_size = fallback;
          }
-         skb = sock_wmalloc(sk, try_size, 0, sk->allocation);
+         skb = sock_wmalloc_err(sk, try_size, 0, sk->allocation, &err);
          if (skb)
               break;
+         if (err)
+              goto failure;

          /*
           *   This means we have too many buffers for this socket already.


Test case is simple:  keep spawning lots of long-running 'ping' processes
until physical memory is exhausted.


Mit freundlichen Gruessen / Best Regards

Ulrich Weigand

--
  Dr. Ulrich Weigand
  Linux for S/390 Design & Development
  IBM Deutschland Entwicklung GmbH, Schoenaicher Str. 220, 71032 Boeblingen
  Phone: +49-7031/16-3727   ---   Email: Ulrich.Weigand@de.ibm.com


