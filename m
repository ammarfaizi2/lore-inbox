Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261997AbVCARXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261997AbVCARXM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 12:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261991AbVCARWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 12:22:55 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:40218 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261988AbVCARWG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 12:22:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=YSja++do3LTUAjzaAVidI6hJlZL0FiQwWC6Ao+1ZY0LDrOtkJ/xkw6iKeMGHXPu1i8U2pxocvMwHK5NSMIKVAVug4fhA6iGA3I0aG3gFNQRLgbrNrAp/+5AgVdgbrAtrxAfABCqmfaX5C2s4ZxLwDuEi03y87eAUajNLiY919Mw=
Date: Wed, 2 Mar 2005 01:49:52 +0900
From: Tejun Heo <htejun@gmail.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.11-rc3 01/11] ide: task_end_request() fix
Message-ID: <20050301164952.GA22499@htj.dyndns.org>
References: <20050210083808.48E9DD1A@htj.dyndns.org> <20050210083809.63BF53E6@htj.dyndns.org> <58cb370e05022407587e86f8ad@mail.gmail.com> <20050227064922.GA27728@htj.dyndns.org> <58cb370e050301063069799c75@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e050301063069799c75@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, Bartlomiej.

On Tue, Mar 01, 2005 at 03:30:32PM +0100, Bartlomiej Zolnierkiewicz wrote:
> On Sun, 27 Feb 2005 15:49:22 +0900, Tejun Heo <htejun@gmail.com> wrote:
> > 
> >  Taskfile DMA path is still broken.  Also calling ide_end_request()
> > will work there, but IMHO it's just cleaner to finish special commands
> > inside ide_end_drive_cmd().  Currently,
> 
> I agree but please note that your patch makes *all* taskfile registers to
> be exposed through HDIO_DRIVE_TASKFILE regardless of ->rf_in_flags
> (and obviously later you can't revert this change).
> 
> >  * Successful flagged taskfile                  -> ide_end_drive_cmd()
> >  * All other successful non-DMA special cmds    -> ide_end_request()
> >  * Successful DMA taskfile                      -> segfault
> 
> Have you tested it?  Why would it segfault?
> 

 It's the same reason why PIO taskfiles were broken.  rq->rq_disk is
NULL for taskfile requests.

ide_startstop_t ide_dma_intr (ide_drive_t *drive)
{
...
			printk("**HERE0***\n");
			drv = *(ide_driver_t **)rq->rq_disk->private_data;;
			printk("**HERE1***\n");
			drv->end_request(drive, 1, rq->nr_sectors);
			return ide_stopped;
...
}

 And, my test program does the following TASKFILE ioctl.

	memset(&task, 0, sizeof(task));
	task.req.out_size = sizeof(task.outbuf);
	task.req.in_size = sizeof(task.inbuf);

	task.req.io_ports[2] = 1;			/* nsector */
	task.req.io_ports[3] = sector;			/* LBA [7:0] */
	task.req.io_ports[4] = sector >> 8;		/* LBA [15:8] */
	task.req.io_ports[5] = sector >> 16;		/* LBA [23:16] */
	task.req.io_ports[6] = 0x40 | ((sector >> 24) & 0xf); /* select */
	task.req.io_ports[7] = WIN_READDMA;		/* command */
	task.req.req_cmd = IDE_DRIVE_TASK_IN;
	task.req.data_phase = TASKFILE_IN_DMA;

 Then, the kernel oopses...

**HERE0***
Unable to handle kernel NULL pointer dereference at virtual address 00000038
 printing eip:
c026bce4
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP 
Modules linked in: nfs lockd sunrpc e1000 eepro100 e100 mii floppy
CPU:    0
EIP:    0060:[<c026bce4>]    Not tainted VLI
EFLAGS: 00010082   (2.6.11-rc3-work-i386) 
EIP is at ide_dma_intr+0x84/0xd0
eax: 00000000   ebx: f5e79d6c   ecx: c03a678c   edx: 00000001
esi: c048b3b0   edi: c048b3b0   ebp: c0435efc   esp: c0435ee0
ds: 007b   es: 007b   ss: 0068


> >  * All failed special cmds                      -> ide_end_drive_cmd()
> > 
> >  It just shouldn't be like this.  :-(
> 
> Yep.
> 
> > >
> > > >         * enables TASKFILE ioctls to get valid register outputs on
> > > >           successful completion.
> > >
> > > This change makes *all* taskfile registers to be read on completion
> > > of *any* command.  Currently this is done only for flagged taskfiles
> > > and commands using no-data protocol.
> > >
> > > With all your changes it will be also done for:
> > > * HDIO_DRIVE_[TASKFILE,CMD] ioctls
> > > * /proc/ide/hd?/{identify,smart_thresholds,smart_values}
> > > but reading back all registers is not always needed.
> > 
> >  None is on a hot path or even near to one, but maybe I don't have
> > enough experience with old hardware.  Are there some old hardware
> > which make the additional reads stand out?
> 
> I dunno, better be safe then sorry, after all we are working
> on the *stable* kernel tree.
> 
> Converting HDIO_DRIVE_CMD and in-kernel users to
> soon-to-be-implemented ;-) sane discrete interface shouldn't
> require much effort.
> 
> > > It is already bad enough (and we can't fix it cause it is exported
> > > to user-space through HDIO_DRIVE_TASKFILE), we shouldn't
> > > make it worse.
> > 
> >  Yeah, the whole IDE ioctl interface seems disturbingly messy. :-(
> > 
> >  * Register output is available only if
> >         1. The command fails.
> >         2. The command is a flagged taskfile.
> 
> 3. the command uses no-data protocol
> 

 Yes, that one. :-)

> >  * taskfile->device_head is used regardless of outflags setting.
> >  * In flagged taskfile, taskfile->device_head can turn on the device
> >    bit, so we can issue commands to hdb with permissions to hda.
> >  * In TASK and TASKFILE, LBA commands can be issued to drives in CHS
> >    mode but the reverse isn't true.  However, in TASKFILE, if the
> >    command isn't flagged, the lower nibble of device register is
> >    zeroed depending on addressing setting.
> >  * taskfile->data endianess is reversed on big endian machines.
> >  * ide_reg_valid_t endianess issue.
> >  * And, none of above is documented.
> > 
> >  So, I don't know.  Do you think we should keep all of the above
> > behaviors?  Please let me know; then, I'll update ioctl/hdio.txt so
> 
> Now read again the list above and think about amount of time required
> to *safely* fix all the issues mentioned vs introducing sane interface.
> Please also note that once we expose something to user-space
> applications may depend on the broken behavior so we can't fix all
> issues anyway.

 So, I guess we're keeping most of them.

> If somebody implements SG_IO ioctl and SCSI command pass-through
> from libata for IDE driver (and add possibility for discrete taskfiles), we can
> just deprecate HDIO_DRIVE_TASKFILE, forget about it and some time later
> remove this FPOS.

 That sounds sweet.

> > that people can at least know these gotchas.
> 
> Please do so, thanks.

 Yes, I'll do.

 Thanks.

-- 
tejun

