Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932909AbWJISUH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932909AbWJISUH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 14:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932995AbWJISUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 14:20:06 -0400
Received: from smtp4-g19.free.fr ([212.27.42.30]:36508 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S932909AbWJISUF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 14:20:05 -0400
Subject: 2.6.18 suspend regression on Intel Macs
From: =?ISO-8859-1?Q?Fr=E9d=E9ric?= Riss <frederic.riss@gmail.com>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, len.brown@intel.com,
       Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain
Date: Mon, 09 Oct 2006 20:19:41 +0200
Message-Id: <1160417982.5142.45.camel@funkylaptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, I'm not sure it qualifies as a regression, because AFAIK no
official kernels can s2ram/resume Intel Macs correctly out of the box.

There has already been some discussion about the SCI_EN ACPI control bit
not being set when the Mactel boxes come out of suspend to ram. 
http://marc.theaimsgroup.com/?l=linux-acpi&m=114957637501557&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=115005083610700&w=2
http://bugme.osdl.org/show_bug.cgi?id=6670

The symptom is:
    irq 9: nobody cared (try booting with the "irqpoll" option)
    Disabling IRQ #9
when the system comes out of sleep, making ACPI non-functional.

Two days after having released 2.6.17, Linus commited a fix for this
issue in his tree (commit 5603509137940f4cbc577281cee62110d4097b1b):

@@ -812,6 +812,9 @@ static int irqrouter_resume(struct sys_d

ACPI_FUNCTION_TRACE("irqrouter_resume");

+ /* Make sure SCI is enabled again (Apple firmware bug?) */
+ acpi_set_register(ACPI_BITREG_SCI_ENABLE, 1, ACPI_MTX_DO_NOT_LOCK);
+

I since then used lightly patched 2.6.17 kernels on my MacMini without a
problem. With the release of 2.6.18, I decided to switch to a vanilla
kernel but I realized that the above issue reappeared. 

I tracked it down to the ACPI merge that took place on July 1st. More
precisely the commit 967440e3be1af06ad4dc7bb18d2e3c16130fe067 (ACPI:
ACPICA 20060623) contains the following hunk:

@@ -635,6 +663,25 @@ acpi_status acpi_hw_register_write(u8 us
 
 	case ACPI_REGISTER_PM1_CONTROL:	/* 16-bit access */
 
+		/*
+		 * Perform a read first to preserve certain bits (per ACPI spec)
+		 *
+		 * Note: This includes SCI_EN, we never want to change this bit
+		 */
+		status = acpi_hw_register_read(ACPI_MTX_DO_NOT_LOCK,
+					       ACPI_REGISTER_PM1_CONTROL,
+					       &read_value);
+		if (ACPI_FAILURE(status)) {
+			goto unlock_and_exit;
+		}
+
+		/* Insert the bits to be preserved */
+
+		ACPI_INSERT_BITS(value, ACPI_PM1_CONTROL_PRESERVED_BITS,
+				 read_value);
+
+		/* Now we can write the data */
+
 		status =
 		    acpi_hw_low_level_write(16, value,
 					    &acpi_gbl_FADT->xpm1a_cnt_blk);


which makes Linus' fix a no-op, because it disallows setting the SCI_EN
bit.

Fred.

