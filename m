Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313541AbSDMJrc>; Sat, 13 Apr 2002 05:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313580AbSDMJrb>; Sat, 13 Apr 2002 05:47:31 -0400
Received: from ws-002.ray.fi ([193.64.14.2]:23397 "EHLO behemoth.ts.ray.fi")
	by vger.kernel.org with ESMTP id <S313541AbSDMJr3>;
	Sat, 13 Apr 2002 05:47:29 -0400
Date: Sat, 13 Apr 2002 12:47:23 +0300 (EEST)
From: Tommi Kyntola <kynde@ts.ray.fi>
X-X-Sender: kynde@behemoth.ts.ray.fi
To: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: [BUG] oops with USB mass storage and DiskOnKey
In-Reply-To: <20020412224832.D1832@nbkurt.etpnet.phys.tue.nl>
Message-ID: <Pine.LNX.4.44.0204131121040.22068-100000@behemoth.ts.ray.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Reproducible mount/sync hang which results in oops with DiskOnKey.

After unplugging a DiskOnKey USB mass storage device (after being plugged 
in and mounted/umounted atleast once) and then plugging it back in, any 
mount for that device will hang (and after that all calls to sync 
will/would hang, too) And after 20ish seconds it oopses...

Here's the oops with 2.4.19-pre6, what was done was :
mount /dev/sda1 /mnt/diskonkey
umout /mnt/diskonkey
*** unplugged the DoK and plugged it right back in ***
mount /dev/sda1 /mnt/diskonkey

straced : 
mount("/dev/sda1","/mnt/diskonkey","ext2",MS_NOSUID|MS_NODEV|0xc0ed0000,0x805b140 
-------------------------------------------------------------------------

Unable to handle kernel paging request at virtual address 6c2d7479
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<d0851269>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 6c2d7461   ebx: cf658c00   ecx: cd837e5c   edx: cf2228c0
esi: 00000190   edi: cd837e58   ebp: cd836000   esp: cd837e4c
ds: 0018   es: 0018   ss: 0018
Process scsi_eh_0 (pid: 1372, stackpage=cd837000)
Stack: d0851352 cf2228c0 cd837e68 00000000 cd837e70 cd837e70 00000000 00000000
       cd836000 cd837e5c cd837e5c cf658c00 80000000 ce47ee40 00000000 d08514b9
       cf2228c0 00000190 cd837e98 00000246 00000000 ce47ee40 00000190 cf658c00
Call Trace: [<d0851352>] [<d08514b9>] [<d0851554>] [<d085f484>] [<d0852371>]   
  [<d0855016>] [<c011543b>] [<d0962359>] [<d0917c0d>] [<d0918313>] [<d091882a>]
  [<c010879e>] [<c0110018>] [<c0107036>] [<d0918730>]
Code: 8b 40 18 85 c0 74 06 52 ff 50 0c 5a c3 b8 ed ff ff ff c3 8d

>>EIP; d0851269 <[usbcore]usb_submit_urb+19/30>   <=====
Trace; d0851352 <[usbcore]usb_start_wait_urb+82/190>
Trace; d08514b9 <[usbcore]usb_internal_control_msg+59/70>
Trace; d0851554 <[usbcore]usb_control_msg+84/a0>
Trace; d085f484 <[usbcore]usb_address0_sem+0/14>
Trace; d0852371 <[usbcore]usb_set_address+31/40>
Trace; d0855016 <[usbcore]usb_reset_device+c6/2f7>
Trace; c011543b <call_console_drivers+eb/100>
Trace; d0962359 <[usb-storage]bus_reset+89/1e0>
Trace; d0917c0d <[scsi_mod]scsi_try_bus_reset+3d/90>
Trace; d0918313 <[scsi_mod]scsi_unjam_host+383/7a0>
Trace; d091882a <[scsi_mod]scsi_error_handler+fa/160>
Trace; c010879e <ret_from_fork+6/20>
Trace; c0110018 <pcibios_lookup_irq+138/2a0>
Trace; c0107036 <kernel_thread+26/30>
Trace; d0918730 <[scsi_mod]scsi_error_handler+0/160>
Code;  d0851269 <[usbcore]usb_submit_urb+19/30>   <=====
   0:   8b 40 18                  mov    0x18(%eax),%eax   <=====
Code;  d085126c <[usbcore]usb_submit_urb+1c/30>
   3:   85 c0                     test   %eax,%eax

...

I'm not sure wether this is a known issue or just induced by 
possible bugs in DiskOnKey. I've tested this thing with uhci (bx 
chipset) and ohci (Ali chipset) boxen with same results.

I've had this same issue with kernel versions 2.4.X (vanilla aswell 
as -ac tree) from atleast 2.4.9 up to 2.4.19-pre6 aswell as 2.5.0 up to 
IIRC 2.5.7 (possibly just up to 2.5.6).

I can post the .config and post the full ksymoops and look into it more 
if this indeed is a new issue and not just some personal fsck-up due to 
ignorance. 

-- 
Tommi Kynde Kyntola		kynde@ts.ray.fi
      "A man alone in the forest talking to himself and
       no women around to hear him. Is he still wrong?"

