Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbUAZLuq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 06:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbUAZLuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 06:50:46 -0500
Received: from kluizenaar.xs4all.nl ([213.84.184.247]:11393 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S261965AbUAZLup (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 06:50:45 -0500
Message-ID: <4014FF00.1020106@samwel.tk>
Date: Mon, 26 Jan 2004 12:50:24 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: felix-kernel@fefe.de, linux-kernel@vger.kernel.org
Subject: Re: Request: I/O request recording
References: <20040124181026.GA22100@codeblau.de>	<20040124153551.24e74f63.akpm@osdl.org>	<40144A36.5090709@samwel.tk>	<20040125150914.1583d487.akpm@osdl.org>	<4014516D.5070409@samwel.tk> <20040125153803.4d7e1015.akpm@osdl.org>
In-Reply-To: <20040125153803.4d7e1015.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: bart@samwel.tk
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Bart Samwel <bart@samwel.tk> wrote:
> 
>>>Linux caches disk data on a per-file basis.  So if you preload pagecache
>>>via the /dev/hda1 "file", that is of no benefit to the /etc/passwd file. 
>>>Each one has its own unique pagecache.  When reading pages for /etc/passwd
>>>we don't go looking for the same disk blocks in the cache of /dev/hda1.
>>>
>>>Which is why the userspace cache preloading needs to know the pathnames of
>>>all the relevant files - it needs to open and read each one, applying
>>>knowledge of disk layout while doing it.
>>
>>Hmmm, that explains why this didn't work. :( So if I wanted to do this 
>>completely from user space using only block_dump data I'd probably have 
>>to go through all files and find out if they had any blocks in common 
>>with my preload set -- presuming there is a way to find that out, which 
>>there probably isn't. That  makes this idea pretty much useless, I'm 
>>sorry to have bothered you with it.
> 
> You could certainly do that.  Given disk block #N you need to search all
> files on the disk asking "who owns this block".  The FIBMAP ioctl can be
> used on most filesystems (ext2, ext3, others..) to find out which blocks a
> file is using.   See bmap.c in
> 
> http://www.zip.com.au/~akpm/linux/patches/stuff/ext3-tools.tar.gz
> 
> Unfortunately you cannot determine a directory's blocks in this way. 
> Ext3's directories live in the /dev/hda1 pagecache anyway.  ext2's
> directories each have their own pagecache.

I found out two things while trying to do this:

1. Many filesystems in linux set f_fsid to zero for statfs. I was trying 
to use this to skip over mount points, but that doesn't work. Had to use 
the st_dev field from stat instead. :(

2. Swapfiles apparently don't like to be touched. I did an 
ioctl(FIGETBSZ) on a swapfile, and it would simply block until I did a 
swapoff on the file. I didn't even get to the FIBMAP part. :( Is this 
correct behaviour? And is there any way to detect this so that I can 
work around it?

-- Bart
