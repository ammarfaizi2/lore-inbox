Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262888AbSIUUgy>; Sat, 21 Sep 2002 16:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275940AbSIUUgy>; Sat, 21 Sep 2002 16:36:54 -0400
Received: from pa90.banino.sdi.tpnet.pl ([213.76.211.90]:30738 "EHLO
	alf.amelek.gda.pl") by vger.kernel.org with ESMTP
	id <S262888AbSIUUgw>; Sat, 21 Sep 2002 16:36:52 -0400
Subject: Oops in usb_submit_urb with US_FL_MODE_XLATE (2.4.19 and 2.4.20-pre7)
To: greg@kroah.com, mdharm-usb@one-eyed-alien.net
Date: Sat, 21 Sep 2002 22:41:52 +0200 (CEST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL95 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E17sr4a-0007j8-00@alf.amelek.gda.pl>
From: Marek Michalkiewicz <marekm@amelek.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

while getting my Sagatek DCS-CF (aka Datafab KECF-USB) USB/CompactFlash
adapter to work, I got an Oops after adding US_FL_MODE_XLATE to the
drivers/usb/storage/unusual_devs.h entry.  Fortunately, my device does
not require that flag (it just avoids a harmless "test WP failed"
message, but the Oops a while later is worse ;), but I hope you find
the bug report useful (I can also see the same problem under 2.4.19).

See below for the patch I applied (note that US_FL_MODE_XLATE is not
required for the device to work, only required to trigger the Oops),
and the decoded Oops itself.  After the Oops, the system continues
to run, but the scsi_eh_2 process dies, and any process trying to
access the device gets stuck in the D state forever.

Thanks,
Marek


--- orig/linux-2.4.20-pre7/drivers/usb/storage/unusual_devs.h	2002-09-21 12:27:12.000000000 +0200
+++ linux-2.4.20-pre7/drivers/usb/storage/unusual_devs.h	2002-09-21 18:35:04.000000000 +0200
@@ -485,6 +485,17 @@
 		US_FL_MODE_XLATE ),
 #endif
 
+/* Datafab KECF-USB / Sagatek DCS-CF (Datafab DF-UG-07 chip).
+ * Submitted by Marek Michalkiewicz <marekm@amelek.gda.pl>.
+ * Needed for FIX_INQUIRY.  Only revision 1.13 tested.
+ * See also http://martin.wilck.bei.t-online.de/#kecf .
+ */
+UNUSUAL_DEV(  0x07c4, 0xa400, 0x0000, 0xffff,
+		"Datafab",
+		"KECF-USB",
+		US_SC_SCSI, US_PR_BULK, NULL,
+		US_FL_FIX_INQUIRY | US_FL_MODE_XLATE ),
+
 /* Casio QV 2x00/3x00/4000/8000 digital still cameras are not conformant
  * to the USB storage specification in two ways:
  * - They tell us they are using transport protocol CBI. In reality they


ksymoops 2.4.6 on i686 2.4.20-pre7.  Options used
     -V (default)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.20-pre7/ (default)
     -m /boot/System.map-2.4.20-pre7 (default)

No modules in ksyms, skipping objects
Unable to handle kernel paging request at virtual address 00140021
c02a4811
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c02a4811>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 00140005   ebx: cfec2000   ecx: cfc0de70   edx: cff585c0
esi: 0000012c   edi: cfc0c000   ebp: cfc0de70   esp: cfc0de50
ds: 0018   es: 0018   ss: 0018
Process scsi_eh_2 (pid: 29, stackpage=cfc0d000)
Stack: c02a4902 cff585c0 cfec2000 85033b80 cfe22200 cfc0df5c 00000109 cfc0de80 
       cfc0de88 cfc0de88 00000000 00000000 00000000 cfc0c000 cfc0de70 cfc0de70 
       c02a4a63 cff585c0 0000012c cfc0deb0 cfe22200 00000004 00000080 00000004 
Call Trace:    [<c02a4902>] [<c02a4a63>] [<c02a4af3>] [<c02a580e>] [<c02a7f74>]
  [<c02b629d>] [<c0258607>] [<c0258e66>] [<c0259409>] [<c0106ec0>]
Code: 8b 40 1c 85 c0 74 0a 52 8b 40 0c ff d0 83 c4 04 c3 b8 ed ff 


>>EIP; c02a4811 <usb_submit_urb+19/30>   <=====

Trace; c02a4902 <usb_start_wait_urb+8a/18c>
Trace; c02a4a63 <usb_internal_control_msg+5f/74>
Trace; c02a4af3 <usb_control_msg+7b/98>
Trace; c02a580e <usb_get_descriptor+96/b0>
Trace; c02a7f74 <usb_reset_device+18c/311>
Trace; c02b629d <bus_reset+5d/150>
Trace; c0258607 <scsi_try_bus_reset+3b/88>
Trace; c0258e66 <scsi_unjam_host+50a/970>
Trace; c0259409 <scsi_error_handler+13d/19c>
Trace; c0106ec0 <kernel_thread+28/38>

Code;  c02a4811 <usb_submit_urb+19/30>
00000000 <_EIP>:
Code;  c02a4811 <usb_submit_urb+19/30>   <=====
   0:   8b 40 1c                  mov    0x1c(%eax),%eax   <=====
Code;  c02a4814 <usb_submit_urb+1c/30>
   3:   85 c0                     test   %eax,%eax
Code;  c02a4816 <usb_submit_urb+1e/30>
   5:   74 0a                     je     11 <_EIP+0x11> c02a4822 <usb_submit_urb+2a/30>
Code;  c02a4818 <usb_submit_urb+20/30>
   7:   52                        push   %edx
Code;  c02a4819 <usb_submit_urb+21/30>
   8:   8b 40 0c                  mov    0xc(%eax),%eax
Code;  c02a481c <usb_submit_urb+24/30>
   b:   ff d0                     call   *%eax
Code;  c02a481e <usb_submit_urb+26/30>
   d:   83 c4 04                  add    $0x4,%esp
Code;  c02a4821 <usb_submit_urb+29/30>
  10:   c3                        ret    
Code;  c02a4822 <usb_submit_urb+2a/30>
  11:   b8 ed ff 00 00            mov    $0xffed,%eax


