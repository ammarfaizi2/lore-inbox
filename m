Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264755AbSLJUnl>; Tue, 10 Dec 2002 15:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264795AbSLJUnl>; Tue, 10 Dec 2002 15:43:41 -0500
Received: from pizda.ninka.net ([216.101.162.242]:44697 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264755AbSLJUnj>;
	Tue, 10 Dec 2002 15:43:39 -0500
Date: Tue, 10 Dec 2002 12:47:40 -0800 (PST)
Message-Id: <20021210.124740.86261163.davem@redhat.com>
To: raul@pleyades.net
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: [BK-2.4] [PATCH] Small do_mmap_pgoff correction
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021210204530.GA63@DervishD>
References: <200212101931.gBAJV1K10639@hera.kernel.org>
	<20021210.121908.00373632.davem@redhat.com>
	<20021210204530.GA63@DervishD>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: DervishD <raul@pleyades.net>
   Date: Tue, 10 Dec 2002 21:45:30 +0100

       Hi David :)
   
   >    + *	NOTE: in this function we rely on TASK_SIZE being lower than
   >    + *	SIZE_MAX-PAGE_SIZE at least. I'm pretty sure that it is.
   > This assumption is wrong.
   
       OK, then another way of fixing the corner case that exists in
   do_mmap_pgoff is needed. You cannot mmap a chunk of memory whose size
   is bigger than SIZE_MAX-PAGE_SIZE, because 'PAGE_ALIGN' will return 0
   when page-aligning the size.
   
And after your patch, we'd use a zero length.  That is a bug.

       Anyway you cannot use a size larger than SIZE_MAX-PAGE_SIZE even
   on sparc64, since mmap will fail when page aligning such a size,
   returning 0 :((( Reverting the change is worse (IMHO).
   
This is wrong.

I said that the address space can be this huge size.  I didn't
say that this means such a huge single mmap() could work.

It makes that your assumption that allows for the code change
you made is invalid.

       if ((len = PAGE_ALIGN(len)) == 0)
   
       and this returns 0 if the requested size ('len', here) is between
   SIZE_MAX-PAGE_SIZE and SIZE_MAX. And this is wrong.

And your change causes us to use a len of "zero" in this case, how is
that more valid?

Look at what happens, you PAGE_ALIGN(len) after all the range checks
then we use a len of '0' for the rest of the function.  How is that
supposed to be better?
