Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266072AbUA2FHL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 00:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266083AbUA2FHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 00:07:11 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:1994 "EHLO
	myware.akkadia.org") by vger.kernel.org with ESMTP id S266072AbUA2FHJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 00:07:09 -0500
Message-ID: <401894DA.7000609@redhat.com>
Date: Wed, 28 Jan 2004 21:06:34 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040118
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] linux-2.6.2-rc2_vsyscall-gtod_B1.patch
References: <1075344395.1592.87.camel@cog.beaverton.ibm.com>
In-Reply-To: <1075344395.1592.87.camel@cog.beaverton.ibm.com>
X-Enigmail-Version: 0.83.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

john stultz wrote:

> Please let me know if you have any comments or suggestions. 

I really don't like this special address in the vdso approach.  Yes,
it's unfortunately done for x86-64 as well but this doesn't mean the
mistakes have to be repeated.

Ideally there will be a couple more syscalls which over time can at
least partially be handled at userlevel in the vdso.  Do you want to add
a new special address for each of them?

There are two ways two avoid this which are easy to support in the
current framework:

~ to transparently invoke the optimized syscalls change the DSO entry
code to do a table lookup.  The table content are pointers to code.  By
default, it points to the syscall code we now use.  If there is a
special version of the syscall point to that code and see it magically
called.  No need for libc changes, old libcs automatically take
advantage of the optimizations.  No information about the optimizations
is spilled out to userlevel.

~ alternatively use the symbol table the vdso has.  Export the new code
only via the symbol table.  No fixed address for the function, the
runtime gets it from the symbol table.  glibc will use weak symbol
references; if the symbol isn't there, the old code is used.  This will
require that every single optimized syscall needs to be handled special.


I personally like the first approach better.  The indirection table can
maintained in sync with the syscall table inside the kernel.  It all
comes at all times from the same source.  The overhead of the memory
load should be neglectable.

- -- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAGJTa2ijCOnn/RHQRArL2AJ9ULsq2xl3m8TNLNkJydPzrmhQXbACgrlhe
uYIrFlankjw1TIU5W/AdvBA=
=yP4a
-----END PGP SIGNATURE-----
