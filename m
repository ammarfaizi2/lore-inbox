Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314097AbSDLOsl>; Fri, 12 Apr 2002 10:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314100AbSDLOsk>; Fri, 12 Apr 2002 10:48:40 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:41143 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S314097AbSDLOsi>;
	Fri, 12 Apr 2002 10:48:38 -0400
Date: Fri, 12 Apr 2002 20:19:50 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Faster reboots (and a better way of taking crashdumps?)
Message-ID: <20020412201950.A1443@in.ibm.com>
Reply-To: suparna@in.ibm.com
In-Reply-To: <1759496962.1018114339@[10.10.2.3]> <m18z80nrxc.fsf@frodo.biederman.org> <3CB1A9A8.1155722E@in.ibm.com> <m1ofgum81l.fsf@frodo.biederman.org> <20020409205636.A1234@in.ibm.com> <m1y9fvlfyb.fsf@frodo.biederman.org> <20020411192649.A1947@in.ibm.com> <m1hemil03d.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2002 at 09:35:34AM -0600, Eric W. Biederman wrote:
> Suparna Bhattacharya <suparna@in.ibm.com> writes:
> 
> 
> > OK. I hadn't looked at your user space pieces earlier, where you 
> > patch in the code to jump to real-mode etc. 
> > (from my perspective this seems to be the main difference vs bootimg)
> 
> I have borrowed techniques from all over.  And I will go with whatever
> works.  In this case I don't see why bootimg wasn't doing that.
>  
> > > Reseting the video mode like monte does is questionable.
> > 
> > Could you explain that a bit ?
> 
> 1) You should have done proper video shutdown before you left the
>    previous kernel.
> 2) You might not have a video card.
> 3) You might not have a working BIOS.
> 4) It is generally a very good idea to make a division of who controls
>    what hardware.  And after the initial boot and the kernel has
>    driven the hardware it isn't reliable to give control back to the
>    BIOS.  We may have changed state enough to confuse the BIOS.
> 
> Or in summary it is generally unnecessary so why the heck are we doing
> it.

OK. The crash with bootimg implementation was known to have occasional
difficulties when boot got triggered (via panic) while in X -- sometimes 
having the console messed up, and on some occasions even hangs.
How's been your experience - no problems in kexec'ing from X, 
anytime ?

> 
> > > The basic point though is that the monte kernel interface is not set
> > > up to support anything but the linux kernel.  The bootimg interface
> > > if fairly general, the user space just happens to be a little
> > > immature.
> > 
> > I wasn't really looking at the system call interface as yet. That's
> > important of course, but I first wanted to be understand the actual
> > boot mechanism and the degree of reliability plus any known
> > limitations.
> > 
> > The interface which is interesting to me ATM is actually the lower
> > level in-kernel interface to initate the boot with a preloaded image
> > (i.e after the segments are loaded into a kimage).
> 
> O.k.  Any comments, on that interface?

That would be machine_kexec, and the kimage struct, right ?
So far looks ok, though I haven't looked at it critically. One thing that 
that I require was a way to pass information across boots - 
maybe that could be done through command line parameters to the new 
kernel.

> 
> > > As for skipping the real mode setup code, I prefer to do that cleanly
> > > when it is needed.
> > > 
> > > > At first I
> > > > thought some of your querybios stuff achieves a similar effect,
> > > > but then is that for linux bios ?
> > > 
> > > Yes that is primarily for linuxbios.  But that is when it is necessary
> > > to skip the real mode setup.  But all you have to do is specify a
> > 
> > OK. Now that I have seen your bzImage kexec userland code, I see the 
> > missing link.  When I'd looked at the older patches around 
> > the time of our elfboot announcment, I couldn't locate the right
> > user space pieces, so things weren't clear.
> 
> O.k.  Given that I keep evolving this, that is understandable.  
> Sorry about that.
> 
> > > Unless I missed something the Linux kernel won't work on smp though.
> > > It is a matter of resetting the state of the apics, and ensuring you
> > > are running on the first processor.  I don't believe bootimg did/does that.
> > 
> > What I tried out was the MCLX crash dump implementation using bootimg
> > and that did work on a 2-way. This has some modifications to run on
> > the boot_cpu, and also to setup the local APIC and program the LVT0
> > register. (The pure bootimg patch I had was pretty old, so never 
> > tried that out separately). 
> 
> O.k. cool.  I haven't really looked at that.
> 
> > I ran into some errors when building elfboottools.
> > EM_486 is reported to be undeclared. I think it must somehow be
> > picking up the wrong elf.h, but didn't dig around too much
> > into the makefiles. 
> 
> Version 2.0 is an early beta.  Some idiot yanked EM_486 and a couple
> of other symbols out of elf.h from glibc.  Despite the ELF spec says
> EM_486 at least should be there.  In any case that is just a debugging
> bit and you can safely disable those.  Or do a make -k and compile the
> kexec piece, but not the kparam, which isn't really relevant.

I commented out the EM_486 check from the kexec code, and it built
cleanly. I was able to boot a 2-way system with it, though it seemed
to take a while, perhaps more so because I didn't seem to be getting
any of the bootup/startup messages on my console. In one case there were 
some INIT respawning messages that came up. Not sure the fact that
I'm using a serial console matters.

Regards
Suparna
