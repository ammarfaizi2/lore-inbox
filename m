Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261551AbUEVPO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbUEVPO3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 11:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbUEVPO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 11:14:29 -0400
Received: from elektron.ikp.physik.tu-darmstadt.de ([130.83.24.72]:15878 "EHLO
	elektron.ikp.physik.tu-darmstadt.de") by vger.kernel.org with ESMTP
	id S261551AbUEVPO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 11:14:26 -0400
From: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16559.28240.860047.83057@hertz.ikp.physik.tu-darmstadt.de>
Date: Sat, 22 May 2004 17:14:24 +0200
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: rfc: test whether a device has a partition table
In-Reply-To: <20040522125633.GA4777@apps.cwi.nl>
References: <16559.14090.6623.563810@hertz.ikp.physik.tu-darmstadt.de>
	<20040522125633.GA4777@apps.cwi.nl>
X-Mailer: VM 7.07 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andries" == Andries Brouwer <Andries.Brouwer@cwi.nl> writes:


    Andries> What do you mean by "floppy as second partition"?

Sorry, I mean as second device realized in the stick. On my R50 Laptop
without a floppy drive, when the USB stick is plugged in, it appears as
Floppy "A:" in the boot process.


    >> Find appended a patch that does the 0x00/0x80 "boot flag"
    >> checks. Please discuss and consider for inclusion into the kernel.

    >> +#define BOOT_IND(p) (get_unaligned(&p->boot_ind)) #define SYS_IND(p)
    >> (get_unaligned(&p->sys_ind))

    Andries> Hmm. get_unaligned() for a single byte?  I see no reason for
    Andries> these two macros.  Also, it is a good habit to parenthesize
    Andries> macro parameters.

I must admit that I didn't dig deeper what "get_unaligned" really means. From
what you tell, I understand that the macro is not needed, and the compare
would do if ((&p->sys_ind != 0x80) && (&p->sys_ind != 0x0)) should work too.

    >> + /* + Some consistancy check for a valid partition table

...
    Andries> I have no objections.

    Andries> Does it in your case suffice to check for 0 / 0x80 only
    Andries> (without testing nr_bootable)?

Yes, the test for 0x80/0 is sufficant. Testing nr_bootable was only paranoid...

    Andries> I would prefer to omit that test, until there is at least one
    Andries> person who shows a boot sector where it is needed.

Find appeneded the revised patch.

-- 
Uwe Bonnes                bon@elektron.ikp.physik.tu-darmstadt.de

Institut fuer Kernphysik  Schlossgartenstrasse 9  64289 Darmstadt
--------- Tel. 06151 162516 -------- Fax. 06151 164321 ----------
--- linux-2.6.6/fs/partitions/msdos-sav.c	2004-05-10 04:32:52.000000000 +0200
+++ linux-2.6.6/fs/partitions/msdos.c	2004-05-22 17:14:08.000000000 +0200
@@ -389,6 +389,17 @@
 		put_dev_sector(sect);
 		return 0;
 	}
+
+	/* 
+	   Some consistancy check for a valid partition table
+	   Boot indicator must either be 0x80 or 0x0 on all primary partitions
+	*/
+ 	p = (struct partition *) (data + 0x1be);
+	for (slot = 1 ; slot <= 4 ; slot++, p++) {
+	  if ( (p->boot_ind != 0x80) &&  (p->boot_ind!= 0x0))
+	    return 0;
+	}
+
 	p = (struct partition *) (data + 0x1be);
 #ifdef CONFIG_EFI_PARTITION
 	for (slot = 1 ; slot <= 4 ; slot++, p++) {
