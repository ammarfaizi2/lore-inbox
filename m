Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbVKQJ12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbVKQJ12 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 04:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbVKQJ12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 04:27:28 -0500
Received: from bsamwel.xs4all.nl ([82.92.179.183]:8775 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S1750711AbVKQJ12 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 04:27:28 -0500
Message-ID: <437C4C8B.4030502@samwel.tk>
Date: Thu, 17 Nov 2005 10:25:31 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Thunderbird 1.5 (Windows/20051025)
MIME-Version: 1.0
To: Jan Niehusmann <jan@gondor.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Laptop mode causing writes to wrong sectors?
References: <20051116181612.GA9231@knautsch.gondor.com> <437B912B.7090505@samwel.tk> <20051116214222.GB4935@knautsch.gondor.com>
In-Reply-To: <20051116214222.GB4935@knautsch.gondor.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: bart@samwel.tk
X-SA-Exim-Scanned: No (on samwel.tk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Niehusmann wrote:
> On Wed, Nov 16, 2005 at 09:06:03PM +0100, Bart Samwel wrote:
>> First of all, you having resized your fs is a smoking gun, if you ask 
>> me. Your fs is dead/dying, and you know you've recently been tinkering 
>> with it. It's the most probable cause.
> 
> Well, it would be nice if the explanation was that easy - but the recent
> corruption (with the man page) was on my root partition, which is not on
> LVM and has never been resized.

Youch. I assumed this was all the same fs! It is the same HD though?

> Be assured that at least after the first corruption I observed, I did
> forced e2fsck on all partitions. Without any errors found.

ACK.

>> after the resize2fs -- seeing as all the subsequent fscks were probably 
>> done by journal.
> 
> What do you mean with 'by journal'? The filesystems were unmounted (or
> remounted r/o), so the journal should have been committed and empty at
> e2fsck time.

I mean, no full e2fsck, at most a journal replay. This doesn't check the 
bitmaps, so if they are inconsistent, they stay inconsistent.

>>> But now, I got another hint pointing to a possible cause of this
>>> problem: I found a file - /usr/lib/libatlas.so.3.0 - which was corrupted
>>> by 4k of it being overwritten by a different file, which I recognized. 
>>> And that file happened to be an uncompressed manual page.
>> This sounds like your filesystem's block bitmaps are "fscked up". These 
>> problems can definitely cause "creeping corruption" when undetected, 
> 
> But this should definitely have been detected by an fsck, right?

Yes. And you've had this problem before, even. Googling for "e2fsck 
block bitmap differences" shows me this as the third entry. :)

http://lkml.org/lkml/2003/8/3/166

If you didn't get those messages, then this is not the problem, apparently.

> I agree it's probably not a sync problem. And therefore, probably not
> really a laptop-mode bug, even if laptop-mode triggered the corruption.
> I suspected the hard drive to mess up write requests during spin-up. Or
> perhaps giving some kind of error message, which could trigger a bug in
> a rarely tested error-handling path in the kernel. But the fact that you
> never got similar reports makes this less likely. In the end, I have to
> consider there may be some bad hardware in my laptop. (Already did a
> memtest86, of course.)

There is a known problem with laptop mode where, often during 
spindown/spinup, the kernel emits DMA timeout errors.

http://lkml.org/lkml/2005/8/21/48

According to Andrea Gelmini (the original reporter of this problem) this 
can lead to system freezes on some kernels, and corruption on others. 
Are you seeing these errors somewhere in your logs?

What's your hardware? A Thinkpad perhaps?

--Bart
