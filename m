Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262723AbTDFACt (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 19:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbTDFACt (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 19:02:49 -0500
Received: from mail-6.tiscali.it ([195.130.225.152]:60504 "EHLO
	mail.tiscali.it") by vger.kernel.org with ESMTP id S262723AbTDFACr (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 19:02:47 -0500
Date: Sun, 6 Apr 2003 02:14:07 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, mbligh@aracnet.com,
       mingo@elte.hu, hugh@veritas.com, dmccr@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-ID: <20030406001407.GL1326@dualathlon.random>
References: <20030404163154.77f19d9e.akpm@digeo.com> <12880000.1049508832@flay> <20030405024414.GP16293@dualathlon.random> <20030404192401.03292293.akpm@digeo.com> <20030405040614.66511e1e.akpm@digeo.com> <20030405232524.GD1828@holomorphy.com> <20030405155740.3da6a5bf.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030405155740.3da6a5bf.akpm@digeo.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 05, 2003 at 03:57:40PM -0800, Andrew Morton wrote:
> William Lee Irwin III <wli@holomorphy.com> wrote:
> > On Sat, Apr 05, 2003 at 04:06:14AM -0800, Andrew Morton wrote:
> > > In the third test a single task owns 10000 VMA's and walks across them in a
> > > linear pattern:
> > > 	./rmap-test -v -l -i 10 -n 10000 -s 7 -t 1 foo
> > > 2.5.66-mm4:
> > > 	0.25s user 3.75s system 1% cpu 4:38.44 total
> > > 2.5.66-mm4+objrmap:
> > > 	0.28s user 146.45s system 16% cpu 15:14.59 total
> > > 2.4.21-pre5aa2:
> > > 	0.32s user 4.83s system 0% cpu 18:25.90 total
> > 
> > This doesn't appear to be the kind of issue that would be addressed by
> > the more advanced search structure to replace ->i_mmap and ->i_mmap_shared.
> 
> We have 10000 disjoint VMA's and we want to find the one which maps this
> page.  If we cannot solve this then we have a problem.
> 
> > I'm somewhat surprised the virtualscan does so poorly; from an a priori
> > POV with low sharing and linear access there's no obvious reason in my
> > mind why it would do as poorly as or worse than the objrmap here.
> 
> The virtual scan did well in all tests I _think_.  What happened in this test
> is that the IO scheduling was crap - the disk sounded like a dentist's drill.
> 
> Could be that this is due to the elevator changes which Andrea has made, or

2.4-aa is outperforming 2.5 in almost all tiobenchs results, so I doubt
the elevator is that bad and could explain such drop in performance. 

I suspect it must be something on the lines of the filesystem doing
synchronous I/O for some reason inside writepage, like doing a
wait_on_buffer for every writepage, generating the above fake results.
Note the 0% cpu time. You're not benchmarking the vm here. Infact I
would be interested to see the above repeated on ext2.

It's not true that ext3 is sharing the same writepage of ext2 as you
said in a earlier email, the ext3 writepage starts like this:

static int ext3_writepage(struct page *page)
{
	struct inode *inode = page->mapping->host;
	struct buffer_head *page_buffers;
	handle_t *handle = NULL;
	int ret = 0, err;
	int needed;
	int order_data;

	J_ASSERT(PageLocked(page));
	
	/*
	 * We give up here if we're reentered, because it might be
	 * for a different filesystem.  One *could* look for a
	 * nested transaction opportunity.
	 */
	lock_kernel();
	if (ext3_journal_current_handle())
		goto out_fail;

	needed = ext3_writepage_trans_blocks(inode);
	if (current->flags & PF_MEMALLOC)
		handle = ext3_journal_try_start(inode, needed);
	else
		handle = ext3_journal_start(inode, needed);

and even the ext2 writepage can be synchronous if it has to call
get_block. Infact I would reccomend to fill the "foo" file with zeros
and not to have holes in it just to avoid additional synchronous fs
overhead and to only be sync in the inode map lookup.

Andrea
