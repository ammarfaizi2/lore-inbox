Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030448AbVKPUIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030448AbVKPUIB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 15:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030484AbVKPUIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 15:08:00 -0500
Received: from bsamwel.xs4all.nl ([82.92.179.183]:27459 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S1030448AbVKPUIA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 15:08:00 -0500
Message-ID: <437B912B.7090505@samwel.tk>
Date: Wed, 16 Nov 2005 21:06:03 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Thunderbird 1.5 (Windows/20051025)
MIME-Version: 1.0
To: Jan Niehusmann <jan@gondor.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Laptop mode causing writes to wrong sectors?
References: <20051116181612.GA9231@knautsch.gondor.com>
In-Reply-To: <20051116181612.GA9231@knautsch.gondor.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: bart@samwel.tk
X-SA-Exim-Scanned: No (on samwel.tk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Niehusmann wrote:
> let me start by stating that the following is mainly guessed. I may be
> completely wrong. Still I think you may be interested in my
> observations, and perhaps you already got similar reports?

Nope, no similar reports. But I'm listening. :)

> On my laptop, running 2.6.14, I'm observing some strange file- and
> filesystem corruptions. First, I thought it may have been caused by an
> ext3 bug because the first corruption I did observe happened shortly
> after an ext3 journal replay.
> 
> I did report this to linux-kernel, but without any helpful response:
> http://www.ussg.iu.edu/hypermail/linux/kernel/0511.0/0129.html
> (Subject: ext3 corruption: "JBD: no valid journal superblock found")

Quoting your message:

# There are two things I did with the filesystem which may be related to
# this: First, on Oct. 27 I did resize the filesystem (umount, lvextend,
# e2fsck -f, resize2fs, mount). But after that I did several reboots
# without any problems - this is my notebook and I turn it on and off
# several times a day.

First of all, you having resized your fs is a smoking gun, if you ask 
me. Your fs is dead/dying, and you know you've recently been tinkering 
with it. It's the most probable cause.

Secondly, I think that your resize sequence is missing an e2fsck -f 
after resize2fs. Resizing filesystems is risky business, and I've ruined 
many a filesystem by resizing them. Even when it came clean out of an 
fsck. I'm also worried that there was apparently _never_ a full fsck 
after the resize2fs -- seeing as all the subsequent fscks were probably 
done by journal. That way, any existing problem can stay in existence 
and slowly "creep" into more and more of your files as you modify them.

> But now, I got another hint pointing to a possible cause of this
> problem: I found a file - /usr/lib/libatlas.so.3.0 - which was corrupted
> by 4k of it being overwritten by a different file, which I recognized. 
> And that file happened to be an uncompressed manual page.

This sounds like your filesystem's block bitmaps are "fscked up". These 
problems can definitely cause "creeping corruption" when undetected, 
because (a) new files overwrite existing files only part of the time 
(especially if your filesystem has a relatively large amount of free 
space, as it probably does because you just resized it), and (b) you 
don't actually use most of your files very often, so you usually don't 
really notice it until it's too late.

Also, AFAIK the journal is simply a special file as far as ext3 is 
concerned, and perhaps the journal corruption you experienced has to do 
with that special file's bits being marked free, and the beginning of 
the journal being overwritten by other data.

DISCLAIMER: I'm biased. I almost lost a filesystem to this exact problem 
once. It was ext2resize, not resize2fs. But still.

About the laptop mode hypothesis: I think it's just a coincidence. If 
it's not, then it could be a "sync-time-only" problem (because what 
laptop mode does before spindown is a sync), but not a specific laptop 
mode problem -- laptop mode doesn't influence block numbers whatsoever. 
  But if it were a sync problem, we would be seeing a lot more reports 
of corruption. For now my vote is with the resize. :)

--Bart
