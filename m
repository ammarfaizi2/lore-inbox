Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbTJRUep (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 16:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbTJRUep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 16:34:45 -0400
Received: from gprs144-147.eurotel.cz ([160.218.144.147]:60803 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261821AbTJRUem (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 16:34:42 -0400
Date: Sat, 18 Oct 2003 22:34:11 +0200
From: Pavel Machek <pavel@suse.cz>
To: Martin Loschwitz <madkiss@madkiss.org>
Cc: Patrick Mochel <mochel@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
Subject: Re: PARTIAL success with ACPI S3 suspend to ram on Acer TravelMate 800LCi
Message-ID: <20031018203409.GN395@elf.ucw.cz>
References: <20031018202820.GA9737@minerva.local.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031018202820.GA9737@minerva.local.lan>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The saga ([0] and [1]) continues, here are the latest facts about ACPI S3
> suspend to ram mode with the Acer TravelMate 800LCi notebook.
> 
> With Linux 2.6.0-test8, there is some kind of partial success: After doing
> "echo -n mem > /sys/power/state" the box suspends and after pressing a key
> on the keyboard the box resumes. The box reacts to input afterwards, for
> example one can do "reboot" as root and even pressing the power key does
> what it is supposed to do. Unfortunately there is one big disadvantage:
> The panel of the notebook stays completely black. I tried booting with
> "acpi_sleep=s3_{mode,boot}" but in both cases, the box apparently hangs
> while trying to resume (no [blind] keyboard input possible, pressing the
> power button has no effect)

Good. [Well, good for me, very bad for you.]

This is known problem, see below. I don't really know what other dirty
hack to try. I'm afraid its your turn.

Rusty, could you make this go in? This is becoming FAQ :-(. Perhaps
some other ideas can be added if it is in the source tree.

								Pavel

--- clean/Documentation/power/video.txt	2003-10-10 09:11:51.000000000 +0200
+++ linux/Documentation/power/video.txt	2003-10-10 09:40:44.000000000 +0200
@@ -0,0 +1,36 @@
+
+		Video issues with S3 resume
+		~~~~~~~~~~~~~~~~~~~~~~~~~~~
+		     2003, Pavel Machek
+
+During S3 resume, hardware needs to be reinitialized. For most
+devices, this is easy, and kernel driver knows how to do
+it. Unfortunately there's one exception: video card. Those are usually
+initialized by BIOS, and kernel does not have enough information to
+boot video card. (Kernel usually does not even contain video card
+driver -- vesafb and vgacon are widely used).
+
+This is not problem for swsusp, because during swsusp resume, BIOS is
+run normally so video card is normally initialized.
+
+There are three types of systems where video works after S3 resume:
+
+* systems where video state is preserved over S3. (HP Omnibook xe3)
+
+* systems that initialize video card into vga text mode and where BIOS
+  works well enough to be able to set video mode. Use
+  acpi_sleep=s3_mode on these. (Toshiba 4030cdt)
+
+* systems where it is possible to call video bios during S3
+  resume. Unfortunately, it is not correct to call video BIOS at that
+  point, but it happens to work on some machines. Use
+  acpi_sleep=s3_bios (Athlon64 desktop system)
+
+Now, if you pass acpi_sleep=something, and it does not work with your
+bios, you'll get hard crash during resume. Be carefull.
+
+You may have system where none of above works. At that point you
+either invent another ugly hack that works, or write proper driver for
+your video card (good luck getting docs :-(). Maybe suspending from X
+(proper X, knowing your hardware, not XF68_FBcon) might have better
+chance of working.




-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
