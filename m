Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261361AbVELJVI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbVELJVI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 05:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbVELJVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 05:21:07 -0400
Received: from gw.exalead.com ([212.234.111.157]:1188 "EHLO exalead.com")
	by vger.kernel.org with ESMTP id S261361AbVELJUv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 05:20:51 -0400
Message-ID: <42831F85.1000208@exalead.com>
Date: Thu, 12 May 2005 11:19:01 +0200
From: Xavier Roche <roche+kml2@exalead.com>
Organization: Exalead
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.7) Gecko/20050414
X-Accept-Language: fr, en-us, en, ja
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [XFS] Kernel (2.6.11) deadlock (kernel hang) in user mode when
 writing data through mmap on large files (64-bit systems)
References: <427F6310.9020709@exalead.com> <4280D292.2030509@exalead.com> <20050510170129.GA1320@infradead.org>
In-Reply-To: <20050510170129.GA1320@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Christoph Hellwig wrote:
> This is a known problem, or rather two of them:
>  1) when dirtying lots of memory via mmap writeout happens pretty randmomly
>     inside the file and the filesystem has problems creating nice clusters.
>     In the case of extent based filesystems that's really bad as the extent
>     map is fragmented now
>  2) XFS keeps each inode's extent map in one single memory block.

It seems that the file was really *badly* fragmented. The reason, as far 
as we understand the problem, was:

- a file "truncated" to _expand_ its size (using ftruncate() with a size 
MUCH larger that the current size, which is == 0), leading to create a 
"big sparse file" area
- sequential write in this file (_NOT_ random) using the corresponding 
mmapp'ed data segment
- random (!) flush from kswapd leading to allocate fragmented pages 
(sparse file)

The file appears to have over one million fragments:

$ xfs_bmap ./data | wc -l
1051397

$ xfs_bmap ./data | head -n 20
./data:
         0: [0..7]: 15103824..15103831
         1: [8..15]: 15103840..15103847
         2: [16..23]: 15103856..15103863
         3: [24..31]: 15103872..15103879
         4: [32..39]: 15103888..15103895
         5: [40..47]: 15103904..15103911
         6: [48..55]: 15103920..15103927
         7: [56..63]: 15103936..15103943
         8: [64..71]: 15103952..15103959
         9: [72..79]: 15103968..15103975
         10: [80..87]: 15104104..15104111
         11: [88..95]: 15104120..15104127
         12: [96..103]: 15104136..15104143
         13: [104..111]: 15104152..15104159
         14: [112..119]: 15104168..15104175
         15: [120..127]: 15104184..15104191
         16: [128..135]: 15104200..15104207
         17: [136..143]: 15104216..15104223
         18: [144..151]: 15104232..15104239
..

> You're seeing allocation errors where we are trying to realloc that memory
> block.
> Could you try the patches that Nikita posted to -mm that should improve
> this behaviour?

Well, the reasons seems to clearly be this anormal number fo fragments - 
is there any potential solution (in the kernel/mm), or the olny solution 
is a patch to ensure that ftruncate() is replaced by regulars 
fwrite()-zero calls ?



