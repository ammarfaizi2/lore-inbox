Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318880AbSHNPS4>; Wed, 14 Aug 2002 11:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318900AbSHNPS4>; Wed, 14 Aug 2002 11:18:56 -0400
Received: from d06lmsgate-5.uk.ibm.com ([195.212.29.5]:8637 "EHLO
	d06lmsgate-5.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S318880AbSHNPSz>; Wed, 14 Aug 2002 11:18:55 -0400
Content-Type: text/plain; charset=US-ASCII
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: S390 vs S390x, was Re: [kbuild-devel] Re: [patch] kernel config 3/N - move sound into drivers/media
Date: Wed, 14 Aug 2002 19:21:58 +0200
User-Agent: KMail/1.4.2
Cc: linux-kernel@vger.kernel.org
References: <20020814043558.GN761@cadcamlab.org> <200208141256.27680.arnd@bergmann-dalldorf.de> <20020814132011.A13932@infradead.org>
In-Reply-To: <20020814132011.A13932@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208141921.58931.arnd@bergmann-dalldorf.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 August 2002 14:20, Christoph Hellwig wrote:
> On Wed, Aug 14, 2002 at 12:56:27PM +0200, Arnd Bergmann wrote:
> > It's not logical, but it tends to help because it's what's meant most
> > of the time. I don't know a single place in the kernel where you want
> > to test for (CONFIG_ARCH_S390 && !CONFIG_ARCH_S390X).
>
> BTW, ho much differences are between arch/s390 and arch/s390x?  Is there
> any chance it could use the same #ifdef __LP64__ trick parisc uses for
> its 32 and 64bit versions?  so far every file I've looked at was duplicated
> exactly in s390 and s390x.

The biggest differences are that s390 has an fpu emulation while s390x has
emulation for s390 binaries. These are not an issue -- just an ifdef for 
the files. The other problem is that the assembly opcodes are different 
-- 64 bit instructions have a 'g' in the opcode so you need two versions
of each .S file and #ifdefs for each inline asm.

The remaining differences are stuff that depends on sizeof(void*) and some
more backwards compatible system calls for s390, the diff -u between these
is ~300kb out of 500kb of the common .c files. I'd expect this to become
at least 50 #ifdefs plus some moved files (e.g. s390x/kernel/ptrace.c ->
s390/kernel/ptrace64.c) and an audit of all places where the difference
is nonobvious.

I also had the idea to unify the two (actually have tried a few months ago
but did not bring it to a clean end), but was not really sure if it was a 
good one. Do you think it is worth the effort of merging the existing code
and changing all the documentation referring to arch/s390x?

We do indeed want to merge include/asm-s390 include/asm-s390x, which would
help building a compiler that supports both on s390x, but nobody has
worked on that recently -- I had done this for ~2.5.8 but it soon got
outdated.

	Arnd <><
