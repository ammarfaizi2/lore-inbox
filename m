Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261901AbVEPVyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261901AbVEPVyP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 17:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbVEPVvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 17:51:41 -0400
Received: from sccrmhc14.comcast.net ([204.127.202.59]:6134 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S261919AbVEPVti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 17:49:38 -0400
Message-ID: <4289156C.1030907@acm.org>
Date: Mon, 16 May 2005 16:49:32 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Yann Droneaud <ydroneaud@mandriva.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Subject: Re: Oops with IPMI and ACPI disabled on command line
References: <m27jhyzwj6.fsf@firedrake.mandriva.com>
In-Reply-To: <m27jhyzwj6.fsf@firedrake.mandriva.com>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I noticed this recently, too.  It seems to be an ACPI bug, but I'm 
not 100% sure.  Here's my post to lkml:

In 2.6.12-rc4, I added acpi=off to the kernel command line and it 
panic-ed in acpi_get_firmware_table, called from the IPMI driver.

The attached patch fixes the problem, but it still spits out ugly 
"ACPI-0166: *** Error: Invalid address flags 8" errors.  So I doubt the 
patch is right, but maybe it points to something else.

Is it legal to call acpi_get_firmware_table if acpi is off?  If not, how 
can I tell that acpi is off?

-Corey

------------------------------------------------------------------------

Index: linux-2.6.12-rc4/drivers/acpi/tables/tbxfroot.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/acpi/tables/tbxfroot.c
+++ linux-2.6.12-rc4/drivers/acpi/tables/tbxfroot.c
@@ -313,7 +313,9 @@
 
 
 cleanup:
-	acpi_os_unmap_memory (rsdt_info->pointer, (acpi_size) rsdt_info->pointer->length);
+	if (rsdt_info->pointer)
+		acpi_os_unmap_memory (rsdt_info->pointer,
+			       	      (acpi_size) rsdt_info->pointer->length);
 	ACPI_MEM_FREE (rsdt_info);
 
 	if (header) {



Yann Droneaud wrote:

>Hi,
>
>I encounter an Oops with IPMI modules using acpi=ht|off,
>I fixed it (only the Oops, IPMI is still not available on the system),
>by two patches which follows.
>
>Here is the Oops messages for reference:
>
>May 16 11:18:29 localhost kernel: ipmi message handler version v33
>May 16 11:18:29 localhost kernel: IPMI System Interface driver version v33, KCS version v33, SMIC version v33, BT version v33
>May 16 11:18:29 localhost kernel:     ACPI-0166: *** Error: Invalid address flags 8
>May 16 11:18:29 localhost kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000004
>May 16 11:18:29 localhost kernel:  printing eip:
>May 16 11:18:29 localhost kernel: c01ff793
>May 16 11:18:29 localhost kernel: *pde = 3764b001
>May 16 11:18:29 localhost kernel: Oops: 0000 [#1]
>May 16 11:18:29 localhost kernel: SMP
>May 16 11:18:29 localhost kernel: Modules linked in: ipmi_si ipmi_msghandler af_packet floppy bcm5700 isofs nls_base md ehci_
>hcd uhci_hcd usbcore genrtc unix sd_mod qla2300 qla2xxx scsi_transport_fc cciss ata_piix libata
>May 16 11:18:29 localhost kernel: CPU:    0
>May 16 11:18:29 localhost kernel: EIP:    0060:[acpi_get_firmware_table+630/694]    Not tainted VLI
>May 16 11:18:29 localhost kernel: EIP:    0060:[<c01ff793>]    Not tainted VLI
>May 16 11:18:29 localhost kernel: EFLAGS: 00010202   (2.6.11.9-mdvc)
>May 16 11:18:29 localhost kernel: EIP is at acpi_get_firmware_table+0x276/0x2b6
>May 16 11:18:29 localhost kernel: eax: 00000000   ebx: c21602c0   ecx: 00000000   edx: c21602c0
>May 16 11:18:29 localhost ipmi: Starting IPMI failed
>May 16 11:18:29 localhost kernel: esi: 00001001   edi: c02bfc49   ebp: 00000008   esp: f7f11eec
>May 16 11:18:30 localhost kernel: ds: 007b   es: 007b   ss: 0068
>May 16 11:18:30 localhost kernel: Process modprobe (pid: 2413, threadinfo=f7f11000 task=f744d540)
>May 16 11:18:30 localhost kernel: Stack: c0119583 f76bff44 00000001 00000000 00000000 00000000 00000008 7fff32c0
>May 16 11:18:30 localhost kernel:        00000000 f7f11f40 ffffffed 00000000 00000000 00000000 f8b81453 f8b851f9
>May 16 11:18:30 localhost kernel:        00000001 00000008 f7f11f3c 000047d9 00000296 ffffffed f7f11f78 00000000
>May 16 11:18:30 localhost kernel: Call Trace:
>May 16 11:18:30 localhost kernel:  [__wake_up_common+63/94] __wake_up_common+0x3f/0x5e
>May 16 11:18:30 localhost kernel:  [<c0119583>] __wake_up_common+0x3f/0x5e
>May 16 11:18:30 localhost kernel:  [pg0+947508307/1069655040] try_init_acpi+0x41/0x2a9 [ipmi_si]
>May 16 11:18:30 localhost kernel:  [<f8b81453>] try_init_acpi+0x41/0x2a9 [ipmi_si]
>May 16 11:18:30 localhost kernel:  [pg0+947512705/1069655040] init_one_smi+0x4e2/0x57d [ipmi_si]
>May 16 11:18:30 localhost kernel:  [<f8b82581>] init_one_smi+0x4e2/0x57d [ipmi_si]
>May 16 11:18:30 localhost kernel:  [vprintk+312/367] vprintk+0x138/0x16f
>May 16 11:18:30 localhost kernel:  [<c011dc62>] vprintk+0x138/0x16f
>May 16 11:18:30 localhost kernel:  [pg0+944169095/1069655040] init_ipmi_si+0x87/0x22f [ipmi_si]
>May 16 11:18:30 localhost kernel:  [<f8852087>] init_ipmi_si+0x87/0x22f [ipmi_si]
>May 16 11:18:30 localhost kernel:  [sys_init_module+371/531] sys_init_module+0x173/0x213
>May 16 11:18:30 localhost kernel:  [<c01361d9>] sys_init_module+0x173/0x213
>May 16 11:18:30 localhost kernel:  [sysenter_past_esp+82/117] sysenter_past_esp+0x52/0x75
>May 16 11:18:30 localhost kernel:  [<c0102fd5>] sysenter_past_esp+0x52/0x75
>May 16 11:18:30 localhost kernel: Code: ff 83 c4 0c 85 c0 89 c6 75 1e 8b 54 24 10 8b 42 0c 8b 54 24 48 89 02 eb 0f 45 3b 6c 24 0c e9 4e ff ff ff be 06 00 00 00 8b 43 0c <ff> 70 04 50 e8 16 c5 fe ff 53 e8 a7 c4 fe ff 83 c4 0c 83 7c 24
>
>Regards
>
>  
>

