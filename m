Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293119AbSDIPZI>; Tue, 9 Apr 2002 11:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293131AbSDIPZH>; Tue, 9 Apr 2002 11:25:07 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:41213 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S293119AbSDIPZG>; Tue, 9 Apr 2002 11:25:06 -0400
Date: Tue, 9 Apr 2002 20:56:37 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Faster reboots (and a better way of taking crashdumps?)
Message-ID: <20020409205636.A1234@in.ibm.com>
Reply-To: suparna@in.ibm.com
In-Reply-To: <1759496962.1018114339@[10.10.2.3]> <m18z80nrxc.fsf@frodo.biederman.org> <3CB1A9A8.1155722E@in.ibm.com> <m1ofgum81l.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2002 at 11:09:26AM -0600, Eric W. Biederman wrote:
> Suparna Bhattacharya <suparna@in.ibm.com> writes:
> 
> > I have been trying look through this in terms of how it compares with 
> > alternate projects (bootimg, monte etc). As I mentioned in an earlier 
> > mail, crash dump (mcore) relies on bootimg, and I'm trying to decide if
> > there
> > could be advantages in using your kexec stuff. 
> 
> My target it to submit the kexec stuff to Linus.  I seem to be the
> only one really actively working on it at this time.  I believe my
> code is the most mature at the moment.  The bottom line is the system
> call needs to get into the kernel.
> 
> With respect to bootimg there is a strong similarity it how things are
> done.  The big difference is that bootimg interface does everything
> per page in asking the kernel where to put things and my kexec call is
> does everything with extents.  Which means the kexec data structures
> are usually much smaller, plus I rely on odd things like PAGE_SIZE.

OK.

> 
> As for monte I can boot other things than the linux kernel.  I'm much
> better at doing the work than publisizing it so my variant isn't quite
> as well known.  That plus I can late to the game.
> 

I'm not sure if I got this right, but unlike bootimg, monte seems 
to prefer going through the early real mode setup code (unless one 
specifies skip_setup), and also resets the video mode. At first I
thought some of your querybios stuff achieves a similar effect,
but then is that for linux bios ?
  
> 
> > My main concern of
> > course is with regard to these BIOS dependent/related issues
> > since at the time of a crash dump we may not be in quite a "friendly 
> > state". Guess some the linux power mgmt infrastructure or driverfs
> > should help with sane resets etc (I'm not saying its straightforward
> > :)).
> > in the long run. As such how far does your implementation address
> > some of this BIOS/h/w state handling better ?
> 
> My code works in SMP.   I call the reboot notifier.
> I probably should run through the pci bus and disable bus masters, but
> I don't right now.

The crash dump code with bootimg seems to work on smp
Yes, I noticed the reboot notifier part in your code.
Disabling the busmaster might be required (monte seems to do that)

>  
> > BTW, some of your other boot enhancements like being able to find out
> > which memory areas were used or overwritten during bootup sound useful
> > to me, in being able to estimate the footprint of early boot and
> > avoiding
> > using those portions of memory for saving any state (because boot could
> > stomp over them). Its good to be able to do this in a generic way,
> > rather
> > than have the dump code be aware of the ranges for every architecture. 
> 
> That is why I am a fan of ELF kernel images.  There is a lot of
> reasonable resistance to change in that department but it is fairly
> sane.
> 
> > > ftp://download.lnxi.com/pub/src/linux-kernel-patches/linux-2.5.7.kexec.diff
> > > ftp://download.lnxi.com/pub/src/linux-kernel-patches/kexec-2.5.7.kexec.log
> > > ftp://download.lnxi.com/pub/src/mkelfImage/elfboottools-2.0.tar.gz
> > >       type make and see objdir/build/sbin/kexec (work with bzImages)
> > 
> > I don't seem to be able to access these urls.
> > The patches I downloaded were from
> > ftp://download.lnxi.com/pub/src/kexec/* (with the same names). Are these
> > the right ones ? (your last note mentioned those, but you are saying
> > that these are the wrong set ... so now I'm a little confused)
> 
> 
> O.k. My directory structure is just to deep I can't type it straight
> I meant:
> ftp://download.lnxi.com/pub/src/linux-kernel-patches/kexec/linux-2.5.7.kexec.diff
> ftp://download.lnxi.com/pub/src/linux-kernel-patches/kexec/kexec-2.5.7.kexec.log
> 
> And you probably meant:
> ftp://downalod.lnxi.com/pub/src/linux-kernel-patches/kexec.

Yes indeed (except for the spelling of download above :))
Looks like I can't type straight either :)

> 
> My other code for cleaning up the boot process is in:
> ftp://download.lnxi.com/pub/src/linux-kernel-patches/boot/linux-2.5.7.boot.diff

Ok got it.
Have to get over the tools too and give it a shot.

> 
> > Is there one single grand rollup patch with all of the function which I
> > should look through or try out ?
> 
> The kexec.diff  (instead of the 3 sub patches) is as close as I have
> gotten.
> 
> > > The basic kernel interface that is added is:
> > > 
> > > struct segment {
> > >         void *buffer;
> > >         void *dest_addr;
> > >         size_t len;
> > > };
> > > int kexec(void *start, int nr_segments, struct segment *segments);
> > > 
> > 
> > Yes, its a good idea to split up the load stage and actual boot/exec
> > stage. Crash dump needs to have it that way too (the second image 
> > preloaded in advance since we don't want to do any i/o at that
> > point).
> 
> Interesting.  After a lot of discussion this was essentially the
> interface we all agreed upon.  Preloading wasn't what I was thinking
> but it works in that sense as well.  At least as long as you mlock
> buffers.
> 
> The most important piece left with this is to get it accepted into
> the kernel so people can count on a stable system call interface.
> 
> Eric
