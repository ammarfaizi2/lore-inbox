Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269515AbUICRL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269515AbUICRL3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 13:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269527AbUICRLC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 13:11:02 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:11644 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269515AbUICRIh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 13:08:37 -0400
Message-ID: <311601c904090310083d057c25@mail.gmail.com>
Date: Fri, 3 Sep 2004 11:08:36 -0600
From: Eric Mudama <edmudama@gmail.com>
Reply-To: Eric Mudama <edmudama@gmail.com>
To: Greg Stark <gsstark@mit.edu>
Subject: Re: Crashed Drive, libata wedges when trying to recover data
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Brad Campbell <brad@wasp.net.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <871xhjti4b.fsf@stark.xeocode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <87oekpvzot.fsf@stark.xeocode.com> <4136E277.6000408@wasp.net.au>
	 <87u0ugt0ml.fsf@stark.xeocode.com>
	 <1094209696.7533.24.camel@localhost.localdomain>
	 <87d613tol4.fsf@stark.xeocode.com>
	 <1094219609.7923.0.camel@localhost.localdomain>
	 <877jrbtkds.fsf@stark.xeocode.com>
	 <1094224166.8102.7.camel@localhost.localdomain>
	 <871xhjti4b.fsf@stark.xeocode.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 03 Sep 2004 12:47:00 -0400, Greg Stark <gsstark@mit.edu> wrote:
> Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> 
> > On Gwe, 2004-09-03 at 16:58, Greg Stark wrote:
> > > I've even unmounted the filesystem and tried mounting it again. Now I can't
> > > even mount it without generating the error.
> >
> > You may well need to reset or powercycle the drive to get it back from
> > such a state.
> 
> Certainly I know power cycling fixes it. That's what I've been doing so far.
> 
> > > Sep  3 11:48:39 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
> > > Sep  3 11:48:39 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
> > > Sep  3 11:48:39 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
> >
> > "Its dead Jim". Once you get a drive that dies totally (or just keeps
> > posting up a hardware fail) after the error you are into forensics
> > (and/or backup) land.
> 
> There's nothing the driver can do to reset the drive or get back to a known
> good protocol state?
> 
> The "ATA: abnormal status 0x59 on port 0xEFE7" makes me think it's just the
> driver getting out of sync with the drive. But i guess that would be hard to
> distinguish from the drive just going south.

Here's my guess at what is happening:

0x59/xx is an artifact of PATA drives being required to transfer bogus
data on an error to satisfy the way the DMA controller was programmed
at the start of the transfer.  Most all drives used this same
technique in PIO modes too, sharing common transfer code in their
firmware.

This behavior, unfortunately, caused a ruckus in SATA ...  At least
one SATA controller immediately starts sending HOLD primitives when
they see the error bit get set.
In PATA, you can asynchronously issue a soft reset or a new command,
to abort the data transfer for the invalid command.  However, in SATA,
once the board starts sending HOLD primitives and the drive responds
with HOLDA, there's no way to transition into X_RDY to send the soft
reset or a new command.  Boom, you're deadlocked.  This means that in
SATA, the only way to overcome this deadlock in the driver is to have
the host/board generate a COMRESET OOB burst to hard-reset the drive.

Today's (and tomorrow's) generation of SATA drives will never ever
generate a 0x59 status... the error and DRQ bits become mutually
exclusive.  However, unfortunately, there are quite a few drives in
the field which have this behavior...

--eric
