Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262709AbUKXOVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbUKXOVu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 09:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262658AbUKXOVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 09:21:00 -0500
Received: from zeus.kernel.org ([204.152.189.113]:3810 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262730AbUKXORF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 09:17:05 -0500
Message-ID: <41A49940.6030104@snapgear.com>
Date: Thu, 25 Nov 2004 00:22:56 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       torvalds@osdl.org, hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Compound page overhaul
References: <20041122155434.758c6fff.akpm@osdl.org> <11948.1101130077@redhat.com> <29356.1101201515@redhat.com> <20041123081129.3e0121fd.akpm@osdl.org> <20041123171039.GK2714@holomorphy.com>
In-Reply-To: <20041123171039.GK2714@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



William Lee Irwin III wrote:
> David Howells <dhowells@redhat.com> wrote:
> 
>>>It's nothing at all to do with MMU vs !MMU.
> 
> 
> On Tue, Nov 23, 2004 at 08:11:29AM -0800, Andrew Morton wrote:
> 
>>In that case I just dunno what's going on now.
>>I thought we were discussing the removal of this, from __free_pages_ok():
>>#ifndef CONFIG_MMU
>>	if (order > 0)
>>		for (i = 1 ; i < (1 << order) ; ++i)
>>			__put_page(page + i);
>>#endif
>>by using compound page's refcounting logic instead.  But !MMU really wants
>>to treat that higher-order page as an array of zero-order pages, and that
>>requires the usual usage of the fields of page[1], page[2], etc.
>>So what I'm saying is "compound pages are designed for treating a
>>higher-order page as a higher-order page.  !MMU wants to treat a higher
>>order page as an array of zero-order pages.  Hence give up and stick with
>>the current code".
>>What are you saying?
> 
> 
> The way I interpreted this is something like:
> 
> The usual way this goes (as I've seen it elsewhere) is that some fields
> are "base page properties", so each struct page in the subarray of
> mem_map the higher-order page represents can have some different,
> meaningful value for the field, and so on. Others are "superpage
> properties", which refer to the head of the higher-order page.
> 
> The MMU-less code appears to assume the refcounts of the tail pages
> will remain balanced, and elevates them to avoid the obvious disaster.
> But this looks rather broken barring some rather unlikely invariants. I
> presume the patch is backing that out so refcounting works properly, or
> in the nomenclature above (for which there is a precedent) makes the
> refcount a superpage property uniformly across MMU and MMU-less cases.

The MMUless code probably does not need to be done differently,
as it is now. Backing out the refcounting changes for non-MMU
is good, once the procfs problem is fixed. (At least as far as
I can tell this is the case, and some limited testing seems to
back that up).


> It's unclear (to me) how the current MMU-less code works properly, at
> the very least. It would appear to leak memory since there is no
> obvious guarantee the reference to the head page will be dropped when
> needed, though things may have intended to free the various tail pages.

I am not aware of any memory leaks in practice, and I haven't
heard from others of any specific problem.


> i.e. AFAICT things really need to acquire and release references on the
> whole higher-order page as a unit for refcounting to actually work,
> regardless of MMU or no.
> 
> It may also be helpful for Greg Ungerer to help review these patches,
> as he appears to represent some of the other MMU-less concerns, and
> may have more concrete notions of how things behave in the MMU-less
> case than I myself do (hardware tends to resolve these issues, but
> that's not always feasible; perhaps an MMU-less port of a "normal"
> architecture would be enlightening to those otherwise unable to
> directly observe MMU-less behavior). In particular, correcting what
> misinterpretations in the above there may be.

The refcounting has been annoying me for a while, it just feels
wrong. It has been done that way for a very long time (since 2.4.0
IIRC). I am sure there was more to it back in the 2.4 but I don't
think we need to do it like this any more.

I don't have any problem with what David has done so far though
I need to test it more extensively first.

Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude       EMAIL:     gerg@snapgear.com
SnapGear -- a CyberGuard Company            PHONE:       +61 7 3435 2888
825 Stanley St,                             FAX:         +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com
