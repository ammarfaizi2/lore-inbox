Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263785AbUC3SBs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 13:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263788AbUC3SBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 13:01:48 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:33097 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263785AbUC3SBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 13:01:45 -0500
Date: Tue, 30 Mar 2004 19:01:44 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrea Arcangeli <andrea@suse.de>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: mapped pages being truncated [was Re: 2.6.5-rc2-aa5]
In-Reply-To: <20040330161056.GZ3808@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0403301845160.23502-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2004, Andrea Arcangeli wrote:
> 
> the funny thing is that it seems to be the same truncate doing
> truncate_inode_pages first, and zap_page_range later. It would be better
> if WARN_ON would show the pid of the task too, if they were two
> different tasks that would be more realistic. Maybe an xfs screwup of
> some sort? I could ask the tester to try again with ext2, but then if it
> doesn't trigger anymore we still have to wonder about timings.
> 
> Anyways now the kernel is solid, it just bugs out those warnings so we
> don't forget. I don't think it's a bug in my tree.

I do think it's something to worry about, it does seem peculiar.

Dunno why, but I never received the first mail in this thread,
neither directly nor via the list, but have now got it from MARC.

I doubt this is the cause of the problem (would not, I think,
cause all of the associated symptoms you describe), but I think it
is a bug in your code which could cause the WARN_ON(!page->mapping):

Imagine if the filesystem (or driver) nopage gave you the empty zero
page for a private writable mapping (it better not give it you for a
shared writable mapping!), perhaps to represent a hole in the file.

I think it will pass the various tests in your do_no_page, and if
it's a write_access, that will correctly copy the page and set_pte
for this private copy: but it doesn't update pageable (from 0 to 1)
for it, so skips the page_add_rmap; and eventually page_remove_rmap
will be passed this page with neither PageAnon nor page->mapping.

As I say, I doubt it's your case, but worth fixing:
force pageable on where you set anon in do_no_page.

Hugh

