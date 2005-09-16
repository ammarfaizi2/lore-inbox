Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161211AbVIPSLd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161211AbVIPSLd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 14:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161217AbVIPSLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 14:11:33 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:29575 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161211AbVIPSLc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 14:11:32 -0400
Date: Fri, 16 Sep 2005 19:11:32 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, rolandd@cisco.com
Subject: [RFC] utterly bogus userland API in infinibad
Message-ID: <20050916181132.GF19626@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Exhibit A:

	opening uverbs... is done by ib_uverbs_open() (in
drivers/infinib*d/core/uverbs_main.c).   Aside of a number of obvious
leaks, it does a number of calls of ib_uverbs_event_init().  Each of
those does something amazingly bogus:
	* allocates a descriptor
	* allocates struct file
	* associates that struct file with root of their pseudo-fs
	* inserts it into caller's descriptor table
... and leaves an unknown number of those if open() fails, while we
are at it.  With zero indications for caller and no way to find out.

	What's more, you _can_ get those descriptors afterwards, if open()
had succeeded.  All you need to do is...

Exibit B:
	... write() to said descriptor.  Buffer should contain a struct
that will be interpreted.  Results will be written to user memory, at the
addresses contained in that struct.  Said results might include the
descriptors shat upon by open().  Nice way to hide an ioctl(), folks...

Note that this "interface" assumes that only original opener will write
to that file - for anybody else descriptors obviously will not make any
sense.

BTW, due to the way we do opens, if another thread sharing descriptor
table will guess the number of first additional descriptor to be opened
and just loops doing close() on it, we'll actually get our ib_uverbs_file
kfreed right under us.  

May I ask who had come up with that insanity?  Aside of inherent ugliness
and abuse of fs syscalls, it simply doesn't work.  E.g. leaks on failed
open() are going to be fun to fix...
