Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbUKRVDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbUKRVDE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 16:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbUKRVA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 16:00:58 -0500
Received: from fw.osdl.org ([65.172.181.6]:58043 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261167AbUKRU5z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 15:57:55 -0500
Date: Thu, 18 Nov 2004 12:57:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: alan@lxorguk.ukuu.org.uk, miklos@szeredi.hu, hbryan@us.ibm.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       pavel@ucw.cz
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
Message-Id: <20041118125734.32ec8e88.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0411181047590.2222@ppc970.osdl.org>
References: <OF28252066.81A6726A-ON88256F50.005D917A-88256F50.005EA7D9@us.ibm.com>
	<E1CUq57-00043P-00@dorka.pomaz.szeredi.hu>
	<Pine.LNX.4.58.0411180959450.2222@ppc970.osdl.org>
	<1100798975.6018.26.camel@localhost.localdomain>
	<Pine.LNX.4.58.0411181047590.2222@ppc970.osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> 
> 
> On Thu, 18 Nov 2004, Alan Cox wrote:
> > 
> > > I really do believe that user-space filesystems have problems. There's a 
> > > reason we tend to do them in kernel space. 
> > > 
> > > But limiting the outstanding writes some way may at least hide the thing.
> > 
> > Possibly dumb question. Is there a reason we can't have a prctl() that
> > flips the PF_* flags for a user space daemon in the same way as we do
> > for kernel threads that do I/O processing ?
> 
> It's more than just PF_MEMALLOC.
> 
> And PF_MEMALLOC really is to avoid _recursion_, which is the smallest
> problem. It does so by allowing the process to dip into the critical
> resources, but that only works if you know that the process is actually
> freeing pages right then and there. If you set it willy-nilly, you'll just
> run out of pages soon, and you'll be dead.

I've seen one 2.4-based project which had essentially a userspace
blockdevice driver.  Marking that special, trusted process PF_MEMALLOC did
indeed fix low-on-memory deadlocks.  Obviously it's something one does with
caution, but there are times when it makes sense.

I think there are codepaths which unconditionally turn off PF_MEMALLOC, so
they need to be tweaked to do a save/set/restore operation for it all to
work.
