Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbULAAfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbULAAfY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 19:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbULAAec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 19:34:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:59627 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261171AbULAAaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 19:30:06 -0500
Date: Tue, 30 Nov 2004 16:33:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com,
       bstroesser@fujitsu-siemens.com,
       user-mode-linux-devel@lists.sourceforge.net, kraxel@bytesex.org
Subject: Re: VFS interactions with UML and other big UML changes (was: Re:
 [patch 1/2] Uml - first part rework of run_helper() and users.)
Message-Id: <20041130163352.62840d12.akpm@osdl.org>
In-Reply-To: <200412010120.39579.blaisorblade_spam@yahoo.it>
References: <20041130200845.2C5058BAFE@zion.localdomain>
	<20041130152017.129e134c.akpm@osdl.org>
	<200412010120.39579.blaisorblade_spam@yahoo.it>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Blaisorblade <blaisorblade_spam@yahoo.it> wrote:
>
> static struct address_space_operations hostfs_aops = {
>         .writepage      = hostfs_writepage,
>         .readpage       = hostfs_readpage,
> /*      .set_page_dirty = __set_page_dirty_nobuffers, */
>         .prepare_write  = hostfs_prepare_write,
>         .commit_write   = hostfs_commit_write
> };
> 
> Actually, hostfs is a nodev filesystem, but I simply don't know if that 
> implies that it uses no buffers. So, should
> 
>  .set_page_dirty = __set_page_dirty_nobuffers
> 
> be uncommented? Or should it be deleted (leaving it there is not a good 
> option).

See the operation of set_page_dirty().

If you have NULL ->set_page_dirty a_op then set_page_dirty() will fall
through to __set_page_dirty_buffers().

If your fs never sets PG_private then __set_page_dirty_buffers() will just
do what __set_page_dirty_nobuffers() does.

Without having looked at it, I'm sure that hostfs does not use
buffer_heads.  So setting your ->set_page_dirty a_op to point at
__set_page_dirty_nobuffers() is a reasonable thing to do - it'll provide a
slight speedup.

