Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314987AbSEUQA7>; Tue, 21 May 2002 12:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315048AbSEUQA6>; Tue, 21 May 2002 12:00:58 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:38410 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S314987AbSEUQA5>; Tue, 21 May 2002 12:00:57 -0400
Date: Tue, 21 May 2002 09:01:05 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David S. Miller" <davem@redhat.com>
cc: paulus@samba.org, <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.16
In-Reply-To: <20020520.221055.106159485.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0205210857590.2249-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 20 May 2002, David S. Miller wrote:
>
> It still needs to handle the "unmapping entire address space"
> vs. "unmapping munmap-like operation".  Currently we'll flush
> excessively when doing exit_mmap().

I'm considering just re-doing exit_mmap() entirely, so that it shares no
real code.

> I'll go and hack this into your new stuff.

Don't hack it into the existing stuff, the exit_mmap() really is
very different.

For example, in the exit_mmap() case, we should tear down the page tables
in top-to-bottom order, and that makes all the "tlb->pages[]" stuff
entirely unnecessary: we can just remove the _top_ pgd, and once that is
done (and the TLB invalidated), we can remove the pmd's and the pte's at
our leisure without any fear of races.

None of the complicated TLB flushing needed or wanted.

Also, exit_mmap() has no races with other threads etc, nor does it have
any reason to worry about the RSS of the process any more.

		Linus

