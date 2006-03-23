Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751481AbWCWTao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbWCWTao (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 14:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbWCWTao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 14:30:44 -0500
Received: from mouth.voxel.net ([69.9.180.118]:61087 "EHLO mail.squishy.cc")
	by vger.kernel.org with ESMTP id S1751481AbWCWTao (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 14:30:44 -0500
Message-ID: <4422F761.8000300@debian.org>
Date: Thu, 23 Mar 2006 14:30:41 -0500
From: Andres Salomon <dilinger@debian.org>
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pdflush and high load
References: <1141682814.30428.60.camel@localhost.localdomain> <20060307040821.29aa78c1.akpm@osdl.org>
In-Reply-To: <20060307040821.29aa78c1.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Sorry for the delayed response, been way too busy)


Andrew Morton wrote:
> Andres Salomon <dilinger@debian.org> wrote:
>> Hi,
>>
>> (2nd attempt at posting this; the first one appears to have
>> disappeared?)
> 
> It came through.
> 
>> Basically, what ends up happening on my system is, each pdflush process
>> is handling background_writeout(), encountering congestion, and calling
>> blk_congestion_wait(WRITE, HZ/10) after every loop.
> 
> Yes, the do-we-need-another-thread algorithm is rather too naive.  I could
> swear it _used_ to work OK.  Maybe something changed to cause individual
> threads to block for longer than they used to.  That would be an
> independent problem - one pdflush instance is supposed to be able to handle
> many queues (I tested one instance on 12 disks and it worked OK.  But that
> was 4-5 years ago)

The fact that background_writeout() seems to count up to 0 in the common
case suggests some serious bitrot.


> 
>> My solution to the problem is to keep the blk_congestion_wait() sleep as
>> uninterruptible, but add a check to the background_writeout() loop to
>> check whether the current pdflush thread is actually doing anything
>> useful; if it's not, just give up.
> 
> It would be better to not start a new thread in the first place.
> 

Indeed, but how do we determine that?

One option that I thought of was to move the thread spawning logic down
into the worker callbacks, as they have more of an idea about what's
going on.  When they simply sleep (as is the case w/
background_writeout), it's very easy to hit the 1 second threshold that
the generic pdflush logic uses to determine whether to create a new thread.

I'm playing around w/ some patches that move the logic down into the
callbacks, returning non-zero if they need help.  Thus, the pdflush
thread checks if the callback returned non-zero, and if there's no
pdflush threads idle; if that's the case, allocate a new thread.
