Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273784AbRIRAKF>; Mon, 17 Sep 2001 20:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273782AbRIRAJ4>; Mon, 17 Sep 2001 20:09:56 -0400
Received: from adsl-209-182-168-213.value.net ([209.182.168.213]:16 "EHLO
	draco.foogod.com") by vger.kernel.org with ESMTP id <S273783AbRIRAJp>;
	Mon, 17 Sep 2001 20:09:45 -0400
Message-ID: <3BA69421.6020304@foogod.com>
Date: Mon, 17 Sep 2001 17:24:01 -0700
From: Alex Stewart <alex@foogod.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lazy umount (1/4)
In-Reply-To: <E15ixGu-0006ym-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox [quoting from Matthias Andree] wrote:

>>Well, from a practical point of view two things that would really help
>>Linux:
>>
>>1) Be able kill -9 processes from "D" state.


Please note that there is a reason why the "D" state exists, and it is 
because there are certain times when interrupting a process can have 
significant consequences on the integrity of the entire filesystem (or 
other global resource) and must not be allowed for consistency.  As it 
happens, most of the conditions which cause processes to get "stuck" in 
disk-wait state (usually because of hardware issues) happen to be 
exactly the places where it's most difficult to work around this (at 
least for physically-backed filesystems, less so for NFS et al).

This, I assume, is at least part of the reason why Alan Says:

> Wont happen. 


(and I would tend to agree)

>>2) Force unmount busy file systems and kill -9 all related processes.
>>
> 
> umount -f


...doesn't do anything for non-NFS filesystems, though.  There isn't 
even a hook for it in any of the other FS drivers.

>>down, there is ABSOLUTELY NO WAY of getting rid of the mounts besides
>>losing unrelated data (i. e. unmount in background, killall -9 rpciod -
>>will possibly lose data written to other servers).
>>
> 
> umount -f. 


(for NFS) does work most of the time.  I'm not quite sure why, but in 
some cases I've needed to combine this with mounting things 'intr' so I 
could manually kill processes off.

>>ago, just because it does umount -f and Linux' ever-rising load with
>>stuck processes really annoys me and has brought one of my production
>>machines down more than once. Soft NFS mounts are not really an option.
>>
> 
> The 'D' state stuff is not "load" - it didn't bring your box down, something
> else did.


Well, yes and no.  It's not _CPU_ load, but the stuck processes can 
consume other limited resources (memory, file descriptors, etc) to the 
point that the system is unable to function properly if enough of them 
accumulate.  I have also had this happen.

-alex

