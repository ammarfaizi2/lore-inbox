Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262843AbRFGStU>; Thu, 7 Jun 2001 14:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262825AbRFGStK>; Thu, 7 Jun 2001 14:49:10 -0400
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:11794 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S262824AbRFGStG>; Thu, 7 Jun 2001 14:49:06 -0400
Message-Id: <200106071851.f57IptV29210@jen.americas.sgi.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: Busy buffers and try_to_free_pages
Date: Thu, 07 Jun 2001 13:51:55 -0500
From: Steve Lord <lord@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am chasing around in circles with an issue where buffers pointing at
highmem pages are getting put onto the buffer free list, and later on
causing oops in ext2 when it gets assigned them for metadata via getblk.

Say one thread is performing a truncate on an inode and is currently in
truncate_inode_pages walking the pages and removing them from the
address space of the inode. If the try_to_free_buffers call fails to remove
the buffers from the page because the buffer_busy test fails, then
the buffers become anonymous and we disconnet the page from the address
space anyway. During unmount, these anonymous buffers get put on the free
list. A simple sync call running in parallel with the truncate can cause
the buffer to be seen as busy and get the system into this state.

What is supposed to prevent this from happening? It seems that pages
allocated from highmem should never be allowed to be cleaned up this
way.

Steve


