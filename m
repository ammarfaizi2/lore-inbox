Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262116AbVAOE3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbVAOE3r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 23:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbVAOE3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 23:29:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:55722 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262116AbVAOE3o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 23:29:44 -0500
Date: Fri, 14 Jan 2005 20:29:07 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: davidm@hpl.hp.com
cc: schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: sparse warning, or why does jifies_to_msecs() return an int?
In-Reply-To: <200501150221.j0F2L2aD021862@napali.hpl.hp.com>
Message-ID: <Pine.LNX.4.58.0501142020130.2310@ppc970.osdl.org>
References: <200501150221.j0F2L2aD021862@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 14 Jan 2005, David Mosberger wrote:
>
> I'm seeing the following warning from sparse:
> 
> include/linux/jiffies.h:262:9: warning: cast truncates bits from constant value (3ffffffffffffffe becomes fffffffe)

Indeed. It happens on any 64-bit architecture, I think.
 
> it took me a while to realize that this is due to
> the jiffies_to_msecs(MAX_JIFFY_OFFSET) call in
> msecs_to_jiffies() and due to the fact that
> jiffies_to_msecs() returns only an "unsigned int".
> 
> Is there are a good reason to constrain the return value to 4 billion
> msecs?  If so, what's the proper way to shut up sparse?

There's no good way to shut up sparse, I think. The fact is, we _are_ 
losing bits, but it doesn't matter much in this case. I think 
"jiffies_to_msecs(MAX_JIFFY_OFFSET)" is fundamentally a suspect operation 
(since the ranges are different for the two types), and I think that the 
sparse warnign is correct, but it's one of those "doing the wrong thing is 
not always wrogn enough to matter".

> On a related note, there seem to be some overflow issues in
> jiffies_to_{msec,usec}.  For example:
> 
> 	return (j * 1000) / HZ;
> 
> can overflow if j > MAXULONG/1000, which is the case for
> MAX_JIFFY_OFFSET.

Right. Same kind of situation. 

> I think it would be better to use:
> 
> 	return 1000*(j/HZ) + 1000*(j%HZ)/HZ;
> 
> instead.  No?

I don't see it making a huge difference. Whatever you do will be wrong for 
some value of HZ anyway. If HZ is 10, and j > MAXULONG/10, then...

The issue is the same: jiffies and msecs have different ranges, so the
"fix" to some degree would be the same: making MAX_JIFFY_OFFSET small
enough. But as with the other case, it doesn't much seem to matter - it
turns out that the overflow cases end up being "very large integers"  
anyway, which is good enough, since that's what all those MAX_xxx things
are all about.

In the meantime, a warning might eventually make somebody decide to do
something intelligent that just makes it all go away (most likely
something like avoiding the conversion in the first place, and use
something like MAX_MSECS instead)

		Linus
