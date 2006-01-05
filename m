Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbWAEU1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWAEU1J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 15:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbWAEU1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 15:27:09 -0500
Received: from bay101-f35.bay101.hotmail.com ([64.4.56.45]:9614 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S932151AbWAEU1G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 15:27:06 -0500
Message-ID: <BAY101-F359229E916F544AB7A726FDF2E0@phx.gbl>
X-Originating-IP: [70.150.153.162]
X-Originating-Email: [jtreubig@hotmail.com]
From: "John Treubig" <jtreubig@hotmail.com>
To: alan@lxorguk.ukuu.org.uk
Cc: raw@dslr.net, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: ATA Write Error and Time-out Notification in User Space
Date: Thu, 05 Jan 2006 14:27:03 -0600
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_NextPart_000_3de6_e7d_1aa9"
X-OriginalArrivalTime: 05 Jan 2006 20:27:03.0971 (UTC) FILETIME=[63DEAF30:01C61236]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_3de6_e7d_1aa9
Content-Type: text/plain; format=flowed

I applied the patch to the mm and yes, we have no more hangs!  The bad news 
is the application gets no notification that there has been any error in the 
drive subsystem.  I have only had one instance that I got a notification 
back, but this was due to me adding a BUG_ON statement prior to the PRINTKs.

Here's the details of what occurs:  With the application running, and I 
unplug the drive, my app still tries to read and write because it has gotten 
no error from the SG calls.  Is there a way that we can notify the kernel 
that this device is dead and cause all future accesses to result in an 
error?

I have had great difficulty getting the PRINTKs to output anything for this 
specific error, yet I've been able to get other PRINTKs in the IDE-IO.C to 
output.  I have attached the messages that do result.



From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Treubig <jtreubig@hotmail.com>
CC: raw@dslr.net, linux-ide@vger.kernel.org,linux-kernel@vger.kernel.org, 
linux-scsi@vger.kernel.org
Subject: Re: ATA Write Error and Time-out Notification in User Space
Date: Tue, 03 Jan 2006 21:48:04 +0000

On Maw, 2006-01-03 at 13:27 -0600, John Treubig wrote:
 > I receive this as great news, only I don't know where the -mm tree is
 > located to see if I can get the patch or fix!  Can you give me a few
 > pointers?!

The -mm patches live on kernel.org in pub/linux/kernel/people/akpm/

The patch you want is the one to drivers/ide/ide-io.c although be aware
it will make non PCI ATA controllers crash on errors if applied. The
"right" fix for this is probably to have a hwif->flush_data() function
that defaults to try_to_flush_leftover_data() so that the knowledge
involved is not hacked into the ide core but kept in the driver.


Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-ide" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


------=_NextPart_000_3de6_e7d_1aa9
Content-Type: text/plain; name="junk1.txt"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="junk1.txt"

Jan  5 08:28:26 localhost kernel: [  204.399120] ata_scsi_translate: EXIT
Jan  5 08:28:26 localhost kernel: [  204.408979] ata_host_intr: ata2: 
host_stat 0x4
Jan  5 08:28:26 localhost kernel: [  204.408987] ata_host_intr: ata2: 
protocol 4 (dev_stat 0x50)
Jan  5 08:28:26 localhost kernel: [  204.408991] ata_sg_clean: unmapping 1 
sg elements
Jan  5 08:28:26 localhost kernel: [  204.408993] ata_qc_complete: EXIT
Jan  5 08:28:26 localhost kernel: [  204.409010] ata_scsi_dump_cdb: CDB 
(2:0,0,0) 28 00 01 ca 9f 15 00 00 08
Jan  5 08:28:26 localhost kernel: [  204.409013] ata_scsi_translate: ENTER
Jan  5 08:28:26 localhost kernel: [  204.409015] scsi_10_lba_len: ten-byte 
command
Jan  5 08:28:26 localhost kernel: [  204.409017] ata_sg_setup_one: mapped 
buffer of 4096 bytes for read
Jan  5 08:28:26 localhost kernel: [  204.409020] ata_fill_sg: PRD[0] = 
(0xD048000, 0x1000)
Jan  5 08:28:26 localhost kernel: [  204.409022] ata_dev_select: ENTER, 
ata2: device 0, wait 1
Jan  5 08:28:26 localhost kernel: [  204.409050] ata_tf_load_mmio: feat 0x0 
nsect 0x8 lba 0x15 0x9F 0xCA
Jan  5 08:28:26 localhost kernel: [  204.409052] ata_tf_load_mmio: device 
0xE1
Jan  5 08:28:26 localhost kernel: [  204.409067] ata_exec_command_mmio: 
ata2: cmd 0xC8
Jan  5 08:28:26 localhost kernel: [  204.409072] ata_scsi_translate: EXIT
Jan  5 08:28:26 localhost kernel: [  204.409146] ata_host_intr: ata2: 
host_stat 0x4
Jan  5 08:28:26 localhost kernel: [  204.409154] ata_host_intr: ata2: 
protocol 4 (dev_stat 0x50)
Jan  5 08:28:26 localhost kernel: [  204.409158] ata_sg_clean: unmapping 1 
sg elements
Jan  5 08:28:26 localhost kernel: [  204.409160] ata_qc_complete: EXIT
Jan  5 08:28:26 localhost kernel: [  204.409211] ata_scsi_dump_cdb: CDB 
(2:0,0,0) 25 00 00 00 00 00 00 00 00
Jan  5 08:28:26 localhost kernel: [  204.409214] ata_scsiop_read_cap: ENTER
Jan  5 08:28:26 localhost kernel: [  204.409244] ata_scsi_dump_cdb: CDB 
(2:0,0,0) 2a 00 00 d9 65 fb 00 00 08
Jan  5 08:28:26 localhost kernel: [  204.409246] ata_scsi_translate: ENTER
Jan  5 08:28:26 localhost kernel: [  204.409248] scsi_10_lba_len: ten-byte 
command
Jan  5 08:28:26 localhost kernel: [  204.409251] ata_sg_setup_one: mapped 
buffer of 4096 bytes for write
Jan  5 08:28:26 localhost kernel: [  204.409253] ata_fill_sg: PRD[0] = 
(0xD048000, 0x1000)
Jan  5 08:28:26 localhost kernel: [  204.409256] ata_dev_select: ENTER, 
ata2: device 0, wait 1
Jan  5 08:28:26 localhost kernel: [  204.409283] ata_tf_load_mmio: feat 0x0 
nsect 0x8 lba 0xFB 0x65 0xD9
Jan  5 08:28:26 localhost kernel: [  204.409285] ata_tf_load_mmio: device 
0xE0
Jan  5 08:28:26 localhost kernel: [  204.409300] ata_exec_command_mmio: 
ata2: cmd 0xCA
Jan  5 08:28:26 localhost kernel: [  204.409305] ata_scsi_translate: EXIT
Jan  5 08:28:26 localhost kernel: [  204.462137] ata_host_intr: ata2: 
host_stat 0x1
Jan  5 08:28:26 localhost kernel: [  205.135110] ata_host_intr: ata2: 
host_stat 0x1
Jan  5 08:28:26 localhost kernel: [  205.211290] ata_host_intr: ata2: 
host_stat 0x1
Jan  5 08:28:40 localhost kernel: [  218.368667] ata_host_intr: ata2: 
host_stat 0x1
Jan  5 08:28:40 localhost kernel: [  218.449054] ata_host_intr: ata2: 
host_stat 0x1
Jan  5 08:28:40 localhost kernel: [  218.691283] ata_host_intr: ata2: 
host_stat 0x1
Jan  5 08:28:40 localhost kernel: [  218.946905] ata_host_intr: ata2: 
host_stat 0x1
Jan  5 08:28:40 localhost kernel: [  218.948318] ata_host_intr: ata2: 
host_stat 0x1
Jan  5 08:28:40 localhost kernel: [  219.194021] ata_host_intr: ata2: 
host_stat 0x1
Jan  5 08:28:40 localhost kernel: [  219.214175] ata_host_intr: ata2: 
host_stat 0x1
Jan  5 08:28:41 localhost kernel: [  219.696113] ata_host_intr: ata2: 
host_stat 0x1
Jan  5 08:28:41 localhost kernel: [  219.697451] ata_host_intr: ata2: 
host_stat 0x1
Jan  5 08:28:41 localhost kernel: [  219.742827] ata_host_intr: ata2: 
host_stat 0x1
Jan  5 08:28:41 localhost kernel: [  219.937038] ata_host_intr: ata2: 
host_stat 0x1
Jan  5 08:28:41 localhost kernel: [  219.985139] ata_host_intr: ata2: 
host_stat 0x1
Jan  5 08:28:42 localhost kernel: [  220.445205] ata_host_intr: ata2: 
host_stat 0x1
Jan  5 08:28:42 localhost kernel: [  220.797927] ata_host_intr: ata2: 
host_stat 0x1
Jan  5 08:28:42 localhost kernel: [  220.816866] ata_host_intr: ata2: 
host_stat 0x1
Jan  5 08:28:42 localhost kernel: [  220.907329] ata_host_intr: ata2: 
host_stat 0x1
Jan  5 08:28:42 localhost kernel: [  221.089499] ata_host_intr: ata2: 
host_stat 0x1
Jan  5 08:28:42 localhost kernel: [  221.090284] ata_host_intr: ata2: 
host_stat 0x1
Jan  5 08:28:42 localhost kernel: [  221.238775] ata_host_intr: ata2: 
host_stat 0x1
Jan  5 08:28:43 localhost kernel: [  221.267263] ata_host_intr: ata2: 
host_stat 0x1
Jan  5 08:28:43 localhost kernel: [  221.536527] ata_host_intr: ata2: 
host_stat 0x1
Jan  5 08:28:43 localhost kernel: [  221.611554] ata_host_intr: ata2: 
host_stat 0x1
Jan  5 08:28:43 localhost kernel: [  221.938468] ata_host_intr: ata2: 
host_stat 0x1
Jan  5 08:28:44 localhost kernel: [  222.373794] ata_host_intr: ata2: 
host_stat 0x1
Jan  5 08:28:44 localhost kernel: [  222.374695] ata_host_intr: ata2: 
host_stat 0x1
Jan  5 08:28:44 localhost kernel: [  223.162135] ata_host_intr: ata2: 
host_stat 0x1
Jan  5 08:28:44 localhost kernel: [  223.163329] ata_host_intr: ata2: 
host_stat 0x1
Jan  5 08:28:44 localhost kernel: [  223.164521] ata_host_intr: ata2: 
host_stat 0x1
Jan  5 08:28:45 localhost kernel: [  223.813787] ata_host_intr: ata2: 
host_stat 0x1
Jan  5 08:28:45 localhost kernel: [  224.140885] ata_host_intr: ata2: 
host_stat 0x1
Jan  5 08:28:46 localhost kernel: [  224.353850] ata_host_intr: ata2: 
host_stat 0x1
Jan  5 08:28:46 localhost kernel: [  224.379358] ata_scsi_error: ENTER
Jan  5 08:28:46 localhost kernel: [  224.379361] ata_eng_timeout: ENTER
Jan  5 08:28:46 localhost kernel: [  224.379363] ata_qc_timeout: ENTER
Jan  5 08:28:46 localhost kernel: [  224.379374] ata2: command 0xca timeout, 
stat 0x7f host_stat 0x1
Jan  5 08:28:46 localhost kernel: [  224.379377] ata_sg_clean: unmapping 1 
sg elements
Jan  5 08:28:46 localhost kernel: [  224.379391] ata2: translated ATA 
stat/err 0x7f/7f to SCSI SK/ASC/ASCQ 0x4/00/00
Jan  5 08:28:46 localhost kernel: [  224.379394] ata2: status=0x7f { 
DriveReady DeviceFault SeekComplete DataRequest CorrectedError Index Error }
Jan  5 08:28:46 localhost kernel: [  224.379399] ata2: error=0x7f { 
DriveStatusError UncorrectableError SectorIdNotFound TrackZeroNotFound 
AddrMarkNotFound }
Jan  5 08:28:46 localhost kernel: [  224.379411] ata_qc_complete: EXIT
Jan  5 08:28:46 localhost kernel: [  224.379413] ata_qc_timeout: EXIT
Jan  5 08:28:46 localhost kernel: [  224.379414] ata_eng_timeout: EXIT
Jan  5 08:28:46 localhost kernel: [  224.379416] ata_scsi_error: EXIT
Jan  5 08:28:46 localhost kernel: [  224.400243] ata_scsi_dump_cdb: CDB 
(2:0,0,0) 25 00 00 00 00 00 00 00 00
Jan  5 08:28:46 localhost kernel: [  224.400249] ata_scsiop_read_cap: ENTER
Jan  5 08:28:46 localhost kernel: [  224.400423] ata_scsi_dump_cdb: CDB 
(2:0,0,0) 2a 00 03 af fd 18 00 00 08
Jan  5 08:28:46 localhost kernel: [  224.400426] ata_scsi_translate: ENTER
Jan  5 08:28:46 localhost kernel: [  224.400430] scsi_10_lba_len: ten-byte 
command
Jan  5 08:28:46 localhost kernel: [  224.400435] ata_sg_setup_one: mapped 
buffer of 4096 bytes for write
Jan  5 08:28:46 localhost kernel: [  224.400438] ata_fill_sg: PRD[0] = 
(0xD048000, 0x1000)
Jan  5 08:28:46 localhost kernel: [  224.400441] ata_dev_select: ENTER, 
ata2: device 0, wait 1
Jan  5 08:28:46 localhost kernel: [  224.410486] ATA: abnormal status 0x7F 
on port 0xD08195DF
Jan  5 08:28:46 localhost kernel: [  224.410504] ata_tf_load_mmio: feat 0x0 
nsect 0x8 lba 0x18 0xFD 0xAF
Jan  5 08:28:46 localhost kernel: [  224.410506] ata_tf_load_mmio: device 
0xE3
Jan  5 08:28:46 localhost kernel: [  224.410522] ata_exec_command_mmio: 
ata2: cmd 0xCA
Jan  5 08:28:46 localhost kernel: [  224.410527] ata_scsi_translate: EXIT
Jan  5 08:28:46 localhost kernel: [  224.658874] ata_host_intr: ata2: 
host_stat 0x1
Jan  5 08:28:46 localhost kernel: [  224.753952] ata_host_intr: ata2: 
host_stat 0x1
Jan  5 08:28:46 localhost kernel: [  224.874626] ata_host_intr: ata2: 
host_stat 0x1
Jan  5 08:28:46 localhost kernel: [  225.186896] ata_host_intr: ata2: 
host_stat 0x1
Jan  5 08:28:47 localhost kernel: [  226.040653] ata_host_intr: ata2: 
host_stat 0x1
Jan  5 08:28:47 localhost kernel: [  226.191764] ata_host_intr: ata2: 
host_stat 0x1
Jan  5 08:28:48 localhost kernel: [  226.348601] ata_host_intr: ata2: 
host_stat 0x1
Jan  5 08:28:48 localhost kernel: [  226.415600] ata_host_intr: ata2: 
host_stat 0x1
Jan  5 08:28:48 localhost kernel: [  226.878584] ata_host_intr: ata2: 
host_stat 0x1
Jan  5 08:28:48 localhost kernel: [  226.909086] ata_host_intr: ata2: 
host_stat 0x1
Jan  5 08:28:48 localhost kernel: [  226.933143] ata_host_intr: ata2: 
host_stat 0x1
Jan  5 08:28:49 localhost kernel: [  227.240286] ata_host_intr: ata2: 
host_stat 0x1
Jan  5 08:28:49 localhost kernel: [  227.458131] ata_host_intr: ata2: 
host_stat 0x1


------=_NextPart_000_3de6_e7d_1aa9--
