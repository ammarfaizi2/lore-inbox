Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287516AbSAURXe>; Mon, 21 Jan 2002 12:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287558AbSAURXZ>; Mon, 21 Jan 2002 12:23:25 -0500
Received: from 216-42-72-169.ppp.netsville.net ([216.42.72.169]:21965 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S287516AbSAURXK>; Mon, 21 Jan 2002 12:23:10 -0500
Date: Mon, 21 Jan 2002 12:21:50 -0500
From: Chris Mason <mason@suse.com>
To: Hans Reiser <reiser@namesys.com>, Rik van Riel <riel@conectiva.com.br>
cc: Shawn Starr <spstarr@sh0n.net>, linux-kernel@vger.kernel.org
Subject: Re: Possible Idea with filesystem buffering.
Message-ID: <1780530000.1011633710@tiny>
In-Reply-To: <3C4C20A2.9040009@namesys.com>
In-Reply-To: <Pine.LNX.4.33L.0201211153110.32617-100000@imladris.surriel.com>
 <3C4C20A2.9040009@namesys.com>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday, January 21, 2002 05:07:30 PM +0300 Hans Reiser
<reiser@namesys.com> wrote:

> Rik van Riel wrote:
> 
>> On Mon, 21 Jan 2002, Hans Reiser wrote:
>> 
>>> Pressure received is not equal to pages yielded. ... The number of
>>> pages yielded should depend on the interplay of pressure received and
>>> accesses made.
>>> 

Ah, once the FS starts counting accesses, we get in trouble.  The FS should
strive to know only these 3 things:

How to read useful data into a page
How to flush a dirty page
How to free a pinned page

The VM records everything else, including how often a page is accessed, and
which pages should be freed in response to memory pressure.  Of course, the
FS might have details on many more things such as write clustering, delayed
allocations, or which pinned pages require tons of extra work to write out.
This fools us into thinking the FS might be the best place to decide how to
react under memory pressure, leading to a little VM in each FS.

Everything gets cleaner if we push this info up to the VM in a generic
fashion, instead of trying to push bits of the VM down into each
filesystem. 
The FS should have no idea of what memory pressure is, down that path lies
pain, suffering, and deadlocks against the journal ;-)

If the VM is telling the FS to write a pinned page when there are unpinned
pages that can be written with less cost, then we need to give the VM
better hints about the actual cost of writing the pinned page.

For periodic group flushes (delayed allocation, journal commits, etc), we
need better throttling on dirty pages instead of just dirty buffers like we
do now.

I'm not delusional enough to think this will make all the vm<->journal
nastiness go away, but it hopefully should be less painful than adding
extra VM intelligence into each FS.

-chris

