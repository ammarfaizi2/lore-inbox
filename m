Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311834AbSDNIlC>; Sun, 14 Apr 2002 04:41:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311839AbSDNIlB>; Sun, 14 Apr 2002 04:41:01 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:30995 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S311834AbSDNIlB>;
	Sun, 14 Apr 2002 04:41:01 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Chris Wedgwood <cw@f00f.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zerocopy NFS updated 
In-Reply-To: Your message of "Sun, 14 Apr 2002 01:19:46 MST."
             <20020414081946.GA862@tapu.f00f.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 14 Apr 2002 18:40:45 +1000
Message-ID: <1535.1018773645@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Apr 2002 01:19:46 -0700, 
Chris Wedgwood <cw@f00f.org> wrote:
>On Sun, Apr 14, 2002 at 10:07:56AM +1000, Keith Owens wrote:
>
>    Write in append mode must be atomic in the kernel.  Whether a user
>    space write in append mode is atomic or not depends on how many
>    write() syscalls it takes to pass the data into the kernel.  Each
>    write() append will be atomic but multiple writes can be
>    interleaved.
>
>Up to what size?  I assume I cannot assume O_APPEND atomicity for
>(say) 100M writes?

Atomic on that inode, not atomic wrt other I/O to other inodes.  Most
write operations use generic_file_write() which grabs the inode semaphore.
No other writes (or indeed any other I/O) can proceed on the inode
until this write completes and releases the semaphore.

I suppose that some filesystem could use its own write method that
releases the lock during the write operation.  I would not trust my
data to such filesystems, they violate SUSV2.

  "If the O_APPEND flag of the file status flags is set, the file
  offset shall be set to the end of the file prior to each write and no
  intervening file modification operation shall occur between changing
  the file offset and the write operation"

