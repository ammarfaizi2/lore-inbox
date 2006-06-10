Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161007AbWFJTsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161007AbWFJTsx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 15:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030510AbWFJTsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 15:48:53 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:42065 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1161007AbWFJTsw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 15:48:52 -0400
Message-ID: <448B221D.3080907@tls.msk.ru>
Date: Sat, 10 Jun 2006 23:48:45 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: Ingo Oeser <ioe-lkml@rameria.de>
CC: Wu Fengguang <wfg@mail.ustc.edu.cn>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH 4/5] readahead: backoff on I/O error
References: <20060609080801.741901069@localhost.localdomain> <349840680.03819@ustc.edu.cn> <200606102033.46844.ioe-lkml@rameria.de>
In-Reply-To: <200606102033.46844.ioe-lkml@rameria.de>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser wrote:
> Hi Fengguang,
> 
> On Friday, 9. June 2006 10:08, Wu Fengguang wrote:
>> Backoff readahead size exponentially on I/O error.
>  
>> With this patch, retries are expected to be reduced from, say, 256, to 5.
>  
> 1. Would you mind to push this patch to -stable?
> 
> Reason: If killing a drive was hit in the field, this should be critical 
> 	enough.

Well, it looks like I'm the only one in this world who's drive was
fired this way... ;)  Note it's a combination of two issues: it's
definitely a buggy firmware (or hardware) - it should not fire,
no matter how you're hitting it from software - and the readahead+
EIO logic.  So.. well, I don't want to try another drive really,
but it *seems* like it will eventually "recover".  Not that it's
possible still to watch a DVD with a single scratch (one unreadable
block) anyway with current code (it will freeze and freeze and freeze
again and again), but well, it's not really THAT critical.  My drive
is already dead, nothing worse can happen to it anyway ;)

> 2. Could you disable (at least optionally) read ahead complety 
>   on the first IO error?
> 
> Reason: In a data recovery situation (hitting EIO quite often, 
> 	but not really sequentially) readahead is counter productive.
> 	E.g. trying to save an old CD with the cdparanoia software.

I'm thinking about all this again.. well.  Read-ahead is definitely
very useful on a CD (I'm referring to all optical media here, be it
DVD, or BlueRay, or whatever; floppies too, but there it's less useful
due to speed of the whole thing) - I mean, say, DVDs are played more
smoothly if readahead is enabled; a "live CD" distro will be more
responsive if readahead is enabled, and so on - the effect of RA is
trivially visible.

But still, for a scratched CD, it might be a good idea to turn RA off
while playing it, completely - by means of, eg, blockdev --setra 0,
or something like that.  Yes not many (end)users know this tool, yes
it's privileged (oh well), but it helps.

Why I recall --setra is: when kernel will start reducing RA by its
own, next question will be "why my CD is too slow?" -- after playing
a scratched CD, you insert another one, and RA is *still* zero...

So I'm not really sure how simple the solution should be.

I *think* here we have some logic error, either fundamental or something
simple.

I mean the following.

Let's say an application requests block number N, which is NOT in cache.
The kernel, with readahead set, tries to read blocks N..N+R (R = readahead
value).  In.. hmm. one request?  So the question is whenever this one
big request, if block number N+R failed, will be completed partially, or
will fail entirely?  I think the right way is to complete that request
partially, filling buffer cache with blocks N..N+R-1.  Now, when an app
tries to access block N+1, it's already in the cache, and all goes well
up to block number N+R which is unreadable.  So kernel tries to request
blocks N+R..N+2R, fails, and returns an error to application.. which will
next (possible) request block number N+R+1, the kernel will try to read
blocks N+R+1..N+2R+1, will succeed, and everything will go just fine,
with the same readahead value, and with bad block being retried only twice.

So the question really is whenever that large request fails as a whole,
or partially succeeds.  As Jens Axboe explained, it depends on the driver
(or hardware?  Will, say, a hard drive behave sanely in this case, returning
partial data instead of faling the whole request?  Is it ever possible
for a drive to return such "partially successeful" result?)

If it's really difficult/impossible to "fix" this "fail the whole thing"
case, when yes, the only way to go is to disable (or reduce) readahead,
because it's the only way left to fix the problem...  But is it impossible?

Speaking of the patch, it seems to work fine - *alot* better than current
kernel code, I tried one slightly scratched CD - a process reading it
"unstalls" in some more-or-less sane time (still large but it's not
half an hour as before ;)

/mjt
