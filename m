Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313330AbSDLMaY>; Fri, 12 Apr 2002 08:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313452AbSDLMaX>; Fri, 12 Apr 2002 08:30:23 -0400
Received: from sv1.valinux.co.jp ([202.221.173.100]:13327 "HELO
	sv1.valinux.co.jp") by vger.kernel.org with SMTP id <S313330AbSDLMaX>;
	Fri, 12 Apr 2002 08:30:23 -0400
Date: Fri, 12 Apr 2002 21:30:11 +0900 (JST)
Message-Id: <20020412.213011.45159995.taka@valinux.co.jp>
To: davem@redhat.com
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zerocopy NFS updated
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20020410.234821.122842406.davem@redhat.com>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I wondered if regular truncate() and read() might have the same
problem, so I tested again and again.
And I realized it will occur on any local filesystems.
Sometime I could get partly zero filled data instead of file contents.

I analysis this situation, read systemcall doesn't lock anything
 -- no page lock, no semaphore lock --  while someone truncates
files partially. 
It will often happens in case of pagefault in copy_user() to
copy file data to user space.

I guess if needed, it should be fixed in VFS.

davem> Consider truncate() to 1 byte left in that page.  To handle mmap()'s
davem> of this file the kernel will memset() rest of the page to zero.
davem> 
davem> Now, in the sendfile() case the NFS client sees some page filled
davem> mostly of zeros instead of file contents.
davem> 
davem> In sendmsg() knfd case, client sees something reasonable.  He will
davem> see something that was actually in the file at some point in time.
davem> The sendfile() case sees pure garbage, contents that never were in
davem> the file at any point in time.
davem> 
davem> We could make knfsd take the write semaphore on the inode until client
davem> is known to get the packet but that is the kind of overhead we'd like
davem> to avoid.

Thank you,
Hirokazu Takahashi.

