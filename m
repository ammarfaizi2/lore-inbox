Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbUL1Uub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbUL1Uub (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 15:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbUL1Uua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 15:50:30 -0500
Received: from ALille-201-1-2-142.w193-251.abo.wanadoo.fr ([193.251.33.142]:64641
	"EHLO athena.vetienne.net") by vger.kernel.org with ESMTP
	id S261244AbUL1Ut6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 15:49:58 -0500
From: Vincent ETIENNE <ve@vetienne.net>
To: linux-kernel@vger.kernel.org
Subject: AMD64-AGP pb with AGP APERTURE on IWILL DK8N
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Disposition: inline
Date: Tue, 28 Dec 2004 20:49:48 +0000
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200412282049.48616.ve@vetienne.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello ALL,

I have some problem with AGP initialization with my board : IWLL DK8N (Bi 
opteron chipset NFORCE3 ). I use kernel 2.6.10-rc3-mm1, but i have try with 
different kernel always with the same result :

IOMMU reports a 128MB aperture for CPU0 ( that's the value i used in my bios) 
at F0000000 but only 32MB at 4000000 for CPU1 and declare i have no valid 
aperture as show in this dmesg extract. 

Checking aperture...
CPU 0: aperture @ f0000000 size 128 MB
CPU 1: aperture @ 4000000 size 32 MB
Aperture from northbridge cpu 1 too small (32 MB)
AGP bridge at 00:00:00
Aperture from AGP @ f0000000 size 4096 MB (APSIZE 0)
Aperture from AGP bridge too small (0 MB)
Your BIOS doesn't leave a aperture memory hole

So i have forced the value at CPU1 to be the same as CPU0 in 
arch/x86_64/kernel/aperture.c function iommu_hole_init with the following 
code. Don't asked me what i have done i have quite no idea of what is 
involved by this modification. 

I have add 2 var for memorizing value of aperture_size and base of the first 
cpu and set the value of the second one to the value of the first one on case 
they are diferent ( added line marked with a "+" sign ).

void __init iommu_hole_init(void)
{
 int fix, num;
 u32 aper_size, aper_alloc = 0, aper_order;
 u64 aper_base;
+ u32 last_aper_order = 0;
+ u64 last_aper_base = 0;
 int valid_agp = 0;

 if (iommu_aperture_disabled || !fix_aperture)
  return;
 printk("Checking aperture...\n");
 fix = 0;
 for (num = 24; num < 32; num++) {
  char name[30];
  if (read_pci_config(0, num, 3, 0x00) != NB_ID_3)
   continue;

  iommu_aperture = 1;
  aper_order = (read_pci_config(0, num, 3, 0x90) >> 1) & 7;
  aper_size = (32 * 1024 * 1024) << aper_order;
  aper_base = read_pci_config(0, num, 3, 0x94) & 0x7fff;
  aper_base <<= 25;
  printk("CPU %d: aperture @ %Lx size %u MB\n", num-24,
  aper_base, aper_size>>20);
+  if ( last_aper_order )
+ {
+   if ( aper_order != last_aper_order )
+   {
+    printk("Aperture size changed!! use old one (%x,%x)", last_aper_order, 
last_aper_base );
+    write_pci_config(0, num, 3, 0x90, last_aper_order<<1);
+    write_pci_config(0, num, 3, 0x94, last_aper_base>>25);
+    aper_order = last_aper_order;
+    aper_base = last_aper_base;
+    aper_size = (32 * 1024 * 1024) << aper_order;
+   }
+ }
+  last_aper_order = aper_order;
+  last_aper_base = aper_base;

Rest of the code unchanged.

Now agp is enabled 8x, SBA and fast write activated  (as seeen 
in /proc/driver/nvidia/agp/status ) and i'm very pleased but also frustated 
as i have no idea of that i have done.

Do you think it's more a bios problem (something not initialized correctly by 
the bios as it seem ) or could it be a kernel bug ?  Someone could explain 
what value sould be returned ? Is my modification secured (at least for my 
board ) i.e. is this modification could harm some hardware ?

I wish to be personally CC'ed the answers/comment as i'm not a subscriber of a 
list. 

Thanks for your time.

Vincent ETIENNE
