Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932429AbWEQGLK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbWEQGLK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 02:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbWEQGLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 02:11:10 -0400
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:1453 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932429AbWEQGLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 02:11:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=tZ4fClPr/Z+nk/wWo8UfZklv8oPdvaEOb9GQc8VnejuQcHalkJw+SPGyBgWud0M7VYsb7gPEDwMQ1wyRXpP/hv6f0aC/ZRuUSbPxQ9jTviKC+uAwAE07tFOj/Pls0iPQ9KJ36QOBhWhMjBx6wAaqGxGf650gkIOjoxyHGjDT9Q4=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Subject: Re: [patch 00/14] remap_file_pages protection support
Date: Wed, 17 May 2006 08:10:58 +0200
User-Agent: KMail/1.8.3
Cc: Valerie Henson <val_henson@linux.intel.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       Linux Memory Management <linux-mm@kvack.org>,
       Val Henson <val.henson@intel.com>
References: <20060430172953.409399000@zion.home.lan> <20060516163111.GK9612@goober> <20060516164743.GA23893@rhlx01.fht-esslingen.de>
In-Reply-To: <20060516164743.GA23893@rhlx01.fht-esslingen.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605170810.59589.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 May 2006 18:47, Andreas Mohr wrote:
> Hi,
>
> On Tue, May 16, 2006 at 09:31:12AM -0700, Valerie Henson wrote:
> > On Tue, May 16, 2006 at 03:51:35PM +0200, Andreas Mohr wrote:
> > > I cannot offer much other than some random confirmation that from my
> > > own oprofiling, whatever I did (often running a load test script
> > > consisting of launching 30 big apps at the same time), find_vma
> > > basically always showed up very prominently in the list of
> > > vmlinux-based code (always ranking within the top 4 or 5 kernel
> > > hotspots, such as timer interrupts, ACPI idle I/O etc.pp.).
> > > call-tracing showed it originating from mmap syscalls etc., and AFAIR
> > > quite some find_vma activity from oprofile itself.
> >
> > This is important: Which kernel?

I'd also add (for all peoples): on which processors? L2 cache size probably 
plays an important role, if (as I'm convinced) the problem are cache misses 
during rb-tree traversal.

> I had some traces still showing find_vma prominently during a profiling run
> just yesterday, with a very fresh 2.6.17-rc4-ck1 (IOW, basically
> 2.6.17-rc4). I added some cache prefetching in the list traversal a while
> ago, 

You mean the rb-tree traversal, I guess! Or was the base kernel so old?

> and IIRC that improved profiling times there, but cache prefetching is 
> very often a bandaid in search for a real solution: a better data-handling
> algorithm.

Ok, finally I find the time to kick in and ask a couple of question.

The current algorithm is good but has poor cache locality (IMHO).

First, since you can get find_vma on the profile, I've read (the article 
talked about userspace apps but I think it applies to kernelspace too) that 
oprofile can trace L2 cache misses.

I think such a profiling, if possible, would be particularly interesting: 
there's no reason whatsoever for that lookup, even on a 32-level tree 
(theoretical maximum since we have max 64K vmas and height_rbtree <= 2 logN), 
should be so slow, unless you add cache misses into the picture. The fact 
that cache prefetching helps shows this even more.

The lookup has very poor cache locality: the rb-node (3 pointers i.e. 12 
bytes, and we need only 2 pointers on searches) is surrounded by non-relevant 
data we fetch (we don't need the VMA itself for nodes we traverse).

For cache-locality the best data structure I know of are radix trees; but 
changing the implementation is absolutely non-trivial (the find_vma_prev() 
and friends API is tightly coupled with the rb-tree), and the size of the 
tree grows with the virtual address space (which is a problem on 64-bit 
archs); finally, you have locality when you do multiple searches, especially 
for the root nodes, but not across different levels inside a single search.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
