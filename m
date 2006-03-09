Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbWCIXdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbWCIXdt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 18:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbWCIXds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 18:33:48 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45754 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932116AbWCIXdq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 18:33:46 -0500
Date: Thu, 9 Mar 2006 15:35:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: sct@redhat.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, jack@suse.cz
Subject: Re: ext3_ordered_writepage() questions
Message-Id: <20060309153550.379516e1.akpm@osdl.org>
In-Reply-To: <4410551D.5000303@us.ibm.com>
References: <1141777204.17095.33.camel@dyn9047017100.beaverton.ibm.com>
	<20060308124726.GC4128@lst.de>
	<4410551D.5000303@us.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> Hi,
> 
> I am trying to cleanup ext3_ordered and ext3_writeback_writepage() routines.
> I am confused on what ext3_ordered_writepage() is currently doing ? I hope
> you can help me understand it little better.
> 
> 1) Why do we do journal_start() all the time ?

Because we're lame.

> 2) Why do we call journal_dirty_data_fn() on the buffers ? We already
> issued IO on all those buffers() in block_full_write_page(). Why do we
> need to add them to transaction ?  I understand we need to do this for
> block allocation case. But do we need it for non-allocation case also ?

Yup.  Ordered-mode JBD commit needs to write and wait upon all dirty
file-data buffers prior to journalling the metadata.  If we didn't run
journal_dirty_data_fn() against those buffers then they'd still be under
I/O after commit had completed.

Consequently a crash+recover would occasionally allow a read() to read
uninitialised data blocks - those blocks for which we had a) started the
I/O, b) journalled the metadata which refers to that block and c) not yet
completed the I/O when the crash happened.

Now, if the write was known to be an overwrite then we know that the block
isn't uninitialised, so we could perhaps avoid writing that block in the
next commit - just let pdflush handle it.  We'd need to work out whether a
particular block has initialised data on-disk under it when we dirty it,
then track that all the way through to writepage.  It's all possible, and
adds a significant semantic change to ordered-mode.

If that change offered significant performance benefits then yeah, we could
scratch our heads over it.

But I think if you're looking for CPU consumption reductions, you'd be much
better off attacking prepare_write() and commit_write(), rather than
writepage().


