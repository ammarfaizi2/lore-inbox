Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267621AbRHWRXB>; Thu, 23 Aug 2001 13:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269067AbRHWRWv>; Thu, 23 Aug 2001 13:22:51 -0400
Received: from cmailg6.svr.pol.co.uk ([195.92.195.176]:38224 "EHLO
	cmailg6.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S267621AbRHWRWj>; Thu, 23 Aug 2001 13:22:39 -0400
Message-ID: <3B853BE6.3010703@humboldt.co.uk>
Date: Thu, 23 Aug 2001 18:22:46 +0100
From: Adrian Cox <adrian@humboldt.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2+) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: Filling holes in ext2
In-Reply-To: <3B83E9FD.6020801@humboldt.co.uk> <3B83FB3F.A0BDC056@zip.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> It matters.  -ac kernels handle this by clearing out the blocks
> on the error path in __block_prepare_write().  If you retest with
> -ac kernels, you should just see zeroes.

That doesn't help. The problem occurs just the same on -ac kernels.

In this case __block_prepare_write() is successful. What happens is that 
if __copy_from_user() fails, the block remains mapped but not up to 
date. Thus the next read access to the file fetches the garbage data off 
disk, and presents it to the user.

The only definitive solutions I can see are:
1) implement an abort_write() method for every filesystem that uses 
block_prepare_write()
2) redefine commit_write() to be called on failure as well as success.
3) lock the pages corresponding to the user buffer so that 
__copy_from_user() cannot fail.

I like the latter option, as it removes this abort case for ext3 and 
could drastically simplify GFS.

-- 
Adrian Cox

