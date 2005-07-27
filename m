Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbVG0XMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbVG0XMQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 19:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbVG0XML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 19:12:11 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:59610 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261153AbVG0XJp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 19:09:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sO/oaxBsjk4Z8B1IuEoWomd2vRowbkzqHdtY4bdN2WCVDphH4cE3/L5FIu9jYC3QnrjldYo6tc0bipRfv6W/y/2KVd1oAi4nSGtgg+TKoF1/4WBz3V5xI9TgkGurRDOIp0EvcC7ODDg+q1Jt/1glmppR4S+K25T1OEqt5lUf5Ng=
Message-ID: <279fbba4050727160916bc2d99@mail.gmail.com>
Date: Thu, 28 Jul 2005 00:09:42 +0100
From: Kerin Millar <kerframil@gmail.com>
Reply-To: Kerin Millar <kerframil@gmail.com>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: [ck] 2.6.12-ck4
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck list <ck@vds.kolivas.org>
In-Reply-To: <200507272111.27757.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200507272111.27757.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/05, Con Kolivas <kernel@kolivas.org> wrote:

> Changes since 2.6.12-ck3:
> 
> Added:
> +s11.3_s11.4.diff
> Staircase cpu scheduler update. Change rr intervals to 5ms minimum. With
> interbench I can confidently say there is objective evidence of interactive
> improvement in the human perceptible range with this change :)
> 

Excellent :)

> HZ-864.diff
> +My take on the never ending config HZ debate. Apart from the number not being
> pleasing on the eyes, a HZ value that isn't a multiple of 10 is perfectly
> valid. Setting HZ to 864 gives us very similar low latency performance to a
> 1000HZ kernel, decreases overhead ever so slightly, and minimises clock drift
> substantially. The -server patch uses HZ=82 for similar reasons, with the
> emphasis on throughput rather than low latency. Madness? Probably, but then I
> can't see any valid argument against using these values.
> 

I recently built the new release. Sadly, this particular change
results in my machine performing a hard reset during boot :(

Thus far, I've confirmed that changing the HZ value back to 1000
resolves the issue and I'm now up and running. So it's not the end of
the world but I would like to know which area of the kernel is falling
foul of this change. I'm concerned that others might be affected. I'll
see if I can establish a clearer picture of what seems to be going
wrong here.

Maybe it would be a good idea to allow the user to change this if
needs be? The patch below allows for this (assuming gmail does not
mangle it), provided that experimental config options are enabled and
only on the x86, ppc64 and x86_64 architectures.

--- linux-2.6.12-ck4.orig/init/Kconfig	2005-06-17 20:48:29.000000000 +0100
+++ linux-2.6.12-ck4/init/Kconfig	2005-07-28 00:52:12.000000000 +0100
@@ -77,6 +77,26 @@
 	  object and source tree, in that order.  Your total string can
 	  be a maximum of 64 characters.
 
+config HERTZ
+	int "HZ timer (interrupts per second)"
+	depends on EXPERIMENTAL && (X86 || PPC64 || X86_64)
+	range 10 2000
+	default 864
+	---help---
+	  This option configures the timer interrupt rate. The value in the
+	  mainline kernel is 1000. In -ck kernels the default is 864 which
+	  maintains favourable latencies whilst decreasing overhead slightly
+	  and helping to minimise clock drift substantially.
+
+	  In general, reducing this value results in lower scheduling
+	  granularity with higher throughput whereas increasing it results in
+	  higher scheduling granularity with lower throughput. Servers may be
+	  happier with a lower value such as 100. Setting a lower value can
+	  also help to alleviate issues with some laptops and to increase
+	  battery life.
+
+	  If unsure then do not alter this value.
+
 config SWAP
 	bool "Support for paging of anonymous memory (swap)"
 	depends on MMU
--- linux-2.6.12-ck4.orig/include/asm-i386/param.h	2005-07-27
23:38:04.000000000 +0100
+++ linux-2.6.12-ck4/include/asm-i386/param.h	2005-07-28
00:53:31.000000000 +0100
@@ -2,7 +2,7 @@
 #define _ASMi386_PARAM_H
 
 #ifdef __KERNEL__
-# define HZ		1000		/* Internal kernel timer frequency */
+# define HZ		CONFIG_HERTZ	/* Internal kernel timer frequency */
 # define USER_HZ	100		/* .. some user interfaces are in "ticks" */
 # define CLOCKS_PER_SEC		(USER_HZ)	/* like times() */
 #endif
--- linux-2.6.12-ck4.orig/include/asm-ppc64/param.h	2005-07-27
21:23:27.000000000 +0100
+++ linux-2.6.12-ck4/include/asm-ppc64/param.h	2005-07-28
00:57:40.000000000 +0100
@@ -9,7 +9,7 @@
  */
 
 #ifdef __KERNEL__
-# define HZ		864		/* Internal kernel timer frequency */
+# define HZ		CONFIG_HERTZ	/* Internal kernel timer frequency */
 # define USER_HZ	100		/* .. some user interfaces are in "ticks" */
 # define CLOCKS_PER_SEC	(USER_HZ)	/* like times() */
 #endif
--- linux-2.6.12-ck4.orig/include/asm-x86_64/param.h	2005-07-27
21:23:27.000000000 +0100
+++ linux-2.6.12-ck4/include/asm-x86_64/param.h	2005-07-28
00:57:58.000000000 +0100
@@ -2,7 +2,7 @@
 #define _ASMx86_64_PARAM_H
 
 #ifdef __KERNEL__
-# define HZ            864           /* Internal kernel timer frequency */
+# define HZ            CONFIG_HERTZ /* Internal kernel timer frequency */
 # define USER_HZ       100          /* .. some user interfaces are in "ticks */
 #define CLOCKS_PER_SEC        (USER_HZ)       /* like times() */
 #endif

Cheers,

--Kerin
