Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272108AbRH2W0H>; Wed, 29 Aug 2001 18:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272109AbRH2WZ6>; Wed, 29 Aug 2001 18:25:58 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:33290 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S272108AbRH2WZo>; Wed, 29 Aug 2001 18:25:44 -0400
Message-ID: <3B8D6BF9.BFFC4505@zip.com.au>
Date: Wed, 29 Aug 2001 15:26:01 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Rees <dbr@greenhydrant.com>
CC: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        ext3-users@redhat.com
Subject: Re: kupdated, bdflush and kjournald stuck in D state on RAID1 device 
 (deadlock?)
In-Reply-To: <20010829131720.A20537@greenhydrant.com> <3B8D54F3.46DC2ABB@zip.com.au>, <3B8D54F3.46DC2ABB@zip.com.au>; <20010829141451.A20968@greenhydrant.com> <3B8D60CF.A1400171@zip.com.au>,
		<3B8D60CF.A1400171@zip.com.au>; from akpm@zip.com.au on Wed, Aug 29, 2001 at 02:38:23PM -0700 <20010829144016.C20968@greenhydrant.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Rees wrote:
> 
> On Wed, Aug 29, 2001 at 02:38:23PM -0700, Andrew Morton wrote:
> >
> > OK, thanks.  bdflush is stuck in raid1_alloc_r1bh() and
> > everything else is blocked by it.  I thought we fixed
> > that a couple of months ago :(
> >
> > Could you send the output of `cat /proc/meminfo'?
> >
> > > 18239 -bash            wait4
> > > 18274 umount /opt      rwsem_down_write_failed
> >
> > What are we trying to do here?  Is /opt the deadlocked
> > filesytem?
> 
> Yep, /dev/md0 is mounted on /opt.
> 

OK, and according to your /proc/meminfo:

        total:    used:    free:  shared: buffers:  cached:
Mem:  525422592 497364992 28057600        0 133500928 335839232
Swap: 1052794880  4710400 1048084480
MemTotal:       513108 kB
MemFree:         27400 kB
MemShared:           0 kB
Buffers:        130372 kB
Cached:         323368 kB
SwapCached:       4600 kB
Active:         293704 kB
Inact_dirty:    161536 kB
Inact_clean:      3100 kB
Inact_target:       16 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       513108 kB
LowFree:         27400 kB
SwapTotal:     1028120 kB
SwapFree:      1023520 kB

it's not an out-of-memory deadlock.

The RAID1 buffer allocation is pretty simple - unless the
disk controller has decided to stop delivering interrupts,
everything shold just come back to life as physical writes
complete.  I assume the hardware is still working OK?

It's a uniprocessor machine, yes?
