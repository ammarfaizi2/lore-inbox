Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314009AbSDKGzi>; Thu, 11 Apr 2002 02:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314010AbSDKGzh>; Thu, 11 Apr 2002 02:55:37 -0400
Received: from pizda.ninka.net ([216.101.162.242]:29906 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S314009AbSDKGzh>;
	Thu, 11 Apr 2002 02:55:37 -0400
Date: Wed, 10 Apr 2002 23:48:21 -0700 (PDT)
Message-Id: <20020410.234821.122842406.davem@redhat.com>
To: taka@valinux.co.jp
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zerocopy NFS updated
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020411.154651.51706443.taka@valinux.co.jp>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Hirokazu Takahashi <taka@valinux.co.jp>
   Date: Thu, 11 Apr 2002 15:46:51 +0900 (JST)

   Please consider a knfsd sends data of File A by useing sendmsg().
     1. The knfsd copies the data of File A into sk_buff.
     2. File A may be truncated after step.1
     3. NFS clients receives the packets of File A which is already truncated.
   
   Next please consider the knfsd sends data of File A by useing sendpage().
     1. The knfsd grabs pages of File A. (page_cache_get)
     2. File A may be truncated after step.1
     3. The knfsd send the pages.
     4. NFS clients receives the packets of File A which is already truncated.
   
   Is there any differences between them ?
   This behavior is invisible to NFS Clients, I think.

Consider truncate() to 1 byte left in that page.  To handle mmap()'s
of this file the kernel will memset() rest of the page to zero.

Now, in the sendfile() case the NFS client sees some page filled
mostly of zeros instead of file contents.

In sendmsg() knfd case, client sees something reasonable.  He will
see something that was actually in the file at some point in time.
The sendfile() case sees pure garbage, contents that never were in
the file at any point in time.

We could make knfsd take the write semaphore on the inode until client
is known to get the packet but that is the kind of overhead we'd like
to avoid.
