Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265794AbUF2QSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265794AbUF2QSa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 12:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265795AbUF2QS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 12:18:29 -0400
Received: from [66.199.228.3] ([66.199.228.3]:65285 "EHLO xdr.com")
	by vger.kernel.org with ESMTP id S265794AbUF2QS1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 12:18:27 -0400
Date: Tue, 29 Jun 2004 09:18:26 -0700
From: David Ashley <dash@xdr.com>
Message-Id: <200406291618.i5TGIQ8F028141@xdr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Cached memory never gets released
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ross Biro wrote:
>First it's absolutely normal for cache to fill up all available
>memory.  What's not normal is to not free unused cache when memory is
>needed.
>My best guess is that this isn't a kernel problem, but a bug in flash
>and all that memory really is used.  The next step I would do is go


In the thread this is made clear somewhat, but when I post new
emails I don't summarize all that is known about the problem.

I can kill all user processes, including mozilla,
XFree86, and everything else except an sshd to
log into the system, and the cache is still not
released.

The cached memory is just *gone*, no recovery, bye-bye, history.

I am experimenting with strace to see what mozilla is
doing. It does repeatedly
Open file X with O_EXCL and result is -1 EEXIST
Open file Y with O_EXCL and it is created
Close that file
Open file Y without O_EXCL
Allocate some memory
write to Y
close file Y
later unlink file Y

I tried duplicating this sequence of events thinking it
could be something related to the
create/write/close/delete sequence of a file,
perhaps the file's inode isn't getting freed. However my
test program didn't cause the same trouble.

Specifically the discussed strace output includes this:
mkdir("/root/mynfsarea/mozilla/plugtmp", 0777) = -1 EEXIST (File exists)
open("/root/mynfsarea/mozilla/plugtmp/ipg_template.swf", O_WRONLY|O_CREAT|O_TRUNC|O_EXCL|0x8000, 0600) = -1 EEXIST (File exists)
open("/root/mynfsarea/mozilla/plugtmp/ipg_template-1.swf", O_WRONLY|O_CREAT|O_TRUNC|O_EXCL|0x8000, 0600) = 30
close(30)                               = 0
open("/root/mynfsarea/mozilla/plugtmp/ipg_template-1.swf", O_WRONLY|O_CREAT|O_TRUNC|0x8000, 0600) = 30
brk(0x82d8000)                          = 0x82d8000
gettimeofday({1088521806, 310960}, NULL) = 0
brk(0x82d9000)                          = 0x82d9000
brk(0x82db000)                          = 0x82db000
brk(0x82dc000)                          = 0x82dc000
brk(0x82dd000)                          = 0x82dd000
brk(0x82de000)                          = 0x82de000
brk(0x82df000)                          = 0x82df000
brk(0x82e0000)                          = 0x82e0000
brk(0x82e1000)                          = 0x82e1000
brk(0x82e2000)                          = 0x82e2000
write(30, "FWS\6o\211\0\0x\0\7\320\0\0\27p\0\0\36\n\0C\2\377\377\377"..., 35183) = 35183
brk(0x82ea000)                          = 0x82ea000
close(30)                               = 0
... very much later in log
unlink("/root/mynfsarea/mozilla/plugtmp/ipg_template-1.swf") = 0


My thinking here is that every reload of the page steals about 200K
of cache memory that can never be recovered, and that
the total size of these files in the plugtmp directory (mozilla's
cache) is on the order of 200k.

-Dave
