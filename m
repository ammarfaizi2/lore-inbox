Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262903AbTDFXPy (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 19:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263158AbTDFXPy (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 19:15:54 -0400
Received: from franka.aracnet.com ([216.99.193.44]:5250 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262903AbTDFXPx (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 19:15:53 -0400
Date: Sun, 06 Apr 2003 16:26:57 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Jamie Lokier <jamie@shareable.org>
cc: Rik van Riel <riel@surriel.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@digeo.com>, andrea@suse.de, mingo@elte.hu,
       hugh@veritas.com, dmccr@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org, Bill Irwin <wli@holomorphy.com>
Subject: Re: subobj-rmap
Message-ID: <3370000.1049671616@[10.10.2.4]>
In-Reply-To: <20030406230624.GB25081@mail.jlokier.co.uk>
References: <Pine.LNX.4.44.0304061737510.2296-100000@chimarrao.boston.redhat.com> <1600000.1049666582@[10.10.2.4]> <20030406230624.GB25081@mail.jlokier.co.uk>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 0-150 -> 150-200 -> 200-300 -> 300-400 -> 400-500 -> 500-999
>>  A          A          A          A          A          A
>>  B          B
>>             C          C          C 
>>                                   D          D          
>>                                   E          E          
>>  F          F          F          F          F          F
> 
> I thought of that but decided it is too simple :)
> 
> A downside with it is that from time to time you need to split or
> merge subobjects, and that means splitting or merging the list nodes
> linking "rows" in the table above - potentially quite a lot of memory
> allocation and traversal for a single mmap().

The amount of work to be done is still fairly small ... and we already
do (as far as I can see) *exactly* this already for the existing
rb tree. Yes, mmap has a little bit more overhead, but you lose all
the per-page stuff, which seems much more efficient to me.
 
>> We can always leave the sys_remap_file_pages stuff using pte_chains,
>> and should certainly do that at first. But doing it for normal stuff
>> should be less controversial, I think.
> 
> If you implement the 2d data structure that you illustrated, you have
> a list node for each point in the table.
> 
> By the time your subobject regions are 1 page wide, you have a data
> structure that is order-equivalent to pte rmap chains, although the
> exact number of words is likely to be higher.

Well, yes. Except I hope nobody would want to do that on a per-page
basis. If you want that level of granularity, we should just do this 
for linear objects, and fall back to pte_chains for nonlinear.

Life would be a whole lot simpler if people were willing to specify
non-linear VMAs at create time - I don't see that as a big burden,
personally. That'd get rid of all the conversion stuff.

M.

