Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263260AbTJBGnt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 02:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263263AbTJBGnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 02:43:49 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:35384 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S263260AbTJBGnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 02:43:47 -0400
To: Sam Ravnborg <sam@ravnborg.org>
Cc: "David S. Miller" <davem@redhat.com>, Andreas Steinmetz <ast@domdv.de>,
       axboe@suse.de, schilling@fokus.fraunhofer.de,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel includefile bug not fixed after a year :-(
References: <200309301144.h8UBiUUF004315@burner.fokus.fraunhofer.de>
	<20030930115411.GL2908@suse.de> <3F797316.2010401@domdv.de>
	<20030930052337.444fdac4.davem@redhat.com>
	<20030930161018.GA900@mars.ravnborg.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 02 Oct 2003 00:42:43 -0600
In-Reply-To: <20030930161018.GA900@mars.ravnborg.org>
Message-ID: <m1lls4gmxo.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg <sam@ravnborg.org> writes:

> On Tue, Sep 30, 2003 at 05:23:37AM -0700, David S. Miller wrote:
> > 
> > Suggest changes to fix the problems, but just saying "don't include
> > kernel header in your user apps, NYAH NYAH NYAH!" does not help
> > anyone at all.

One nasty part of the issue is that glibc has decided it is the master
of types and the glibc ABI is not compatible with the kernel ABI with
some fundamental types like dev_t.
 
> I really liked the proposal that Matthew Wilcox came up with:
> 
> Todays hirachi:
> include/linux		=>	Kernel wide internal
> include/sub-system	=>	sub-system internal
> include/asm-$(ARCH)	=>	arch specific
> include/asm		=>	symlink to include/asm-$(ARCH)
> include/asm-generic	=>	default arch implementations
> 
> Additional hirachy:
> usr/include/linux-abi	=>	kernel wide ABI
> usr/include/abi-$(ARCH)	=>	arch specifics ABI
> usr/include/arch-abi	=>	symlink to above

One case that does not handle cleanly because of the symlink
is cross compilation.  With a proliferation of 32/64bit architectures
I think that is something worth considering.

So I would make that:
include/linux-abi/              => kernel wide ABI
include/linux-abi/abi-$(ARCH)/  => arch specifics ABI
include/linux-abi/features.h    => Environment abstractor.

<linux-abi/features.h> would define a macro __LINUX_ARCH that used
like:  ``#include __LINUX_ARCH(syscalls.h)''

And the __LINUX_ARCH(X) would expand to the include directory
for the various architectures as appropriate.  

Something else that needs to happen is that all definitions that
are in flux should be surrounded with an #ifdef LINUX_EXPERIMENTAL or
something similar.  So people don't start using an ABI that is in
flux by mistake.

All type names need to have a __linux_ prefix so we do not pollute
the C namespace, and because our types and the types glibc
exports to user space are different.

All defines for ioctls and the like should be prefixed with __LINUX_
again because user space may be doing something different. 

For glibc and the like it should be easy enough to write a perl
script that identify what definitions are in the headers and creates
definitions for their saner cousins.  It is either that or we need
to define an interface definition language and have tools to process
that.

Fixed sized types need to be derived from stdint.h when compiling
in user space, so they work with any weird compiler around.

We should make this the plan of record for 2.7.  But this is nothing
to rush into because once it is decided what the architecture is going
to be or where a definition should live we really cannot move it,
except during the kernel development cycle when the definitions are
introduced.  

Eric
