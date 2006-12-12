Return-Path: <linux-kernel-owner+w=401wt.eu-S1751528AbWLLQjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528AbWLLQjF (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 11:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751542AbWLLQjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 11:39:05 -0500
Received: from rrcs-24-153-217-226.sw.biz.rr.com ([24.153.217.226]:53948 "EHLO
	smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751528AbWLLQjC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 11:39:02 -0500
Subject: Re: 2.6.19-git3 panics on boot - ata_piix/PCI related [still in
	-git17]
From: Steve Wise <swise@opengridcomputing.com>
To: Alessandro Suardi <alessandro.suardi@gmail.com>
Cc: Alan <alan@lxorguk.ukuu.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1165873362.20877.22.camel@stevo-desktop>
References: <5a4c581d0612110526j26a07b31q26edc075d4981cd8@mail.gmail.com>
	 <1165873362.20877.22.camel@stevo-desktop>
Content-Type: text/plain
Date: Tue, 12 Dec 2006 10:39:02 -0600
Message-Id: <1165941542.24482.5.camel@stevo-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

Bisecting reveals that this commit causes the problem:

commit 368c73d4f689dae0807d0a2aa74c61fd2b9b075f
Author: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date:   Wed Oct 4 00:41:26 2006 +0100

    PCI: quirks: fix the festering mess that claims to handle IDE quirks

    The number of permutations of crap we do is amazing and almost all of it
    has the wrong effect in 2.6.

    At the heart of this is the PCI SFF magic which says that compatibility
    mode PCI IDE controllers use ISA IRQ routing and hard coded addresses
    not the BAR values. The old quirks variously clears them, sets them,
    adjusts them and then IDE ignores the result.

    In order to drive all this garbage out and to do it portably we need to
    handle the SFF rules directly and properly. Because we know the device
    BAR 0-3 are not used in compatibility mode we load them with the values
    that are implied (and indeed which many controllers actually
    thoughtfully put there in this mode anyway).

    This removes special cases in the IDE layer and libata which now knows
    that bar 0/1/2/3 always contain the correct address. It means our
    resource allocation map is accurate from boot, not "mostly accurate"
    after ide is loaded, and it shoots lots of code. There is also lots more
    code and magic constant knowledge to shoot once this is in and settled.

    Been in my test tree for a while both with drivers/ide and with libata.
    Wants some -mm shakedown in case I've missed something dumb or there are
    corner cases lurking.

    Signed-off-by: Alan Cox <alan@redhat.com>
    Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

:040000 040000 137193040dc9d6515f5785dc2f6c9d9e833b56dc 5e55c04e8a951c708417f5b7223219ed9164db40 M      arch
:040000 040000 eb8ae45ee090cd6210edae71c5104826f71dd298 be8d30db9ce51713e2b8de956cf8373aa8591a87 M      drivers
swise@dell3:~/git/cxgb3.git>




On Mon, 2006-12-11 at 15:42 -0600, Steve Wise wrote:
> I'm also hitting this running at commit:
> 
> commit 7bf65382caeecea4ae7206138e92e732b676d6e5
> Author: Andrew Morton <akpm@osdl.org>
> Date:   Fri Dec 8 02:41:14 2006 -0800
> 
> I was at 2.6.19, then merged up to Linus's tree Friday 12/8 and now I
> hit this. I have 2 identical systems with one difference, one has a DVD
> ROM device hooked to the ATA controller.  This system displays the same
> problem.  Since the other system without the DVD worked fine with the
> same code, I removed the DVD from the problem system and it boots ok.
> However I need the DVD, so I guess I'll start bisecting to see what
> caused this. There's about 2000 commits from 2.6.19 to my head...
> 
> More to come...
> 
> Steve.
> 
> 
> 
> On Mon, 2006-12-11 at 14:26 +0100, Alessandro Suardi wrote:
> > On 12/3/06, Alessandro Suardi <alessandro.suardi@gmail.com> wrote:
> > > On 12/3/06, Alan <alan@lxorguk.ukuu.org.uk> wrote:
> > > > > > ACPI: PCI Interrupt 0000:00:1f.2[B] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ5
> > > > > > PCI: Unable to reserve I/O region #1:8@1f0 for device 0000:00:1f.2
> > > > > > ata_piix: probe of 0000:00:1f.2 failed with error -16
> > > > > > [snip]
> > > > > > mount: could not find filesystem '/dev/root'
> > > > >
> > > > > Same failure is also in 2.6.19-git4...
> > > >
> > > > Thats the PCI updates - you need the matching fix to libata-sff where it
> > > > tries to reserve stuff it shouldn't.
> > >
> > > Thanks Alan. Indeed -git1 is where stuff breaks for me.
> > > I'll watch out for when libata-sff gets fixed in the -git
> > >  snapshots and will then report back.
> > 
> > Alan,
> > 
> >   I still have this problem in 2.6.19-git17. Is this expected behavior
> >   or should it have been fixed by now ?
> > 
> > Thanks,
> > 
> > --alessandro
> > 
> > "...when I get it, I _get_ it"
> > 
> >      (Lara Eidemiller)
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

