Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261646AbVBDCYC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261646AbVBDCYC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 21:24:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263388AbVBDCXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 21:23:08 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:52212 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263173AbVBDCWQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 21:22:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=eR3bCxBuOX64f9vrzJXGzfgprxIdF8iiworevHoWbcROk7sjcxZmEt5nME+ePl+hf45nEzODDMlFM08E+SVw6zmuoliguMXLo52ye76LBulojS1AW+r8DSTjBVQgZRk+zm1uzgsLR/bb0lh4zNsNFIXPvjzg/njIbXtcVWYICOc=
Message-ID: <58cb370e05020318227d6ebdeb@mail.gmail.com>
Date: Fri, 4 Feb 2005 03:22:09 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <tj@home-tj.org>
Subject: Re: [PATCH 2.6.11-rc2 26/29] ide: map ide_cmd_ioctl() to ide_taskfile_ioctl()
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <4202D9ED.5020203@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050202024017.GA621@htj.dyndns.org>
	 <20050202031037.GK1187@htj.dyndns.org>
	 <58cb370e050203095417fed306@mail.gmail.com>
	 <4202D9ED.5020203@home-tj.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Feb 2005 11:11:57 +0900, Tejun Heo <tj@home-tj.org> wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > On Wed, 2 Feb 2005 12:10:37 +0900, Tejun Heo <tj@home-tj.org> wrote:
> >
> >>>26_ide_taskfile_cmd_ioctl.patch
> >>>
> >>>      ide_cmd_ioctl() converted to use ide_taskfile_ioctl().  This
> >>>      is the last user of REQ_DRIVE_CMD.
> >
> >
> > ide_cmd_ioctl() needs to map to taskfile transport not ide_taskfile_ioctl()
> >
> >
> >>Index: linux-ide-export/drivers/ide/ide-iops.c
> >>===================================================================
> >>--- linux-ide-export.orig/drivers/ide/ide-iops.c        2005-02-02 10:28:04.466320918 +0900
> >>+++ linux-ide-export/drivers/ide/ide-iops.c     2005-02-02 10:28:07.406843817 +0900
> >>@@ -648,11 +648,11 @@ u8 eighty_ninty_three (ide_drive_t *driv
> >>
> >> EXPORT_SYMBOL(eighty_ninty_three);
> >>
> >>-int ide_ata66_check (ide_drive_t *drive, ide_task_t *args)
> >>+int ide_ata66_check (ide_drive_t *drive, task_ioreg_t *regs)
> >
> >
> > nitpick: int ide_ata66_check()
> >
> 
> meaning...?

silly minor nitpick - please drop extra space while at it:
int ide_ata66_check(ide_drive_t *drive, task_ioreg_t *regs)

> >
> >> {
> >>-       if ((args->tfRegister[IDE_COMMAND_OFFSET] == WIN_SETFEATURES) &&
> >>-           (args->tfRegister[IDE_SECTOR_OFFSET] > XFER_UDMA_2) &&
> >>-           (args->tfRegister[IDE_FEATURE_OFFSET] == SETFEATURES_XFER)) {
> >>+       if ((regs[IDE_COMMAND_OFFSET] == WIN_SETFEATURES) &&
> >>+           (regs[IDE_SECTOR_OFFSET] > XFER_UDMA_2) &&
> >>+           (regs[IDE_FEATURE_OFFSET] == SETFEATURES_XFER)) {
> >
> >
> > nitpick: please drop brackets
> >
> 
> Parenthese?

doh, yes

> >
> >> #ifndef CONFIG_IDEDMA_IVB
> >>                if ((drive->id->hw_config & 0x6000) == 0) {
> >> #else /* !CONFIG_IDEDMA_IVB */
> >>@@ -678,11 +678,11 @@ int ide_ata66_check (ide_drive_t *drive,
> >>  * 1 : Safe to update drive->id DMA registers.
> >>  * 0 : OOPs not allowed.
> >>  */
> >>-int set_transfer (ide_drive_t *drive, ide_task_t *args)
> >>+int set_transfer (ide_drive_t *drive, task_ioreg_t *regs)
> >
> >
> > nitpick: int set_transfer()
> >
> 
> ??

extra space

> >
> >> {
> >>-       if ((args->tfRegister[IDE_COMMAND_OFFSET] == WIN_SETFEATURES) &&
> >>-           (args->tfRegister[IDE_SECTOR_OFFSET] >= XFER_SW_DMA_0) &&
> >>-           (args->tfRegister[IDE_FEATURE_OFFSET] == SETFEATURES_XFER) &&
> >>+       if ((regs[IDE_COMMAND_OFFSET] == WIN_SETFEATURES) &&
> >>+           (regs[IDE_SECTOR_OFFSET] >= XFER_SW_DMA_0) &&
> >>+           (regs[IDE_FEATURE_OFFSET] == SETFEATURES_XFER) &&
> >
> >
> > nitpick: brackets
> >
> 
> Parentheses?

yep
