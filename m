Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267107AbUBFAdO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 19:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267105AbUBFAcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 19:32:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:5064 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267045AbUBFAck (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 19:32:40 -0500
Subject: Re: 2.6.2-mm1 aka "Geriatric Wombat" DIO read race still fails
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org, "linux-aio@kvack.org" <linux-aio@kvack.org>
In-Reply-To: <20040205160755.25583627.akpm@osdl.org>
References: <20040205014405.5a2cf529.akpm@osdl.org>
	 <1076023899.7182.97.camel@ibm-c.pdx.osdl.net>
	 <20040205160755.25583627.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1076027555.7182.122.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 05 Feb 2004 16:32:35 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-02-05 at 16:07, Andrew Morton wrote:
> Daniel McNeil <daniel@osdl.org> wrote:
> >
> > Andrew,
> > 
> > I tested 2.6.2-mm1 on an 8-proc running 6 copies of the read_under
> > test and all 6 read_under tests saw uninitialized data in less than 5
> > minutes. :(
> 
> The performance implications of synchronising behind kjournald writes for
> normal non-blocking writeback are bad.  Can you detail what you now think
> is the failure mechanism?
> 

I think the problem is that any block_write_full_page(WB_SYNC_NONE)
that hits a page that has a buffer in process of being written will
get PageWriteback cleared even though the i/o has not completed.
(The buffer will be locked, but buffer_dirty() is cleared, so
 __block_write_full_page() will SetPageWriteback(); unlock_page();
 see no buffer were submitted and call end_page_writeback())

Any subsequent filemap_write_and_wait() or filemap_fdatawrite() /
filemap_fdatawait will never wait for that i/o.  So this could
potentially be a problem for more than just DIO.

BTW: 2.4 __block_write_full_page() always did a lock_buffer(), so
it waits for i/o in flight.

I agree though, it would be best if non-sync __block_write_full_page()
would not block on buffers in flight.  Somehow we need to move the
clearing of PageWriteback() until after the buffer has been written
even for the case where ll_rw_block() is called.

Thoughts?

Daniel


