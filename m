Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313207AbSDJPrl>; Wed, 10 Apr 2002 11:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313255AbSDJPrl>; Wed, 10 Apr 2002 11:47:41 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:51776 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S313207AbSDJPrj>; Wed, 10 Apr 2002 11:47:39 -0400
To: suparna@in.ibm.com
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Faster reboots (and a better way of taking crashdumps?)
In-Reply-To: <1759496962.1018114339@[10.10.2.3]>
	<m18z80nrxc.fsf@frodo.biederman.org> <3CB1A9A8.1155722E@in.ibm.com>
	<m1ofgum81l.fsf@frodo.biederman.org> <20020409205636.A1234@in.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 10 Apr 2002 09:40:44 -0600
Message-ID: <m1y9fvlfyb.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suparna Bhattacharya <suparna@in.ibm.com> writes:

> On Mon, Apr 08, 2002 at 11:09:26AM -0600, Eric W. Biederman wrote:
> > Suparna Bhattacharya <suparna@in.ibm.com> writes:
> > 
> > > I have been trying look through this in terms of how it compares with 
> > > alternate projects (bootimg, monte etc). As I mentioned in an earlier 
> > > mail, crash dump (mcore) relies on bootimg, and I'm trying to decide if
> > > there
> > > could be advantages in using your kexec stuff. 
> > 
> > My target it to submit the kexec stuff to Linus.  I seem to be the
> > only one really actively working on it at this time.  I believe my
> > code is the most mature at the moment.  The bottom line is the system
> > call needs to get into the kernel.
> > 
> > With respect to bootimg there is a strong similarity it how things are
> > done.  The big difference is that bootimg interface does everything
> > per page in asking the kernel where to put things and my kexec call is
> > does everything with extents.  Which means the kexec data structures
> > are usually much smaller, plus I rely on odd things like PAGE_SIZE.
> 
> OK.
> 
> > 
> > As for monte I can boot other things than the linux kernel.  I'm much
> > better at doing the work than publisizing it so my variant isn't quite
> > as well known.  That plus I can late to the game.
> > 
> 
> I'm not sure if I got this right, but unlike bootimg, monte seems 
> to prefer going through the early real mode setup code (unless one 
> specifies skip_setup), and also resets the video mode. 

Going through the early setup code is good.  I do this as well,
though I have tried the other route as well.

Reseting the video mode like monte does is questionable.

The basic point though is that the monte kernel interface is not set
up to support anything but the linux kernel.  The bootimg interface
if fairly general, the user space just happens to be a little
immature.

As for skipping the real mode setup code, I prefer to do that cleanly
when it is needed.

> At first I
> thought some of your querybios stuff achieves a similar effect,
> but then is that for linux bios ?

Yes that is primarily for linuxbios.  But that is when it is necessary
to skip the real mode setup.  But all you have to do is specify a
mem=xyz line and you also skip the real mode setup, if you feel like
it.

> > > My main concern of
> > > course is with regard to these BIOS dependent/related issues
> > > since at the time of a crash dump we may not be in quite a "friendly 
> > > state". Guess some the linux power mgmt infrastructure or driverfs
> > > should help with sane resets etc (I'm not saying its straightforward
> > > :)).
> > > in the long run. As such how far does your implementation address
> > > some of this BIOS/h/w state handling better ?
> > 
> > My code works in SMP.   I call the reboot notifier.
> > I probably should run through the pci bus and disable bus masters, but
> > I don't right now.
> 
> The crash dump code with bootimg seems to work on smp

Unless I missed something the Linux kernel won't work on smp though.
It is a matter of resetting the state of the apics, and ensuring you
are running on the first processor.  I don't believe bootimg did/does that.

> Yes, I noticed the reboot notifier part in your code.
> Disabling the busmaster might be required (monte seems to do that)

In general yes.  There are some interesting side effects though.
Going through the pci bus and shutting off bus masters is a good
first approximation of what needs to happen.

In general though (a) there are buggy devices that can hang the system
if you treat the incorrectly.  (b) Sometimes you need to do more than
just shutdown bus master DMA.

Which is why I have for the most part been holding off.

> > And you probably meant:
> > ftp://downalod.lnxi.com/pub/src/linux-kernel-patches/kexec.
> 
> Yes indeed (except for the spelling of download above :))
> Looks like I can't type straight either :)

:)

> > My other code for cleaning up the boot process is in:
> >
> ftp://download.lnxi.com/pub/src/linux-kernel-patches/boot/linux-2.5.7.boot.diff
> 
> 
> Ok got it.
> Have to get over the tools too and give it a shot.

Thanks.  Please holler if you have problems.   I really need
to look at building a debugging strategy for this code.  I have gotten
some failure reports but so far it is hard to track down why any of
it has problems.

Eric

