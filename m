Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751575AbVJSWJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575AbVJSWJa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 18:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751580AbVJSWJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 18:09:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26061 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751577AbVJSWJ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 18:09:29 -0400
Date: Wed, 19 Oct 2005 15:09:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@gmail.com>
Cc: uszhaoxin@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: Is ext3 flush data to disk when files are closed?
Message-Id: <20051019150940.477e2184.akpm@osdl.org>
In-Reply-To: <1129756286.8716.16.camel@localhost.localdomain>
References: <4ae3c140510190831j7530742aqc2b82e9e9cd6dde3@mail.gmail.com>
	<1129737026.23632.113.camel@localhost.localdomain>
	<20051019130010.28693db1.akpm@osdl.org>
	<1129756286.8716.16.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@gmail.com> wrote:
>
> On Wed, 2005-10-19 at 13:00 -0700, Andrew Morton wrote:
> > Badari Pulavarty <pbadari@gmail.com> wrote:
> > >
> > > On Wed, 2005-10-19 at 11:31 -0400, Xin Zhao wrote:
> > > > As far as I know, if an application modifies a file on an ext3 file
> > > > ssytem, it actually change the page cache, and the dirty pages will be
> > > > flushed to disk by kupdate periodically.
> > > > 
> > > > My question is: if a file is to be closed, but some of its data pages
> > > > are marked as dirty, will system block on close() and wait for dirty
> > > > pages being flushed to disk? If so, it seems to decrease performance
> > > > significantly if a lot of updates on many small files are involved.
> > > > 
> > > > Can someone point me to the right place to check how it works? Thanks!
> > > 
> > > On the last close() of the file, it should be flushed through ..
> > > 
> > > 	iput_final() -> generic_drop_inode() -> write_inode_now()
> > > 		-> __writeback_single_inode() -> __sync_single_inode()
> > > 			-> do_writepages()
> > 
> > The dcache's reference to the inode will prevent this from happening at
> > close() time.
> > 
> 
> I thought so too, till I wrote a kprobe/systemtap script to print 
> the callers of generic_forget_inode() earlier and saw that most 
> of my stacks are from exit() or close().
> 
>  0xffffffff801a0222 : generic_drop_inode+0x2/0x170 []
>  0xffffffff8019eeb0 : iput+0x50/0x90 []
>  0xffffffff8019c7bb : dput+0x1db/0x220 []
>  0xffffffff80184461 : __fput+0x171/0x1e0 []
>  0xffffffff801829ce : filp_close+0x6e/0x90 []
>  0xffffffff801388eb : put_files_struct+0x6b/0xc0 []
>  0xffffffff801392ef : do_exit+0x1ff/0xbb0 []
>  

But generic_forget_inode usually doesn't dispose of the inode.

	if (!hlist_unhashed(&inode->i_hash)) {
		if (!(inode->i_state & (I_DIRTY|I_LOCK)))
			list_move(&inode->i_list, &inode_unused);
		inodes_stat.nr_unused++;
		if (!sb || (sb->s_flags & MS_ACTIVE)) {
			spin_unlock(&inode_lock);
			return;
		}

