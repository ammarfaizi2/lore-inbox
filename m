Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263152AbTDFWzW (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 18:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263154AbTDFWzV (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 18:55:21 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:51841 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S263152AbTDFWzU (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 18:55:20 -0400
Date: Mon, 7 Apr 2003 00:06:24 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Rik van Riel <riel@surriel.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@digeo.com>, andrea@suse.de, mingo@elte.hu,
       hugh@veritas.com, dmccr@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org, Bill Irwin <wli@holomorphy.com>
Subject: Re: subobj-rmap
Message-ID: <20030406230624.GB25081@mail.jlokier.co.uk>
References: <Pine.LNX.4.44.0304061737510.2296-100000@chimarrao.boston.redhat.com> <1600000.1049666582@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600000.1049666582@[10.10.2.4]>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> 0-150 -> 150-200 -> 200-300 -> 300-400 -> 400-500 -> 500-999
>  A          A          A          A          A          A
>  B          B
>             C          C          C 
>                                   D          D          
>                                   E          E          
>  F          F          F          F          F          F

I thought of that but decided it is too simple :)

A downside with it is that from time to time you need to split or
merge subobjects, and that means splitting or merging the list nodes
linking "rows" in the table above - potentially quite a lot of memory
allocation and traversal for a single mmap().

> > For VMAs D & E and A & F it's a no-brainer,
> > but for Oracle shared memory you shouldn't
> > assume that you have any similar mappings
> 
> We can always leave the sys_remap_file_pages stuff using pte_chains,
> and should certainly do that at first. But doing it for normal stuff
> should be less controversial, I think.

If you implement the 2d data structure that you illustrated, you have
a list node for each point in the table.

By the time your subobject regions are 1 page wide, you have a data
structure that is order-equivalent to pte rmap chains, although the
exact number of words is likely to be higher.

To me this suggests that the 2d data structure could be designed
carefully, so that in the extreme case it gracefully _becomes_ rmap
chains.  For memory efficiency you'd need to pack together multiple
list nodes into a single cache line - the same tricks used to minimise
rmap memory consumption.

I'm not convinced this is the best data structure, but it does seem to
suggest the possibility of a hybrid which gives the best of both
objrmap and rmap data structures.

-- Jamie
