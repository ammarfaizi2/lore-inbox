Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262244AbULRAdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262244AbULRAdW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 19:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262362AbULRAdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 19:33:22 -0500
Received: from mpc-26.sohonet.co.uk ([193.203.82.251]:53434 "EHLO
	moving-picture.com") by vger.kernel.org with ESMTP id S262244AbULRAcw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 19:32:52 -0500
Message-ID: <41C37AB6.10906@moving-picture.com>
Date: Sat, 18 Dec 2004 00:32:54 +0000
From: James Pearson <james-p@moving-picture.com>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.7.2) Gecko/20040804 Netscape/7.2 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Reducing inode cache usage on 2.4?
References: <41C316BC.1020909@moving-picture.com> <20041217151228.GA17650@logos.cnet>
In-Reply-To: <20041217151228.GA17650@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Disclaimer: This email and any attachments are confidential, may be legally
X-Disclaimer: privileged and intended solely for the use of addressee. If you
X-Disclaimer: are not the intended recipient of this message, any disclosure,
X-Disclaimer: copying, distribution or any action taken in reliance on it is
X-Disclaimer: strictly prohibited and may be unlawful. If you have received
X-Disclaimer: this message in error, please notify the sender and delete all
X-Disclaimer: copies from your system.
X-Disclaimer: 
X-Disclaimer: Email may be susceptible to data corruption, interception and
X-Disclaimer: unauthorised amendment, and we do not accept liability for any
X-Disclaimer: such corruption, interception or amendment or the consequences
X-Disclaimer: thereof.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> 
>>Or am I looking in completely the wrong place i.e. the inode cache is 
>>not the problem?
> 
> 
> No, in your case the extreme inode/dcache sizes indeed seem to be a problem. 
> 
> The default kernel shrinking ratio can be tuned for enhanced reclaim efficiency.
> 
> 
>>xfs_inode         931428 931428    408 103492 103492    1 :  124   62
>>dentry_cache      499222 518850    128 17295 17295    1 :  252  126
> 
> 
> vm_vfs_scan_ratio:
> ------------------
> is what proportion of the VFS queues we will scan in one go.
> A value of 6 for vm_vfs_scan_ratio implies that 1/6th of the
> unused-inode, dentry and dquot caches will be freed during a
> normal aging round.
> Big fileservers (NFS, SMB etc.) probably want to set this
> value to 3 or 2.
> 
> The default value is 6.
> =============================================================
> 
> Tune /proc/sys/vm/vm_vfs_scan_ratio increasing the value to 10 and so on and 
> examine the results.

Thanks for the info - but doesn't increasing the value of 
vm_vfs_scan_ratio mean that less of the caches will be freed?

Doing a few tests (on another test file system with 2 million or so 
files and 1Gb of memory) running 'find $disk -type f', with 
vm_vfs_scan_ratio set to 6 (or 10), the first two column values for 
xfs_inode, linvfs_icache and dentry_cache in /proc/slabinfo reach about 
900000 and stay around that value, but setting vm_vfs_scan_ratio to 1, 
then each value still reaches 900000, but then falls to a few thousand 
and increases up to 900000 and then drop away again and repeats.

This still happens when I cat many large files (100Mb) to /dev/null at 
the same time as running the find i.e. the inode caches can still reach 
90% of the memory before being reclaimed (with vm_vfs_scan_ratio set to 1).

If I stop the find process when the inode caches reach about 90% of the 
memory, and then start cat'ing the large files, it appears the inode 
caches are never reclaimed (or longer than it takes to cat 100Gb of data 
to /dev/null) - is this expected behaviour?

It seems the inode cache has priority over cached file data.

What triggers the 'normal ageing round'? Is it possible to trigger this 
earlier (at a lower memory usage), or give a higher priority to cached data?

Thanks

James Pearson

