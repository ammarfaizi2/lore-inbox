Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261225AbUKUQUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbUKUQUT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 11:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbUKUQSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 11:18:34 -0500
Received: from 82-43-72-5.cable.ubr06.croy.blueyonder.co.uk ([82.43.72.5]:63482
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S261206AbUKUQN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 11:13:58 -0500
From: Alan Chandler <alan@chandlerfamily.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: ide-cd problem
Date: Sun, 21 Nov 2004 16:13:54 +0000
User-Agent: KMail/1.7.1
Cc: Jens Axboe <axboe@suse.de>
References: <200411201842.15091.alan@chandlerfamily.org.uk> <20041121085636.GG26240@suse.de> <200411211025.11629.alan@chandlerfamily.org.uk>
In-Reply-To: <200411211025.11629.alan@chandlerfamily.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411211613.54713.alan@chandlerfamily.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 November 2004 10:25, Alan Chandler wrote:
...
> 0x0 Nov 21 10:13:44 kanger kernel: scsi_cmd_ioctl - cmd = 0x2285
> Nov 21 10:13:44 kanger kernel: scsi_ioctl: sg_io cmd [0] = 0x0
...
> Nov 21 10:13:44 kanger kernel: ide-cd:cdrom_newpc_intr (in pio after
> reading registers) ireason = 2 len = 0 stat = 0x58
> Nov 21 10:13:44 kanger kernel: ide-cd:cdrom_newpc_intr (DRQ not clear) - rq
> cmd[0] = 0x0 rq len = 0
> Nov 21 10:13:44 kanger kernel: ide-cd:cdrom_newpc_intr (about to call
> ide_set_handler with seld as rentry) timeout = 40000
> Nov 21 10:14:24 kanger kernel: hdc: lost interrupt

This seems to be some combination of frequently occuring timing problem, and 
the difference treatment in cdrom_newpc_intr to cdrom_pc_intr

I instrumented the latter interrupt routine as well as the first, and got the 
following whilst loading up the system.  It seems that there are several 
times where DRQ is asserted initially, but after a timeout no longer is.

ide-cd:cdrom_do_packet_command
ide-cd:cdrom_start_packet_command - xferlen = 24 - dma = 0
ide-cd:cdrpm_pc_intr - from command 0x5a
ide-cd:cdrom_pc_intr - stat = 0x58 ireason = 2 len = 24
ide-cd:cdrpm_pc_intr - from command 0x5a
ide-cd:cdrom_pc_intr - stat = 0x50 ireason = 3 len = 24
hdc: ATAPI 48X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-cd:cdrom_do_packet_command
ide-cd:cdrom_start_packet_command - xferlen = 0 - dma = 0
ide-cd:cdrpm_pc_intr - from command 0x0
ide-cd:cdrom_pc_intr - stat = 0x50 ireason = 3 len = 0
ide-cd:cdrom_do_packet_command
ide-cd:cdrom_start_packet_command - xferlen = 8 - dma = 0
ide-cd:cdrpm_pc_intr - from command 0x25
ide-cd:cdrom_pc_intr - stat = 0x58 ireason = 2 len = 8
ide-cd:cdrpm_pc_intr - from command 0x25
ide-cd:cdrom_pc_intr - stat = 0x50 ireason = 3 len = 8
ide-cd:cdrom_do_packet_command
ide-cd:cdrom_start_packet_command - xferlen = 4 - dma = 0
ide-cd:cdrpm_pc_intr - from command 0x43
ide-cd:cdrom_do_packet_command
ide-cd:cdrom_start_packet_command - xferlen = 18 - dma = 0
ide-cd:cdrpm_pc_intr - from command 0x3
ide-cd:cdrom_pc_intr - stat = 0x58 ireason = 2 len = 18
ide-cd:cdrpm_pc_intr - from command 0x3
ide-cd:cdrom_pc_intr - stat = 0x50 ireason = 3 len = 18

The other point is that the point of error is not entirely consistent between 
runs.  Occasssionally the 0x0 command succeeds and moves on to the 0x1b 
command

[It might also be worth pointing out here that I am using 2.6.9 and tried with 
2.6.10-rc2 and could not even get the system to get past the cd-rom 
initialisation stage.  I haven't been able to find out what might be 
different between the two ways of initialising the system - I can't see much 
difference inside ide-cd.c]


-- 
Alan Chandler
alan@chandlerfamily.org.uk
First they ignore you, then they laugh at you,
 then they fight you, then you win. --Gandhi
