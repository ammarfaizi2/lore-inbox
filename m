Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262452AbVF2TRR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262452AbVF2TRR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 15:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262449AbVF2TRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 15:17:17 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:40932 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262447AbVF2TRG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 15:17:06 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Christian Zankel <chris@zankel.net>
Subject: Re: Xtensa syscalls (Was: Re: 2.6.12-rc5-mm1)
Date: Wed, 29 Jun 2005 21:11:20 +0200
User-Agent: KMail/1.7.2
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20050525134933.5c22234a.akpm@osdl.org> <200506291542.02618.arnd@arndb.de> <42C2CAB8.1080402@zankel.net>
In-Reply-To: <42C2CAB8.1080402@zankel.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506292111.21309.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Middeweken 29 Juni 2005 18:22, Christian Zankel wrote:
> The question is, if we had to break glibc compatibility, shouldn't we 
> use the opportunity to clean-up the syscall list? It was copied from 
> MIPS and, thus, has inherited a lot of legacy from there. As a new 
> architecture, maybe we should even go as far as removing all ni-syscalls 
> and start fresh?

I tried to make the patch in a way that at least the majority of binaries
built against the reduced set of syscalls would still work with old kernels,
though typically not the other way round.

If you don't mind reordering the syscalls, you could even take this
a few steps further:

- remove all 32 bit file syscalls that have a 64 bit replacement
  (e.g. pread, lseek)
- remove all legacy signal handling in favor of rt_sig*
- remove struct stat and rename struct stat64 to stat
- remove wait4 in favor of waitid
- use utimes instead of utime
- use normal calling conventions for sys_pipe
- split sys_xtensa into separate sys_atomic_{set,exg_add,add,cmp_swp}
- if you are still motivated, make this setup the default for an empty
  arch/*/kernel/syscalls.c and no __ARCH_WANT_FOO definitions to make it
  easier to explain to the next architecture port maintainer.

	Arnd <><
