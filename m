Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751908AbWCLX0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751908AbWCLX0J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 18:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751922AbWCLX0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 18:26:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:7650 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751908AbWCLX0I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 18:26:08 -0500
Date: Sun, 12 Mar 2006 15:23:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: rjw@sisk.pl, linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       pbadari@us.ibm.com
Subject: Re: [discuss] Re: 2.6.16-rc5-mm3: spinlock bad magic on CPU#0 on
 AMD64
Message-Id: <20060312152334.3d37fe6b.akpm@osdl.org>
In-Reply-To: <200603121610.31881.ak@suse.de>
References: <200603120024.04938.rjw@sisk.pl>
	<200603121349.32374.rjw@sisk.pl>
	<20060312142654.650b90fb.akpm@osdl.org>
	<200603121610.31881.ak@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> > Still.  It seems that what's happened is that we took a pagefault while
>  > reiserfs had a transaction open.  The fault is against a mmapped ext3 file
>  > and we ended up in the recently-reworked ext3_get_block() which tests
>  > journal_current_handle() to work out whether we're in a write or a read. 
>  > oops.  The presence of reiserfs journal_info makes it decide it's a write,
>  > not a read so it starts treating a reiserfs journal_info as an ext3 one.
>  > 
>  > The code used to work OK because it was only for direct-IO, which doesn't
>  > get recurred into like this.  But it got used for regular I/O in -mm.
> 
>  Oops. Can this happen in more situations?

I don't _think_ so, but it's pretty scary.  The code's been this way for a
while.

Typical scenario:

	reiserfs_journal_start		- sets current->journal_info
	  copy_from_user
	    pagefault
	      ext3_readpages()

As long as ext3_readpage[s]() doesn't try to start a transaction we're OK. 
And it shouldn't, if create==0.

Fortunately filemap_nopage() doesn't do atime updates.  If it did, things
would get messy.

We do have deadlock possibilities in there - filemap_nopage() does
lock_page() inside journal_start(), whereas generic_file_write() does
journal_start() inside lock_page().  Chris Mason and I have stared
unhappily at that a few times.  Hard to fix.

But I don't _think_ we have any more journal_start() recursions like this -
ext3 tends to get pretty noisy if it detects that in unexpected places.

