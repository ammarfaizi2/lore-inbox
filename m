Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263562AbTCUHeC>; Fri, 21 Mar 2003 02:34:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263563AbTCUHeC>; Fri, 21 Mar 2003 02:34:02 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:29057 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S263562AbTCUHeB>; Fri, 21 Mar 2003 02:34:01 -0500
Message-ID: <3E7AC2BD.440A0C72@cinet.co.jp>
Date: Fri, 21 Mar 2003 16:43:57 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.8C-ja  [ja/Vine] (X11; U; Linux 2.5.65-ac1-pc98smp i686)
X-Accept-Language: ja
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] PC-9800 subarch. support for 2.5.64-ac3 (16/20) SCSI
References: <Pine.GSO.4.21.0303121239380.7675-100000@vervain.sonytel.be>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aplogize for slow respnse.

Geert Uytterhoeven wrote:
> 
> On Sun, 9 Mar 2003, Osamu Tomita wrote:
> > This is the patch to support NEC PC-9800 subarchitecture
> > against 2.5.64-ac3. (16/20)
> >
> > SCSI host adapter support.
> >  - BIOS parameter change for PC98.
> >  - Add pc980155 driver for old PC98.
> >  - wd33c93.h register address size to int, because PC-9801-55 mapped 0xcc0.
[snip]
> > +static int pc980155_abort(Scsi_Cmnd *cmd)
> > +{
> > +     if (wd33c93_abort(cmd) == SCSI_ABORT_SUCCESS)
> > +             return SUCCESS;
> > +
> > +     return FAILED;
> > +}
> 
> The abort handler is generic. Hence it can be moved to wd33c93.c, so the other
> wd33c93 drivers (my main interest :-) can use it.
I posted patch to merge into wd33c93.c aginst 2.5.65-ac1.

> > +static int pc980155_bus_reset(Scsi_Cmnd *cmd)
> > +{
> > +     struct WD33C93_hostdata *hostdata
> > +             = (struct WD33C93_hostdata *)cmd->device->host->hostdata;
> > +
> > +     pc980155_int_disable(hostdata->regs);
> > +     pc980155_assert_bus_reset(hostdata->regs);
> > +     udelay(50);
> > +     pc980155_negate_bus_reset(hostdata->regs);
> > +     (void) inb(*hostdata->regs.SASR);
> > +     (void) read_pc980155(hostdata->regs, WD_SCSI_STATUS);
> > +     pc980155_int_enable(hostdata->regs);
> > +     wd33c93_reset(cmd, 0);
> > +     return SUCCESS;
> > +}
> 
> Is there a generic (wd33c93) way to do this?
I'd been looking for better way. But It seems, standard WD33C93 has
no feature for control bus reset line. I think bus reset is board
specific.
 
> > +static int pc980155_host_reset(Scsi_Cmnd *cmd)
> > +{
> > +     wd33c93_reset(cmd, 0);
> > +     return SUCCESS;
> > +}
> 
> The host reset handler is generic, too.
Patch for PC-98 aginst 2.5.65-ac1 includes this too.

Thanks,
Osamu Tomita
