Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262804AbTHZG7f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 02:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263147AbTHZG7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 02:59:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:22441 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262804AbTHZG7d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 02:59:33 -0400
Date: Tue, 26 Aug 2003 00:02:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@redhat.com>
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Futex non-page-pinning fix
Message-Id: <20030826000218.2ceaea1d.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0308260233550.20822-100000@devserv.devel.redhat.com>
References: <20030825231449.7de28ba6.akpm@osdl.org>
	<Pine.LNX.4.44.0308260233550.20822-100000@devserv.devel.redhat.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@redhat.com> wrote:
>
>  > What about the option of not pinning the pages at all: just fault
>  > them in when required?
> 
>  precisely what scheme do you mean by this? There are two important points:  
>  when a thread sleeps on a futex, and when some thread does a wakeup on a
>  futex address. We cannot hash the futex based on the virtual address
>  (arbitrary share-ability of futex pages is another key appeal of them),
>  and if by the time the wakeup happens the physical page goes away how do
>  we find which threads are queued on this address?

I was suggesting that we hash the futex on mm+vaddr.  Yes, differing vaddrs
break that.

umm, how about hashing only on offset into page?  That reduces the number of
threads which need to be visited in futex_wake() by a factor of up to 1024.

In futext_wake(), fault in and pin the page, then for each thread which is
waiting on a futex which has the same offset into a page, do a
get_user_pages+follow_page, see if he's waiting on the just-faulted-in
page?


