Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275825AbRI1D4B>; Thu, 27 Sep 2001 23:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275824AbRI1Dzv>; Thu, 27 Sep 2001 23:55:51 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:29444 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S275825AbRI1Dzl>;
	Thu, 27 Sep 2001 23:55:41 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200109280356.f8S3u5g154813@saturn.cs.uml.edu>
Subject: Re: swsusp: move resume before mounting root [diff against vanilla 2.4.9]
To: pavel@suse.cz (Pavel Machek)
Date: Thu, 27 Sep 2001 23:56:05 -0400 (EDT)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan),
        linux-kernel@vger.kernel.org (kernel list)
In-Reply-To: <20010927163421.C23647@atrey.karlin.mff.cuni.cz> from "Pavel Machek" at Sep 27, 2001 04:34:21 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek writes:

>>>> Solution for the filesystem problems:
>>>>
>>>> 1. at suspend, basically unmount the filesystem (keep the mount tree)
>>>> 2. at resume, re-validate open files
>>>
>>> Wrong solution. ;-).
>>>
>>> Solution to filesystem problems: at suspend, sync but don't do
>>> anything more. At resume, don't try to mount anything (so that you
>>> don't replay transactions or damage disk in any other way).
>>
>> That is totally broken, because I may mount the disk in between
>> the suspend and resume. I might even:
>>
>> 1. boot kernel X
>> 2. suspend kernel X
>> 3. boot kernel Y
>> 4. suspend kernel Y
>> 5. resume kernel X
>> 6. suspend kernel X
>> 7. resume kernel Y
>> 8. suspend kernel Y
>> 9. goto #5
>>
>> You really have to close the logs and mark the disks clean
>> when you suspend. The problems here are similar the the ones
>
> I can't do that: open deleted files.

Tough luck. Either use the same hack as NFS, or have such files
return -EIO for all operations and give SIGBUS for mappings.
Maybe just refuse to suspend when there are open deleted files.
Oh, just create a name in the filesystem root and use that.
Something like ".8fe4a979.swsusp" would be fine. Whatever!

>> NFS faces. Between the suspend and resume, filesystems may be
>> modified in arbitrary ways.
>
> No, you don't want to do that. This is swsusp package, meant to
> replace suspend-to-disk on your notebook. If you choose random
> notebook, it will allow you to suspend to disk, but not to suspend,
> boot X, poweron, boot Y, reboot, boot X.
>
> If you do what you described, you'll corrupt your filesystem. It is
> designed that way.

Not "If", but "When". Somebody has already posted a report of
doing exactly that, by accident, with a 3-month-old suspension.
The filesystems were destroyed.

Right now, swsusp is a serious hazard.
