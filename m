Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261819AbULJVeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbULJVeR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 16:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbULJVeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 16:34:17 -0500
Received: from 82-43-72-5.cable.ubr06.croy.blueyonder.co.uk ([82.43.72.5]:34807
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S261819AbULJVcq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 16:32:46 -0500
From: Alan Chandler <alan@chandlerfamily.org.uk>
To: linux-kernel@vger.kernel.org
Subject: ide-cd problem revisited - more brainpower needed
Date: Fri, 10 Dec 2004 21:32:41 +0000
User-Agent: KMail/1.7.1
Cc: Jens Axboe <axboe@suse.de>
References: <200411201842.15091.alan@chandlerfamily.org.uk> <200411232149.31701.alan@chandlerfamily.org.uk> <200411300859.43422.alan@chandlerfamily.org.uk>
In-Reply-To: <200411300859.43422.alan@chandlerfamily.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200412102132.41512.alan@chandlerfamily.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of weeks ago, I posted in relation to a problem I have burning CDs. 

Ever since, I have solidly been looking for what might be the cause of the 
problem, and although I have identified what goes wrong, I can not see why 
that should be the case or whether it can be corrected.  Hence the request 
here.
 
All the above output is a result of the command (as root) using linux 
2.6.10-rc2 (with acpi turned off to avoid that bug)·

cdrecord -dev /dev/hdc blank=fast

The device is identified as
CW078D CD-R/RW 
a generic no name rewriter.

There is also a DVD reader on this ide channel (/dev/hdd) but it is not doing 
anything through out the testing.  I have tried removing it, 2.6.9 still 
gives the same symptoms (although I have no printk's in it), 2.6.10-rc panics 
during boot.
 ...

On Tuesday 30 November 2004 08:59, Alan Chandler wrote:
> On Tuesday 23 November 2004 21:49, Alan Chandler wrote:
>
> > Firstly, the symptoms are the same between 2.6.9 and 2.6.10-rc2.  The
> > halt seem to always be in exactly the same place. If it was a timing
> > problem I would have thought it would have varied.
> >
> > Secondly, the command before seems to have an expectation of a 2048
> > transfer rather than the 0 in the command, before the problem and then
> > you get the strange DRQ=1 but 0 in the len register.
> >
> > Nov 23 20:37:33 kanger kernel: ide-cd:ide_do_rq_cdrom - cmd = 0x0
> > Nov 23 20:37:33 kanger kernel: ide-cd:cdrom_newpc_intr - cmd=0x0
> > stat=0x50 ireason=3 len=2048 rq len=0
> > Nov 23 20:37:33 kanger kernel: ide-cd:ide_do_rq_cdrom - cmd = 0x1b
> > Nov 23 20:37:33 kanger kernel: ide-cd:cdrom_newpc_intr - cmd=0x1b
> > stat=0x58 ireason=2 len=0 rq len=0

For the past couple of weeks I have been trying different things with printk 
statements to get to the bottom of what is actually happening - I have now 
got to the point where I do not know how to get more out of it, and the 
device is behaving so strangely that I am not sure how it ever worked - 
although it does under linux 2.4 series.

The lines above are misleading - because as can be seen from below, interrupts 
occur after the command has supposedly finished - and the next request has 
already arrived.  I have added a msleep(10) in the back-end of sg_io so that 
there is a short delay before cdrecord gets control back, and its therefore 
possible to see the interrupts beyond the end of processing and before the 
next command starts.  Before I did that, I think the commands were overlapping 
in some way - and therefore the symptoms were not visable immediately.

Comments are inserted into the output to my log from printk statements below.  
the "time" is the current value of "jiffies".  I have also removed some of 
the "bodges" in ide_wait_stat to loop for 10uS - Does not appear necessary 
and I did not want to confuse the issue with them.  Alan Cox's patch and 
various other ndelay(400) statements are in to ensure that nowhere can a 
statement to clear INTR re-interrupt by the command exiting too fast (although 
in most cases it appears to make no difference if they are there or not). 


Dec 10 20:00:54 kanger kernel: scsi-ioctl: SG_IO
Dec 10 20:00:54 kanger kernel: ide-cd:ide_do_rw_cdrom
Dec 10 20:00:54 kanger kernel: ide-cd:ide_do_rw_cdrom - do block pc
Dec 10 20:00:54 kanger kernel: ide-cd:cdrom_start_packet_command with feature 
reg=0x0

I check feature reg here which indicates whether a dma (or in this case not) 
is about to happen

Dec 10 20:00:54 kanger kernel: ide-cd:cdrom_do_newpc_cont at time=4294941469 
for cmd=0x0

This is routine called after issuing the PACKET command to load the packet 
into the device.

Dec 10 20:00:54 kanger kernel: ide-cd:cdrom_newpc_intr done at time=4294941469 
with cmd=0x0 stat=0x50, req len=0, len=0, ireason=3

This is the interrupt at command completion - showing the length expected in 
the request and the len read from the device at this point.  Its after 
cdrom_decode_status has read and checked that there is not error.  "stat" is 
the value returned in the status register.

Dec 10 20:00:54 kanger kernel: scsi_ioctl:sg_io completed in time 0

This is back in the sg_io route, with the calculated time (in jiffies) to 
execute the command.


Dec 10 20:00:54 kanger kernel: scsi-ioctl: SG_IO
Dec 10 20:00:54 kanger kernel: ide-cd:ide_do_rw_cdrom
Dec 10 20:00:54 kanger kernel: ide-cd:ide_do_rw_cdrom - do block pc
Dec 10 20:00:54 kanger kernel: ide-cd:cdrom_start_packet_command with feature 
reg=0x0
Dec 10 20:00:54 kanger kernel: ide-cd:cdrom_do_newpc_cont at time=4294941480 
for cmd=0x5a
Dec 10 20:00:54 kanger kernel: ide-cd:cdrom_newpc_intr done at time=4294941481 
with cmd=0x5a stat=0x58, req len=60, len=60, ireason=2
Dec 10 20:00:54 kanger kernel: ide-cd:cdrom_newpc_intr done at time=4294941481 
with cmd=0x5a stat=0x50, req len=0, len=60, ireason=3
Dec 10 20:00:54 kanger kernel: scsi_ioctl:sg_io completed in time 1

This is similar, with a pio data transfer. Note how cdrom_newpc_intr is called 
twice, once when the device is ready for the transfer, and then at the end of 
the transfer (command complete).

Dec 10 20:00:54 kanger kernel: scsi-ioctl: SG_IO
Dec 10 20:00:54 kanger kernel: ide-cd:ide_do_rw_cdrom
Dec 10 20:00:54 kanger kernel: ide-cd:ide_do_rw_cdrom - do block pc
Dec 10 20:00:54 kanger kernel: ide-cd:cdrom_start_packet_command with feature 
reg=0x0
Dec 10 20:00:54 kanger kernel: ide-cd:cdrom_do_newpc_cont at time=4294941492 
for cmd=0x0
Dec 10 20:00:54 kanger kernel: ide-cd:cdrom_newpc_intr done at time=4294941492 
with cmd=0x0 stat=0x50, req len=0, len=0, ireason=3
Dec 10 20:00:54 kanger kernel: scsi_ioctl:sg_io completed in time 0
Dec 10 20:00:54 kanger kernel: scsi-ioctl: SG_IO
Dec 10 20:00:54 kanger kernel: ide-cd:ide_do_rw_cdrom
Dec 10 20:00:54 kanger kernel: ide-cd:ide_do_rw_cdrom - do block pc
Dec 10 20:00:54 kanger kernel: ide-cd:cdrom_start_packet_command with feature 
reg=0x0
Dec 10 20:00:54 kanger kernel: ide-cd:cdrom_do_newpc_cont at time=4294941503 
for cmd=0x0
Dec 10 20:00:54 kanger kernel: ide-cd:cdrom_newpc_intr done at time=4294941503 
with cmd=0x0 stat=0x50, req len=0, len=0, ireason=3
Dec 10 20:00:54 kanger kernel: scsi_ioctl:sg_io completed in time 0
Dec 10 20:00:54 kanger kernel: scsi-ioctl: SG_IO
Dec 10 20:00:54 kanger kernel: ide-cd:ide_do_rw_cdrom
Dec 10 20:00:54 kanger kernel: ide-cd:ide_do_rw_cdrom - do block pc
Dec 10 20:00:54 kanger kernel: ide-cd:cdrom_start_packet_command with feature 
reg=0x0
Dec 10 20:00:54 kanger kernel: ide-cd:cdrom_do_newpc_cont at time=4294941514 
for cmd=0x55
Dec 10 20:00:54 kanger kernel: ide-cd:cdrom_newpc_intr done at time=4294941514 
with cmd=0x55 stat=0x58, req len=60, len=60, ireason=0
Dec 10 20:00:54 kanger kernel: ide-cd:cdrom_newpc_intr done at time=4294941516 
with cmd=0x55 stat=0x50, req len=0, len=60, ireason=3
Dec 10 20:00:54 kanger kernel: scsi_ioctl:sg_io completed in time 2
Dec 10 20:00:54 kanger kernel: scsi-ioctl: SG_IO
Dec 10 20:00:54 kanger kernel: ide-cd:ide_do_rw_cdrom
Dec 10 20:00:54 kanger kernel: ide-cd:ide_do_rw_cdrom - do block pc
Dec 10 20:00:54 kanger kernel: ide-cd:cdrom_start_packet_command with feature 
reg=0x0
Dec 10 20:00:54 kanger kernel: ide-cd:cdrom_do_newpc_cont at time=4294941527 
for cmd=0x3c
Dec 10 20:00:54 kanger kernel: cmd[0]=0x3c
Dec 10 20:00:54 kanger kernel: cmd[1]=0x0
Dec 10 20:00:54 kanger kernel: cmd[2]=0x0
Dec 10 20:00:54 kanger kernel: cmd[3]=0x0
Dec 10 20:00:54 kanger kernel: cmd[4]=0x0
Dec 10 20:00:54 kanger kernel: cmd[5]=0x0
Dec 10 20:00:54 kanger kernel: cmd[6]=0x0
Dec 10 20:00:54 kanger kernel: cmd[7]=0x0
Dec 10 20:00:54 kanger kernel: cmd[8]=0x4
Dec 10 20:00:54 kanger kernel: cmd[9]=0x0

This is the first time something goes wrong - and its always on this READ 
BUFFER command (0x3c).  I therefore dump out the command at this stage - 
showing the internal length of 4 bytes, matching the len below.

Dec 10 20:00:54 kanger kernel: ide-cd:cdrom_newpc_intr done at time=4294941527 
with cmd=0x3c stat=0x58, req len=4, len=4, ireason=2
Dec 10 20:00:54 kanger kernel: ide-cd:cdrom_newpc_intr done at time=4294941527 
with cmd=0x3c stat=0x50, req len=0, len=4, ireason=3
Dec 10 20:00:54 kanger kernel: scsi_ioctl:sg_io completed in time 0

IO should be complete here - its the standard termination - but ...

Dec 10 20:00:54 kanger kernel: ide-io:ide_intr - seems we interrupted 
ourselves at time=4294941527, stat=0x58, ireason=0x2,len=4

This printk detects inside ide-io:ide_intr where it checks to see if a null 
handler is defined.  It is, and so tries to wack the status register.  I have 
added in code to not only do that, but if "ireason==2" to read in the data 
register "len" times (If I do not do this, the next command fails in 
ide_wait_stat failing to get a good status).  There is also an added 
ndelay(400) here to ensure the interrupt does not remain pending after the 
return.

Dec 10 20:00:54 kanger kernel: ide-io:ide_intr - seems we interrupted 
ourselves at time=4294941527, stat=0x50, ireason=0x3,len=4
Dec 10 20:00:54 kanger kernel: ide-io:ide_intr - seems we interrupted 
ourselves at time=4294941527, stat=0x50, ireason=0x3,len=4

I am not sure why there are two more interrupts - in case I hadn't got a long 
enough delay I increased it from ndelay(400) to ndelay(800) but it made no 
difference.

As you can all of these at at the same jiffy (ie within 1 millisec) of each 
other.  bits 6:5 of word 0 of the identify data is set to 10 (50uS) for 
length of time for command to complete.

However, eventually the command is seen to complete....

Dec 10 20:00:54 kanger kernel: scsi-ioctl: SG_IO
Dec 10 20:00:54 kanger kernel: ide-cd:ide_do_rw_cdrom
Dec 10 20:00:54 kanger kernel: ide-cd:ide_do_rw_cdrom - do block pc
Dec 10 20:00:54 kanger kernel: ide-cd:cdrom_start_packet_command with feature 
reg=0x1

The first time with dma.


Dec 10 20:00:54 kanger kernel: ide-cd:cdrom_do_newpc_cont at time=4294941538 
for cmd=0x3c
Dec 10 20:00:54 kanger kernel: cmd[0]=0x3c
Dec 10 20:00:54 kanger kernel: cmd[1]=0x0
Dec 10 20:00:54 kanger kernel: cmd[2]=0x0
Dec 10 20:00:54 kanger kernel: cmd[3]=0x0
Dec 10 20:00:54 kanger kernel: cmd[4]=0x0
Dec 10 20:00:54 kanger kernel: cmd[5]=0x0
Dec 10 20:00:54 kanger kernel: cmd[6]=0x0
Dec 10 20:00:54 kanger kernel: cmd[7]=0xfc
Dec 10 20:00:54 kanger kernel: cmd[8]=0x0
Dec 10 20:00:54 kanger kernel: cmd[9]=0x0

With a lot larger transfer

Dec 10 20:00:54 kanger kernel: ide-dma:ide_dma_start - with command 0x8
Dec 10 20:00:54 kanger kernel: ide-cd:cdrom_newpc_intr - assuming just 
finished dma at time=4294941538 with cmd=0x3c, rq len=64512, stat=0x50
Dec 10 20:00:54 kanger kernel: scsi_ioctl:sg_io completed in time 0
Dec 10 20:00:59 kanger kernel: scsi-ioctl: SG_IO
Dec 10 20:00:59 kanger kernel: ide-iops:ide_wait_stat - was busy when I 
arrived

What this means is that when ide_wait_stat was entered the BSY bit was set on 
the first time the routine is entered.  Given the timing, it has in fact had  
BSY showing with no sign of it clearing for a full 5 secs. 

Dec 10 20:00:59 kanger kernel: hdc: status timeout: status=0xd0 { Busy }
Dec 10 20:00:59 kanger kernel: hdc: status timeout: error=0xd0LastFailedSense 
0x0d
Dec 10 20:00:59 kanger kernel: hdc: DMA disabled
Dec 10 20:00:59 kanger kernel: hdc: drive not ready for command

And so we eventually fail completely.

This pattern is fully predictable - its not a timing issue that varies from 
run to run - every time exactly the same thing happens.

So what do I do next?  Why would the hardware work this way - is it a bug in 
the firmware?, is there a subtle timing problem causing interrupts to 
re-enter... should I just junk the hardware and start again?  Help!

-- 
Alan Chandler
alan@chandlerfamily.org.uk
First they ignore you, then they laugh at you,
 then they fight you, then you win. --Gandhi
