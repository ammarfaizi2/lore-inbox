Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267965AbUBRTgr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 14:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267966AbUBRTgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 14:36:46 -0500
Received: from fw.osdl.org ([65.172.181.6]:27847 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267965AbUBRTgn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 14:36:43 -0500
Subject: Re: [PATCH 2.6.3-rc2-mm1] address_space_serialize_writeback patch
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040217174755.2d870b40.akpm@osdl.org>
References: <20040212015710.3b0dee67.akpm@osdl.org>
	 <1076707830.1956.46.camel@ibm-c.pdx.osdl.net>
	 <20040213143836.0a5fdabb.akpm@osdl.org>
	 <1076715039.1956.104.camel@ibm-c.pdx.osdl.net>
	 <20040213154815.42e74cb5.akpm@osdl.org>
	 <1077066147.1956.136.camel@ibm-c.pdx.osdl.net>
	 <20040217174755.2d870b40.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1077132986.1956.223.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 18 Feb 2004 11:36:26 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

I did run the multiple copies of the direct_read_under test on:

KERNEL					RESULT
======					======
2.6.3-rc2-mm1				Sees uninitialized data

2.6.3-rc2-mm1 + wait_on_buffer() in
  __block_write_full_page		no uninitialized data seen

2.6.3-rc2-mm1 + __set_page_dirty_nobuffers
  if cannot lock_buffer in
  __block_write_full_page		Sees uninitialized data

2.6.3-rc2-mm1 + wb_rwsema patch		no uninitialized data seen


There looks like there are potential race conditions with
the rwsema in do_writepages() since a page can be moved back
to the dirty list while waiting on the down_write() and also
with multiple filemap_fdatawait()s.  I have pointed this out before
but I do not have a test that can reproduce the problem.

The rwsema patch does make the direct_read_under test pass.
It ran overnight without errors.

I want to close all the potential race conditions, but since
this patch is a step in the process and the test ran correctly
with it, I submitted the patch.

I'll send out updated patches as I do more testing.


Daniel

On Tue, 2004-02-17 at 17:47, Andrew Morton wrote:
> Daniel McNeil <daniel@osdl.org> wrote:
> >
> > Here is the patch that does what you suggested.  It adds a rwsema to
> > the address_space and do_writepages() uses it serialize writebacks.
> 
> Did you verify that we actually _need_ the semaphore?  I seem to recall that
> it was a "try this, otherwise add the semaphore" thing.  Where "this" was "always
> remark the page dirty".
> 
> Probably we do need the semaphore, but I'd just like to check that you checked ;)

