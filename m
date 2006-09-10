Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932551AbWIJT0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932551AbWIJT0u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 15:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbWIJT0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 15:26:50 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:46036 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932551AbWIJT0t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 15:26:49 -0400
Date: Sun, 10 Sep 2006 21:26:25 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Brownell <david-b@pacbell.net>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] Problems with STR
Message-ID: <20060910192625.GA5308@elf.ucw.cz>
References: <20050928212955.GH2506@elf.ucw.cz> <20050929180249.AE766E9E4D@adsl-69-107-32-110.dsl.pltn13.pacbell.net> <20050929181206.GO1990@elf.ucw.cz> <200608312310.20851.david-b@pacbell.net> <20060906103806.GB4987@atrey.karlin.mff.cuni.cz> <20060906153343.6D89719FEC1@adsl-69-226-248-13.dsl.pltn13.pacbell.net> <20060907220718.GH29890@elf.ucw.cz> <20060910150323.5DE2019FFB5@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060910150323.5DE2019FFB5@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2006-09-10 08:03:23, David Brownell wrote:
> > From pavel@suse.cz  Thu Sep  7 15:10:51 2006
> > Date: Fri, 8 Sep 2006 00:07:18 +0200
> > From: Pavel Machek <pavel@suse.cz>
> > To: David Brownell <david-b@pacbell.net>
> > Subject: Re: [linux-pm] Problems with PM_FREEZE
> >
> > Hi!
> >
> > > > > Just for the record, I tried those tricks and no success on either
> > > > > the NF3 or NF2 boxes.  And the NF3 ran into 's2ram' problems,
> > > > > it seems vbetool etc don't work in 64bit mode yet ...
> > > >
> > > > Any chance to try it in 32-bit mode? Recovery cd, or something?
> > > 
> > > Not for a few weeks, but that wouldn't have affected the NF2 ...
> >
> > Ok, can you do bugreport on bugzilla.kernel.org?
> 
> You mean, like bugid 6906?

Ahha, okay, feel free to Cc me on suspend bugs.

> > Is the resume (with minimal modules, init=/bin/bash, no acpi_sleep=
> > parameter) completely broken, or is just the video dead?
> 
> Completely broken.

Ok, this is beeping patch. It would be interesting to know what result
you get if you attempt to resume from S3 with this applied.

diff --git a/arch/i386/kernel/acpi/wakeup.S b/arch/i386/kernel/acpi/wakeup.S
index b781b38..88d4cba 100644
--- a/arch/i386/kernel/acpi/wakeup.S
+++ b/arch/i386/kernel/acpi/wakeup.S
@@ -11,7 +11,22 @@
 #
 # If physical address of wakeup_code is 0x12345, BIOS should call us with
 # cs = 0x1234, eip = 0x05
-# 
+#
+
+#define BEEP \
+	inb	$97, %al; 	\
+	outb	%al, $0x80; 	\
+	movb	$3, %al; 	\
+	outb	%al, $97; 	\
+	outb	%al, $0x80; 	\
+	movb	$-74, %al; 	\
+	outb	%al, $67; 	\
+	outb	%al, $0x80; 	\
+	movb	$-119, %al; 	\
+	outb	%al, $66; 	\
+	outb	%al, $0x80; 	\
+	movb	$15, %al; 	\
+	outb	%al, $66;
 
 ALIGN
 	.align	4096
@@ -20,6 +35,7 @@ wakeup_code:
 	wakeup_code_start = .
 	.code16
 
+	BEEP
  	movw	$0xb800, %ax
 	movw	%ax,%fs
 	movw	$0x0e00 + 'L', %fs:(0x10)


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
