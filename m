Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbULABAj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbULABAj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 20:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbULAA7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 19:59:37 -0500
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:24439 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261230AbULAAsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 19:48:41 -0500
From: Blaisorblade <blaisorblade_spam@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: VFS interactions with UML and other big UML changes (was: Re: [patch 1/2] Uml - first part rework of run_helper() and users.)
Date: Wed, 1 Dec 2004 01:51:35 +0100
User-Agent: KMail/1.7.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       jdike@addtoit.com, bstroesser@fujitsu-siemens.com, kraxel@bytesex.org
References: <20041130200845.2C5058BAFE@zion.localdomain> <200412010120.39579.blaisorblade_spam@yahoo.it> <20041130163352.62840d12.akpm@osdl.org>
In-Reply-To: <20041130163352.62840d12.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412010151.36181.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 December 2004 01:33, Andrew Morton wrote:
> Blaisorblade <blaisorblade_spam@yahoo.it> wrote:
> > static struct address_space_operations hostfs_aops = {
> >         .writepage      = hostfs_writepage,
> >         .readpage       = hostfs_readpage,
> > /*      .set_page_dirty = __set_page_dirty_nobuffers, */
> >         .prepare_write  = hostfs_prepare_write,
> >         .commit_write   = hostfs_commit_write
> > };
> >
> > Actually, hostfs is a nodev filesystem, but I simply don't know if that
> > implies that it uses no buffers. So, should
> >
> >  .set_page_dirty = __set_page_dirty_nobuffers
> >
> > be uncommented? Or should it be deleted (leaving it there is not a good
> > option).
>
> See the operation of set_page_dirty().

> If you have NULL ->set_page_dirty a_op then set_page_dirty() will fall
> through to __set_page_dirty_buffers().
Yes, I already understood this, the easy part.
> If your fs never sets PG_private then __set_page_dirty_buffers() will just
> do what __set_page_dirty_nobuffers() does.
Ok, I didn't imagine this (looks reasonable though).

Apart the fact that the "race with truncate" check is a bit different: this is 
is in __set_page_dirty_nobuffers(mm/page-writeback.c) and probably wants 
being added to the _buffers version, since it does cannot do anything else 
than triggering a BUG (which you don't see currently, I guess):

[...]
                        mapping2 = page_mapping(page);
                        if (mapping2) { /* Race with truncate? */
                                BUG_ON(mapping2 != mapping);
[...]

> Without having looked at it, I'm sure that hostfs does not use
> buffer_heads.

It can compile without 

#include <linux/buffer_head.h>

(even if the include is there), and it never seem to set any page as buffer 
(by setting the PG_private bit, which can have other meanings too I guess in 
other contexts).

So I guessed this right the first time - I was not sure if it was so 
straightforward.

> So setting your ->set_page_dirty a_op to point at 
> __set_page_dirty_nobuffers() is a reasonable thing to do - it'll provide a
> slight speedup.

If it is a speedup only, then I'm happier - I was especially worried if it was 
going to create possible bugs, even because there are someone has reported 
problems in listing large folders... never reproduced it here and most users 
don't see it, so not yet any clues.

Thanks a lot for the help!
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade
