Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262781AbUCRRJm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 12:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262775AbUCRRIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 12:08:46 -0500
Received: from fw.osdl.org ([65.172.181.6]:54763 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262776AbUCRRHm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 12:07:42 -0500
Date: Thu, 18 Mar 2004 09:07:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeffrey Siegal <jbs@quiotix.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why is fsync so much slower than O_SYNC?
Message-Id: <20040318090747.35c65219.akpm@osdl.org>
In-Reply-To: <4059C381.1000601@quiotix.com>
References: <40587F90.1040903@quiotix.com>
	<20040318003335.6bf3eb41.akpm@osdl.org>
	<4059C381.1000601@quiotix.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeffrey Siegal <jbs@quiotix.com> wrote:
>
> Andrew Morton wrote:
> > This is because ext3 is being dumb.  It is forcing a journal commit even
> > when the inode has not been altered.
> > 
> > Here's a moderately-tested 2.6 fix.  A 2.4 fix would be similar.
> > 
> > 
> > File overwrite:
> > 
> > 	vmm:/mnt/hda5> ~/fsync-is-sucky 
> > 	O_SYNC:
> > 	Creating
> > 	Starting
> > 	iter = 1000, latency = 0.191464ms
> > 
> > 	O_DSYNC:
> > 	Creating
> > 	Starting
> > 	iter = 1000, latency = 0.181637ms
> > 
> > 	fsync:
> > 	Creating
> > 	Starting
> > 	iter = 1000, latency = 0.186326ms
> > 
> > 	fdatasync:
> > 	Creating
> > 	Starting
> > 	iter = 1000, latency = 0.193013ms
> 
> Hmm, this doesn't seem right.  For an overwrite, it should still be 
> waiting for just the data page to be written out, and that should take 
> about 8ms (for a 7200rpm drive),

That's with the disk writeback cache enabled.

> and the append case should take longer, 
> since it requires writing both the data page and then the journal.

Append takes 40 times longer, because in that case we need to commit the
journal after each sync to write the modifed inode.

