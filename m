Return-Path: <linux-kernel-owner+w=401wt.eu-S1422687AbWLPW1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422687AbWLPW1w (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 17:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422689AbWLPW1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 17:27:52 -0500
Received: from mcr-smtp-002.bulldogdsl.com ([212.158.248.8]:3318 "EHLO
	mcr-smtp-002.bulldogdsl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1422687AbWLPW1v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 17:27:51 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Linux 2.6.20-rc1
Date: Sat, 16 Dec 2006 22:28:06 +0000
User-Agent: KMail/1.9.5
Cc: Jens Axboe <jens.axboe@oracle.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jeff@garzik.org>
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org> <200612150141.09020.s0348365@sms.ed.ac.uk> <Pine.LNX.4.64.0612161326120.3479@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612161326120.3479@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612162228.06913.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 16 December 2006 21:36, Linus Torvalds wrote:
> On Fri, 15 Dec 2006, Alistair John Strachan wrote:
> > In total isolation, v2.6.19..0e75f9063f5c55fb0b0b546a7c356f8ec186825e it
> > breaks. Reverting just 0e75f9063f5c55fb0b0b546a7c356f8ec186825e, it works
> > again.
> >
> > So I think this is the source, but I can't explain why it "goes away"
> > before git1 and "comes back" before 2.6.20-rc1.
>
> Can you see if the kernel state at commit 77d172ce ("[PATCH] fix SG_IO bio
> leak") is good? Ie just do something like
>
> 	git checkout -b test-branch 77d172ce
>
> and compile and test that?
>
> That commit _should_ be the one that fixed whatever problems that commit
> 0e75f906 introduced. It *did* fix it for other - somewhat similar -
> situations.
>
> That said: Jens - I think 0e75f906 was a mistake. "blk_rq_unmap()" really
> should be passed the "struct bio", not the "struct request *". Right now
> it does something _really_ strange with requests with linked bio's, and I
> don't think your and FUJITA's "leak fix" really works. What happens when
> the bio was a linked list on the request, and you put the old _head_ on
> the request with "rq->bio = bio"? What happens to the other parts of it?
>
> IOW, I think this is broken. I think we should revert 0e75f906. Or at
> least you should explain to me why it's not broken, and why clearly people
> (eg Alistair) still see problems with it?

It could simply be that bisect isn't working here because it's actually broken
by two separate patches. Out of bad luck, I've ended up singling out the one
that already has a "fix", and the "real bug" hasn't been found.

I guess I should repeat the bisection, and when the bio-fix isn't applied,
manually apply it? Is there some magical Git way to do this?

Here's the bisection log, for what it's worth;

[alistair] 22:27 [~/linux-git] git bisect log
git-bisect start
# bad: [cc016448b0bf0764928275d034e367753bde8162] Linux v2.6.20-rc1
git-bisect bad cc016448b0bf0764928275d034e367753bde8162
# good: [c3fe6924620fd733ffe8bc8a9da1e9cde08402b3] Linux 2.6.19
git-bisect good c3fe6924620fd733ffe8bc8a9da1e9cde08402b3
# bad: [b2c03941b50944a268ee4d5823872f220809a3ba] IPMI: Allow hot system interface remove
git-bisect bad b2c03941b50944a268ee4d5823872f220809a3ba
# bad: [29b08d2bae854f66d3cfd5f57aaf2e7c2c7fce32] [S390] pfault code cleanup.
git-bisect bad 29b08d2bae854f66d3cfd5f57aaf2e7c2c7fce32
# bad: [0e11c91e1e912bc4db5b71607d149e7e9a77e756] [AF_PACKET]: annotate
git-bisect bad 0e11c91e1e912bc4db5b71607d149e7e9a77e756
# bad: [5f56bbdf1e35d41b4b3d4c92bdb3e70c63877e4d] Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband
git-bisect bad 5f56bbdf1e35d41b4b3d4c92bdb3e70c63877e4d
# good: [94fcda1f8ab5e0cacc381c5ca1cc9aa6ad523576] usbcore: remove unused argument in autosuspend
git-bisect good 94fcda1f8ab5e0cacc381c5ca1cc9aa6ad523576
# bad: [4549df891a31b9a05b7d183106c09049b79327be] Merge master.kernel.org:/pub/scm/linux/kernel/git/gregkh/driver-2.6
git-bisect bad 4549df891a31b9a05b7d183106c09049b79327be
# good: [5ab699810d46011ad2195c5916f3cbc684bfe3ee] driver core: Introduce device_find_child().
git-bisect good 5ab699810d46011ad2195c5916f3cbc684bfe3ee
# good: [6b44d4e69c6144d0df71ab47ec90d2009237d48f] Fix typos in drivers/isdn/hisax/isdnl2.c
git-bisect good 6b44d4e69c6144d0df71ab47ec90d2009237d48f
# bad: [6b8cc71ab2619a776b02869fd733ac1ead3db4e8] Merge git://git.kernel.org/pub/scm/linux/kernel/git/sfrench/cifs-2.6
git-bisect bad 6b8cc71ab2619a776b02869fd733ac1ead3db4e8
# bad: [bb37b94c68e7b37eecea8576039ae9396ca07839] [BLOCK] Cleanup unused variable passing
git-bisect bad bb37b94c68e7b37eecea8576039ae9396ca07839
# good: [ad2d7225709b11da47e092634cbdf0591829ae9c] block: kill length alignment test in bio_map_user()
git-bisect good ad2d7225709b11da47e092634cbdf0591829ae9c
# bad: [0e75f9063f5c55fb0b0b546a7c356f8ec186825e] block: support larger block pc requests
git-bisect bad 0e75f9063f5c55fb0b0b546a7c356f8ec186825e

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
