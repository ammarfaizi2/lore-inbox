Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266184AbUA2SIf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 13:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266167AbUA2SIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 13:08:35 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:56525
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S266184AbUA2SII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 13:08:08 -0500
Message-ID: <40194B6D.6060906@redhat.com>
Date: Thu, 29 Jan 2004 10:05:33 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040118
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] linux-2.6.2-rc2_vsyscall-gtod_B1.patch
References: <1075344395.1592.87.camel@cog.beaverton.ibm.com> <401894DA.7000609@redhat.com> <20040129132623.GB13225@mail.shareable.org>
In-Reply-To: <20040129132623.GB13225@mail.shareable.org>
X-Enigmail-Version: 0.83.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jamie Lokier wrote:

> I like the second approach more.  You can change glibc to look up the
> weak symbol for _all_ syscalls, then none of them are special and it
> will work with future kernel optimisations.

Symbol lookups are slow.  And they require the syscall stubs to suddenly
set up the usual PIC infrastructure since a jump through the PLT is
used.  This is much slower than the extra indirection the vdso could do.

The vdso is just one of the DSOs in the search path and usually the very
last.  So there would be possible many objects which are looked at
first, unsuccessfully.

And another problem I should have mentioned last night: in statically
linked applications the vDSO isn't used this way.  Do dynamic linker
functionality is available.  We find the vDSO through the auxiliary
vector and use the absolute address, not the symbol table of the vDSO.
If the syscall entry in the vDSO would do the dispatch automatically,
statically linked apps would benefit from the optimizations, too.
Otherwise they are left out.


- -- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAGUtt2ijCOnn/RHQRAgLwAKCcvvzg/FB8/8C+Jo1I6wfWBju25gCeKr4z
kErg4cvJuxBvmRltLF4AxEE=
=f2aR
-----END PGP SIGNATURE-----
