Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263413AbUFNQ5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263413AbUFNQ5u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 12:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263415AbUFNQ5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 12:57:50 -0400
Received: from [209.195.52.121] ([209.195.52.121]:55193 "HELO
	warden2b.diginsite.com") by vger.kernel.org with SMTP
	id S263413AbUFNQ5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 12:57:47 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Cesar Eduardo Barros <cesarb@nitnet.com.br>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Alexander Viro <viro@math.psu.edu>
Date: Mon, 14 Jun 2004 09:57:11 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: [PATCH] O_NOATIME support
In-Reply-To: <20040614134652.GA1961@flower.home.cesarb.net>
Message-ID: <Pine.LNX.4.60.0406140954210.30433@dlang.diginsite.com>
References: <20040612011129.GD1967@flower.home.cesarb.net>
 <20040614095529.GA11563@infradead.org> <20040614134652.GA1961@flower.home.cesarb.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jun 2004, Cesar Eduardo Barros wrote:
> On Mon, Jun 14, 2004 at 10:55:29AM +0100, Christoph Hellwig wrote:
>> On Fri, Jun 11, 2004 at 10:11:29PM -0300, Cesar Eduardo Barros wrote:
>>> (not subscribed to lkml, please CC: me on replies)
>>>
>>> This patch adds support for the O_NOATIME open flag (GNU extension):
>>>
>>> int O_NOATIME  	Macro
>>>   If this bit is set, read will not update the access time of the file.
>>>   See File Times. This is used by programs that do backups, so that
>>>   backing a file up does not count as reading it. Only the owner of the
>>>   file or the superuser may use this bit.
>>>
>>> It is useful if you want to do something with the file atime (for
>>> instance, moving files that have not been accessed in a while to
>>> somewhere else, or something like Debian's popularity-contest) but you
>>> also want to read all files periodically (for instance, tripwire or
>>> debsums).
>>>
>>> Currently, the program that reads all files periodically has to use
>>> utimes, which can race with the atime update:
>>
>> Any chance we could change the flag to also not update mtime and ctime
>> for updates on a fd opened with it (and renaming it to O_INVISIBLE for
>> example).  That's needed for your above moving infrequently used files
>> away scenario (aka a HSM)
>
> I don't see why preserving the mtime and ctime would be necessary, since
> to move a file away you either don't touch it (using rename) or only
> read and unlink it (to write to a tape or other filesystem, and you can
> save the atime and mtime while doing it). So O_NOATIME is enough for
> both behaviours.
>
> Besides, O_NOATIME is most important not for the program that's moving
> the files elsewhere, but for these checksum-the-world utilities that
> read every single file they can see, and in the process manage to
> destroy the usefulness of the atime, or backup programs that also read
> everything they can touch. Both currently have to use utimes after
> reading the whole file to restore the atime it had when they began
> reading, which can take a long time if the file is huge (but note that
> the mtime doesn't change since they are all reading, not writing).
>
> The ctime changing is not a problem, since programs that want to move
> infrequently used files away will use only the atime and mtime to make
> their decisions, not the ctime. Also, wouldn't not changing the atime
> make the ctime not change too, since nothing in the inode has changed?
>
> O_NOATIME would also be useful for things like tar --atime-preserve,
> cpio --reset-access-time, star -atime, pax -t, and others.

This sounds like the same catagory of use that does a single pass through 
the data and is destroying our memory useage. should this flag also imply 
that the data gets thrown away immediatly after being freed by the 
program?

that way you don't have to worry if the software reads the data once or 
ten times, as long as it doesn't go back to it after it has freed it.

David Lang

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
