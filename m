Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285273AbSBGHji>; Thu, 7 Feb 2002 02:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285498AbSBGHja>; Thu, 7 Feb 2002 02:39:30 -0500
Received: from netfinity.realnet.co.sz ([196.28.7.2]:45526 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S285273AbSBGHjX>; Thu, 7 Feb 2002 02:39:23 -0500
Date: Thu, 7 Feb 2002 09:32:05 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Andre Hedrick <andre@linux-ide.org>
Cc: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH] Oops after disabling DMA with IDE-SCSI
Message-ID: <Pine.LNX.4.44.0202070911321.8308-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	Before i go on, i'd just like to know what the general consensus 
is amongst the kernel hackers in general on how to handle error cases. 
Do we want to attain the "_Try_ and break me" status? Or is that kind of 
robustness going to hurt us performance and size wise too much? 

Looks like things get a little hairy if we drop down to PIO mode and then 
try and mount a drive. However i feel that this patch only catches cases 
like this instead of a proper fix, apparent by the fact that the scattergather table 
gets somewhat borked in ide-scsi.

2. hdparm -w /dev/hdd (actually /dev/sr0, disables DMA too)
3. mount /dev/sr0 /cdrom
4. Oops...

Looks like this particular NULL pointer goes through a few functions 
unchecked, i've decided to put the check in ide_input_data.

ide-scsi.c
static void idescsi_input_buffers (ide_drive_t *drive, idescsi_pc_t *pc, unsigned int bcount)
[...]
count = IDE_MIN (pc->sg->length - pc->b_count, bcount);
		atapi_input_bytes (drive, pc->sg->address + pc->b_count, count); <== [1]
[...]

ide.c
void ide_output_data (ide_drive_t *drive, void *buffer, unsigned int wcount)
[...]
	if (drive->slow) {
			unsigned short *ptr = (unsigned short *) buffer; <== [2]
			while (wcount--) {
				outw_p(*ptr++, IDE_DATA_REG); <=== [2]
				outw_p(*ptr++, IDE_DATA_REG);
[...]

[1] This is where the real problem is, pc->sg->address and pc->b_count are 
both 0 so looks like we've totally hosed everything.

[2] This is where we hit the NULL pointer.

Patch against 2.4.18-pre8

--- linux-2.4.18-pre8/drivers/ide/ide.c.orig	Thu Feb  7 09:21:38 2002
+++ linux-2.4.18-pre8/drivers/ide/ide.c	Thu Feb  7 09:22:30 2002
@@ -383,6 +383,8 @@
 void ide_input_data (ide_drive_t *drive, void *buffer, unsigned int wcount)
 {
 	byte io_32bit;
+	
+	BUG_ON(buffer == NULL);
 
 	/* first check if this controller has defined a special function
 	 * for handling polled ide transfers


Patch against 2.5.4-pre1

--- linux-2.5.4-pre1/drivers/ide/ide-taskfile.c.orig	Thu Feb  7 09:29:15 2002
+++ linux-2.5.4-pre1/drivers/ide/ide-taskfile.c	Thu Feb  7 09:29:40 2002
@@ -80,6 +80,8 @@
 void ata_input_data (ide_drive_t *drive, void *buffer, unsigned int wcount)
 {
 	byte io_32bit;
+	
+	BUG_ON(buffer == NULL);
 
 	/*
 	 * first check if this controller has defined a special function


Unable to handle kernel NULL pointer dereference at virtual address 00000000
*pde = 0eaa0001                                                             
*pte = 00000000
Oops: 0002     
CPU:    0 
EIP:    0010:[<c0215577>]    Not tainted
EFLAGS: 00010046                        
eax: 00000000   ebx: 00000200   ecx: 00000400   edx: 00000170
esi: c03f3cd8   edi: 00000000   ebp: c03f3cd8   esp: c032bea4
ds: 0018   es: 0018   ss: 0018                               
Process swapper (pid: 0, stackpage=c032b000)
Stack: cffeb58c 984f52b3 00000801 c03f3cd8 00000000 c03f3cd8 c021569e c03f3cd8 
       00000000 00000200 00000800 cf8b2a4c 00000000 c022cd6e c03f3cd8 00000000 
       00000800 cf8b2a4c cfd5848c 00000800 c03f3cd8 c022d39e c03f3cd8 cf8b2a4c 
Call Trace: [<c021569e>] [<c022cd6e>] [<c022d39e>] [<c011bf7b>] [<c0128536>]   
   [<c022d1e0>] [<c02175fb>] [<c010a9ee>] [<c010ad4a>] [<c0106dd0>] [<c0106dd0>] 
   [<c0106dd0>] [<c0106dd0>] [<c0106dfc>] [<c0106e62>] [<c0105000>]              
                                                                    
Code: f3 66 6d 83 c4 08 5b 5e 5f 5d c3 8d b4 26 00 00 00 00 8d bc 
 <0>Kernel panic: Aiee, killing interrupt handler!                
In interrupt handler - not syncing                

>>EIP; c0215577 <ide_input_data+c7/e0>   <=====
Trace; c021569e <atapi_input_bytes+3e/70>
Trace; c022cd6e <idescsi_input_buffers+6e/a0>
Trace; c022d39e <idescsi_pc_intr+1be/250>
Trace; c011bf7b <wake_up_process+b/20>
Trace; c0128536 <update_wall_time+16/50>
Trace; c022d1e0 <idescsi_pc_intr+0/250>
Trace; c02175fb <ide_intr+17b/260>
Trace; c010a9ee <handle_IRQ_event+5e/90>
Trace; c010ad4a <do_IRQ+10a/1c0>
Trace; c0106dd0 <default_idle+0/40>
Trace; c0106dd0 <default_idle+0/40>
Trace; c0106dd0 <default_idle+0/40>
Trace; c0106dd0 <default_idle+0/40>
Trace; c0106dfc <default_idle+2c/40>
Trace; c0106e62 <cpu_idle+32/50>
Trace; c0105000 <_stext+0/0>
Code;  c0215577 <ide_input_data+c7/e0>
00000000 <_EIP>:
Code;  c0215577 <ide_input_data+c7/e0>   <=====
   0:   f3 66 6d                  repz insw (%dx),%es:(%edi)   <=====
Code;  c021557a <ide_input_data+ca/e0>
   3:   83 c4 08                  add    $0x8,%esp
Code;  c021557d <ide_input_data+cd/e0>
   6:   5b                        pop    %ebx
Code;  c021557e <ide_input_data+ce/e0>
   7:   5e                        pop    %esi
Code;  c021557f <ide_input_data+cf/e0>
   8:   5f                        pop    %edi
Code;  c0215580 <ide_input_data+d0/e0>
   9:   5d                        pop    %ebp
Code;  c0215581 <ide_input_data+d1/e0>
   a:   c3                        ret
Code;  c0215582 <ide_input_data+d2/e0>
   b:   8d b4 26 00 00 00 00      lea    0x0(%esi,1),%esi
Code;  c0215589 <ide_input_data+d9/e0>
  12:   8d bc 00 00 00 00 00      lea    0x0(%eax,%eax,1),%edi

 <0>Kernel panic: Aiee, killing interrupt handler!

