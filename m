Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264971AbSJWNLD>; Wed, 23 Oct 2002 09:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264972AbSJWNLD>; Wed, 23 Oct 2002 09:11:03 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25349 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264971AbSJWNLC>;
	Wed, 23 Oct 2002 09:11:02 -0400
Date: Wed, 23 Oct 2002 14:17:12 +0100
From: Matthew Wilcox <willy@debian.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matthew Wilcox <willy@debian.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mingo@redhat.com
Subject: Re: [PATCH] use 1ULL instead of 1UL in kernel/signal.c
Message-ID: <20021023141712.M27461@parcelfarce.linux.theplanet.co.uk>
References: <20021022222719.H27461@parcelfarce.linux.theplanet.co.uk> <1035323879.329.185.camel@irongate.swansea.linux.org.uk> <20021022224853.I27461@parcelfarce.linux.theplanet.co.uk> <1035328632.329.187.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1035328632.329.187.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Wed, Oct 23, 2002 at 12:17:12AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2002 at 12:17:12AM +0100, Alan Cox wrote:
> Care to move the define into include/asm-foo then ?

How about this instead?  All other arches define SIGRTMIN to be 32, so
this only affects PA.

Index: kernel/signal.c
===================================================================
RCS file: /var/cvs/linux-2.5/kernel/signal.c,v
retrieving revision 1.1.2.4
diff -u -p -r1.1.2.4 signal.c
--- kernel/signal.c	21 Oct 2002 03:07:20 -0000	1.1.2.4
+++ kernel/signal.c	23 Oct 2002 13:14:33 -0000
@@ -96,7 +96,12 @@ int max_queued_signals = 1024;
 #define M_SIGEMT	0
 #endif
 
+#if SIGRTMIN > 32
+#define M(sig) (1ULL << (sig))
+#else
 #define M(sig) (1UL << (sig))
+#endif
+#define T(sig, mask) (M(sig) & mask)
 
 #define SIG_USER_SPECIFIC_MASK (\
 	M(SIGILL)    |  M(SIGTRAP)   |  M(SIGABRT)   |  M(SIGBUS)    | \
@@ -130,9 +135,6 @@ int max_queued_signals = 1024;
         M(SIGQUIT)   |  M(SIGILL)    |  M(SIGTRAP)   |  M(SIGABRT)   | \
         M(SIGFPE)    |  M(SIGSEGV)   |  M(SIGBUS)    |  M(SIGSYS)    | \
         M(SIGXCPU)   |  M(SIGXFSZ)   |  M_SIGEMT                     )
-
-#define T(sig, mask) \
-	((1UL << (sig)) & mask)
 
 #define sig_user_specific(sig) \
 		(((sig) < SIGRTMIN)  && T(sig, SIG_USER_SPECIFIC_MASK))

-- 
Revolutions do not require corporate support.
