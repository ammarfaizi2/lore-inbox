Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272115AbRH2Wia>; Wed, 29 Aug 2001 18:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272117AbRH2WiU>; Wed, 29 Aug 2001 18:38:20 -0400
Received: from [208.48.139.185] ([208.48.139.185]:40579 "HELO
	forty.greenhydrant.com") by vger.kernel.org with SMTP
	id <S272115AbRH2WiF>; Wed, 29 Aug 2001 18:38:05 -0400
Date: Wed, 29 Aug 2001 15:38:18 -0700
From: David Rees <dbr@greenhydrant.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        ext3-users@redhat.com
Subject: Re: kupdated, bdflush and kjournald stuck in D state on RAID1 device (deadlock?)
Message-ID: <20010829153818.B21590@greenhydrant.com>
Mail-Followup-To: David Rees <dbr@greenhydrant.com>,
	Andrew Morton <akpm@zip.com.au>, linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org, ext3-users@redhat.com
In-Reply-To: <20010829131720.A20537@greenhydrant.com> <3B8D54F3.46DC2ABB@zip.com.au>, <3B8D54F3.46DC2ABB@zip.com.au>; <20010829141451.A20968@greenhydrant.com> <3B8D60CF.A1400171@zip.com.au>, <3B8D60CF.A1400171@zip.com.au>; <20010829144016.C20968@greenhydrant.com> <3B8D6BF9.BFFC4505@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B8D6BF9.BFFC4505@zip.com.au>; from akpm@zip.com.au on Wed, Aug 29, 2001 at 03:26:01PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2001 at 03:26:01PM -0700, Andrew Morton wrote:
> David Rees wrote:
> > 
> > On Wed, Aug 29, 2001 at 02:38:23PM -0700, Andrew Morton wrote:
> > >
> > > OK, thanks.  bdflush is stuck in raid1_alloc_r1bh() and
> > > everything else is blocked by it.  I thought we fixed
> > > that a couple of months ago :(
> > >
> > > Could you send the output of `cat /proc/meminfo'?
> > >
> > > > 18239 -bash            wait4
> > > > 18274 umount /opt      rwsem_down_write_failed
> > >
> > > What are we trying to do here?  Is /opt the deadlocked
> > > filesytem?
> > 
> > Yep, /dev/md0 is mounted on /opt.
> > 
> 
> OK, and according to your /proc/meminfo:
> 
>         total:    used:    free:  shared: buffers:  cached:
> Mem:  525422592 497364992 28057600        0 133500928 335839232
> Swap: 1052794880  4710400 1048084480
> MemTotal:       513108 kB
> MemFree:         27400 kB
> MemShared:           0 kB
> Buffers:        130372 kB
> Cached:         323368 kB
> SwapCached:       4600 kB
> Active:         293704 kB
> Inact_dirty:    161536 kB
> Inact_clean:      3100 kB
> Inact_target:       16 kB
> HighTotal:           0 kB
> HighFree:            0 kB
> LowTotal:       513108 kB
> LowFree:         27400 kB
> SwapTotal:     1028120 kB
> SwapFree:      1023520 kB
> 
> it's not an out-of-memory deadlock.
> 
> The RAID1 buffer allocation is pretty simple - unless the
> disk controller has decided to stop delivering interrupts,
> everything shold just come back to life as physical writes
> complete.  I assume the hardware is still working OK?
> 
> It's a uniprocessor machine, yes?

It is a uniprocessor machine, yes.  The machine is a 1.1GHz Athlon on a Soyo
motherboard.  This is the first problem we've seen with the machine.

The machine was and is still working mostly ok.  Since I typed "umount /opt",
the opt directory doesn't show any contents any more, but before that things
appear OK.  I can still use fdisk to look at the partition layout of the
drives in /opt raid1 array.  /proc/mdstat is normal.

There are no other software raid devices on the machine (/ is also ext3 on a
separate drive/controller).  There are no suspicious messages printed from
dmesg, either.

-Dave
