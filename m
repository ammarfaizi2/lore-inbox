Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbUKNVzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbUKNVzz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 16:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbUKNVzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 16:55:54 -0500
Received: from linux.us.dell.com ([143.166.224.162]:31334 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S261352AbUKNVzg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 16:55:36 -0500
Date: Sun, 14 Nov 2004 15:55:21 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Christian Kujau <evil@g-house.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Oops in 2.6.10-rc1 (almost solved)
Message-ID: <20041114215521.GA9717@lists.us.dell.com>
References: <200411122248_MC3-1-8E97-BFE5@compuserve.com> <20041113142835.GA9109@lists.us.dell.com> <20041114025814.GA20342@lists.us.dell.com> <4197B9D9.9010806@g-house.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4197B9D9.9010806@g-house.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 14, 2004 at 09:02:33PM +0100, Christian Kujau wrote:
> > Not ready for Linus yet, and you'll need to re-apply the previous
> > edd.S patch which is now reverted in Linus's tree.  As your BIOS
> 
> i've applied the patch to a pristine 2.6.10-rc1, so the (currently
> reverted) EDD change is still there. tell me, if the patch had to be
> applied to sth. else.
> 
> but for now i have to say, that it still oopses:
> 
> http://www.nerdbynature.de/bits/prinz/2.6.10-rc1/dmesg-2.6.10-rc1_edd-2.txt

OK, the patch below (which Linus applied to his tree yesterday) should
fix the oopses.
 
> BIOS EDD facility v0.16 2004-Jun-25, 16 devices found

but the patch to edd.S doesn't resolve that EDD believes you've got 16
devices (I would expect it to report 2, as you have only 2 disks).

Thanks for the quick testing.  Back to the drawing board though for
this second part.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

===== drivers/firmware/edd.c 1.30 vs edited =====
--- 1.30/drivers/firmware/edd.c	2004-06-29 09:44:48 -05:00
+++ edited/drivers/firmware/edd.c	2004-11-13 07:56:00 -06:00
@@ -70,7 +70,7 @@
 static int edd_dev_is_type(struct edd_device *edev, const char *type);
 static struct pci_dev *edd_get_pci_dev(struct edd_device *edev);
 
-static struct edd_device *edd_devices[EDDMAXNR];
+static struct edd_device *edd_devices[EDD_MBR_SIG_MAX];
 
 #define EDD_DEVICE_ATTR(_name,_mode,_show,_test) \
 struct edd_attribute edd_attr_##_name = { 	\
@@ -728,9 +728,9 @@
 
 static inline int edd_num_devices(void)
 {
-	return min_t(unsigned char,
-		     max_t(unsigned char, edd.edd_info_nr, edd.mbr_signature_nr),
-		     max_t(unsigned char, EDD_MBR_SIG_MAX, EDDMAXNR));
+	return max_t(unsigned char,
+		     min_t(unsigned char, EDD_MBR_SIG_MAX, edd.mbr_signature_nr),
+		     min_t(unsigned char, EDDMAXNR, edd.edd_info_nr));
 }
 
 /**
