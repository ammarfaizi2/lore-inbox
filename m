Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288870AbSAIGMk>; Wed, 9 Jan 2002 01:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288866AbSAIGMb>; Wed, 9 Jan 2002 01:12:31 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:29630 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S288870AbSAIGMT>; Wed, 9 Jan 2002 01:12:19 -0500
Date: Wed, 9 Jan 2002 08:12:14 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: Jens Axboe <axboe@suse.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Oops with eject and cdrom affects 2.4 & 2.5
Message-ID: <Pine.LNX.4.33.0201090809080.30141-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens, Marcelo,
	Doing an "eject" with my somewhat damaged SuSE 5.3 CD gave me the
appended reproducible oops. This bug is present in both 2.4 (visual
inspection) and 2.5. Here is the code path before the oops

ide-cd.c
static
int cdrom_queue_packet_command(ide_drive_t *drive, struct packet_command
*pc)
{
<snip>
		if (ide_do_drive_cmd (drive, &req, ide_wait)) { <== [1]
			printk("%s: do_drive_cmd returned
stat=%02x,err=%02x\n",
				drive->name, req.buffer[0],
req.buffer[1]);
			/* FIXME: we should probably abort/retry or
something */
<snip>

[1] ide_do_drive_cmd returns -EIO so we end up doing the printk. Tadow!
NULL dereference because of (char *)req.buffer. Then again, this printk
seems quite redundant IMO.

Patch diffed and tested on 2.5.2-pre10, should also apply to 2.4.17+

--- linux-2.5.2-pre10/drivers/ide/ide-cd.c.orig	Wed Jan  9 09:37:24 2002
+++ linux-2.5.2-pre10/drivers/ide/ide-cd.c	Wed Jan  9 09:48:15 2002
@@ -1399,8 +1399,8 @@
 		req.flags = REQ_PC;
 		req.special = (char *) pc;
 		if (ide_do_drive_cmd (drive, &req, ide_wait)) {
-			printk("%s: do_drive_cmd returned stat=%02x,err=%02x\n",
-				drive->name, req.buffer[0], req.buffer[1]);
+			printk(KERN_DEBUG "%s: do_drive_cmd returned -EIO\n",
+				drive->name);
 			/* FIXME: we should probably abort/retry or something */
 		}
 		if (pc->stat != 0) {

Regards,
	Zwane Mwaikambo

[root@mondecino root]# eject
Jan  1 02:01:25 mondecino kernel: VFS: Disk change detected on device
ide1(22,64)
Jan  1 02:01:35 mondecino kernel: hdd: irq timeout: status=0xd0 { Busy }
Unable to handle kernel NULL pointer dereference at virtual address
00000001
*pde = 0a5d5001
*pte = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c02268ae>]    Not tainted
EFLAGS: 00010282
eax: fffffffb   ebx: ca5d7dc0   ecx: 013de100   edx: 00000000
esi: 0000000a   edi: ca5d7cec   ebp: c03de138   esp: ca5d7cec
ds: 0018   es: 0018   ss: 0018
Process eject (pid: 704, stackpage=ca5d7000)
Stack: c03de138 c03de138 00002000 00000000 00000000 00000000 00000000
00000220
       ffffffff 00001640 00000001 00000000 00000000 00000000 00000000
00000000
       00000000 00000000 ca5d7dc0 00000000 ca5d7ca8 00000000 00000000
00000000
Call Trace: [<c022714d>] [<c02271f3>] [<c01506d5>] [<c0228a7d>]
[<c0171640>]
   [<c0162ef0>] [<c0172ce7>] [<c0171640>] [<c021bfb9>] [<c0150e69>]
[<c02311c8>]
   [<c02289d0>] [<c021c18e>] [<c0150f89>] [<c0151125>] [<c01472a6>]
[<c01471ad>]
   [<c015478e>] [<c0147517>] [<c010910b>]

Code: 0f be 42 01 50 0f be 02 50 8d 85 34 01 00 00 50 68 40 4a 2f

>>EIP; c02268ae <cdrom_queue_packet_command+5e/f0>   <=====
Trace; c022714d <cdrom_read_tocentry+7d/90>
Trace; c02271f3 <cdrom_read_toc+93/3c0>
Trace; c01506d5 <bdget+75/270>
Trace; c0228a7d <ide_cdrom_revalidate+2d/b0>
Trace; c0171640 <kstat_read_proc+180/300>
Trace; c0162ef0 <invalidate_device+50/60>
Trace; c0172ce7 <wipe_partitions+67/90>
Trace; c0171640 <kstat_read_proc+180/300>
Trace; c021bfb9 <ide_revalidate_disk+159/180>
Trace; c0150e69 <check_disk_change+79/90>
Trace; c02311c8 <cdrom_open+b8/c0>
Trace; c02289d0 <ide_cdrom_open+40/60>
Trace; c021c18e <ide_open+ce/100>
Trace; c0150f89 <do_open+b9/1c0>
Trace; c0151125 <blkdev_open+25/30>
Trace; c01472a6 <dentry_open+e6/190>
Trace; c01471ad <filp_open+4d/60>
Trace; c015478e <getname+5e/a0>
Trace; c0147517 <sys_open+47/130>
Trace; c010910b <system_call+33/38>
Code;  c02268ae <cdrom_queue_packet_command+5e/f0>
00000000 <_EIP>:
Code;  c02268ae <cdrom_queue_packet_command+5e/f0>   <=====
   0:   0f be 42 01               movsbl 0x1(%edx),%eax   <=====
Code;  c02268b2 <cdrom_queue_packet_command+62/f0>
   4:   50                        push   %eax
Code;  c02268b3 <cdrom_queue_packet_command+63/f0>
   5:   0f be 02                  movsbl (%edx),%eax
Code;  c02268b6 <cdrom_queue_packet_command+66/f0>
   8:   50                        push   %eax
Code;  c02268b7 <cdrom_queue_packet_command+67/f0>
   9:   8d 85 34 01 00 00         lea    0x134(%ebp),%eax
Code;  c02268bd <cdrom_queue_packet_command+6d/f0>
   f:   50                        push   %eax
Code;  c02268be <cdrom_queue_packet_command+6e/f0>
  10:   68 40 4a 2f 00            push   $0x2f4a40


