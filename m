Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751638AbWHAOd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638AbWHAOd0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 10:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751630AbWHAOd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 10:33:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48340 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751637AbWHAOdZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 10:33:25 -0400
Date: Tue, 1 Aug 2006 07:33:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Vladimir V. Saveliev" <vs@namesys.com>
Cc: vda.linux@googlemail.com, linux-kernel@vger.kernel.org,
       Reiserfs-List@namesys.com
Subject: Re: reiser4: maybe just fix bugs?
Message-Id: <20060801073316.ee77036e.akpm@osdl.org>
In-Reply-To: <1154431477.10043.55.camel@tribesman.namesys.com>
References: <1158166a0607310226m5e134307o8c6bedd1f883479c@mail.gmail.com>
	<20060801013104.f7557fb1.akpm@osdl.org>
	<44CEBA0A.3060206@namesys.com>
	<1154431477.10043.55.camel@tribesman.namesys.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Aug 2006 15:24:37 +0400
"Vladimir V. Saveliev" <vs@namesys.com> wrote:

> > >The writeout code is ugly, although that's largely due to a mismatch between
> > >what reiser4 wants to do and what the VFS/MM expects it to do.
> 
> Yes. reiser4 writeouts atoms. Most of pages get into atoms via
> sys_write. But pages dirtied via shared mapping do not. They get into
> atoms in reiser4's writepages address space operation.

It think you mean ->writepage - reiser4 desn't implement ->writepages().

I assume you considered hooking into ->set_page_dirty() to do the
add-to-atom thing earlier on?

We'll merge mm-tracking-shared-dirty-pages.patch into 2.6.19-rc1, which
would make that approach considerably more successful, I expect. 
->set_page_dirty() is a bit awkward because it can be called under
spinlock.

Maybe comething could also be gained from the new
vm_operations_struct.page_mkwrite(), although that's less obvious...

> That is why
> reiser4_sync_inodes has two steps: on first one it calls
> generic_sync_sb_inodes to call writepages for dirty inodes to capture
> pages dirtied via shared mapping into atoms. Second step flushes atoms.
> 
> > >
> > I agree --- both with it being ugly, and that being part of why.
> > 
> > >  If it
> > >works, we can live with it, although perhaps the VFS could be made smarter.
> > >  
> > >
> > I would be curious regarding any ideas on that.  Next time I read
> > through that code, I will keep in mind that you are open to making VFS
> > changes if it improves things, and I will try to get clever somehow and
> > send it by you.  Our squalloc code though is I must say the most
> > complicated and ugliest piece of code I ever worked on for which every
> > cumulative ugliness had a substantive performance advantage requiring us
> > to keep it.  If you spare yourself from reading that, it is
> > understandable to do so.
> > 
> > >I'd say that resier4's major problem is the lack of xattrs, acls and
> > >direct-io.  That's likely to significantly limit its vendor uptake. 
> 
> xattrs is really a problem.

That's not good.  The ability to properly support SELinux is likely to be
important.
