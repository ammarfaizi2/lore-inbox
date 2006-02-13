Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbWBMQxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbWBMQxQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 11:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbWBMQxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 11:53:16 -0500
Received: from nproxy.gmail.com ([64.233.182.197]:57670 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932225AbWBMQxP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 11:53:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g9hJhb36Cyv5t23qjvOYKkr6USeZI5bG4RJ5Z3mwCuZSEuxoGkqIwAF/dFpXf9QtB/AVYvr6H9CtKVcsQ0RDqwMjpeWBVcpAxIcLiBGEoUpEu/CuTpd887i5I2RHSCbp3dKFjHvT58CMFunMTdcQm3d+ZkSy/zs3uobO14/LoGo=
Message-ID: <58cb370e0602130853s4ce767c6j57337a9587cc2963@mail.gmail.com>
Date: Mon, 13 Feb 2006 17:53:11 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: RFC: Compact Flash True IDE Mode Driver
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0602131020370.30316-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <58cb370e0602130235h3ab521cep47584ee634e8fc7f@mail.gmail.com>
	 <Pine.LNX.4.44.0602131020370.30316-100000@gate.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/06, Kumar Gala <galak@kernel.crashing.org> wrote:

> > > +static void cfide_outsl(unsigned long port, void *addr, u32 count)
> > > +{
> > > +       panic("outsl unsupported");
> > > +}
> >
> > This will panic as soon as somebody tries to enable 32-bit I/O
> > using hdparm.  Please add ide_hwif_t.no_io_32bit flag and teach
> > ide-disk.c:ide_disk_setup() about it (separate patch).
>
> I'm not sure I follow this, can you expand.

Do "hdparm -c 2 /dev/hdx" first and then read/write to the device
and you should see it. :)

We need to make "hdparm -c 2" (and "hdparm -c 3") unsupported
(see how "io_32bit" setting is handled in ide_add_generic_settings()
and how it can be read-only or read-write setting depending on the
value of drive->no_io_32bit).

To do this we need to set drive->no_io_32bit to 1 (see how
ide_disk_setup() handles it).  Unfortunately 32-bit I/O capability
is based on capabilities of both host and device so we have to
add new flag hwif->no_io_32bit to indicate that host doesn't
support 32-bit I/O.

> > > +static ide_hwif_t *cfide_locate_hwif(void __iomem * base, void __iomem * ctrl,
> > > +                                    unsigned int sz, int irq)
> >
> > __devinit
> >
> > > +{
> > > +       unsigned long port = (unsigned long)base;
> > > +       ide_hwif_t *hwif;
> > > +       int index, i;
> > > +
> > > +       for (index = 0; index < MAX_HWIFS; ++index) {
> > > +               hwif = ide_hwifs + index;
> > > +               if (hwif->io_ports[IDE_DATA_OFFSET] == port)
> > > +                       goto found;
> > > +       }
> > > +
> > > +       for (index = 0; index < MAX_HWIFS; ++index) {
> > > +               hwif = ide_hwifs + index;
> > > +               if (hwif->io_ports[IDE_DATA_OFFSET] == 0)
> > > +                       goto found;
> > > +       }
> > > +
> > > +       return NULL;
> >
> > This is the same as in icside.c/rapide.c,
> > it really should be generic helper (separate patch)
>
> Suggesitions, on where that should live, ide-probe.c?

ide.c, no rush for this one as I have patch ready
(only needs to find it... sigh...)

> > Otherwise driver looks pretty decent and with the above changes
> > it gets my ACK.  Additional enhancements as suggested by Ben
> > would be nice but obviously they are not needed for a start
>
> Everything else makes sense and I'll make those changes, plus some based
> on Ben's comments.  If you can let me know about the two questions
> (expanding on ide_hwif_t.no_io_32bit and where to but a generic version of
> cfide_locate_hwif).

Thanks,
Bartlomiej
