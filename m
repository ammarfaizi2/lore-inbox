Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129413AbQKSUxN>; Sun, 19 Nov 2000 15:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129624AbQKSUxD>; Sun, 19 Nov 2000 15:53:03 -0500
Received: from slc410.modem.xmission.com ([166.70.2.156]:36106 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S129413AbQKSUwz>; Sun, 19 Nov 2000 15:52:55 -0500
To: Werner Almesberger <Werner.Almesberger@epfl.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Q: Linux rebooting directly into linux.
In-Reply-To: <m17l6deey7.fsf@frodo.biederman.org> <20001111171158.B17692@progenylinux.com> <m1bsvmcb4z.fsf@frodo.biederman.org> <20001114154953.E8753@almesberger.net> <m1vgtn7rfw.fsf@frodo.biederman.org> <20001119032439.H23033@almesberger.net> <m1wve04ed5.fsf@frodo.biederman.org> <20001119142530.B31695@almesberger.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Nov 2000 13:14:45 -0700
In-Reply-To: Werner Almesberger's message of "Sun, 19 Nov 2000 14:25:30 +0100"
Message-ID: <m1itpj4t3e.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger <Werner.Almesberger@epfl.ch> writes:

> Eric W. Biederman wrote:
> > The code wasn't trivially reusable, and the structures had a lot
> > of overhead.
> 
> There's some overhead, but I think it's not too bad. I'll give it a
> try ...
> 
> > The rebooting is done the rest is not yet.
> 
> Ah, and I already wondered where in all the APIC code you've hidden
> the magic to avoid the config data clobbering issues ;-)

Nope.  That just comes in two parts.
The first chunk is the work on the apic so the deadlock detector
can run on UP kernels.  From Ingo Molanar.  The second part are my
cleanups so we up the apic in a sane state upon reboot.
 
> > I agree writing the code to understand the table may be a significant
> > issue.  On the other hand I still think it is worth a look, being
> > able to unify option parsing for multiple platforms is not a small
> > gain, nor is getting out from short sighted vendor half standards.
> 
> Well, you certainly have a point where stupid vendors and BIOS nonsense
> are concerned. However, if we ignore LinuxBIOS for a moment, each
> platform already has a set of configuration parameter passing conventions
> imposed by the firmware. So we need to be able to handle this anyway, and
> most of the information is highly platform-specific.
> 
> LinuxBIOS is a special case, because you have your own firmware. But
> what you're suggesting is basically yet another parameter format, which
> needs to incorporate and possibly unify much of the information
> contained in all those platform-specific formats. I'm not sure it's worth
> the effort.
> 
> And, besides, I think it complicates the kernel, because you either
> have to add a parallel set of functions extracting and processing data
> from the "native" or the UBE environment, or you have to add a converter
> between "native" and UBE for each platform. Or do you have a better
> plan ?

My initial plan was to have two parallel table parsers.  The ones we
have now.  And another based on UBE.  If we find the information we
need via UBE use that.  If not fall back to the old way.

But the tables are only half of it.  Right now we have all kinds
of weirdness going through the empty_zero_page at boot time.
A lot of that I plan on just gather in UBE format instead of random
data in random locations.  Since Setup.S implements this it should
be transparent to most everything.

But I need to see how well that works first before I'm too commited
either way.

For x86 it isn't too big of a deal.  For other platforms though
where the Firmware comes is multiple flavors converting everything
looks like it could be a real win.

I guess what I'm most after is improving the linux BIOS abstraction layer.
We mostly have one, and only do BIOS calls before really starting the
kernel (except for some stupid BIOS standards like APM).

> When I started with bootimg, I also thought that we'd need some
> parameter passing mechanism, a bit similar to UBE (although I would
> have tried to be more text-based). Then I realized that there are
> actually only a few tables, and we can just keep them in memory. And
> some of them need to be modified before we can re-use them. (Trivial
> example: the boot command line. Video modes are a similar, although
> much more complicated issue.)

I agree with tables that we need to be careful.  A lossy conversion
can be a real problem.  The empty_zero_page is my first canidate,
and I'll see where it goes from there.

One of the more ugly challenges that I've already run into is that
there are multiple tables for specifying how interrupts are routed.
(In modern PC irq number is dynamically assigned).  I would
like to have one good table than two that fight each other.

But the point is that looking through the parameters and figuring
out what works and what makes sense will take some doing, and
I'm not promising to do any more than clean up the empty_zero_page.

> 
> > Besides which most tables seem to contain a lot of information that
> > is probeable.  Which just makes them a waste of BIOS space, and
> > sources of bugs.
> 
> Agreed with BIOS bugs ;-) Where probing is possible, is it reliable ?
> It'd take some baroque BIOS parameter table over yet another mandatory
> boot command line parameter any time ...
> 
> > Hmm. I wonder how hard it would be to add -fPIC to the compilation
> > line for that file.  But I'm not certain that would do what I want
> > in this instance...
> 
> Are there actually architectures where the compiler generates
> position-dependent code even if you're careful ? (I.e. all functions
> inlined, only auto variables.)

I don't know yet.  And since that part is machine specific, x86 is
really the only case that matters.  I just don't quite trust the compiler.
But next rev I'll make certain to steal this code from bootimg.

Given a normal architecture I believe no references to global data
should be sufficient, to ensure the code is pic.  Inlines are
interesting because they aren't always inlined.  To be really 
certain you can specify -fPIC and then make certain to properly
fill in the offset table after relocation.  But avoiding the
whole offset table issue is much better.

Eric
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
