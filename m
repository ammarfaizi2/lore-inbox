Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275627AbRIZVer>; Wed, 26 Sep 2001 17:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275632AbRIZVei>; Wed, 26 Sep 2001 17:34:38 -0400
Received: from [195.223.140.107] ([195.223.140.107]:59376 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S275627AbRIZVeX>;
	Wed, 26 Sep 2001 17:34:23 -0400
Date: Wed, 26 Sep 2001 23:34:51 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.10aa1 - 0-order allocation failed.
Message-ID: <20010926233451.V27945@athlon.random>
In-Reply-To: <20010926183128.N27945@athlon.random> <Pine.LNX.4.21.0109261547260.957-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0109261547260.957-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Wed, Sep 26, 2001 at 03:49:42PM -0300
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2001 at 03:49:42PM -0300, Marcelo Tosatti wrote:
> 
> On Wed, 26 Sep 2001, Andrea Arcangeli wrote:
> 
> > On Wed, Sep 26, 2001 at 12:02:05PM -0300, Marcelo Tosatti wrote:
> > > 
> > > 
> > > On Wed, 26 Sep 2001, Andrea Arcangeli wrote:
> > > 
> > > > On Wed, Sep 26, 2001 at 06:07:48PM +0400, Oleg A. Yurlov wrote:
> > > > > 
> > > > >         Hi, Andrea,
> > > > > 
> > > > >         We have next problem on our servers:
> > > > > 
> > > > > Sep 26 11:22:39 sol kernel: __alloc_pages: 0-order allocation failed (gfp=0x20/0)
> > > > > Sep 26 11:22:39 sol kernel: f048dd94 e02ab000 00000000 00000020 00000000 00000020 00000020 e298f820 
> > > > > Sep 26 11:22:39 sol kernel:        e298f844 00000001 e030a56c e030a6c4 00000020 00000000 e01382be 00000000 
> > > > > Sep 26 11:22:39 sol kernel:        e013874a e013488c 00000000 e298f820 00000202 e298f898 00000202 00000246 
> > > > > Sep 26 11:22:39 sol kernel: Call Trace: [put_dirty_page+122/132] [flush_old_exec+234/572] [sys_ustat+212/268] [kill_super+232/352] [unix_gc+394/748] 
> > > > > Sep 26 11:22:39 sol kernel:    [Unused_offset+27374/99203] [Unused_offset+12842/99203] [call_spurious_interrupt+14521/27705] [Unused_offset+43342/99203] [call_spurious_interrupt+14615/27705] [call_spurious_interrupt+16483/27705] 
> > > > > Sep 26 11:22:39 sol kernel:    [Unused_offset+90704/99203] [ipgre_rcv+233/636] [ipgre_rcv+503/636] [fcntl_getlk+327/624] [do_invalid_TSS+43/96] 
> > > > > Sep 26 11:22:39 sol kernel: __alloc_pages: 0-order allocation failed (gfp=0x20/0)
> > > > > Sep 26 11:22:39 sol kernel: f048ddd4 e02ab000 00000000 00000020 00000000 00000020 00000020 e298f820 
> > > > > Sep 26 11:22:39 sol kernel:        e298f844 00000001 e030a56c e030a6c4 00000020 00000000 e01382be 00000000 
> > > > > Sep 26 11:22:39 sol kernel:        e013874a e013488c 00000000 e298f820 00000202 e298f898 00000202 00000246 
> > > > > Sep 26 11:22:39 sol kernel: Call Trace: [put_dirty_page+122/132] [flush_old_exec+234/572] [sys_ustat+212/268] [kill_super+232/352] [unix_gc+394/748] 
> > > > > Sep 26 11:22:39 sol kernel:    [Unused_offset+27374/99203] [call_spurious_interrupt+13905/27705] [call_spurious_interrupt+17048/27705] [Unused_offset+90704/99203] [ipgre_rcv+233/636] [ipgre_rcv+503/636] 
> > > > > Sep 26 11:22:39 sol kernel:    [fcntl_getlk+327/624] [do_invalid_TSS+43/96] 
> > > > 
> > > > the system.map is wrong but this should be harmless, just a notice (if
> > > > you do the reverse lookup to find the address and you resolve the right
> > > > symbols we could make sure of that).
> > > > 
> > > > For driver writers (since it could be on topic with those GFP_ATOMIC
> > > > faliures): as I suggested to the SG folks make sure to never use
> > > > GFP_ATOMIC in normal kernel context, if you want lowlatency use GFP_NOIO
> > > > instead. GFP_NOIO can schedule (so you must release all the spinlocks
> > > > first) but it will never block on I/O so it will provide a small latency
> > > > too _but_ it will be able to shrink the clean cache so it is very unlikely
> > > > it will fail unless you have lots of dirty or mapped cache in ram.
> > > > 
> > > > >         Also, we see next in process status:
> > > > > 
> > > > > USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
> > > > > vz         927  0.0 625.1 43900 4267034752 ? S    08:10   0:00 hits
> > > > > vz        1030  0.0 625.1 43900 4267034752 ? S    08:11   0:00 hits
> > > > > vz        4561  1.3 625.1 45948 4267034724 ? S    10:48   0:00 hits
> > > > > root      4564  0.0  0.0  1460  548 pts/2    S    10:48   0:00 grep hits
> > > > > vz        4566  0.0 625.1 45948 4267034724 ? S    10:48   0:00 hits
> > > > 
> > > > Ben sent the fix for this one [Linus, you can find it on l-k if you
> > > > weren't cc'ed] (was a missing check in the tlb shootdown smp fixes) but
> > > > it's only a beauty issue, so really don't worry about it :)
> > > > 
> > > > >         After these errors we see some uninterruptable processes (with flag D in
> > > > > process  status),  gdb  say  that function "fdatasync" called and no returned...
> > > > > Soft reboot not work.
> > > > > 
> > > > >         Server   has   2  CPUs (Pentium III Katmai), 2Gb RAM, 2Gb swap, Hardware
> > > > > RAID (Mylex DAC960PTL1 PCI RAID Controller).
> > > > > 
> > > > >         Any ideas ?
> > > > 
> > > > Yes you have highmem.
> > > > 
> > > > Last night I spent one hour on the traces from Bob (btw, many thanks for
> > > > the helpful report Bob!) and the first suspect is the recent
> > > > GFP_NOHIGHIO logic.
> > > > 
> > > > Despite Bob's traces not obviously showing this, I think I can see a
> > > > potential problem with writepage with regard to the GFP_NOHIGHIO logic
> > > > (I just checked 2.4.9ac15 has the same issue too, see the CAN_DO_FS
> > > > definition so this shouldn't been introduced recently).
> > > > 
> > > > This should fix it, and please also apply vm-tweaks-2 posted to l-k a
> > > > few minutes ago.
> > > > 
> > > > --- 2.4.10aa1/mm/vmscan.c	Sun Sep 23 22:16:22 2001
> > > > +++ vm/mm/vmscan.c	Wed Sep 26 16:34:30 2001
> > > > @@ -392,7 +384,7 @@
> > > >  			int (*writepage)(struct page *);
> > > >  
> > > >  			writepage = page->mapping->a_ops->writepage;
> > > > -			if ((gfp_mask & __GFP_FS) && writepage) {
> > > > +			if ((gfp_mask & __GFP_FS) && ((gfp_mask & __GFP_HIGHIO) || !PageHighMem(page)) && writepage) {
> > > >  				ClearPageDirty(page);
> > > >  				page_cache_get(page);
> 
> Andrea, 
> 
> This is going to make __GFP_NOFS allocations call writepage(): deadlock. 

(side note: I assume you mean GFP_NOFS)

GFP_NOFS will never call writepage with the above change, obviously
because __GFP_FS isn't set. So it can't deadlock.

actually the only valid remark is that GFP_NOHIGHIO doesn't set __GFP_FS
either in first place, so if something the above change is going to be a
noop for GFP_NOHIGHIO :(.

Andrea
