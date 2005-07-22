Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261256AbVGVMRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbVGVMRJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 08:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbVGVMRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 08:17:09 -0400
Received: from smtp2.belwue.de ([129.143.2.15]:16321 "EHLO smtp2.BelWue.DE")
	by vger.kernel.org with ESMTP id S261256AbVGVMRI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 08:17:08 -0400
From: Oliver Tennert <O.Tennert@science-computing.de>
To: linux-kernel@vger.kernel.org
Subject: IDE disk and HPA
Date: Fri, 22 Jul 2005 14:17:04 +0200
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507221417.04640.tennert@science-computing.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a question concerning the handling of HPA (Host-protected areas) in 
current Linux kernels.

Have a look at drivers/ide/ide-disk.c:


static inline void idedisk_check_hpa(ide_drive_t *drive)
{
        unsigned long long capacity, set_max;
        int lba48 = idedisk_supports_lba48(drive->id);

        capacity = drive->capacity64;
        if (lba48)
                set_max = idedisk_read_native_max_address_ext(drive);
        else
                set_max = idedisk_read_native_max_address(drive);

        if (set_max <= capacity)
                return;

        printk(KERN_INFO "%s: Host Protected Area detected.\n"
                         "\tcurrent capacity is %llu sectors (%llu MB)\n"
                         "\tnative  capacity is %llu sectors (%llu MB)\n",
                         drive->name,
                         capacity, sectors_to_MB(capacity),
                         set_max, sectors_to_MB(set_max));

        if (lba48)
                set_max = idedisk_set_max_address_ext(drive, set_max);
        else
                set_max = idedisk_set_max_address(drive, set_max);
        if (set_max) {
                drive->capacity64 = set_max;
                printk(KERN_INFO "%s: Host Protected Area disabled.\n",
                                 drive->name);
        }
}

Do I interpret it right that the following is done in the above function:

1.) The current capacity of the disk is detected.
2.) The "native max. address size" of the disk is detected and stored in 
set_max.
3.) If capacity < set_max then it is rightly stated that an HPA is detected.
4.) If an HPA is detected, then that HPA is disabled, i.e. the maximum address 
size is set to the "native max. address size". Afterwards, the HPA is no 
more!

My question is now: why is an HPA disabled i.e. disprotected when detected? 
Why not let the HPA alone, because a certain set of disk sectors shall not be 
accessible by the OS?

Best regards

Oliver
-- 

Acid -- better living through chemistry.
--
__
________________________________________creating IT solutions

Dr. Oliver Tennert
Senior Solutions Engineer
CAx Professional Services
                                        science + computing ag
phone   +49(0)7071 9457-598             Hagellocher Weg 71-75	
fax     +49(0)7071 9457-411             D-72070 Tuebingen, Germany
O.Tennert@science-computing.de          www.science-computing.de


