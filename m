Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270131AbRHWTRZ>; Thu, 23 Aug 2001 15:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270133AbRHWTRP>; Thu, 23 Aug 2001 15:17:15 -0400
Received: from cmailg4.svr.pol.co.uk ([195.92.195.174]:38737 "EHLO
	cmailg4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S270131AbRHWTRB>; Thu, 23 Aug 2001 15:17:01 -0400
Message-ID: <3B8556B6.7040700@humboldt.co.uk>
Date: Thu, 23 Aug 2001 20:17:10 +0100
From: Adrian Cox <adrian@humboldt.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2+) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: Filling holes in ext2
In-Reply-To: <3B83E9FD.6020801@humboldt.co.uk> <3B83FB3F.A0BDC056@zip.com.au> <3B853BE6.3010703@humboldt.co.uk> <3B854186.F0C00E3C@zip.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> generic_file_write() will mark the page not up-to-date in this case.
> I wonder what's actually going on?  Perhaps the fact that we've
> instantiated a block in ext2 outside i_size?

The problem is that the on-disk metadata now says that that disk block 
is part of the file. So as the page is not up-to-date, the next read 
operation will go to the disk and fetch that block of garbage into the 
page cache.

> If you change the error path in -ac's generic_file_write() thusly:
> 
> -	goto fail_write;
> +	status = -EFAULT;
> +	goto sync_failure;
> 
> does it fix it?

No difference, as the write is to a hole in the middle of the file, and 
doesn't change i_size.

> Can you send the code you're using to demonstrate this?

The heart of it is this:
fd = open(file, O_CREAT | O_TRUNC | O_RDWR, S_IRUSR | S_IWUSR);
lseek(fd, 16385, SEEK_SET);
write(fd, "x", 1);
lseek(fd, 12345, SEEK_SET);
write(fd, "y", 1);
	
During the final write, I intervene with gdb to force the 
__copy_from_user() to fail. It should be possible to do something 
similar with a multi-threaded application where another thread modifies 
the VM, but I haven't actually built a real example.

Then I just take a look at the file with od.

[usermode:~] od -x /mnt/adrian/test
0000000 0000 0000 0000 0000 0000 0000 0000 0000
*
0030000 0a79 0a79 0a79 0a79 0a79 0a79 0a79 0a79
*
0040000 7800
0040002


-- 
Adrian Cox   http://www.humboldt.co.uk/

