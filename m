Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272774AbTHEOKh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 10:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272790AbTHEOKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 10:10:37 -0400
Received: from mivlgu.ru ([81.18.140.87]:51890 "EHLO mail.mivlgu.ru")
	by vger.kernel.org with ESMTP id S272774AbTHEOKd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 10:10:33 -0400
Date: Tue, 5 Aug 2003 18:10:25 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: 2.4.22-pre7 drivers/i2c/i2c-dev.c user/kernel bug and
 mem leak
Message-Id: <20030805181025.72ad4819.vsu@altlinux.ru>
In-Reply-To: <20030805103240.02221bed.khali@linux-fr.org>
References: <20030803192312.68762d3c.khali@linux-fr.org>
	<20030804193212.11786d06.vsu@altlinux.ru>
	<20030805103240.02221bed.khali@linux-fr.org>
X-Mailer: Sylpheed version 0.9.4cvs2 (GTK+ 1.2.10; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Aug 2003 10:32:40 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> > The current code takes rdwr_arg.msgs (which is a userspace pointer)
> > and then reads rdwr_arg.msgs[i].buf directly, which must not be done.
> 
> The reason why this must not be done is unknown to me. This is why I am
> having a hard time figuring why a fix is necessary. If someone can
> explain this to me (off list I guess, unless it is of general interest),
> he/she would be welcome.

All userspace access from the kernel code must be guarded - otherwise
an invalid address supplied by a buggy or malicious program can crash
the kernel or make it perform something which is not normally allowed.
Unchecked userspace access is a security problem.

In this particular case the address has already been checked by
copy_from_user() before - but the access still is not safe. Example:

1) A multithreaded program calls the I2C_RDWR ioctl in one thread,
passing some valid address in rdwr_arg.msgs. The code in i2c-dev gets
the supplied parameters and calls i2c_transfer(), which sleeps.

2) While the first thread is sleeping somewhere inside i2c_transfer(),
the second thread unmaps the page where the rdwr_arg.msgs array was
located.

3) When i2c_transfer() completes, the I2C_RDWR handling code will try
to copy the returned data to the user memory, and will try to access
rdwr_arg.msgs[i].buf in the loop. But now this page is inaccessible,
and the access will result in Oops.

Also see the recent LKML postings (Kernel Traffic #224, "Better
Support For Big-RAM Systems"); with the 4G/4G configuration described
there, direct userspace access will not work at all.

> Anyway, since you seem to agree with Robert T. Johnson on the fact that
> this needs to be fixed, I have to believe you. But then again I am not
> sure I understand how different your code is from the original one if
> copy_to_user and copy_from_user are regular functions. Are these macros?

Yes, hairy macros with assembler tricks.

> Maybe taking a look at them would help me understand how the whole thing
> works.

You should not depend on implementation details. All userspace access
must be performed through the documented macros. Doing something other
is a bug - possibly a very dangerous one.

> > Because both the userspace pointer and the kernel buffer pointer are
> > needed, a second copy must be made.
> 
> OK, I get this now (wasn't that obvious at first, especially because I
> hadn't realized the values were used again after i2c_transfer).
> 
> > If you want to conserve memory, you may just allocate an array
> > of pointers to keep the userspace buffer pointers during the
> > transfer.
> 
> Definitely better than what Robert T. Johnson first proposed. This makes
> it really clear what data actually needs to be "duplicated" and what
> doesn't.
> 
> > BTW, an optimization is possible here: the whole rdwr_arg.msgs array
> > can be copied into the kernel memory with one copy_from_user() instead
> > of copying its items one by one.
> 
> Nice one, I like it.
> 
> > > Contrary to the proposed fix, my fix does not slow down the
> > > non-faulty cases. I also believe it will increase the code size by
> > > fewer bytes than the proposed fix (not verified though).
> > 
> > This fix should work too. Yet another way is to do ++i there, but that
> > would be too obscure.
> 
> I don't find it that obscure, and after thinking about it for some
> times, I even find it more elegant. And I guess it's smaller
> (binary-code-wise), although I admit it's almost pointless.
> 
> > Here is my version (with the mentioned optimization - warning: not
> > even compiled):
> 
> Really, I like it much more than Robert's one. It's probably faster,
> uses less memory, and was easier to read and understand.
> 
> Here comes my version, which is basically yours modified. If it pleases
> everyone, we could apply it to 2.4.22-pre10 and i2c-CVS.
> 
> Changes:
> 1* Amount of white space, twice. Ignore.
> 2* Use ++i instead of kfree as discussed above.
> 3* Remove conditional test around i2c_transfer, since it isn't necessary
> (if I'm not missing something).

Yes, looks like the test is redundant.

> diff -ru drivers/i2c/i2c-dev.c drivers/i2c/i2c-dev.c
[patch skipped]

Looks good to me.
