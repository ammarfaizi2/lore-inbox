Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422782AbWBNVR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422782AbWBNVR6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 16:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422781AbWBNVRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 16:17:55 -0500
Received: from smtpauth07.mail.atl.earthlink.net ([209.86.89.67]:48054 "EHLO
	smtpauth07.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S1422733AbWBNVRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 16:17:53 -0500
To: "Brown, Len" <len.brown@intel.com>
cc: "David S. Miller" <davem@davemloft.net>, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, axboe@suse.de,
       James.Bottomley@steeleye.com, greg@kroah.com,
       linux-acpi@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       "Yu, Luming" <luming.yu@intel.com>, lk@bencastricum.nl,
       helgehaf@aitel.hist.no, fluido@fluido.as, gbruchhaeuser@gmx.de,
       Nicolas.Mailhot@LaPoste.net, perex@suse.cz, tiwai@suse.de,
       patrizio.bassi@gmail.com, bni.swe@gmail.com, arvidjaar@mail.ru,
       p_christ@hol.gr, ghrt@dial.kappa.ro, jinhong.hu@gmail.com,
       andrew.vasquez@qlogic.com, linux-scsi@vger.kernel.org, bcrl@kvack.org
Subject: Re: Linux 2.6.16-rc3 
In-Reply-To: Your message of "Mon, 13 Feb 2006 03:02:46 EST."
             <F7DC2337C7631D4386A2DF6E8FB22B30060BD1D9@hdsmsx401.amr.corp.intel.com> 
X-Mailer: MH-E 7.85; nmh 1.1; GNU Emacs 21.4.1
Date: Tue, 14 Feb 2006 16:17:01 -0500
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1F97Xh-000138-59@approximate.corpus.cam.ac.uk>
X-ELNK-Trace: dcd19350f30646cc26f3bd1b5f75c9f474bf435c0eb9d478f6de188fdd142d4e55a2680650e88f3e8d2457b3aaa45aec350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 24.41.6.91
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't think anybody claimed this isn't a regression for the 600X.

I narrowed it further.  The short story is that this commit (diff below
sig) makes the second S3 sleep go into the endless loop, if the loaded
modules are exactly thermal, processor, intel_agp, and agpgart:

53f11d4ff8797bcceaf014e62bd39f16ce84baec is first bad commit
diff-tree 53f11d4ff8797bcceaf014e62bd39f16ce84baec (from 02b28a33aae93a3b53068e0858d62f8bcaef60a3)
Author: Len Brown <len.brown@intel.com>
Date:   Mon Dec 5 16:46:36 2005 -0500

    [ACPI] Enable Embedded Controller (EC) interrupt mode by default
    
    "ec_intr=0" reverts to polling
    "ec_burst=" no longer exists.
    
    Signed-off-by: Len Brown <len.brown@intel.com>
    Acked-by: Luming Yu <luming.yu@intel.com>

:040000 040000 9eec66712c68ebe372b2fb2c8d78bdc99df942ab e7e62cd09983730aee468edd4ba1cce50786b7e5 M	Documentation
:040000 040000 6e7db46918f6124f64a11f6757560078a8a27519 aa8abb1023024902300cb2e7a5bf74acd8c579e8 M	drivers

If I boot with ec_intr=0, the second sleep works fine.

Here is the full story.  First I tried a system with the minimal set of
modules to boot and run X (S3 sleep-wake wrecks the VGA consoles, but X
restores fine with 'chvt 1; sleep 0.5 ; chvt 7' on wakeup).  So I
stopped every service and unloaded all modules possible, which left only
intel_agp and agpgart.  Then, for each of the usual loaded modules
(except for sound modules, which often has sleep-wake problems anyway),
I tried:

1. Load the module
2. S3 sleep-wake-sleep-wake
3. Unload the module

to see whether the second sleep went into the infinite loop (visible
across the console).  The one culprit I found was 'thermal' (which
brings in 'processor').  Other modules didn't trigger the problem.

Then I recompiled using a minimal config, with only networking (for X to
work) and the acpi modules, and maybe a few others that I couldn't
avoid, and retested to make sure 'thermal' still triggered the problem,
which it did.  I used this config, or one just like it for 2.6.15, as a
base for all other kernels in the bisection search, using the nearest
ancestor's .config and then
   yes '' | make oldconfig
to make the new .config

Eventually bisection converged to the commit above, and then I retested
that kernel with 'ec_intr=0'.

Is this a problem with the TP 600X hardware, in which case I'll just use
ec_intr=0 forever, or is there more software debugging (DSDT or related
to the diff)?  I can turn on gobs of ACPI debugging and send the useful
parts of the log file.

In the bisection, many kernels worked fine, meaning that the second S3
cycle returned and I could compile the next bisection kernel.  In doing
that I noticed another problem, that the fan would not turn on with some
of these good kernels even though the system was hot enough (plenty of
chance for it to turn on since the next compile heated up the CPU).  For
example, acpi -t showed

     Thermal 1: ok, 46.0 degrees C
     Thermal 2: active[0], 42.0 degrees C
     Thermal 3: ok, 31.0 degrees C
     Thermal 4: ok, 34.0 degrees C

but the fan was off.  

So whenever I had a good kernel (meaning taht S3 sleep-wake-sleep-wake
returned), I checked whether the fan would turn on, to collect data for
a separate bisection search.  However, the data seems inconsistent.  If
I feed the data to a fresh git bisect, it complains about one commit
being marked both good and bad.  So I'll ask on the git list about that
issue.

-Sanjoy

`A society of sheep must in time beget a government of wolves.'
   - Bertrand de Jouvenal


diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 5dffcfe..2ad64ef 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -452,6 +452,11 @@ running once the system is up.
 
 	eata=		[HW,SCSI]
 
+	ec_intr=	[HW,ACPI] ACPI Embedded Controller interrupt mode
+			Format: <int>
+			0: polling mode
+			non-0: interrupt mode (default)
+
 	eda=		[HW,PS2]
 
 	edb=		[HW,PS2]
diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index bb3963b..d4366ad 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -73,7 +73,7 @@ static struct acpi_driver acpi_ec_driver
 	.class = ACPI_EC_CLASS,
 	.ids = ACPI_EC_HID,
 	.ops = {
-		.add = acpi_ec_poll_add,
+		.add = acpi_ec_intr_add,
 		.remove = acpi_ec_remove,
 		.start = acpi_ec_start,
 		.stop = acpi_ec_stop,
@@ -147,7 +147,7 @@ static union acpi_ec *ec_ecdt;
 
 /* External interfaces use first EC only, so remember */
 static struct acpi_device *first_ec;
-static int acpi_ec_poll_mode = EC_POLL;
+static int acpi_ec_poll_mode = EC_INTR;
 
 /* --------------------------------------------------------------------------
                              Transaction Management
@@ -1594,4 +1594,4 @@ static int __init acpi_ec_set_intr_mode(
 	return 0;
 }
 
-__setup("ec_burst=", acpi_ec_set_intr_mode);
+__setup("ec_intr=", acpi_ec_set_intr_mode);
