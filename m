Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263750AbTI2QpN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 12:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263746AbTI2QpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 12:45:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:63721 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263750AbTI2QpI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 12:45:08 -0400
Date: Mon, 29 Sep 2003 09:44:50 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andries.Brouwer@cwi.nl
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] autofs sparse fixes
In-Reply-To: <UTC200309282325.h8SNPJT21048.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.44.0309290940530.23520-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


For cases like this, where we use a kernel pointer and do the 
"set_fs(KERNEL_DS)" thing to mak ea user-pointer routing write to kernel 
space, I suggest casting the pointer instead of the function, along with a 
comment on the "set_fs()".

Basically, something like this instead:

  static int autofs_write(struct file *file, const void *addr, int bytes)
  {
	const void __user *data;
	...

	set_fs(KERNEL_DS);
	/* This cast is legal due to the set_fs()! */
	data = (const void __user *) addr;

	...->write(file, data, bytes);
	set_fs(old_fs);
  }

See? That makes the cast more obvious, and it also makes it obvious _why_ 
the cast from kernel->user pointer is ok in this case.

		Linus

