Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261402AbVEIPCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261402AbVEIPCa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 11:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261403AbVEIPCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 11:02:30 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:1730 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261402AbVEIPCK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 11:02:10 -0400
From: Jim Washer <e2big@us.ibm.com>
Message-Id: <200505091502.j49F26303024@crg8.beaverton.ibm.com>
Subject: Possible bug in do_generic_file_read?
To: linux-kernel@vger.kernel.org
Date: Mon, 9 May 2005 08:02:05 -0700 (PDT)
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been looking at a stack trace from a 2.4.x kenrel where the kernel
hits the "page has mapping still set" BUG() in __free_pages_ok.

What I've found is that in do_generic_file_read, the call:
	error = mapping->a_ops->readpage(filp, page);

is returning an error (EFAULT)

However, shortly after, we fall into:
		/* UHHUH! A synchronous read error occurred. Report it */
		desc->error = error;
		page_cache_release(page);
		break;

This code tries to free the page in question. However, is it reasonable for 
do_generic_file_read to free a page "that belongs to" filesystem code?

Is there some (un)written rule that says filesystem readpage code MUST 
unmap a page before returning an error?


I notice that several other locations in do_generic_file_read first check 
that the page has no mapping before freeing, but not here.


Further details.
1)The file system in question is veritas VXFS, which is NOT open source.
However, I'm asking this as a general question about whether or not
there is a requirement that an given FS unmap a page before returning 
an error

2)The kernel is RHEL3u3, but the code path here apprears the same in 2.4.30

3)I've not included the stack trace here, as it came from a RHEL3 kernel, 
which I assume most reader of lkml would not have access to.
I don't want to get into arguing about the analysis of this particular
stack, but rather I want to consider if the attempted page free in 
do_generic_file_read is "correct" in ALL cases.


thanks for considering this.

 - jim


-- 
James Washer
IBM Linux Change Team
