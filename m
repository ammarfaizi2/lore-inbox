Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264392AbTI2Sdu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 14:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbTI2Sd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 14:33:27 -0400
Received: from hera.cwi.nl ([192.16.191.8]:61122 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S264319AbTI2SdK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 14:33:10 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 29 Sep 2003 20:25:11 +0200 (MEST)
Message-Id: <UTC200309291825.h8TIPB318380.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, torvalds@osdl.org
Subject: Re: [PATCH] autofs sparse fixes
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

aeb:

        /* Our write does not write to user space */
        write = (ssize_t (*)(struct file *, const char *, size_t, loff_t *))
                file->f_op->write;

lbt:

	For cases like this, where we use a kernel pointer and do the 
	"set_fs(KERNEL_DS)" thing to make a user-pointer routine write
	to kernel space, I suggest casting the pointer instead of
	the function, along with a comment on the "set_fs()".

		set_fs(KERNEL_DS);

		/* This cast is legal due to the set_fs()! */
		data = (const void __user *) addr;

		...->write(file, data, bytes);
		set_fs(old_fs);

	See? That makes the cast more obvious, and it also makes it obvious
	_why_ the cast from kernel->user pointer is ok in this case.

Hmm. Yes. Hmm.
I have to admit that my cast is complicated, one might even say messy,
but as always - when something seems messy it can be made to look
less so by using more lines of code. E.g.,

	write = (write_to_kernel_t) file->f_op->write;

looks less intimidating, and write_to_kernel_t can be defined next to
write_proc_t that we have already.

I think I prefer two rights above two wrongs - the declaration
already gives addr the right type - it really does point to kernel space -
but we inherit an incorrect type for file->f_op->write, so have to cast
that.

Hmm. In reality maybe I have no strong feelings either way.
Will see what you do and possibly send some other version
of what you did not apply.

Andries


[Soon things get more interesting. These were the trivial cases,
with set_fs nearby and to a constant value. In other words, cases
where we know precisely what happens and only have to add a cast.
Intermezzo has a lot of code where the same code may be executed
with kernel and with user pointers.
Sendfile can use kernel or user pointers. It is declared with __user
so requires

        retval = in_file->f_op->sendfile(in_file, ppos, count, file_send_actor,
                                         (void __user *) out_file);

(fs/read_write.c:585 -- two wrongs indeed) where the type of pointer
is implicit in the actor.  Struct tty_operations has the field
	int  (*write)(struct tty_struct *tty, int from_user,
		      const unsigned char *buf, int count);
Etc. Lots of places where static markup does not suffice to show
which pointers point to user space. Pity. That diminishes the value
of __user markup greatly.]
