Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030220AbWFISlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030220AbWFISlG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 14:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030301AbWFISlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 14:41:06 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:57236 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030220AbWFISlE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 14:41:04 -0400
Message-ID: <4489C0B8.7050400@garzik.org>
Date: Fri, 09 Jun 2006 14:40:56 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Andreas Dilger <adilger@clusterfs.com>
CC: Linus Torvalds <torvalds@osdl.org>, Alex Tomas <alex@clusterfs.com>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com> <4488E1A4.20305@garzik.org> <20060609083523.GQ5964@schatzie.adilger.int> <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org> <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <m33beecntr.fsf@bzzz.home.net> <Pine.LNX.4.64.0606090913390.5498@g5.osdl.org> <Pine.LNX.4.64.0606090933130.5498@g5.osdl.org> <20060609181020.GB5964@schatzie.adilger.int>
In-Reply-To: <20060609181020.GB5964@schatzie.adilger.int>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> Having a single codebase for everyone means that it is continually maintained
> and users of ext3 aren't left out in the cold.

That implies continually upgrading ext3 for newer storage technologies, 
which in turn implies adding all sorts of incompatible formats to 
support better storage scaling, and new usage models.

This constant patching of ext3 is IMO one of the problems.  Let it 
stabilize with current storage technologies.


> On Jun 09, 2006  09:54 -0700, Linus Torvalds wrote:
>> Btw, I'm not kidding you on this one.
>>
>> THE NUMBER ONE MEMORY USAGE ON A LOT OF LOADS IS EXT3 INODES IN MEMORY!
> 
> Do you think that would be any different with a new filesystem?
> 
>> And you know what? 2TB files are totally uninteresting to 99.9999% of all 
>> people. Most people find it _much_ more interesting to have hundreds of 
>> thousands of _smaller_ files instead.
>>
>> So do this:
>>
>> 	cat /proc/slabinfo | grep ext3
> 
> # head -2 /proc/slabinfo
> slabinfo - version: 2.1
> name       <active_objs> <num_objs> <objsize> <objperslab>
> 
> # grep ext2 /proc/slabinfo
> ext2_inode_cache       0          0       572            7
> ext2_xattr             0          0        48           81
> 
> # grep ext3 /proc/slabinfo
> 
> ext3_inode_cache   30207      41418       616            6
> ext3_xattr             0          0        48           81
> 
> # grep xfs /proc/slabinfo
> xfs_ili             2558       2576       140           28
> xfs_inode           2558       2565       448            9
> 
> # grep jfs /proc/slabinfo
> jfs_ip                 0          0      1048            3
> 
> So, the ext3 inode could grow another ~50 bytes without changing the
> slab allocation size ;-), and in fact other filesystem aren't noticably
> different.
> 
>> and be absolutely disgusted and horrified by the size of those inodes 
>> already, and ask yourself whether extending the block size to 48 bits will 
>> help or further hurt one of the biggest problems of ext3 right now?
> 
> This is then the biggest problem of all filesystems.
> 
>> (And yes, I realize that block numbers are just a small part of it. The 
>> "vfs_inode" is also a real problem - it's got _way_ too many large 
>> list-heads that explode on a 64-bit kernel, for example. Oh, well.
> 
> On a 32-bit system the vfs_inode is more than half of the size of the ext3
> inode, it is worse on 64-bit systems.
> 
>> My point is that things like this can make a very real issue _worse_ for all 
>> the people who don't care one whit about it)
> 
> The current group of changes will be a no-op if CONFIG_LBD isn't enabled,
> and I think I argued fairly strongly to also have a CONFIG_ flag to allow
> larger than 2TB file support only for those users that want it.
> 
> Cheers, Andreas
> --
> Andreas Dilger
> Principal Software Engineer
> Cluster File Systems, Inc.
> 
> 

