Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315445AbSEBWiF>; Thu, 2 May 2002 18:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315448AbSEBWiF>; Thu, 2 May 2002 18:38:05 -0400
Received: from melancholia.rimspace.net ([210.23.138.19]:6160 "EHLO
	melancholia.danann.net") by vger.kernel.org with ESMTP
	id <S315445AbSEBWiD>; Thu, 2 May 2002 18:38:03 -0400
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.12 severe ext3 filesystem corruption warning!
In-Reply-To: <87u1pqln4h.fsf@enki.rimspace.net> <3CD191C5.AC09B1F4@zip.com.au>
From: Daniel Pittman <daniel@rimspace.net>
Organization: Not today, thank you, Mother.
Date: Fri, 03 May 2002 08:37:56 +1000
Message-ID: <87znzi18hn.fsf@enki.rimspace.net>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.5 (bamboo,
 i686-pc-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 May 2002, Andrew Morton wrote:
> Daniel Pittman wrote:
>> 
>> I gave the 2.5.12 kernel a shot on my workstation tonight and found
>> an *extremely* serious ext3 filesystem corrupting behavior.
> 
> A few things..
> 
> Are your other filesystems using journalled data as well?

Yes:

] mount
/dev/discs/disc0/part6 on / type ext3 (rw,data=journal)
none on /proc type proc (rw)
none on /proc/bus/usb type usbdevfs (rw)
/dev/discs/disc0/part7 on /home/daniel type ext3 (rw,data=journal)
none on /proc/sys/fs/binfmt_misc type binfmt_misc (rw)
anu.rimspace.net:/music on /music type nfs (rw,noexec,nosuid,nodev,rsize=8192,wsize=8192,nfsvers=3,bg,soft,addr=210.23.138.21)

> Are you sure that all kernel files were recompiled?  If,
> for example, you had some 2.5.11 objects in the link, that
> would be bad.

Yes. The kernel was build with clean, oldconfig, dep and then building
the image and modules. 

> Do you know whether the bad data is actually on-disk, or
> could it be just in-RAM?  ie: was the data still bad after
> a reboot?

I only found it after the reboot; being the cautious sort I rebooted as
soon as it showed odd data issues, back to the known stable 2.5.6 and
did a full fsck run. That showed no issues, which was nice, but I found
the data corruption.

> What blocksize is that filesystem using?  The output of
> `dumpe2fs -h /dev/whatever' will tell you this.

2k blocks, as I found that 4k was giving me over 40% wasted space last
time I bothered to check. I have most of the files in this filesystem
being ~2K in size.

Full output of the command is attached below.

> Can you please force an fsck against that filesystem,
> see what it says?

I did. The filesystem itself was clean -- not even a warning. Just data
corruption, not metadata.

On Thu, 2 May 2002, Alexander Viro wrote:
> On Thu, 2 May 2002, Andrew Morton wrote:
>> A few things..
>> 
> [snip]
> 
> Andrew, judging by the filenames he'd mentioned, I suspect that he
> runs innd. I.e. one of the very few programs heavily using truncate().

Not quite. I found the corruption in three places:

* my XEmacs and Gnus mail spool.
* gkrellm configuration files.
* galeon/mozilla bookmarks and preferences.

XEmacs uses the mode (O_WRONLY | O_TRUNC) when it writes out files, so
everything that was written there would have been truncated before
output. There shouldn't have been any mmap() of the files, though.

It's also worth noting that XEmacs would fsync() the file handle after
writing the content, for what that's worth.


I found corruption in the galeon bookmarks file, which seemed to start
writing XML half way through the actual data and to add a block of
around 2K NULL bytes half way through the content.

I also found corruption in the mozilla prefs.js file from the same
application[1]. That was simply a truncated file -- no NULL bytes or
anything, just a file that cut off half way through a single expression
like:

user_pref("wallet.capture

This /may/ be the logical break between two write(2) calls or a partly
completed write, though.

> And no, it doesn't promise anything good - last time we had crap in
> truncate/mmap interaction it was a hell to fix.
> 
> I suspect that you had screwed the truncate exclusion warranties up. 
> If _any_ IO happens in the area currently manipulated by ->truncate()
> - you are screwed and results would look pretty much like the things
> mentioned in bug report.

Ick. Er, good luck. I am quite happy to provide more information and
even to install a scratch disk and try to get it to fail the same way if
you wish.

I can't use the same kernel build, though, as I removed the binary
kernel. I can build an equivalent one, of course, but it's not quite the
same. Sorry about that -- I did it before thinking about it. :/

Let me know if there is any more information that would be useful, other
than the corrupted files. I killed those, also, without thinking. :(

        Daniel

Footnotes: 
[1]  Galeon is a GNOME front-end for Mozilla, in case you didn't know.

-- 
The English have the most rigid code of immorality in the world.
        -- Malcom Bradbury, _Eating People is Wrong_
