Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268964AbRHBOlu>; Thu, 2 Aug 2001 10:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268965AbRHBOll>; Thu, 2 Aug 2001 10:41:41 -0400
Received: from hera.cwi.nl ([192.16.191.8]:40956 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S268964AbRHBOl1>;
	Thu, 2 Aug 2001 10:41:27 -0400
From: Andries.Brouwer@cwi.nl
Date: Thu, 2 Aug 2001 14:38:43 GMT
Message-Id: <200108021438.OAA110364@vlet.cwi.nl>
To: alan@lxorguk.ukuu.org.uk, davem@redhat.com, mbartz@optushome.com.au,
        torvalds@transmeta.com
Subject: Re: setsockopt(..,SO_RCVBUF,..) sets wrong value
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: "David S. Miller" <davem@redhat.com>

    Manfred Bartz writes:

     > When I do a setsockopt(..,SO_RCVBUF,..) and then read the value back
     > with getsockopt(), the reported value is exactly twice of what I set

    That's correct.  Please search the list archives to learn why things
    behave this way and why they are not going to change.

    I wish that this long winded, and often occurring thread not occur
    again.

Hmm. There are two aspects to this: explaining why "*2" is done,
and the fact that getsockopt() reports something other than
what was given to setsockopt().

The best way to prevent questions about the "*2" is to document it.
Below some text by Andi Kleen.

--- ../linux-2.4.7/linux/net/core/sock.c	Sat Jul 28 17:08:47 2001
+++ linux/net/core/sock.c	Thu Aug  2 16:23:53 2001
@@ -232,6 +232,8 @@
 				val = sysctl_wmem_max;
 
 			sk->userlocks |= SOCK_SNDBUF_LOCK;
+
+			/* For the "*2", see SO_RCVBUF below. */
 			sk->sndbuf = max(val*2,SOCK_MIN_SNDBUF);
 
 			/*
@@ -251,7 +253,18 @@
 				val = sysctl_rmem_max;
 
 			sk->userlocks |= SOCK_RCVBUF_LOCK;
-			/* FIXME: is this lower bound the right one? */
+
+			/* People regularly wonder whether the "*2" here
+			   is correct. Linux reserves half of the socket
+			   buffer for metadata (skbuff headers etc.)
+			   BSD doesn't do that. Most programs using
+			   SO_SNDBUF/SO_RCVBUF didn't expect this, because
+			   traditional BSD does not do metadata accounting,
+			   and on Linux they ended up with too small effective
+			   buffers. To fix this Linux always doubles the
+			   buffer internally to stay compatible.
+			   See also socket(7). */
+
 			sk->rcvbuf = max(val*2,SOCK_MIN_RCVBUF);
 			break;


Of course everybody will regard a system broken that has a getfoo()
that does not return what was given to setfoo().
No documentation will change that.
 
Andries
