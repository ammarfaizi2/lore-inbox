Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751737AbVLGTPL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737AbVLGTPL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 14:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbVLGTPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 14:15:10 -0500
Received: from nproxy.gmail.com ([64.233.182.192]:395 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751744AbVLGTPI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 14:15:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eierMJKCUX0TWoFT82/6qA0MGpTGAml+AU7MZQNS2TT3M0Qwob46G8bf+AG2jqdXcTdncq2o5eMpCvfd4qSPHSYEKPcVAfWbfOzlC59kzTfD2qIGByaCCmEl9/kaHtAWKXYcIJc46E7FgmVDgS04z4mrFe7XskKmhZbwc6ZBz9M=
Message-ID: <58cb370e0512071115i3dbb741aqda7f98a97221d99b@mail.gmail.com>
Date: Wed, 7 Dec 2005 20:15:05 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [RFC]add ACPI hooks for IDE suspend/resume
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Matthew Garrett <mjg59@srcf.ucam.org>,
       linux-ide <linux-ide@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>, pavel <pavel@ucw.cz>,
       Len Brown <len.brown@intel.com>, akpm <akpm@osdl.org>
In-Reply-To: <1133918523.2936.12.camel@sli10-mobl.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1133849404.3026.10.camel@sli10-mobl.sh.intel.com>
	 <20051206222001.GA14171@srcf.ucam.org>
	 <58cb370e0512070017u606ee22fse207b9a859856dd4@mail.gmail.com>
	 <20051207131454.GA16558@srcf.ucam.org>
	 <58cb370e0512070619k17022317v8e871dc3f9cafb9@mail.gmail.com>
	 <20051207143337.GA16938@srcf.ucam.org>
	 <58cb370e0512070645o78569e82y63483a9ae5511f52@mail.gmail.com>
	 <1133970074.544.69.camel@localhost.localdomain>
	 <58cb370e0512070749y68b2f9e9t1c68a3e03f91baa0@mail.gmail.com>
	 <1133918523.2936.12.camel@sli10-mobl.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/05, Shaohua Li <shaohua.li@intel.com> wrote:
> On Wed, 2005-12-07 at 16:49 +0100, Bartlomiej Zolnierkiewicz wrote:
> > On 12/7/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > > On Mer, 2005-12-07 at 15:45 +0100, Bartlomiej Zolnierkiewicz wrote:
> > > > OK, I understand it now - when using 'ide-generic' host driver for IDE
> > > > PCI device, resume fails (for obvious reason - IDE PCI device is not
> > > > re-configured) and this patch fixes it through using ACPI methods.
> >
> > I was talking about bugzilla bug #5604.
> Sorry for my ignorance in IDE side. From the ACPI spec, there isn't a
> generic way to save/restore IDE's configuration. That's why ACPI
> provides such methods. I suppose all IDE drivers need call the methods,
> wrong?

>From the hardware POV:
* there is generic way to save/restores IDE device's configuration
* there is no generic way to save/restore IDE controller's configuration

>From the software POV what we only do currently is setting controller
and drive for a correct transfer mode by using host driver specific callback
(in case of using 'ide-generic' there is no such callback).

> > > Even in the piix case some devices need it because the bios wants to
> > > issue commands such as password control if the laptop is set up in
> > > secure modes.
> >
> > I completely agree.  However at the moment this patch doesn't seem
> > to issue any ATA commands (code is commented out in _GTF) so
> > this is not a case for bugzilla bug #5604.
> I actually tried to invoke ATA commands using IDE APIs, but can't find
> any available one. I'd be very happy if you can give me any hint how to
> do it or even you can fix it.

Probably do_rw_taskfile() is the method you want to use, you also need
to place invoking of ACPI provided ATA commands in the right place in
the IDE PM state machine [ ide_{start,complete}_power_step() ].

PS1 Please don't use taskfile_lib_get_identify(), drive->id
should contain valid ID - if it doesn't it is a BUG.

PS2 Have you seen libata ACPI patches by Randy?
Maybe some of the code dealing with ACPI can be put to
<linux/ata.h> and be shared between IDE and libata drivers?

Thanks,
Bartlomiej
