Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292269AbSBTT4k>; Wed, 20 Feb 2002 14:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292267AbSBTT4g>; Wed, 20 Feb 2002 14:56:36 -0500
Received: from 66-73-249-62.cambianetworks.com ([66.73.249.62]:46600 "HELO
	cambianetworks.com") by vger.kernel.org with SMTP
	id <S292255AbSBTTzq>; Wed, 20 Feb 2002 14:55:46 -0500
Message-ID: <01d101c1ba48$bb6ed8a0$310610ac@beryllium>
From: "Jeffrey Nowland" <jnowland@cambianetworks.com>
To: "kernel list" <linux-kernel@vger.kernel.org>
In-Reply-To: <E16d7bR-00005Y-00@the-village.bc.nu>
Subject: Re: OOM killer
Date: Wed, 20 Feb 2002 13:56:48 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have seen some wierdness in this area.  I think I might see how it comes
about.

The machine and configuration:
IBM x330 SMP 1.266 GHz Pentium III
2GB RAM
Rawhide 2.4.17-0.16 kernel
**NO SWAP**

Anyway, it appears that at some point the system is running low on
absolutely free RAM and the vmscan kicks in to try to free some pages.  At
this point my top output says I have around 200MB of free memory and about
1.5GB of file cache so one could say this counts as shouldn't OOM anything.

If, at this point, I try to build both the i386 and i686 kernels from a
single rpm command (not sure if just running two sequential rpm -ba's does
it or not) I will start losing kdeinit's with the following showing up in
/var/log/messages:

kernel: Out of memory: Killed process 1630 (kdeinit)
(many more follow as the rpm processes continue valiantly trying to compile
kernels).

Somewhere along the lines here, try_to_free_pages in mm/vmscan.c is called
(not sure why, but doesn't matter, it just does).  In do_try_to_free_pages
it calls page_launder, shrink_dcache_memory, shrink_icache_memory and
shirnk_dqcache_memory in succession and (eventually) if none of them frees
any pages and free_low(ANY_ZONE) > 0 then out of memory is declared.

Now here's the kick, if the gfp_mask indicates that this is a file system
(!(gfp_mask & __GFP_FS)) request then in shrink_dcache_memory there is a
blurb about a deadlock and the dcache refuses to release anything (no matter
how much it has: see shrink_dcache_memory in fs/dcache.c).

So it would appear to me that if the system is feeling some memory pressure
and the only thing that might be freeable is dcache and the file system asks
for some memory causing try_to_free_pages to be called, that you are just
SOL.  dcache isn't giving you anything and there's nothing can be done about
it (well except implement the micro-suggestion in the DEADLOCK blurb in
dcache.c).

Anyway, I don't know if this helps or is even relevent, but I thought I'd
give it a whirl.

Jeff---

----- Original Message -----
From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
To: "Paco Martinez" <pmartinez@heraldo.es>
Cc: "kernel list" <linux-kernel@vger.kernel.org>
Sent: Tuesday, February 19, 2002 4:34 AM
Subject: Re: OOM killer


> > Do you know any newer kernel that solves problem about "OOM Killer" ??
> > Thank you !!!!
>
> I've had no problem with bogus out of memory cases in either 2.4.18-rc, or
> the 2.4.18-ac tree (which adds the rmap vm improvements). I'm also working
> at the moment on adding support for strict memory overcommit handling so
> that you can opt to be sure OOM will not happen, and that a program will
> always get out of memory returns from a syscall (or if you are really
> really unlucky a kill from a stackfault on an app that doesnt take the
> right care)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

