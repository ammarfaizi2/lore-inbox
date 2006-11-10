Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946383AbWKJKgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946383AbWKJKgX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 05:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946388AbWKJKgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 05:36:20 -0500
Received: from web31808.mail.mud.yahoo.com ([68.142.207.71]:43431 "HELO
	web31808.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1946373AbWKJKgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 05:36:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Wwob1tBQ+jeM7g0yLb937QUZPBHff5cWJWz2KEwJvfQOCWi26aFvOVGaFu2dPrj5Z7LIKqIsM4eG4Z892vgrnzii39iSUjekckbTJfugHLdX75Z3mM4i0nYKkIK7UmhaP+AJh8s4dexo8gut7UPvWMU8m6343NPC0RMmeALtJYA=  ;
Message-ID: <20061110103617.79354.qmail@web31808.mail.mud.yahoo.com>
X-YMail-OSG: zy6veh4VM1lg4oWQ4R5.ZxGLwG0xvCm4YG5hHl5tAeq2Gy5Lnw1PPFBRSP.6qxWb4Ei3Q.DK_4UZPLFPae0baJEWaUytZl7qaDPpTSFh2v50zSF52uq0gOXyNvQrcuGrpAluwoehIGxymIA5YUWUhQM3XbW776dPavVXEzxgEP.ib6CGMUIbiO.q
Date: Fri, 10 Nov 2006 02:36:16 -0800 (PST)
From: Luben Tuikov <ltuikov@yahoo.com>
Reply-To: ltuikov@yahoo.com
Subject: Re: 2.6.19-rc3 system freezes when ripping with cdparanoia at ioctl(SG_IO)
To: dougg@torque.net, Tejun Heo <htejun@gmail.com>
Cc: Brice Goglin <Brice.Goglin@ens-lyon.org>,
       Jens Axboe <jens.axboe@oracle.com>,
       Gregor Jasny <gjasny@googlemail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       monty@xiph.org, linux-scsi@vger.kernel.org
In-Reply-To: <45534E2B.10303@torque.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Douglas Gilbert <dougg@torque.net> wrote:
> Tejun Heo wrote:
> > [CC'ing Monty and Douglas.]
> > 
> > Hello, the original thread can be read from the following URL.
> > 
> > http://thread.gmane.org/gmane.linux.ide/13708/focus=13708
> > 
> > Brice Goglin wrote:
> >> ens Axboe wrote:
> >>> On Mon, Oct 30 2006, Gregor Jasny wrote:
> >>>  
> >>>> 2006/10/30, Jens Axboe <jens.axboe@oracle.com>:
> >>>>    
> >>>>> Can you confirm that 2.6.18 works?
> >>>>>       
> >>>> The reporter of [1] states that his SATA Thinkpad freezes with 2.6.17
> >>>> and 2.6.18, too.
> >>>>
> >>>> Gregor
> >>>>
> >>>> [1] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=391901
> >>>>     
> >>> Ok, mainly just checking if this was a potential dupe of another bug.
> >>>
> >>>   
> >>
> >> Jens (or anybody else who has any idea of how to debug this),
> >>
> >> Did you have a chance to reproduce the problem? I guess we "only" need a
> >> machine with SATA/ata_piix and cdparanoia 3.10. If you want me to debug
> >> some stuff, feel free to tell me what. But, since it freezes the machine
> >> and sysrq doesn't even work, I don't really know what to try...
> >>
> >> I just tried on rc5 and rc5-mm1, both have the problem (as 2.6.16, .17
> >> and .18 do, don't know about earlier kernels). I didn't have a audio CD
> >> here, so I tried abcde on a DVD on purpose. With cdparanoia 3.10-pre0
> >> (from Debian testing), it reports nothing during about 5 seconds and
> >> then the machine freezes. With cdparanoia 3a9.8-11 (from Debian stable),
> >> it reports an error very quickly, and dmesg gets a couple line like
> >> these:
> >>     sg_write: data in/out 12/12 bytes for SCSI command 0x43--guessing
> >> data in;
> >>        program cdparanoia not setting count and/or reply_len properly
> > 
> > Okay, here's the story.
> > 
> > In interface/scan_devices.c::cdda_identify_scsi(), cdparanoia calls
> > scsi_inquiry() to identify the device and determine interface type. This
> > seems to be the first time to actually issue commands to the device.  As
> > interface type isn't completely determined, for sg devices, it first
> > issues the command w/ d->interface set to SGIO_SCSI.  If that fails, it
> > falls back to SGIO_SCSI_BUGGY1.
> > 
> > For to-device request, both SGIO_SCSI and SGIO_SCSI_BUGGY1 set
> > sg_io_hdr.dxfer_direction to SG_DXFER_TO_DEV.  But for from-device
> > request, SGIO_SCSI uses SG_DXFER_TO_FROM_DEV while SGIO_SCSI_BUGGY1 uses
> > SG_DXFER_FROM_DEV.  So, cdparanoia first issues inquiry w/
> > SG_DXFER_TO_FROM_DEV and if that fails falls back to SG_DXFER_FROM_DEV.
> > 
> > drivers/scsi/sg.c interprets SG_DXFER_TO_FROM_DEV as read while
> > block/scsi_ioctl.c interprets it as write.  I guess this is historic
> > thing (scsi/sg.c updated but block/scsi_ioctl.c is forgotten).  As
> > written above, cdparanoia can handle both cases as long as the kernel
> > promptly fails command issued with the wrong direction.
> > 
> > This works for most PATA ATAPI devices.  Most devices detect reversed
> > transfer and terminate the command promptly.  But this doesn't seem to
> > be true for SATA device.  Many just hang and time out commands with the
> > wrong transfer direction.  If you consider that most early SATA ATAPI
> > devices are actually PATA + bridge, this is sorta inevitable.  The
> > PATA-SATA bridge cannot issue D2H FIS to abort the command by itself.
> > It's just mirroring the status of PATA side and PATA side doesn't know
> > SATA protocol mismatch has occurred.
> > 
> > So, IDENTIFY w/ write-DMA protocol times out after quite some seconds.
> > This is where things go worse from bad.  SATA controllers which have
> > shadow TF registers don't handle timeout conditions very well,
> > especially when they're waiting for data transfer.  They basically hold
> > the PCI bus and hang till the transfer completes (which never happens).
> >  That's where the hard lock up comes from.
> > 
> > Jens, I think we need to match block sg's behavior to SCSI's.  Monty,
> > the timeout and hard lock up are due to hardware restrictions.  Kernel
> > and libata can't do much about it.  So, please find other way to detect
> > interface.
> 
> Tejun,
> Your SG_DXFER_TO_FROM_DEV analysis is correct.
> 
> The stupid ~!@# who wrote the code, and the documentation
> for it, defined SG_DXFER_TO_FROM_DEV to mean a "transfer
> from device" operation where the kernel buffer receiving
> the DMA transfer was prefilled with data that the application
> provided. That certainly isn't a bidirectional transfer to/from
> the device, but it is a bidirectional transfer to kernel
> buffers when indirect IO is used.
> 
> Why do this? Because the 'resid' field indicating how much
> less data was transferred in a "from_device" transfer than
> was requested, was not added to SCSI infrastructure till much
> later. There are still LLDs out there that don't implement it.
> It also reflected a similar technique used with the sg_header
> structure (circa 1992) for precisely the same reason. And
> application writers wanted that functionality. Joerg was the
> first name of one such application writer.
> 
> 
> Coincidentally I am sitting on a patch from Luben Tuikov
> to cause the same breakage in the sg driver itself.

Here is a link to the recently posted 8 month patch:
http://marc.theaimsgroup.com/?l=linux-scsi&m=116267031029025&w=2

The patch would appear to fix the problem Tejun is describing.

I cannot quite remember exactly what I was doing that day 8 months
ago, but was either disk or tape devices testing and arrived
at that patch.

This patch had been in my dev (gateway) tree for the last 8
months, without any problems.

    Luben


> Nobody has proposed a patch to the documentation for
> the explanation of SG_DXFER_TO_FROM_DEV :-)
>     http://www.torque.net/sg/p/sg_v3_ho.html
> 
> 
> As I am currently proposing a SCSI pass through version 4
> interface with twin scatter gather lists for independent
> bidirectional transfers for SCSI commands, I'm not sure
> what setting DMA_BIDIRECTIONAL in the existing interface
> buys us.
> 
> 
> When you maintain and document a pass through interface you
> sit between two groups of people that have conflicting goals
> and don't have a particularly high opinion of each other.
> 
> Doug Gilbert
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

