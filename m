Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261355AbVB0Gto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbVB0Gto (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 01:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbVB0Gto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 01:49:44 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:3869 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261355AbVB0Gt2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 01:49:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=ZKdMOLrMMdAXaZJybDCgzIsmLAegEmukfUV4yEqbYxHaHRnyxNpUEfO5HNCUN/cwfCa0vQCuJb1F73y+MO3z/RQylJ3g+mIj/G40FHAR27Xm7EEeczXCP7CMy/XBPazrOfeDxEIY8l1RUopgWopJct0KWykIg3JYYDbS5SJWxgw=
Date: Sun, 27 Feb 2005 15:49:22 +0900
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>, lkml <linux-kernel@vger.kernel.org>,
       linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.11-rc3 01/11] ide: task_end_request() fix
Message-ID: <20050227064922.GA27728@htj.dyndns.org>
References: <20050210083808.48E9DD1A@htj.dyndns.org> <20050210083809.63BF53E6@htj.dyndns.org> <58cb370e05022407587e86f8ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e05022407587e86f8ad@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
From: Tejun Heo <htejun@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2005 at 04:58:03PM +0100, Bartlomiej Zolnierkiewicz wrote:
> On Thu, 10 Feb 2005 17:38:14 +0900 (KST), Tejun Heo <htejun@gmail.com> wrote:
> > 
> > 01_ide_task_end_request_fix.patch
> > 
> >         task_end_request() modified to always call ide_end_drive_cmd()
> >         for taskfile requests.  Previously, ide_end_drive_cmd() was
> >         called only when task->tf_out_flags.all was set.  Also,
> >         ide_dma_intr() is modified to use task_end_request().
> > 
> >         * fixes taskfile ioctl oops bug which was caused by referencing
> >           NULL rq->rq_disk of taskfile requests.
> 
> I fixed it in slightly different way in ide-dev-2.6 - by calling
> ide_end_request() instead of ->end_request().

 Taskfile DMA path is still broken.  Also calling ide_end_request()
will work there, but IMHO it's just cleaner to finish special commands
inside ide_end_drive_cmd().  Currently,

 * Successful flagged taskfile			-> ide_end_drive_cmd()
 * All other successful non-DMA special cmds	-> ide_end_request()
 * Successful DMA taskfile			-> segfault
 * All failed special cmds			-> ide_end_drive_cmd()

 It just shouldn't be like this.  :-(

> 
> >         * enables TASKFILE ioctls to get valid register outputs on
> >           successful completion.
> 
> This change makes *all* taskfile registers to be read on completion
> of *any* command.  Currently this is done only for flagged taskfiles
> and commands using no-data protocol.
> 
> With all your changes it will be also done for:
> * HDIO_DRIVE_[TASKFILE,CMD] ioctls
> * /proc/ide/hd?/{identify,smart_thresholds,smart_values}
> but reading back all registers is not always needed.

 None is on a hot path or even near to one, but maybe I don't have
enough experience with old hardware.  Are there some old hardware
which make the additional reads stand out?

> It is already bad enough (and we can't fix it cause it is exported
> to user-space through HDIO_DRIVE_TASKFILE), we shouldn't
> make it worse.

 Yeah, the whole IDE ioctl interface seems disturbingly messy. :-(

 * Register output is available only if
	1. The command fails.
	2. The command is a flagged taskfile.
 * taskfile->device_head is used regardless of outflags setting.
 * In flagged taskfile, taskfile->device_head can turn on the device
   bit, so we can issue commands to hdb with permissions to hda.
 * In TASK and TASKFILE, LBA commands can be issued to drives in CHS
   mode but the reverse isn't true.  However, in TASKFILE, if the
   command isn't flagged, the lower nibble of device register is
   zeroed depending on addressing setting.
 * taskfile->data endianess is reversed on big endian machines.
 * ide_reg_valid_t endianess issue.
 * And, none of above is documented.

 So, I don't know.  Do you think we should keep all of the above
behaviors?  Please let me know; then, I'll update ioctl/hdio.txt so
that people can at least know these gotchas.

 Thanks.

-- 
tejun

