Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316846AbSEVED6>; Wed, 22 May 2002 00:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316847AbSEVED5>; Wed, 22 May 2002 00:03:57 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22029 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316846AbSEVED5>; Wed, 22 May 2002 00:03:57 -0400
Date: Tue, 21 May 2002 21:04:03 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Paul Mackerras <paulus@samba.org>
cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Make 2.5.17 TLB even more friendlier
In-Reply-To: <15595.5939.708078.827286@argo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.44.0205212100550.5797-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 May 2002, Paul Mackerras wrote:
>
> It seems to me that there is a race in this code in zap_pte_range,
> because there is a gap between when we read the pte and when we clear
> it:

Yes and no.

There is a race, and yes, another thread might mark it dirty.

However, I've not decided whether we care about it yet. I think we _do_
care, for people doing strange things with their own internal VM
management using mmap/munmap of shared mappings, but on the other hand it
_is_ fairly expensive to do a "ptep_get_and_clear()".

> Shouldn't we do this as "pte = ptep_get_and_clear(ptep)", at least in
> the case where we are unmapping stuff?

Yeah, I want to do it, but I also would really want to avoid the overhead
for the exit case. Which is another reason I'd like to have exit() not use
zap_page_range() at all.

But I'll make that change now, so that we don't lose it. We should just
remember to not do it if we split up exit.

		Linus

