Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751814AbWHATPB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751814AbWHATPB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 15:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751815AbWHATPB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 15:15:01 -0400
Received: from wx-out-0102.google.com ([66.249.82.195]:83 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751814AbWHATPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 15:15:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=G/61zVegxsW1E9MwVKQ4eq8JP3m3AZko2+8zOcSB/VJ3miw5mpsebunQBKvL2SPc1gy5NTZmb3E5SnKVEAvLZHED6h27WNvA/OOrc45S18PL9+TLnbU9bGjELwgCuUsgs25Npopcuu0uu4u2Eup6lMnsZYOJBfsYZf+PIrMjWV4=
Message-ID: <5c49b0ed0608011214x23e18275s9b9d30ac9d0b5056@mail.gmail.com>
Date: Tue, 1 Aug 2006 12:14:58 -0700
From: "Nate Diller" <nate.diller@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: reiser4: maybe just fix bugs?
Cc: "Vladimir V. Saveliev" <vs@namesys.com>, vda.linux@googlemail.com,
       linux-kernel@vger.kernel.org, Reiserfs-List@namesys.com
In-Reply-To: <20060801073316.ee77036e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1158166a0607310226m5e134307o8c6bedd1f883479c@mail.gmail.com>
	 <20060801013104.f7557fb1.akpm@osdl.org> <44CEBA0A.3060206@namesys.com>
	 <1154431477.10043.55.camel@tribesman.namesys.com>
	 <20060801073316.ee77036e.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/06, Andrew Morton <akpm@osdl.org> wrote:
> On Tue, 01 Aug 2006 15:24:37 +0400
> "Vladimir V. Saveliev" <vs@namesys.com> wrote:
>
> > > >The writeout code is ugly, although that's largely due to a mismatch between
> > > >what reiser4 wants to do and what the VFS/MM expects it to do.
> >
> > Yes. reiser4 writeouts atoms. Most of pages get into atoms via
> > sys_write. But pages dirtied via shared mapping do not. They get into
> > atoms in reiser4's writepages address space operation.
>
> It think you mean ->writepage - reiser4 desn't implement ->writepages().
>
> I assume you considered hooking into ->set_page_dirty() to do the
> add-to-atom thing earlier on?
>
> We'll merge mm-tracking-shared-dirty-pages.patch into 2.6.19-rc1, which
> would make that approach considerably more successful, I expect.
> ->set_page_dirty() is a bit awkward because it can be called under
> spinlock.
>
> Maybe comething could also be gained from the new
> vm_operations_struct.page_mkwrite(), although that's less obvious...
>
> > That is why
> > reiser4_sync_inodes has two steps: on first one it calls
> > generic_sync_sb_inodes to call writepages for dirty inodes to capture
> > pages dirtied via shared mapping into atoms. Second step flushes atoms.
> >
> > > >
> > > I agree --- both with it being ugly, and that being part of why.
> > >
> > > >  If it
> > > >works, we can live with it, although perhaps the VFS could be made smarter.
> > > >
> > > >
> > > I would be curious regarding any ideas on that.  Next time I read
> > > through that code, I will keep in mind that you are open to making VFS
> > > changes if it improves things, and I will try to get clever somehow and
> > > send it by you.  Our squalloc code though is I must say the most
> > > complicated and ugliest piece of code I ever worked on for which every
> > > cumulative ugliness had a substantive performance advantage requiring us
> > > to keep it.  If you spare yourself from reading that, it is
> > > understandable to do so.
> > >
> > > >I'd say that resier4's major problem is the lack of xattrs, acls and
> > > >direct-io.  That's likely to significantly limit its vendor uptake.
> >
> > xattrs is really a problem.
>
> That's not good.  The ability to properly support SELinux is likely to be
> important.

i disagreee that it will be difficult.  unfortunately, the patch that
I am working on right now, which fixes the various reiser4 specific
functions to avoid using VFS data structures unless needed, is a
prerequisite to enabling xattrs.  creating it is a time of tedium for
me, and it will cause a bit of internal churn (1000 lines and
counting).  it's all in the fs/reiser4 directory though, and it should
cause minimal disruption, as far as runtime bugs introduced.

once that's taken care of, i will be delighted to enable xattr support
in a way that will make selinux and beagle and such run as expected,
and will have the added advantage of some major scalability
improvements for certain lookup and update operations.

NATE
