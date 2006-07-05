Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964873AbWGEOEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964873AbWGEOEV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 10:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbWGEOEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 10:04:21 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:58120 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S964873AbWGEOEU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 10:04:20 -0400
Message-ID: <44ABC6E1.7050200@argo.co.il>
Date: Wed, 05 Jul 2006 17:04:17 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Theodore Tso <tytso@mit.edu>
CC: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: ext4 features
References: <20060704010240.GD6317@thunk.org>
In-Reply-To: <20060704010240.GD6317@thunk.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Jul 2006 14:04:18.0897 (UTC) FILETIME=[E8633C10:01C6A03B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso wrote:
>
> could argue that such a stupid student doesnt *deserve* to get a 
> Ph.D.  :-)
>
> >         * and snapshots on filesystem basis
>
> This requires a filesystem that is designed from the get-go to support
> snapshots.  So yes, it's lilely not going to happen for ext4.
> Although, if you have a really clever idea, feel free to post patches
> or a detailed technical proposal for how to achieve such a goal.  :-)
>

To take a snapshot of a file, copy its inode to a free inode (call it a 
frozen inode, or finode). The inode is at the head of a linked list of 
finodes, each older than its predecessor.

Finodes have the same content as the inode they were clones from except 
the extent map. A new finode's extent map contains a single extent the 
size of the entire file with a flag that means "look in the nearest 
future finode (or inode)".

When writing to a file, first look at the nearest finode's mapping for 
that range. If it has a normal extent, go ahead and write. If it has a 
future extent for that range, first transfer that extent to the finode 
(replacing the future extent), then write the data to newly allocated 
extents. Of course this process can break up extents. One can choose 
whether to transfer the block pointers or just the data; a tradeoff of 
additional data copying vs. fragmentation avoidance.

When reading from a finode, if you're reading a normal extent, proceed 
normally. If you encounter a future extent, keep searching for the range 
in newer finodes until you encounter a normal extent or the base inode.

To snapshot the entire filesystem, have a snapshot generation count in 
the superblock and in each inode. Incrementing the superblock generation 
count snapshots the filesystem. Whenever you write to a file, if its 
generation number lags the filesystem generation number, you take a file 
snapshot as outlined above.

Directories are handled in the same way as files, although special care 
is necessary for inode reference counts.

Deleting a snapshots means merging the preceding and next finodes' 
extent maps and freeing blocks. We'd need a linked list of all finodes 
belonging to a snapshot generation.



-- 
error compiling committee.c: too many arguments to function

