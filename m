Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262378AbVCBSBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262378AbVCBSBu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 13:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbVCBSBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 13:01:08 -0500
Received: from fire.osdl.org ([65.172.181.4]:43726 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262378AbVCBR7M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 12:59:12 -0500
Date: Wed, 2 Mar 2005 09:58:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Muthian Sivathanu <muthian_s@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3 journal commit performance
Message-Id: <20050302095852.3d4da20b.akpm@osdl.org>
In-Reply-To: <20050302165814.70651.qmail@web53704.mail.yahoo.com>
References: <20050302165814.70651.qmail@web53704.mail.yahoo.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Muthian Sivathanu <muthian_s@yahoo.com> wrote:
>
> Hi,
> 
> I have a question on ext3 journal commit code.  When a
> transaction is committed in the ordered mode, ext3
> first issues the data writes, waits for them to
> finish, then issues the journal writes, waits for them
> to finish, and then writes out the commit record. 
> 
> It appears that the first wait (for the data blocks)
> is unnecessary because all that is required is that
> before the commit, both the data and the metadata
> blocks should be on disk.  This extra wait can
> potentially reduce performance in cases where the
> journal is on a separate disk, because you lose
> parallelism between data writes and the metadata
> writes.

	1) write the data
	2) wait on the data write
	3) write the journal
	4) wait on the journal write

If we were to omit step 2), we wouldn't be ordering data any more: we will
commit the journal while there are still data writes in flight.

However, what you are proposing is, I think,

	1) write the data
	2) write the journal
	3) wait on the data write
	4) wait on the journal write

That would work, and could possibly speed things up a little.

But bear in mind that the journal write is just a single seek, and the
journal tends to be at one end of the disk, and we need to seek to it
anyway.  There would be some opportunity for the elevator and the disk to
optimise away a seek.

