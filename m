Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263697AbUD0DLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263697AbUD0DLP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 23:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263701AbUD0DLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 23:11:15 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:36736 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S263697AbUD0DLN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 23:11:13 -0400
Subject: Re: 2.6.6-rc{1,2} bad VM/NFS interaction in case of dirty page
	writeback
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: Shantanu Goel <sgoel01@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20040426191512.69485c42.akpm@osdl.org>
References: <20040427011237.33342.qmail@web12824.mail.yahoo.com>
	 <20040426191512.69485c42.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1083035471.3710.65.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 26 Apr 2004 23:11:12 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-04-26 at 22:15, Andrew Morton wrote:
> WRITEPAGE_ACTIVATE is a bit of a hack to fix up specific peculiarities of
> the interaction between tmpfs and page reclaim.
> 
> Trond, the changelog for that patch does not explain what is going on in
> there - can you help out?

As far as I understand, the WRITEPAGE_ACTIVATE hack is supposed to allow
filesystems to defer actually starting the I/O until the call to
->writepages(). This is indeed beneficial to NFS, since most servers
will work more efficiently if we cluster NFS write requests into "wsize"
sized chunks.

> Also, what's the theory behind the handling of BDI_write_congested and
> nfs_wait_on_write_congestion() in nfs_writepages()?  From a quick peek it
> looks like NFS should be waking the sleepers in blk_congestion_wait()
> rather than doing it privately?

The idea is mainly to prevent tasks from scheduling new writes if we are
in the situation of wanting to reclaim or otherwise flush out dirty
pages. IOW: I am assuming that the writepages() method is usually called
only when we are low on memory and/or if pdflush() was triggered.

> yup.  We should be able to handle the throttling and writeback scheduling
> from within core VFS/VM.  NFS should set and clear the backing_dev
> congestion state appropriately and the VFS should take care of the rest. 
> The missing bit is the early blk_congestion_wait() termination.

Err... I appear to be missing something here. What is it you mean by
*early* blk_congestion_wait() termination?

Cheers,
  Trond
