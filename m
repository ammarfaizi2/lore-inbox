Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261238AbUL1OVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbUL1OVY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 09:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbUL1OVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 09:21:24 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22698 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261238AbUL1OVP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 09:21:15 -0500
Date: Tue, 28 Dec 2004 09:24:43 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Manfred Schwarb <manfred99@gmx.ch>
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com,
       trond.myklebust@fys.uio.no, Hans Reiser <reiser@namesys.com>
Subject: Re: 2.4.29-pre2 Oops at find_inode/reiserfs_find_actor
Message-ID: <20041228112443.GA25253@logos.cnet>
References: <20041221164610.GC3596@logos.cnet> <1742.1103673366@www47.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1742.1103673366@www47.gmx.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2004 at 12:56:06AM +0100, Manfred Schwarb wrote:

> > > >>EIP; c0153b09 <find_inode+19/70>   <=====
> > > 
> > > >>eax; e0b3c9e0 <[reiserfs]reiserfs_find_actor+0/40>
> > > >>edx; dff80000 <_end+1fbfd7f4/20792854>
> > > >>edi; dffa2a58 <_end+1fc2024c/20792854>
> > > >>esp; d7f05d60 <_end+17b83554/20792854>
> > > 
> > > Trace; c0153f4e <iget4_locked+5e/110>
> > > Trace; e0b3c9e0 <[reiserfs]reiserfs_find_actor+0/40>
> > > Trace; e0b3ca60 <[reiserfs]reiserfs_iget+40/c0>
> > > Trace; e0b3c9e0 <[reiserfs]reiserfs_find_actor+0/40>
> > > Trace; e0b37b11 <[reiserfs]reiserfs_lookup+101/120>
> > > Trace; c0151d1c <d_alloc+1c/1d0>
> > > Trace; c01491cf <lookup_hash+9f/d0>
> > > Trace; c0149279 <lookup_one_len+79/90>
> > > Trace; e118fd71 <[nfsd]nfsd_lookup+d1/490>
> > > Trace; e1196d39 <[nfsd]nfsd3_proc_lookup+a9/140>
> > > Trace; e119de8c <[nfsd]nfsd_procedures3+6c/320>
> > > Trace; e118c68d <[nfsd]nfsd_dispatch+14d/220>
> > > Trace; c027ab3e <svc_process+3de/590>
> > > Trace; e119de8c <[nfsd]nfsd_procedures3+6c/320>
> > > Trace; e119d758 <[nfsd]nfsd_version3+0/10>
> > > Trace; e119d778 <[nfsd]nfsd_program+0/28>
> > > Trace; e118c3cb <[nfsd]nfsd+1bb/330>
> > > Trace; c010729b <arch_kernel_thread+2b/40>
> > > Trace; e118c210 <[nfsd]nfsd+0/330>
> > > 
> > > Code;  c0153b09 <find_inode+19/70>
> > > 00000000 <_EIP>:
> > > Code;  c0153b09 <find_inode+19/70>   <=====
> > >    0:   39 6b 28                  cmp    %ebp,0x28(%ebx)   <=====
> > > Code;  c0153b0c <find_inode+1c/70>
> > >    3:   89 de                     mov    %ebx,%esi
> > > Code;  c0153b0e <find_inode+1e/70>
> > >    5:   75 f1                     jne    fffffff8 <_EIP+0xfffffff8>
> > > Code;  c0153b10 <find_inode+20/70>
> > >    7:   8b 44 24 20               mov    0x20(%esp,1),%eax
> > > Code;  c0153b14 <find_inode+24/70>
> > >    b:   39 83 a0 00 00 00         cmp    %eax,0xa0(%ebx)
> > > Code;  c0153b1a <find_inode+2a/70>
> > >   11:   75 e5                     jne    fffffff8 <_EIP+0xfffffff8>
> > > Code;  c0153b1c <find_inode+2c/70>
> > >   13:   8b 00                     mov    (%eax),%eax
> > 
> > This is indeed corruption - an inode in this hash bucket has "->next" as 
> > NULL, so find_inode goes boom.
> > 
> > Something is leaving this hash bucket list corrupt. 
> > 
> > Have you ever seen this crash before ? Can you reproduce it? 
> > 
> 
> No, not at all. This machine was running for 10 months with 2.4.xx 
> kernels without any problems. Since this oops, I tried to reproduce
> the particular situation (rsync over nfs, and some additional load),
> put I had no success in crashing the box:
> I mirrored the box (ca. 1 million files) 5 times, no problem.
>  
> 
> > The only inode corruption case that was reliable was from Chris Caputo
> > and we end up agreeing that it was most likely a hardware issue, because
> > it was
> > hard to reproduce and strange in several ways. Can you point me at 
> > the "quite some similar reports" you have found, please ?
> > 
> 
> Just my first impression, a closer look showed that most of the
> cases group around 2.4.1[789] because of lacking reiserfs_find_actor.
> Sorry for the overstatement.
> 
> A recent oops report shows some similarity, using a 2.6.7 kernel:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=109278828905885&w=2
> 
> 
> Hardware issue: you mean memory? Last winter I ran memtest86
> during a weekend, everything was fine. At the moment I can't
> take this box offline for a longer period to test again, so I 
> tend to belive memory is ok, and knock on wood...

Yes, what I'm saying is that no reliable inode corruption case has been 
reported recently, except when hardware was flaky (usually memory errors).

I'm not saying that this is your case - its just one explanation to the
problem. It might well be a software problem.

Hans, did any of your developers see similar inode cache hashtable corruption 
in v2.4.x?
