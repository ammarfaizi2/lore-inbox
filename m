Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267884AbTAMSYi>; Mon, 13 Jan 2003 13:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267943AbTAMSYh>; Mon, 13 Jan 2003 13:24:37 -0500
Received: from [217.167.51.129] ([217.167.51.129]:5374 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S267884AbTAMSYf>;
	Mon, 13 Jan 2003 13:24:35 -0500
Subject: Re: any chance of 2.6.0-test*?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Paul Mackerras <paulus@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1042469960.18624.9.camel@irongate.swansea.linux.org.uk>
References: <20030110165441$1a8a@gated-at.bofh.it>
	 <15906.13194.169834.758112@argo.ozlabs.ibm.com>
	 <1042469960.18624.9.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042482986.30833.22.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 13 Jan 2003 19:36:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-01-13 at 15:59, Alan Cox wrote:
> On Mon, 2003-01-13 at 03:33, Paul Mackerras wrote:
> > I'm using the patch below, which makes sure that ide_release (in
> > ide-cs.c) runs in process context not interrupt context.  The specific
> > problem I saw was that ide_unregister calls various devfs routines
> > that don't like being called in interrupt context, but there may well
> > be other thing ide_unregister does that aren't safe in interrupt
> > context.
> 
> The ide release code isnt safe in any context.

Yup, though Paul's patch is a first step in the right way as I don't
think anybody sane plan to fix the IDE release code to make it interrupt
safe ;) At least I don't...
 
> > I have "fixed" the problem for now by adding a call to
> > init_hwif_data(index) in ide_register_hw just before the first
> > memcpy.  I'd be interested to know what the right fix is. :)
> 
> The code is currently written on the basis that people don't mangle
> free interfaces (the free up code restores stuff which I grant is
> kind of ass backwards). It also needs serious review and 2.5 testing
> before I'd want to move it to the right spot.

The code is indeed strangely backward, I had to deal with that in 2.4
for the PowerBook hotswap CD bay and will soon have to review that for
2.4.21-pre & 2.5.

> Also note that freeing the IDE can fail. If it fails then the code
> should probably be a lot smarter. Right now it 'loses' the interface.
> Really it should set a timer and try again. It might also want to
> add a null iops (out does nothing in returns FFFFFFFF) to stop
> further I/O cycles.

Yup, this have been a problem for me too, as ide_unregister for example
fails with a mounted fs. So the user had effectively removed the drive
from the bay, but I couldn't free the interface... nasty. Especially if
the user then plugs some different IDE device in the bay, the kernel
will get completely confused.

