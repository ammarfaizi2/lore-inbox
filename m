Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964890AbWJIVx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964890AbWJIVx3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 17:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964892AbWJIVx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 17:53:29 -0400
Received: from mx2.quantum.com ([146.174.252.112]:12767 "EHLO mx2.quantum.com")
	by vger.kernel.org with ESMTP id S964889AbWJIVx1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 17:53:27 -0400
Message-ID: <452AC4BE.6090905@xfs.org>
Date: Mon, 09 Oct 2006 16:53:02 -0500
From: Steve Lord <lord@xfs.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
       linux-kernel@vger.kernel.org, xfs@oss.sgi.com
Subject: Re: Directories > 2GB
References: <20061004165655.GD22010@schatzie.adilger.int>
In-Reply-To: <20061004165655.GD22010@schatzie.adilger.int>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Oct 2006 21:53:04.0003 (UTC) FILETIME=[4BE9D530:01C6EBED]
X-Spam-Score: 0.00%
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> For ext4 we are exploring the possibility of directories being larger
> than 2GB in size.  For ext3/ext4 the 2GB limit is about 50M files, and
> the 2-level htree limit is about 25M files (this is a kernel code and not
> disk format limit).
> 
> Amusingly (or not) some users of very large filesystems hit this limit
> with their HPC batch jobs because they have 10,000 or 128,000 processes
> creating files in a directory on an hourly basis (job restart files,
> data dumps for visualization, etc) and it is not always easy to change
> the apps.
> 
> My question (esp. for XFS folks) is if anyone has looked at this problem
> before, and what kind of problems they might have hit in userspace and in
> the kernel due to "large" directory sizes (i.e. > 2GB).  It appears at
> first glance that 64-bit systems will do OK because off_t is a long
> (for telldir output), but that 32-bit systems would need to use O_LARGEFILE
> when opening the file in order to be able to read the full directory
> contents.  It might also be possible to return -EFBIG only in the case
> that telldir is used beyond 2GB (the LFS spec doesn't really talk about
> large directories at all).
> 

My first thought is to run screaming for the hills when user's want this.
In a previous life we had a customer in the US Gov who decided to
put all their 700 million files in one directory. Then they had a
double disk unreported raid failure (raid vendors fault). The
filesystem repair ran for 7 days and a heck of a lot of files
ended up in lost+found. Fortunately they had the huge amount of
memory and process address space available to run repair.

Anyone who does this and has any sense does not allow any sort of
scanning of the namespace (i.e. anything using readdir). You tend
to run out of process address space before you have read the
directory.

You might want to think about keeping the directory a little
more contiguous than individual disk blocks. XFS does have
code in it to allocate the directory in chunks larger than
a single file system block. It does not get used on linux
because the code was written under the assumption you can
see the whole chunk as a single piece of memory which does not
work to well in the linux kernel.

Steve
