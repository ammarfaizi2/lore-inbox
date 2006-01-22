Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbWAVWoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbWAVWoR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 17:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbWAVWoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 17:44:17 -0500
Received: from smtpout.mac.com ([17.250.248.86]:11994 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932311AbWAVWoQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 17:44:16 -0500
In-Reply-To: <20060122210238.GA28980@thunk.org>
References: <43D3295E.8040702@comcast.net> <20060122093144.GA7127@thunk.org> <43D3D4DF.2000503@comcast.net> <20060122210238.GA28980@thunk.org>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4D75B95E-2595-4B60-91B3-28AD469C3D39@mac.com>
Cc: John Richard Moser <nigelenki@comcast.net>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: soft update vs journaling?
Date: Sun, 22 Jan 2006 17:44:08 -0500
To: "Theodore Ts'o" <tytso@mit.edu>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 22, 2006, at 16:02, Theodore Ts'o wrote:
>> Online resizing is ever safe?  I mean, with on-disk filesystem  
>> layout support I could somewhat believe it for growing; for  
>> shrinking you'd need a way to move files around without damaging  
>> them (possible).  I guess it would be.
>>
>> So how does this work?  Move files -> alter file system superblocks?
>
> The online resizing support in ext3 only grows the filesystems; it  
> doesn't shrink it.  What is currently supported in 2.6 requires you  
> to reserve space in advance.  There is also a slight modification  
> to the ext2/3 filesystem format which is only supported by Linux  
> 2.6 which allows you to grow the filesystem without needing to move  
> filesystem data structures around; the kernel patches for  
> actualling doing this new style of online resizing aren't yet in  
> mainline yet, although they have been posted to ext2-devel for  
> evaluation.

 From my understanding of HFS+/HFSX, this is actually one of the  
nicer bits of that filesystem architecture.  It stores the data- 
structures on-disk using extents in such a way that you probably  
could hot-resize the disk without significant RAM overhead (both grow  
and shrink) as long as there's enough free space.  Essentially, every  
block on the disk is represented by an allocation block, and all data  
structures refer to allocation block offsets.  The allocation file  
bitmap itself is comprised of allocation blocks and mapped by a set  
of extent descriptors.  The result is that it is possible to fragment  
the allocation file, catalog file, and any other on-disk structures  
(with the sole exception of the 1K boot block and the 512-byte volume  
headers at the very start and end of the volume).

At the moment I'm educating myself on the operation of MFS/HFS/HFS+/ 
HFSX and the linux kernel VFS by writing a completely new combined  
hfsx driver, which I eventually plan to add online-resizing support  
and a variety of other features to.

One question though: Does anyone have any good recent references to  
"How to write a blockdev-based Linux Filesystem" docs?  I've searched  
the various crufty corners of the web, Documentation/, etc, and found  
enough to get started, but (for example), I had a hard time  
determining from the various sources what a struct file_system_type  
was supposed to have in it, and what the available default  
address_space/superblock ops are.

Cheers,
Kyle Moffett

--
They _will_ find opposing experts to say it isn't, if you push hard  
enough the wrong way.  Idiots with a PhD aren't hard to buy.
   -- Rob Landley



