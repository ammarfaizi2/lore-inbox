Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267363AbTGMO7v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 10:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267401AbTGMO7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 10:59:51 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:21008 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S267363AbTGMO7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 10:59:44 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.5.75 - ppa unload PATCH and remaining problem
Date: Sun, 13 Jul 2003 18:47:39 +0400
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_LEXE/7cWYJRhSsc"
Message-Id: <200307131847.39447.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_LEXE/7cWYJRhSsc
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

rmmod ppa does not remove any attached device nodes and gives:

ppa: Version 2.07 (for Linux 2.4.x)
ppa: Found device at ID 4, Attempting to use EPP 32 bit
ppa: Found device at ID 4, Attempting to use PS/2
ppa: Communication established with ID 4 using PS/2
scsi0 : Iomega VPI0 (ppa) interface
  Vendor: iomega    Model: jaz 2GB           Rev: E.17
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sda at scsi0, channel 0, id 4, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 4, lun 0,  type 0
sda: Spinning up disk....ready
SCSI device sda: 2091050 512-byte hdwr sectors (1071 MB)
sda: Write Protect is off
sda: Mode Sense: 39 00 10 08
SCSI device sda: drive cache: write through
SCSI device sda: 2091050 512-byte hdwr sectors (1071 MB)
sda: Write Protect is off
sda: Mode Sense: 39 00 10 08
SCSI device sda: drive cache: write through
 /dev/scsi/host0/bus0/target4/lun0: p4
Releasing ppa0
Iomega VPI0 (ppa) interface did not call scsi_unregister
Call Trace:
 [<d2d2fcf6>] exit_this_scsi_driver+0xb6/0xfa [ppa]
 [<c013f0ad>] sys_delete_module+0x11d/0x150
 [<c015787b>] do_munmap+0x13b/0x1a0
 [<c0157923>] sys_munmap+0x43/0x70
 [<c011d920>] do_page_fault+0x0/0x4b8
 [<c010b527>] syscall_call+0x7/0xb


adding scsi_unregister to ppa_release does remove all devices and sysfs node 
for ppa but leaves /dev/scsi/host0/bus0/target4 in place and does not remove 
/proc entries; loading ppa again creates second host with /proc/scsi looking 
funny:

{pts/3}% LC_ALL=C ls -l /proc/scsi
total 0
-r--r--r--    1 root     root            0 Jul 13 18:42 device_info
dr-xr-xr-x    2 root     root            0 Jul 13 18:42 ppa/
dr-xr-xr-x    2 root     root            0 Jul 13 18:42 ppa/
-r--r--r--    1 root     root            0 Jul 13 18:42 scsi
dr-xr-xr-x    2 root     root            0 Jul 13 18:42 sg/

attempt to access /proc/scsi after ppa has been unloaded (with my patch or 
without) even after the first time gives:

pts/3}% LC_ALL=C ls -lR /proc/scsi
zsh: segmentation fault  LC_ALL=C ls -F --color=auto -lR /proc/scsi

dmesg ->

Unable to handle kernel paging request at virtual address d2d42320
 printing eip:
c0199360
*pde = 09fa3067
*pte = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c0199360>]    Tainted: P
EFLAGS: 00010202
EIP is at proc_get_inode+0xb0/0x1a0
eax: 00000000   ebx: c5a3e014   ecx: 00000002   edx: d2d42320
esi: c2f4a4fc   edi: 00000001   ebp: c77afe30   esp: c77afe24
ds: 007b   es: 007b   ss: 0068
Process ls (pid: 2893, threadinfo=c77ae000 task=c76c9000)
Stack: 00000003 c5ab708b c2f4a54b c77afe5c c019cb29 cff93004 000011e7 c2f4a4fc
       c2f4a4fc ffffffea 00000000 fffffff4 cea33084 cea33014 c77afe80 c0173a25
       cea33014 c5ab7004 c77aff30 c5ab7004 c77afef4 c77aff30 cffb08e4 c77afea0
Call Trace:
 [<c019cb29>] proc_lookup+0x169/0x190
 [<c0173a25>] real_lookup+0xb5/0xe0
 [<c0173ebd>] do_lookup+0x6d/0x80
 [<c01744a7>] link_path_walk+0x5d7/0xb30
 [<c014c129>] kmem_cache_alloc+0x99/0x1a0
 [<c0174f92>] __user_walk+0x32/0x50
 [<c016f127>] vfs_lstat+0x17/0x50
 [<c016f724>] sys_lstat64+0x14/0x30
 [<c01796f4>] sys_getdents64+0x74/0xb2
 [<c017972d>] sys_getdents64+0xad/0xb2
 [<c010b527>] syscall_call+0x7/0xb

Code: 83 3a 02 0f 84 aa 00 00 00 c1 e0 05 8d 04 10 f0 ff 80 a0 00
 <6>note: ls[2893] exited with preempt_count 2
Debug: sleeping function called from illegal context at 
include/asm/semaphore.h:119
Call Trace:
 [<c0122bb8>] __might_sleep+0x58/0x70
 [<c01560bb>] remove_shared_vm_struct+0x2b/0x90
 [<c0157cfa>] exit_mmap+0x19a/0x250
 [<c012375c>] mmput+0x8c/0x100
 [<c012868c>] do_exit+0x19c/0x690
 [<c010cbf7>] die+0x137/0x140
 [<c011da6a>] do_page_fault+0x14a/0x4b8
 [<c014c1bb>] kmem_cache_alloc+0x12b/0x1a0
 [<c0199107>] proc_alloc_inode+0x17/0x70
 [<c0199136>] proc_alloc_inode+0x46/0x70
 [<c011d920>] do_page_fault+0x0/0x4b8
 [<c010c54d>] error_code+0x2d/0x40
 [<c018007b>] d_delete+0x15b/0x270
 [<c0199360>] proc_get_inode+0xb0/0x1a0
 [<c019cb29>] proc_lookup+0x169/0x190
 [<c0173a25>] real_lookup+0xb5/0xe0
 [<c0173ebd>] do_lookup+0x6d/0x80
 [<c01744a7>] link_path_walk+0x5d7/0xb30
 [<c014c129>] kmem_cache_alloc+0x99/0x1a0
 [<c0174f92>] __user_walk+0x32/0x50
 [<c016f127>] vfs_lstat+0x17/0x50
 [<c016f724>] sys_lstat64+0x14/0x30
 [<c01796f4>] sys_getdents64+0x74/0xb2
 [<c017972d>] sys_getdents64+0xad/0xb2
 [<c010b527>] syscall_call+0x7/0xb

Any pointers appreciated. It is tainted by nVidia if question arises.

TIA

-andrey

--Boundary-00=_LEXE/7cWYJRhSsc
Content-Type: text/x-diff;
  charset="us-ascii";
  name="2.5.75-ppa-scsi_unregister.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="2.5.75-ppa-scsi_unregister.patch"

--- linux-2.5.75-smp/drivers/scsi/ppa.c.scsi_unregister	2003-06-26 21:41:23.000000000 +0400
+++ linux-2.5.75-smp/drivers/scsi/ppa.c	2003-07-13 18:05:07.000000000 +0400
@@ -76,6 +76,7 @@ int ppa_release(struct Scsi_Host *host)
     int host_no = host->unique_id;
 
     printk("Releasing ppa%i\n", host_no);
+    scsi_unregister(host);
     parport_unregister_device(ppa_hosts[host_no].dev);
     return 0;
 }

--Boundary-00=_LEXE/7cWYJRhSsc--

