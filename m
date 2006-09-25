Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbWIYUGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWIYUGH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 16:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbWIYUGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 16:06:07 -0400
Received: from iriserv.iradimed.com ([69.44.168.233]:55685 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1750794AbWIYUGF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 16:06:05 -0400
Message-ID: <451836CC.2010003@cfl.rr.com>
Date: Mon, 25 Sep 2006 16:06:36 -0400
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: =?ISO-8859-1?Q?T=F6r=F6k_Edvin?= <edwintorok@gmail.com>
CC: linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH][RFC] Rearranging files to improve disk performanc
References: <4354d3270609231211r6b9227fdhb88a6dc8822fc803@mail.gmail.com>
In-Reply-To: <4354d3270609231211r6b9227fdhb88a6dc8822fc803@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 25 Sep 2006 20:06:16.0396 (UTC) FILETIME=[0EE618C0:01C6E0DE]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14714.000
X-TM-AS-Result: No--28.064800-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This ability is already available at least for ext2/3 in the old defrag 
package, which can take a list of files and priorities to assign to 
them, and it will pack them in the order given at the start of the disk.

As for your idea, if there is going to be online defrag support in the 
kernel ( and yes, this is a form of defragmenting ) I'd rather see the 
ability to move files around deterministically rather than just give a 
hint and pray, similar to how windows handles online defragmenting.

Török Edvin wrote:
> Hello,
> 
> I am trying to implement a feature in the kernel to allow rearranging
> files on the disk in order to improve performance.
> The purpose is to reduce seeks. Before you say:"we don't need
> defragmenting", note that this is _not_ defragmenting.
> 
> This is what I want to accomplish:
> - a userspace program determines in what order are files accessed
> (during boot, startup, etc.), and generates a list of files that are
> always accessed
> in a certain order
> - rearranging these files to be one-after-another will improve disk
> performance (it won't have to seek forward/backward)
> 
> This is how I suggest to implement it:
> - a userspace program gives a 'hint' to the kernel where  certain
> files should be placed
> [it opens the file, sends the kernel a hint, copies the file to a temp
> storage, truncates, and rewrites file: thus the file will end up in a
> new location]
> - when the kernel allocates space for inodes, it first verifies if
> there is a 'hint' for that inode, if there is, it tries to honor it
> - there has to be a way to communicate between kernel/userspace the
> following: userspace->kernel: which file should be placed where,
> kernel->userspace: if it managed to honor userspace hints or not
> 
> 
> The following questions came up while developing this:
> - what exactly should the 'hint' contain (I chose: inode, device, disk
> location, size)
> - how should the userspace program communicate with the kernel? (I
> chose sysfs for now)
> - if sysfs is going to be used, in which directory should files be put?
> - should the kernel also preallocate space when receiving a hint
> - how should errors be reported? (sysfs?)
> - where is the appropriate place to put this stuff? (fs/relayout.c?)
> - how can the implementation be as generic as possible (have as much
> fs-independent code as possible)
> - what can we do if there isn't enough contigous free disk space
> available for moving the file (risk fragmenting the file?)
> - is somebody else currently trying to implement a similar feature?
> 
> The patch below also contains a sample of how the relayout functions
> could be used, in this case for reiserfs. (I intend to have support
> for at least
> ext3, and xfs too, but of course ideal would be if all fs-s would 
> support this)
> 
> 
> I am sending this patch (a draft), and waiting for your feedback on it
> (and on my questions above), before going any further.
> 
<snip>
