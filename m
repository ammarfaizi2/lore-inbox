Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262156AbUKQCMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262156AbUKQCMJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 21:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262162AbUKQCLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 21:11:31 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:54762
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262161AbUKQCIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 21:08:20 -0500
Date: Tue, 16 Nov 2004 17:53:28 -0800
From: "David S. Miller" <davem@davemloft.net>
To: linux-kernel@vger.kernel.org
Subject: loops in get_user_pages() for VM_IO
Message-Id: <20041116175328.5e425e01.davem@davemloft.net>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Some time recently, I don't know when, the logic in get_user_pages()
appears to have been changed a bit.

The inner-most loop of this routine basically does:

	while (follow_page() returns NULL)
		try handle_mm_fault();

The problem with this is that for !pfn_valid()
(for example, VM_IO areas mapping to I/O physical
address which have no assosciated page struct) follow_page()
will _always_ return NULL.

So when X tries to mmap() the frame buffer on my
system it loops forever here now.

Is pfn_valid() supposed to return true for I/O areas
too?  If so, where does the struct page backing store
come from?

It could be argued that setting VM_LOCKED is invalid.
And not setting it in drivers/video/sbuslib.c would make
this hang go away, but the above analysis means that
make_pages_present() cannot work on VM_IO areas.
