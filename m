Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263686AbUD0CPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263686AbUD0CPd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 22:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263687AbUD0CPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 22:15:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:46513 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263686AbUD0CP3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 22:15:29 -0400
Date: Mon, 26 Apr 2004 19:15:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Shantanu Goel <sgoel01@yahoo.com>
Cc: linux-kernel@vger.kernel.org, Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: 2.6.6-rc{1,2} bad VM/NFS interaction in case of dirty page
 writeback
Message-Id: <20040426191512.69485c42.akpm@osdl.org>
In-Reply-To: <20040427011237.33342.qmail@web12824.mail.yahoo.com>
References: <20040427011237.33342.qmail@web12824.mail.yahoo.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shantanu Goel <sgoel01@yahoo.com> wrote:
>
> Hi,
> 
> During page reclamation when the scanner encounters a
> dirty page and invokes writepage(), if the FS layer
> returns WRITEPAGE_ACTIVATE as NFS does, I think the
> page should not be placed on the active as is
> presently done.  This can cause a lot of extraneous
> swapout activity because in the presence of a large
> active list, the pages being written out will not be
> reclaimed quickly enough.  It also seems counter
> intuitive since the scanner has just determined that
> the page has not been recently referenced.
> 
> Shouldn't the following code from shrink_list():
> 
> res = mapping->a_ops->writepage(page, &wbc);
> if (res < 0)
> 	handle_write_error(mapping, page, res);
> if (res == WRITEPAGE_ACTIVATE) {
> 	ClearPageReclaim(page);
> 	goto activate_locked;
> }
> 
> read:
> 
> res = mapping->a_ops->writepage(page, &wbc);
> if (res < 0)
> 	handle_write_error(mapping, page, res);
> if (res == WRITEPAGE_ACTIVATE) {
> 	ClearPageReclaim(page);
> 	goto keep_locked;
> }

WRITEPAGE_ACTIVATE is a bit of a hack to fix up specific peculiarities of
the interaction between tmpfs and page reclaim.

Trond, the changelog for that patch does not explain what is going on in
there - can you help out?

Also, what's the theory behind the handling of BDI_write_congested and
nfs_wait_on_write_congestion() in nfs_writepages()?  From a quick peek it
looks like NFS should be waking the sleepers in blk_congestion_wait()
rather than doing it privately?

> I can observe the benefit of this change if I run a dd
> on an NFS mount with the active list full of mostly
> mapped pages.  The stock kernel ends up paging out
> quite a bit of memory whereas the modified kernel does
> not.

yup.  We should be able to handle the throttling and writeback scheduling
from within core VFS/VM.  NFS should set and clear the backing_dev
congestion state appropriately and the VFS should take care of the rest. 
The missing bit is the early blk_congestion_wait() termination.

