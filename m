Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314059AbSDKN4E>; Thu, 11 Apr 2002 09:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314060AbSDKN4D>; Thu, 11 Apr 2002 09:56:03 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:22751 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S314059AbSDKNzu>;
	Thu, 11 Apr 2002 09:55:50 -0400
Date: Thu, 11 Apr 2002 19:26:49 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Faster reboots (and a better way of taking crashdumps?)
Message-ID: <20020411192649.A1947@in.ibm.com>
Reply-To: suparna@in.ibm.com
In-Reply-To: <1759496962.1018114339@[10.10.2.3]> <m18z80nrxc.fsf@frodo.biederman.org> <3CB1A9A8.1155722E@in.ibm.com> <m1ofgum81l.fsf@frodo.biederman.org> <20020409205636.A1234@in.ibm.com> <m1y9fvlfyb.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2002 at 09:40:44AM -0600, Eric W. Biederman wrote:
> Suparna Bhattacharya <suparna@in.ibm.com> writes:
> 
> > On Mon, Apr 08, 2002 at 11:09:26AM -0600, Eric W. Biederman wrote:
> > > Suparna Bhattacharya <suparna@in.ibm.com> writes:
> > > 
> > > > I have been trying look through this in terms of how it compares with 
> > > > alternate projects (bootimg, monte etc). As I mentioned in an earlier 
> > > > mail, crash dump (mcore) relies on bootimg, and I'm trying to decide if
> > > > there
> > > > could be advantages in using your kexec stuff. 
> > > 
> > > My target it to submit the kexec stuff to Linus.  I seem to be the
> > > only one really actively working on it at this time.  I believe my
> > > code is the most mature at the moment.  The bottom line is the system
> > > call needs to get into the kernel.
> > > 
> > > With respect to bootimg there is a strong similarity it how things are
> > > done.  The big difference is that bootimg interface does everything
> > > per page in asking the kernel where to put things and my kexec call is
> > > does everything with extents.  Which means the kexec data structures
> > > are usually much smaller, plus I rely on odd things like PAGE_SIZE.
> > 
> > OK.
> > 
> > > 
> > > As for monte I can boot other things than the linux kernel.  I'm much
> > > better at doing the work than publisizing it so my variant isn't quite
> > > as well known.  That plus I can late to the game.
> > > 
> > 
> > I'm not sure if I got this right, but unlike bootimg, monte seems 
> > to prefer going through the early real mode setup code (unless one 
> > specifies skip_setup), and also resets the video mode. 
> 
> Going through the early setup code is good.  I do this as well,
> though I have tried the other route as well.

OK. I hadn't looked at your user space pieces earlier, where you 
patch in the code to jump to real-mode etc. 
(from my perspective this seems to be the main difference vs bootimg)

> 
> Reseting the video mode like monte does is questionable.

Could you explain that a bit ?

> 
> The basic point though is that the monte kernel interface is not set
> up to support anything but the linux kernel.  The bootimg interface
> if fairly general, the user space just happens to be a little
> immature.

I wasn't really looking at the system call interface as yet. That's
important of course, but I first wanted to be understand the actual
boot mechanism and the degree of reliability plus any known
limitations.

The interface which is interesting to me ATM is actually the lower
level in-kernel interface to initate the boot with a preloaded image
(i.e after the segments are loaded into a kimage).

> 
> As for skipping the real mode setup code, I prefer to do that cleanly
> when it is needed.
> 
> > At first I
> > thought some of your querybios stuff achieves a similar effect,
> > but then is that for linux bios ?
> 
> Yes that is primarily for linuxbios.  But that is when it is necessary
> to skip the real mode setup.  But all you have to do is specify a

OK. Now that I have seen your bzImage kexec userland code, I see the 
missing link.  When I'd looked at the older patches around 
the time of our elfboot announcment, I couldn't locate the right
user space pieces, so things weren't clear.

> mem=xyz line and you also skip the real mode setup, if you feel like
> it.
> 
> > > > My main concern of
> > > > course is with regard to these BIOS dependent/related issues
> > > > since at the time of a crash dump we may not be in quite a "friendly 
> > > > state". Guess some the linux power mgmt infrastructure or driverfs
> > > > should help with sane resets etc (I'm not saying its straightforward
> > > > :)).
> > > > in the long run. As such how far does your implementation address
> > > > some of this BIOS/h/w state handling better ?
> > > 
> > > My code works in SMP.   I call the reboot notifier.
> > > I probably should run through the pci bus and disable bus masters, but
> > > I don't right now.
> > 
> > The crash dump code with bootimg seems to work on smp
> 
> Unless I missed something the Linux kernel won't work on smp though.
> It is a matter of resetting the state of the apics, and ensuring you
> are running on the first processor.  I don't believe bootimg did/does that.

What I tried out was the MCLX crash dump implementation using bootimg
and that did work on a 2-way. This has some modifications to run on
the boot_cpu, and also to setup the local APIC and program the LVT0
register. (The pure bootimg patch I had was pretty old, so never 
tried that out separately). 

> 
> > Yes, I noticed the reboot notifier part in your code.
> > Disabling the busmaster might be required (monte seems to do that)
> 
> In general yes.  There are some interesting side effects though.
> Going through the pci bus and shutting off bus masters is a good
> first approximation of what needs to happen.
> 
> In general though (a) there are buggy devices that can hang the system
> if you treat the incorrectly.  (b) Sometimes you need to do more than
> just shutdown bus master DMA.
> 
> Which is why I have for the most part been holding off.
> 
> > > And you probably meant:
> > > ftp://downalod.lnxi.com/pub/src/linux-kernel-patches/kexec.
> > 
> > Yes indeed (except for the spelling of download above :))
> > Looks like I can't type straight either :)
> 
> :)
> 
> > > My other code for cleaning up the boot process is in:
> > >
> > ftp://download.lnxi.com/pub/src/linux-kernel-patches/boot/linux-2.5.7.boot.diff
> > 
> > 
> > Ok got it.
> > Have to get over the tools too and give it a shot.
> 
> Thanks.  Please holler if you have problems.   I really need

I ran into some errors when building elfboottools.
EM_486 is reported to be undeclared. I think it must somehow be
picking up the wrong elf.h, but didn't dig around too much
into the makefiles. 

> to look at building a debugging strategy for this code.  I have gotten
> some failure reports but so far it is hard to track down why any of
> it has problems.
> 
> Eric

Regards
Suparna
