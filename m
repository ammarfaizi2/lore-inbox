Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161317AbWBUEdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161317AbWBUEdG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 23:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932705AbWBUEdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 23:33:05 -0500
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:38112 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S932703AbWBUEdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 23:33:04 -0500
Message-ID: <43FA97D9.4070902@myrealbox.com>
Date: Mon, 20 Feb 2006 20:32:25 -0800
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthias Hensler <matthias@wspse.de>,
       kernel list <linux-kernel@vger.kernel.org>
CC: Nigel Cunningham <nigel@suspend2.net>, Sebastian Kgler <sebas@kde.org>,
       rjw@sisk.pl, pavel@ucw.cz
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2]
 Modules support.)
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602200709.17955.nigel@suspend2.net> <20060219212952.GI15311@elf.ucw.cz> <200602201025.01823.nigel@suspend2.net> <20060220005333.GL15608@elf.ucw.cz> <20060220094728.GD19293@kobayashi-maru.wspse.de>
In-Reply-To: <20060220094728.GD19293@kobayashi-maru.wspse.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Hensler wrote:
> Hi.
> 
> On Mon, Feb 20, 2006 at 01:53:33AM +0100, Pavel Machek wrote:
> 
>>Only feature I can't do is "save whole pagecache"... and 14000 lines
>>of code for _that_ is a bit too much. I could probably patch my kernel
>>to dump pagecache to userspace, but I do not think it is worth the
>>effort.
> 
> 
> I do not think that Suspend 2 needs 14000 lines for that, the core is
> much smaller. But besides, _not_ saving the pagecache is a really _bad_
> idea. I expect to have my system back after resume, in the same state I
> had left it prior to suspend. I really do not like it how it is done by
> Windows, it is just ugly to have a slowly responding system after
> resume, because all caches and buffers are gone.
> 
> I can only speak for myself, but I want to work with my system from the
> moment my desktop is back.

I Am Not A VM Hacker, but:

What's the point of saving pagecache during suspend?  This seems like a 
total waste.  Why don't we save a list of pages in pagecache to disk,
then, after resume, prefetch them all back in.  This will slow down 
resume (extra seeks, minimized if we sort the list, and inability
to compress these pages), but it will speed up suspend, and it sounds
a lot simpler.  There's already a patch to add swap prefetching, and 
this can't be much more complicated.

While I'm at it, here's another pie-in-the-sky idea.  If we had the 
ability to unmount an in-use filesystem (that lack is my single biggest 
pet peeve about Linux right now -- Windows has been able to do this for 
ages), then the process could be:
1. Atomic snapshot of userspace.  Snapshot all struct file's as well.
2. Unmount local filesystems.  Network filesystems probably can't be 
trashed by buggy suspend anyway.
3. Snapshot kernelspace.
4. Suspend happily without worrying about hosing filesystems, since 
they're all unmounted.
5. For extra safety, unmount anything that the suspend process mounted.

-- Shutdown and restart --

6. Mount stuff and load the image, then unmount it (again using the 
in-use FS unmounting).
7. Restore the image and resume kernelspace.
8. Remount local filesystems and reattach all the struct files.
9. Resume userspace.  Start prefetching everything.

This would seem to allow an ordinary program to handle image writing 
with no particular worries about disk access, except that unlinking 
files might confuse userspace (but not the FS) on resume.

Feel free to tell me why this is impossible.  If no one tells me it's 
impossible, I may work on unmounting in-use filesystems and revoking 
fd's in a month when I have more free time.


--Andy
