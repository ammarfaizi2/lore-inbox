Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265006AbUD2W1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265006AbUD2W1P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 18:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265005AbUD2W1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 18:27:15 -0400
Received: from pirx.hexapodia.org ([65.103.12.242]:10032 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S265006AbUD2W1F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 18:27:05 -0400
Date: Thu, 29 Apr 2004 17:27:04 -0500
From: Andy Isaacson <adi@hexapodia.org>
To: Andrew Morton <akpm@osdl.org>
Cc: elf@buici.com, riel@redhat.com, brettspamacct@fastclick.com,
       jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Message-ID: <20040429222704.GD5957@hexapodia.org>
References: <20040428180038.73a38683.akpm@osdl.org> <Pine.LNX.4.44.0404282143360.19633-100000@chimarrao.boston.redhat.com> <20040428185720.07a3da4d.akpm@osdl.org> <20040429022944.GA24000@buici.com> <20040428193541.1e2cf489.akpm@osdl.org> <20040429031059.GA26060@buici.com> <20040428201924.719dfb68.akpm@osdl.org> <20040429165116.GA24033@hexapodia.org> <20040429134222.291f83d4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040429134222.291f83d4.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 01:42:22PM -0700, Andrew Morton wrote:
> Andy Isaacson <adi@hexapodia.org> wrote:
> > What I want is for purely sequential workloads which far exceed cache
> > size (dd, updatedb, tar czf /backup/home.nightly.tar.gz /home) to avoid
> > thrashing my entire desktop out of memory.  I DON'T CARE if the tar
> > completed in 45 minutes rather than 80.  (It wouldn't, anyways, because
> > it only needs about 5 MB of cache to get every bit of the speedup it was
> > going to get.)  But the additional latency when I un-xlock in the
> > morning is annoying, and there is no benefit.
> 
> What kernel version are you using?  If 2.6, what value of
> /proc/sys/vm/swappiness?

2.4.various, including 2.4.25 and 2.4.26.  I haven't taken the 2.6
plunge yet.  Running on various x86 including
 - dual PIII 666 MHz 512 MB
 - SpeedStep PIII 700 MHz 128 MB
 - Athlon XP 2GHz 512 MB

> > For a more useful example, ideally I *should not be able to tell* that
> > "dd if=/hde1 of=/hdf1" is running.
> 
> I just did a 4GB `dd if=/dev/sda of=/x bs=1M' on a 1GB 2.6.6-rc2-mm2
> swappiness=85 machine here and there was no swapout at all.
> 
> Probably your machine has less memory.  But without real, hard details
> nothing can be done.

I'm pleased to hear that 2.6 is apparently better behaved.  In your
test, what was the impact on the file cache?  It's a big improvement to
not be paging out to swap, but it's also important that sequential IO
not evict my cached build tree.

An interesting test would be to time a compilation of a source file with
a large number of includes.  For example, building
linux-2.4.25/kernel/sysctl.c on my Athlon XP 2GHz, 512MB, 2.4.25 takes
2.8 seconds with (fairly) cold cache.  (I didn't reboot, but I did take
fairly extreme measures to force stuff out.)  It takes 0.54 seconds with
warm caches.  After doing 1GB of sequential IO (wc -w /tmp/bigfile) I'm
back up to 2.08 seconds.

> > There is *no* benefit to cacheing
> > more than about 2 pages, under this workload.
> 
> Sure, we could do better things with the large streaming files, although
> the risk of accidentally screwing up particular workloads is high.

Yeah, I agree.  For example, I've occasionally used cat(1) or wc(1) to
prefetch files that I knew I was going to be accessing randomly; with my
hypothetical "sequential IO doesn't cause cacheing" it would be much
harder to do effective manual prefetching.

> But the use-once logic which we have in there at present does handle these
> cases quite well.

Where is the use-once logic available?  Is it in mainstream 2.6 or only
in some development branches?  I've not upgraded from 2.4 mostly because
I didn't see much benefits evident in the discussions, but improved
paging logic would be nice.

> >  But with current kernels,
> > IME, that workload results in a gargantuan buffer cache and lots of
> > swapout of apps I was using 3 minutes ago.  I've taken to walking away
> > for some coffee, coming back when it's done, and "sudo swapoff
> > /dev/hda3; sudo swapon -a" to avoid the latency that is so annoying when
> > trying to use bloaty apps.
> 
> What kernel, what system specs, what swappiness setting?

2.4.25, Athlon XP 2 GHz, 512MB.  I suppose you're not terribly
interested in 2.4.  I'll see if I can reasonably upgrade, if you can
tell me what I should upgrade to for the good stuff.

-andy
