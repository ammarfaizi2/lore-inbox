Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264303AbTLVEkb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 23:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264310AbTLVEkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 23:40:31 -0500
Received: from dhcp024-209-033-037.neo.rr.com ([24.209.33.37]:37250 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S264303AbTLVEkT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 23:40:19 -0500
Date: Sun, 21 Dec 2003 23:29:56 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Alexander Poquet <atp@csbd.org>
Cc: wli@holomorphy.com, linux-kernel@vger.kernel.org, zwane@arm.linux.org.uk
Subject: Re: 2.6.0 fails to complete boot - Sony VAIO laptop
Message-ID: <20031221232955.GA11201@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Alexander Poquet <atp@csbd.org>, wli@holomorphy.com,
	linux-kernel@vger.kernel.org, zwane@arm.linux.org.uk
References: <20031220040953.9C35D1E030CA3@csbd.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031220040953.9C35D1E030CA3@csbd.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 19, 2003 at 11:20:54PM -0500, Alexander Poquet wrote:
> Hey folks.
>
>
>
> On Fri, 19 Dec 2003 02:28:21 -0800, William Lee Irwin III wrote:
> > The hardware solution is better, but I'll settle for anything you can
> > get that way.
>
>
> Not having a hardware solution at my disposal, I copied the dmesg by hand from
> the screen, giving myself screenfuls by hacking null while loops into various
> places.  I've attached it below; as it was copied by hand there may be a typo
> or two but I was as careful as possible.  There are a few lines that I did not
> get, at the very beginning, because the last place I could put a hang was after
> console_init() in start_kernel() -- if information from up there is needed,
> I can probably hack printk.  It doesn't look too hard but I didn't want to mess
> with it unless someone requires the information.
>
> As is evident from the dmesg, the blank out happens while doing an isapnp
> scan.  Now, I'm wondering why I have isapnp configured -- I think it has
> something to do with 16-bit PCMCIA cards, but I can't remember exactly -- but

In this system, isapnp is probably not necessary.

>
> at any rate as stock kernels are likely to have it setup perhaps this is a bug
> that should be ironed out.  I haven't tried compiling the kernel without

Agreed.  In what kernel version did you first see this problem?

> isapnp support, but I can do that if you think the bug is a symptom of something
> else and not a fsck-up in the isapnp code itself.  At any rate, the exact
> function call that generates the black out is in drivers/pnp/isapnp/core.c,
> on line 1132 (or just about).  The code in question (it's in isapnp_init()):
>
>         isapnp_detected = 1;
>         if (isapnp_rdp < 0x203 || isapnp_rdp > 0x3ff) {
>                 cards = isapnp_isolate();
>                 if (cards < 0 ||
>                     (isapnp_rdp < 0x203 || isapnp_rdp > 0x3ff)) {
> #ifdef ISAPNP_REGION_OK
>                         release_region(_PIDXR, 1);
> #endif
> ----------------->      release_region(_PNPWRP, 1);
>                         isapnp_detected = 0;
>                         printk(KERN_INFO "isapnp: No Plug & Play device found\n");
>                         return 0;
>                 }
>                 request_region(isapnp_rdp, 1, "isapnp read");
>         }
>         isapnp_build_device_list();

Hmm, it doesn't seem possible for it to be occuring on that exact line.  Perhaps there
is a delay between the bad code and the time the lcd actually blanks. ISAPnP uses
legacy probing techniques.  It is possible that it is writting to one of your laptop's
configuration interfaces during the probe.

Could you provide more information as to how you isolated the problem to this line?


>
> The corresponding request_region is a little bit higher up in the function.
> Why would releasing the region cause a console blank?
>
> WRT to the console blank, it was very much as if the card jumped out of text
> mode, or something.  The monitor felt ... weird.  (I'm connecting to my laptop
> using an external monitor; the Sony VAIO model I have, the PCG-F450, has a
> documented issue with its LCD panel).  I'm not exactly sure how to put it into
> words, but it was like doing "SCREEN 9" in BASICA back on DOS.  Like it jumped
> into a graphics mode, or something.
>
> The boot obviously doesn't continue -- does that imply that the kernel panics
> after the console black out?  Without a serial cable I can't be sure that
> there isn't more stuff being printed after the console black out that might be
> useful.  Any ideas on how to deal with this would be appreciated.
>
> Oh, and also, what does that address space collision stuff in the PCI init
> portion of the dmesg mean?  Should I be worried about that?

The PnPBIOS is reserving ACPI configuration space.  PCI is surprised when it
finds it already reserved.  Usually this isn't a problem.  It is interesting,
however, that the the PCI bridge and the PnP BIOS are reporting slightly
different ranges.

> PnPBIOS: Scanning system for PnP BIOS support...
> PnPBIOS: Found PnP BIOS installation structure at 0x00f71f0
> pnp: 00:00: ioport range 0x398-0x399 has been reserved
> pnp: 00:00: ioport range 0x4d0-0x4d1 has been reserved
> pnp: 00:00: ioport range 0x8000-0x804f has been reserved
> pnp: 00:00: ioport range 0x1040-0x104f has been reserved
> PnPBIOS: 17 nodes reported by PnP BIOS; 17 recorded by driver

> PCI: Probing PCI hardware
> PCI: Probing PCI hardware (bus 00)
> PCI: Address space collision on region 7 of bridge 0000:00:07.3 [8000:803f]
> PCI: Address space collision on region 8 of bridge 0000:00:07.3 [1040:105f]

>
>
> Alexander
>
> dmesg follows...
>
> -------------------------------------------------------------------------------
>
--> snip
>
> isapnp: Scanning for PnP cards...

Could you please ensure that ISAPnP is indeed the culprit by passing the "noisapnp"
kernel parameter.

Thanks,
Adam
