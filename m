Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261679AbTISTQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 15:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbTISTQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 15:16:58 -0400
Received: from relay1.eltel.net ([195.209.236.38]:9173 "EHLO relay1.eltel.net")
	by vger.kernel.org with ESMTP id S261679AbTISTQ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 15:16:56 -0400
Date: Fri, 19 Sep 2003 23:17:32 +0400
From: Andrew Zabolotny <zap@homelink.ru>
To: linux-kernel@vger.kernel.org
Subject: __make_request() bug and a fix variant
Message-Id: <20030919231732.7f7874e6.zap@homelink.ru>
Organization: =?ISO-8859-1?Q?=20=E4=CF=CD?=
X-Mailer: Sylpheed version 0.8.2 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

While developing a driver I found something that I think is a bug in
kernel (I'm using 2.4.20, I just hope it is already fixed in 2.6.x
series). It manifests itself by bread() randomly crashing (in different
places) if called for, say, reading 1024 bytes from block 0 of device
0300 from a driver's module_init() (at least in my very stripped debug
environment, this could differ from system to system).

Here's a somewhat long description of the problem roots:

bread() in the first place calls getblk(), which first tries to find the
requested buffer in hash tables, and if it is not there, it calls
grow_buffers(), the later calls grow_dev_page() and finally that calls
create_buffers(). The later gets a set of free buffer_head's from the
pool, and puts them in a chain attached to a page. Many fields are left
in a indefinite state since they are initialized before usage. The
b_reqnext field is left in a indefinite state as well, and it happens
to be filled with garbage in my case (actually it's a leftover from
previous usage of the buffer_head).

Now when bread() gets this buffer, it is passed to ll_rw_block() which
is passing it to generic_make_request(), and, in turn (for many block
devices including IDE) to __make_request.

And finally, if elevator returns ELEVATOR_NO_MERGE, the b_reqnext field
of the buffer_head structure is left uninitialized! So when b_end_io
(and in turn end_that_request_first) is called, it looks at b_reqnext
and sees there's another bufhead waiting for processing. What happens
next is limited just by your imagination :-)

Also I observed the ELEVATOR_BACK_MERGE case also has the same problem
(bh->b_reqnext is left in a indefinite state). So maybe __make_request
always assumes that b_reqnext is initially NULL? In this case the bug is
in create_buffers which should NULLify this field. In any case, I'm
leaving the final solution up to kernel wizards.

--
Greetings,
   Andrew

P.S. If you reply to this letter, please cc: it to my address since I'm
not subscribed to this list.
