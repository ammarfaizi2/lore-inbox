Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262540AbVA0KEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbVA0KEL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 05:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262543AbVA0KEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 05:04:11 -0500
Received: from verein.lst.de ([213.95.11.210]:44255 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S262540AbVA0KEG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 05:04:06 -0500
Date: Thu, 27 Jan 2005 11:03:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Attila Body <compi@freemail.hu>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@lst.de>
Subject: Re: UDF madness
Message-ID: <20050127100354.GA10622@lst.de>
References: <1106688285.5297.3.camel@smiley> <20050126201141.59c90e69.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050126201141.59c90e69.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, me too.  generic_shutdown_super() takes lock_super().  And udf uses
> lock_super for protecting its block allocation data strutures.  Trivial
> deadlock on unmount.
> 
> Filesystems really shouldn't be using lock_super() for internal purposes,
> and the main filesystems have been taught to not do that any more, but UDF
> is a holdout.
> 
> It seems that this deadlock was introduced on Jan 5 by the "udf: fix
> reservation discarding" patch which added the udf_discard_prealloc() call
> into udf_clear_inode().  The below dopey patch prevents the deadlock, but
> perhaps we can think of something more appealing.  Ideally, use a new lock
> altogether?

Yes, the lock_super usage in UDF only protects it's block allocation and
doesn't try to cross-protect anything with the VFS usage of it.

I'll cook up a patch to add a balloc_mutex to the UDF superblock and
give it some testing. 

