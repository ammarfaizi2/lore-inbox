Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318804AbSHESDf>; Mon, 5 Aug 2002 14:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318806AbSHESDf>; Mon, 5 Aug 2002 14:03:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5382 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318804AbSHESDe>;
	Mon, 5 Aug 2002 14:03:34 -0400
Message-ID: <3D4EC114.C87FEEFF@zip.com.au>
Date: Mon, 05 Aug 2002 11:16:52 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Daniel Phillips <phillips@arcor.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Rmap speedup
References: <E17biDi-0000w7-00@starship> <Pine.LNX.4.44L.0208051056440.23404-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Mon, 5 Aug 2002, Daniel Phillips wrote:
> 
> > > Despite the fact that the number of pte_chain references in
> > > page_add/remove_rmap now just averages two in that test.
> >
> > It's weird that it only averages two.  It's a four way and your running
> > 10 in parallel, plus a process to watch for completion, right?
> 
> I explained this one in the comment above the declaration of
> struct pte_chain ;)
> 
>  * A singly linked list should be fine for most, if not all, workloads.
>  * On fork-after-exec the mapping we'll be removing will still be near
>  * the start of the list, on mixed application systems the short-lived
>  * processes will have their mappings near the start of the list and
>  * in systems with long-lived applications the relative overhead of
>  * exit() will be lower since the applications are long-lived.

I don't think so - the list walks in there are fairly long.
What seems to be happening is that, as Daniel mentioned,
all the pte_chains for page N happen to have good locality
with the pte_chains for page N+1.  Like parallel lines.

That might not hold up for longer-lived processes, slab cache
fragmentation, longer chains, etc...
