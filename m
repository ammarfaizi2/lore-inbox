Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751909AbWJJCPh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909AbWJJCPh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 22:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751979AbWJJCPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 22:15:37 -0400
Received: from relay04.roc.ny.frontiernet.net ([66.133.182.167]:37058 "EHLO
	relay04.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S1751316AbWJJCPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 22:15:36 -0400
X-Trace: 53616c7465645f5f50e6a3e1e0bc0a4428f87adc22a08f5675be8ec0086993b6e89418c207721a33086e2d0840802b1538eb98f8361361aa4413473ed1c99eb613963e4acbff7f47361ade957c3ac4b6a4d4b15a863af9b35f77f07093694540
Message-ID: <452B0240.60203@xfs.org>
Date: Mon, 09 Oct 2006 21:15:28 -0500
From: Steve Lord <lord@xfs.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: David Chinner <dgc@sgi.com>
CC: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
       linux-kernel@vger.kernel.org, xfs@oss.sgi.com
Subject: Re: Directories > 2GB
References: <20061004165655.GD22010@schatzie.adilger.int> <452AC4BE.6090905@xfs.org> <20061010015512.GQ11034@melbourne.sgi.com>
In-Reply-To: <20061010015512.GQ11034@melbourne.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

My recollection is that it used to default to on, it was disabled
because it needs to map the buffer into a single contiguous chunk
of kernel memory. This was placing a lot of pressure on the memory
remapping code, so we made it not default to on as reworking the
code to deal with non contig memory was looking like a major
effort.

Steve


David Chinner wrote:
> On Mon, Oct 09, 2006 at 04:53:02PM -0500, Steve Lord wrote:
>> You might want to think about keeping the directory a little
>> more contiguous than individual disk blocks. XFS does have
>> code in it to allocate the directory in chunks larger than
>> a single file system block. It does not get used on linux
>> because the code was written under the assumption you can
>> see the whole chunk as a single piece of memory which does not
>> work to well in the linux kernel.
> 
> This code is enabled and seems to work in Linux. I don't know if it
> passes xfsqa  so I don't know how reliable this feature is. TO check
> it all I did was run a quick test on a x86_64 kernel (4k page
> size) using 16k directory blocks (4 pages):



> 
> # mkfs.xfs -f -n size=16384 /dev/ubd/1
> .....
> # xfs_db -r -c "sb 0" -c "p dirblklog" /dev/ubd/1
> dirblklog = 2
> # mount /dev/ubd/1 /mnt/xfs
> # for i in `seq 0 1 100000`; do touch fred.$i; done
> # umount /mnt/xfs
> # mount /mnt/xfs
> # ls /mnt/xfs |wc -l
> 100000
> # rm -rf /mnt/xfs/*
> # ls /mnt/xfs |wc -l
> 0
> # umount /mnt/xfs
> #
> 
> Cheers,
> 
> Dave.

