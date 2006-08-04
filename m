Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030311AbWHDDV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030311AbWHDDV4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 23:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030309AbWHDDV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 23:21:56 -0400
Received: from ns1.soleranetworks.com ([70.103.108.67]:15281 "EHLO
	ns1.soleranetworks.com") by vger.kernel.org with ESMTP
	id S1030306AbWHDDVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 23:21:55 -0400
Message-ID: <44D2BEBE.8030303@wolfmountaingroup.com>
Date: Thu, 03 Aug 2006 21:27:58 -0600
From: "Jeffrey V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Kleikamp <shaggy@austin.ibm.com>
CC: Maarten Maathuis <madman2003@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: heavy file i/o on ext3 filesystem leads to huge	ext3_inode_cache
 and dentry_cache that doesn't return to normal for hours
References: <6d4bc9fc0608030927t175f16c0kfef6a21cc521e368@mail.gmail.com> <1154661560.17180.31.camel@kleikamp.austin.ibm.com>
In-Reply-To: <1154661560.17180.31.camel@kleikamp.austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Kleikamp wrote:

>On Thu, 2006-08-03 at 18:27 +0200, Maarten Maathuis wrote:
>  
>
>>I have a kernel specific problem and this seemed like a suitable place to ask.
>>
>>I would like responces to be CC'ed to me if possible.
>>
>>I use a 2.6.17-ck1 kernel on an amd64 system. I have observed this
>>problem on other/older kernels.
>>
>>Whenever there is serious hard drive activity (such as doing "slocate
>>-u") ext3_inode_cache and dentry_cache grow to a combined 400-500 MiB.
>>    
>>
>
>The behavior of slocate (updatedb) is pretty well-known, but nobody has
>come up with a real solution.
>
>  
>
>>The amount of objects is more than half a million.
>>
>>This will slowly decrease to normal, but will take many hours. It does
>>not result in any OOM, because i have 1 GiB of memory.
>>
>>As far as i understand hard drive cache should not be in the slab. Are
>>these just the inode's, because the amount of memory consumption seems
>>large for that?
>>    
>>
>
>inodes and directory cache entries (dentries).  In general, it's a good
>idea to cache inodes and dentries that have recently been read.  slocate
>is a special case since it will traverse all of the directories and
>never look at them again (until the next time it runs).  The kernel
>doesn't have any idea that it may be a good idea to free those objects.
>
>  
>
>>I have found a way to clear the memory (and unfortunately most of the cache):
>>
>>echo 100 > /proc/sys/vm/nr_hugepages
>>echo 0 > /proc/sys/vm/nr_hugepages
>>    
>>
>
>A better way to clear just the inodes and dentries (that aren't in use)
>is:
>
>echo 2 > /proc/sys/vm/drop_caches
>
>This feature is relatively new.
>
>  
>
>>This suggest the kernel can free this memory. It's not the caching
>>that bothers me, what bothers me is that it seems to reside in the
>>slab.
>>    
>>
>
>I'm not sure why that bothers you.  A more common complaint is that all
>the inodes and dentries being cached push out other pages to swap.
>
>Completely free memory doesn't do the system any good.  The kernel
>attempts to keep as much as possible in cache in case something is
>needed again.  These objects are easily reclaimable, so when more memory
>is needed, they can be freed with very little overhead.
>
>  
>
>>I am not a developer, so please keep that in mind when replying.
>>
>>I hope someone can be of help.
>>
>>Sincerely,
>>
>>Maarten Maathuis.
>>    
>>
>
>Shaggy
>  
>
dcache architecture is one of the big bottlenecks. 

Jeff
