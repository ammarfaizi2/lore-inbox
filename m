Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbUCGGL5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 01:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261765AbUCGGL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 01:11:57 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:22448
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S261764AbUCGGLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 01:11:55 -0500
Message-ID: <404ABD06.4060607@redhat.com>
Date: Sat, 06 Mar 2004 22:11:18 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040306
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mike@navi.cx
CC: linux-kernel@vger.kernel.org
Subject: Re: Potential bug in fs/binfmt_elf.c?
References: <1078508281.3065.33.camel@linux.littlegreen>	 <404A1C71.3010507@redhat.com> <1078607410.10313.7.camel@linux.littlegreen>
In-Reply-To: <1078607410.10313.7.camel@linux.littlegreen>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Mike Hearn wrote:

>   LOAD           0x000000 0x00000000 0x00000000 0x00bc4 0x00bc4 R E 0x1000
>   LOAD           0x000bc4 0x00000bc4 0x00000bc4 0x00150 0x00154 RW  0x1000
>   DYNAMIC        0x000bd0 0x00000bd0 0x00000bd0 0x00108 0x00108 RW  0x4
>   LOAD           0x001000 0x00400000 0x00400000 0x00000 0x10000000 R   0x1000

Not everything which can be expressed in ELF is supported.  You don't
want to load something, you want to reserve address space.  And you want
it allocated in a certain way.  The ELF loader is no generic ELF
interpreter.

Now, if the only problem is the overcommit and making the do_brk() call
allocate the memory as read-only a change to the do_brk() interface
might be acceptable (well, ask somebody doing mm hacking).  I wouldn't
be entirely sure whether read-only pages alone are enough.  This does
not open any new holes as far as I can see.

I'd say experiment with it and add a flags parameter which is the right
combination of VM_READ | VM_WRITE | VM_EXEC.  All calls but the one in
binfmt_elf.c should pass all read bits, the one in binfmt_elf can
respect the binaries flags.  You must be sure, though, that the last
page of the data area (i.e., writable area) in a regular binary is not
mapped read-only.

- -- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFASr0L2ijCOnn/RHQRAjtZAJ931c+0Czw8jJc0kOv1+lIMyVLEOgCgtj3f
aHnlBUWz8qFQitDqVBWyPpc=
=f2UN
-----END PGP SIGNATURE-----
