Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129850AbRBRV42>; Sun, 18 Feb 2001 16:56:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129826AbRBRV4S>; Sun, 18 Feb 2001 16:56:18 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:268 "EHLO aslan.scsiguy.com")
	by vger.kernel.org with ESMTP id <S129850AbRBRV4J>;
	Sun, 18 Feb 2001 16:56:09 -0500
Message-Id: <200102182156.f1ILu2O97461@aslan.scsiguy.com>
To: Wakko Warner <wakko@animx.eu.org>
cc: linux-kernel@vger.kernel.org
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Subject: Re: AIC7xxx oops with justin gibbs patch on 2.4.1 alpha noritake 
In-Reply-To: Your message of "Sun, 18 Feb 2001 15:58:50 EST."
	 <20010218155850.A16715@animx.eu.org> 
Date: Sun, 18 Feb 2001 14:56:02 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Here's the dmesg when it happened (I took this via serial console which I was
>logged in to)
>[root@kakarot:/lvm/misc] cp /dev/zero .
>(scsi1:A:2:0): data overrun detected in Data-out phase.  Tag == 0x33.

Someone is sending a request that your drive believes specifies a data
transfer to the drive such that either use_sg is 0 and request_buflen is
0 or use_sg is non-zero, but pci_map_sg returns 0.  From looking at the
alpha implementation of pci_map_sg, you should see a kernel message if
it fails, so that should not be the problem.

Some things to try...

1) In aic7xxx_linux.c:ahc_run_device_queue() around line 1612, you can
add code to panic should we ever get to that point with scb-sg_count == 0
and cmd->sc_data_direction != SCSI_DATA_NONE.  If that hits, printout
cmd->use_sg and cmd->request_buflen.

2) In aic7xxx.c:ahc_handle_seqint() around line 743, you might want to
print out scb->io_ctx->cmnd which is the cdb that was sent.  It may also
be good to print out cmd->use_sg and cmd->request_buflen.

>From the looks of it, it logged me out.  the 2nd oops I caused with the
>sysrq-s.  As you can see, I copied /dev/zero to a disk.  That disk is
>reiserfs ontop of LVM striping across 3 disks. 2.4.1 using the builtin
>qlogic controller appears to be solid (had a 10 day uptime or so when I
>shut it down.  before with the reiserfs patch it would crash every 3-4 days
>w/o usage).  what's strange is the fact that once the disk is full it then
>crashes.  Last time I tried this, after the system came back up I noticed
>that there were 0 bytes left on the drive (well 1995kb, but I couldn't write
>anything, I think that's a reiserfs bug, not sure)

Perhaps in the case of a full disk, the kernel queues a 0 length transaction
that is not caught before reaching the SCSI driver.  The driver doesn't
spend a lot of its time trying to catch bogus transactions queued to it,
so it doesn't surprise me that it falls over in this case.   Hopefully the
information gleaned from the above printks/panics will help track down
the source of the bogus transaction.

--
Justin
