Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261844AbUKMO2u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbUKMO2u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 09:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262756AbUKMO2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 09:28:50 -0500
Received: from linux.us.dell.com ([143.166.224.162]:28861 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S261844AbUKMO2r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 09:28:47 -0500
Date: Sat, 13 Nov 2004 08:28:35 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Chuck Ebbert <76306.1226@compuserve.com>,
       Christian Kujau <evil@g-house.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Oops in 2.6.10-rc1 (almost solved)
Message-ID: <20041113142835.GA9109@lists.us.dell.com>
References: <200411122248_MC3-1-8E97-BFE5@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411122248_MC3-1-8E97-BFE5@compuserve.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2004 at 10:45:12PM -0500, Chuck Ebbert wrote:
> On Tue, 9 Nov 2004 at 17:01:10 -0800 Linus Torvalds <torvalds@osdl.org> wrote:
> 
> > > PS: do you have *any* idea how this could be related to the snd-es1371
> > > driver (which is producing the oops then)?
> >
> > I bet it's overwriting some array, and just corrupting memory after it. 
> > For example, the edd_info[] array only has 6 entries,
> 
>   That's almost certainly the problem.  There can be up to 16 EDD devices
> as of the Jun 30 update to the EDD code.

Bingo...  edd_devices[] was too short.  When we keep more
than 6 signatures, it overruns the end.  Also, I rewrote
edd_num_devices to be clearer about its goal.

This patch is necessary even after the last edd.S patch was reverted.

It still doesn't explain why Christian's BIOS reports more devices
than he has, that's still UI, so don't re-apply the edd.S patch just reverted.

Signed-off-by: Matt Domsch

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
