Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314027AbSDKLnd>; Thu, 11 Apr 2002 07:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314028AbSDKLnc>; Thu, 11 Apr 2002 07:43:32 -0400
Received: from pizda.ninka.net ([216.101.162.242]:30932 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S314027AbSDKLnb>;
	Thu, 11 Apr 2002 07:43:31 -0400
Date: Thu, 11 Apr 2002 04:36:14 -0700 (PDT)
Message-Id: <20020411.043614.02328218.davem@redhat.com>
To: taka@valinux.co.jp
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zerocopy NFS updated
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020411.203823.67879801.taka@valinux.co.jp>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Hirokazu Takahashi <taka@valinux.co.jp>
   Date: Thu, 11 Apr 2002 20:38:23 +0900 (JST)

   Hmmm... If I'd implement them.....
   How about following codes ?
   
   nfsd read()
   {
   	   :
       page_cache_get(page);
       if (page is mapped to anywhere)
           page = duplicate_and_rehash(page);
       else {
           page_lock(page);
   	page->flags |= COW;
   	page_unlock(page);
       }
       sendpage(page);
       page_cache_release(page);
   }
   
What if a process mmap's the page between duplicate_and_rehash and the
card actually getting the data?

This is hopeless.  The whole COW idea is 1) expensive 2) complex to
implement.

This is why we don't implement sendfile with anything other than a
simple page reference.  Otherwise the overhead and complexity is
unacceptable.

No, you must block truncate operations on the file until the client
ACK's the nfsd read request if you wish to use sendfile() with
nfsd.
