Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288485AbSAUVye>; Mon, 21 Jan 2002 16:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288548AbSAUVyZ>; Mon, 21 Jan 2002 16:54:25 -0500
Received: from 216-42-72-169.ppp.netsville.net ([216.42.72.169]:59854 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S288485AbSAUVyK>; Mon, 21 Jan 2002 16:54:10 -0500
Date: Mon, 21 Jan 2002 16:53:07 -0500
From: Chris Mason <mason@suse.com>
To: Hans Reiser <reiser@namesys.com>
cc: Rik van Riel <riel@conectiva.com.br>, Shawn Starr <spstarr@sh0n.net>,
        linux-kernel@vger.kernel.org
Subject: Re: Possible Idea with filesystem buffering.
Message-ID: <1854570000.1011649986@tiny>
In-Reply-To: <3C4C7D08.2020707@namesys.com>
In-Reply-To: <Pine.LNX.4.33L.0201211153110.32617-100000@imladris.surriel.com>
 <3C4C20A2.9040009@namesys.com> <1780530000.1011633710@tiny>
 <3C4C5414.2090104@namesys.com> <1819870000.1011642257@tiny>
 <3C4C7D08.2020707@namesys.com>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday, January 21, 2002 11:41:44 PM +0300 Hans Reiser
<reiser@namesys.com> wrote:

> I read this and it sounds like you are agreeing with me, which is
> confusing;-),

No, no, you're agreeing with me ;-)

> help me to understand what you mean by triggered.  Do you
> mean VM sends pressure to the FS?  Do you mean that VM understands what a
> transaction is?  Is this that generic journaling layer trying to come
> alive as a piece of the VM?  I am definitely confused.
> 
The vm doesn't know what a transaction is.  But, the vm might know that
a) this block is pinned by the FS for write ordering reasons
b) the cost of writing this block is X
c) calling page->somefunc will trigger writes on those blocks.

The cost could be in order of magnitude, the idea would be to give the FS
the chance to say 'one a scale of 1 to 10, writing this block will hurt
this much'.  Some blocks might have negative costs, meaning they don't
depend on anything and help free others.

The same system can be used for transactions and delayed allocation,
without telling the VM about any specifics.  

> I think what I need to understand, is do you see the VM as telling the FS
> when it has (too many dirty pages or too many clean pages) and letting
> the FS choose to commit a transaction if it wants to as its way of
> cleaning pages, or do you see the VM as telling the FS to commit a
> transaction?

I see the VM calling page->somefunc to flush that page, triggering whatever
events the FS feels are necessary.  We might want some way to differentiate
between periodic writes and memory pressure, so the FS has the option of
doing fancier things during write throttling.

> 
> If you think that VM should tell the FS when it has too many pages, does
> that mean that the VM understands that a particular page in the subcache
> has not been accessed recently enough?  Is that the pivot point of our
> disagreement?

Pretty much.  I don't think the VM should say 'you have too many pages', I
think it should say 'free this page'.  

>> 
>> 
>> For write clustering, we could add an int clusterpage(struct page *p)
>> address space op that allow the FS to find pages close to p, or the FS
>> could choose to cluster in its own writepage func.
>> 
> What you are proposing is not consistent with how Marcello is doing write
> clustering as part of the VM, you understand that, yes?  What Marcello is
> doing is fine for ReiserFS V3 but won't work well for v4, do you agree?

Well, my only point is that it is possible to make an interface for write
clustering that gives the FS the freedom to do what it needs, but still
keep the intelligence about which pages need freeing first in the VM.  

-chris

