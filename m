Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030529AbWJJVuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030529AbWJJVuO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030536AbWJJVuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:50:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53665 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030529AbWJJVtf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:49:35 -0400
Date: Tue, 10 Oct 2006 14:49:20 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
cc: =?ISO-8859-1?Q?Fr=E9d=E9ric_Riss?= <frederic.riss@gmail.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>, len.brown@intel.com
Subject: Re: 2.6.18 suspend regression on Intel Macs
In-Reply-To: <20061010195022.GA32134@elf.ucw.cz>
Message-ID: <Pine.LNX.4.64.0610101447270.3952@g5.osdl.org>
References: <1160417982.5142.45.camel@funkylaptop> <20061010103910.GD31598@elf.ucw.cz>
 <1160476889.3000.282.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0610100830370.3952@g5.osdl.org>
 <1160507296.5134.4.camel@funkylaptop> <1160509121.3000.327.camel@laptopd505.fenrus.org>
 <1160509584.5134.11.camel@funkylaptop> <20061010195022.GA32134@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 10 Oct 2006, Pavel Machek wrote:
> 
> Maybe you can just create a patch that modifies ACPI not to mask the
> SCI bit? Reverting big chunk of ACPI code is likely not the right
> solution.

I'm going to apply this after I've confirmed that it fixes the Mac Mini.

It would be nice if somebody documented what the heck that "bit 9" 
actually is that we're trying to preserve. I wonder if that one is any 
better..

It's entirely possible that what we should do in acpi_hw_register_write() 
is to always force SCI_EN to be on, but in the meantime, this would seem 
to be the minimal fix that undoes the damage done by the ACPI merge.

		Linus

---
diff --git a/drivers/acpi/hardware/hwregs.c b/drivers/acpi/hardware/hwregs.c
index 3143f36..fa58c1e 100644
--- a/drivers/acpi/hardware/hwregs.c
+++ b/drivers/acpi/hardware/hwregs.c
@@ -665,8 +665,6 @@ acpi_status acpi_hw_register_write(u8 us
 
 		/*
 		 * Perform a read first to preserve certain bits (per ACPI spec)
-		 *
-		 * Note: This includes SCI_EN, we never want to change this bit
 		 */
 		status = acpi_hw_register_read(ACPI_MTX_DO_NOT_LOCK,
 					       ACPI_REGISTER_PM1_CONTROL,
diff --git a/include/acpi/aclocal.h b/include/acpi/aclocal.h
index a4d0e73..063c4b5 100644
--- a/include/acpi/aclocal.h
+++ b/include/acpi/aclocal.h
@@ -708,7 +708,7 @@ struct acpi_bit_register_info {
  * must be preserved.
  */
 #define ACPI_PM1_STATUS_PRESERVED_BITS          0x0800	/* Bit 11 */
-#define ACPI_PM1_CONTROL_PRESERVED_BITS         0x0201	/* Bit 9, Bit 0 (SCI_EN) */
+#define ACPI_PM1_CONTROL_PRESERVED_BITS         0x0200	/* Bit 9 (whatever) */
 
 /*
  * Register IDs
