Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262671AbUJ0UrW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262671AbUJ0UrW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 16:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262702AbUJ0Uiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 16:38:50 -0400
Received: from mail.dif.dk ([193.138.115.101]:174 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262695AbUJ0UeV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 16:34:21 -0400
Date: Wed, 27 Oct 2004 22:42:43 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Chris Wedgwood <cw@f00f.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Would auto setting CONFIG_RTC make sense when building SMP
 kernel?
In-Reply-To: <1098893383.4304.21.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0410272237140.3284@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0410262108041.3277@dragon.hygekrogen.localhost>
 <1098893383.4304.21.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2004, Alan Cox wrote:

> On Maw, 2004-10-26 at 20:13, Jesper Juhl wrote:
> > Isn't it always desirable to be able to set the clock in an SMP compatible 
> > fashion if the kernel is indeed build for SMP?
> 
> Probably it is best to just move it to CONFIG_EMBEDDED. Without the
> driver the clock binary bitbangs the cmos and that isnt safe non SMP
> either nowdays
> 
How about the patch below that makes it default to Y, and only allows it 
to be modified if EMBEDDED, and make GEN_RTC default to Y if RTC is 
disabled (so there's always some RTC driver of sorts unless you select 
EMBEDDED and explicitly disable it) as well as modifying the help text a 
bit to encourage people a bit more to select Y.

Or am I making this more complicated than need be?

I've not moved it to the embedded menu, would that be preferable?

Comments welcome.

(ohh, and I'm not proposing that anyone merge this just yet, the below is 
just the logic that makes sense to me, and mainly to get some comments)


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -u linux-2.6.10-rc1-bk5-orig/drivers/char/Kconfig linux-2.6.10-rc1-bk5/drivers/char/Kconfig
--- linux-2.6.10-rc1-bk5-orig/drivers/char/Kconfig	2004-10-26 00:20:49.000000000 +0200
+++ linux-2.6.10-rc1-bk5/drivers/char/Kconfig	2004-10-27 22:35:06.000000000 +0200
@@ -704,8 +704,9 @@
 	  module will be called nvram.
 
 config RTC
-	tristate "Enhanced Real Time Clock Support"
+	tristate "Enhanced Real Time Clock Support" if EMBEDDED
 	depends on !PPC32 && !PARISC && !IA64 && !M68K
+	default y
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
@@ -720,7 +721,10 @@
 
 	  If you run Linux on a multiprocessor machine and said Y to
 	  "Symmetric Multi Processing" above, you should say Y here to read
-	  and set the RTC in an SMP compatible fashion.
+	  and set the RTC in an SMP compatible fashion. A lot of modern UP
+	  machines also need this to access the clock safely and it is safe
+	  for older machines as well, so you really should say Y except
+	  possibly for embedded systems. 
 
 	  If you think you have a use for such a device (such as periodic data
 	  sampling), then say Y here, and read <file:Documentation/rtc.txt>
@@ -729,6 +733,8 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called rtc.
 
+	  If in doubt say Y.
+
 config SGI_DS1286
 	tristate "SGI DS1286 RTC support"
 	depends on SGI_IP22
@@ -752,8 +758,10 @@
 	  /dev/rtc.
 
 config GEN_RTC
-	tristate "Generic /dev/rtc emulation"
+	tristate "Generic /dev/rtc emulation" if EMBEDDED
 	depends on RTC!=y && !IA64 && !ARM
+	default y if RTC = n
+	default n if RTC = m
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
@@ -769,9 +777,12 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called genrtc.
 
+	  If in doubt say Y.
+
 config GEN_RTC_X
-	bool "Extended RTC operation"
+	bool "Extended RTC operation" if EMBEDDED
 	depends on GEN_RTC
+	default y if GEN_RTC = y || GEN_RTC = m
 	help
 	  Provides an emulation for RTC_UIE which is required by some programs
 	  and may improve precision of the generic RTC support in some cases.


