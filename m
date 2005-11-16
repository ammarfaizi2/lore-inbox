Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030515AbVKPVuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030515AbVKPVuK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 16:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030519AbVKPVuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 16:50:10 -0500
Received: from pat.uio.no ([129.240.130.16]:50587 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1030515AbVKPVuI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 16:50:08 -0500
Subject: Re: mmap over nfs leads to excessive system load
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: theonetruekenny@yahoo.com, linux-kernel@vger.kernel.org
In-Reply-To: <20051116133130.625cd19b.akpm@osdl.org>
References: <20051116150141.29549.qmail@web34113.mail.mud.yahoo.com>
	 <1132163057.8811.15.camel@lade.trondhjem.org>
	 <20051116100053.44d81ae2.akpm@osdl.org>
	 <1132166062.8811.30.camel@lade.trondhjem.org>
	 <20051116110938.1bf54339.akpm@osdl.org>
	 <1132171500.8811.37.camel@lade.trondhjem.org>
	 <20051116133130.625cd19b.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 16:49:45 -0500
Message-Id: <1132177785.8811.57.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.724, required 12,
	autolearn=disabled, AWL 1.28, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-16 at 13:31 -0800, Andrew Morton wrote:
> But block-backed filesytems have the same concern: we don't want to do a
> whole bunch of 4k I/Os.  Hence the writepages() interface, which is the
> appropriate place to be building up these large I/Os.
> 
> NFS does nfw_writepages->mpage_writepages->nfs_writepage and to build the
> large I/Os it leaves the I/O pending on return from nfs_writepage().  It
> appears to flush any pending pages on the exit path from nfs_writepages().
> 
> If that's a correct reading then there doesn't appear to be any way in
> which there's dangling I/O left to do after nfs_writepages() completes.

Agreed. AFAICS, nfs_writepages should be quite OK, however writepage()
on its own _is_ problematic.

Look at the usage in write_one_page(), which calls directly down to
->writepage(), and then immediately does a wait_on_page_writeback().

How is the filesystem supposed to distinguish between the cases
"VM->writepage()", and "VM->writepages->mpage_writepages->writepage()"?

Cheers,
  Trond

