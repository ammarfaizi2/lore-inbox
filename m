Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263232AbSJOSPH>; Tue, 15 Oct 2002 14:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264631AbSJOSPG>; Tue, 15 Oct 2002 14:15:06 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:45522 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S263232AbSJOSPE>; Tue, 15 Oct 2002 14:15:04 -0400
Date: Tue, 15 Oct 2002 14:19:48 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>, arnd@bergmann-dalldorf.de,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: s390x build warnings from <linux/module.h>
Message-ID: <20021015141948.V5659@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <OF83D5DB36.D1321FFF-ONC1256C53.005AFE6B@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <OF83D5DB36.D1321FFF-ONC1256C53.005AFE6B@de.ibm.com>; from schwidefsky@de.ibm.com on Tue, Oct 15, 2002 at 06:50:12PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 06:50:12PM +0200, Martin Schwidefsky wrote:
> 
> >> during 'make modules' on s390x, I see lots of warnings about 'ignoring
> >> changed section attributes for __ksymtab' that I have found to be the
> >> result of changeset 1.373.196.1, where Kai changed the defaults for
> module
> >> exports to 'no symbols exported'.
> >>
> >> The problem is that there is a section '__ksymtab,"a"', while s390x
> >> requires it to be '__ksymtab,"aw"' because modules must be compiled with
> >> '-fpic' here, unlike afaics all the other architectures.
> >
> >Hmmh, there's a couple of things I don't understand, though they're most
> >likely there for a reason. First of all, why do you need -fpic at all?
> >kernel modules are not shared, they should get properly relocated when
> >insmod'ing them, so I don't see why you're doing that.
> 
> The reason for -fpic for module code lies in the compiler. To improve the
> code we use the brasl and larl instructions for function calling and
> addressing data. Unluckily these two instructions have a limited range
> of +-4GB. For user space programs that means that a single shared object
> may not be bigger than 4GB and that no non-fpic code is linked into
> shared objects. With these two restrictions we are able to generate
> much better code. There is one small problem though: kernel modules.
> They get loaded into the vmalloc area which is located AFTER the main
> memory. A machine with more than 4 GB of main memory therefore can't
> load modules anymore because the calls and references to kernel structure
> can't span the distance between vmalloc area and kernel image. To get
> around this problem we compile kernel modules with -fpic and make the
> modutils create plt stubs and got entries. Easy ?

Is there any reason why you cannot implement module_map and module_unmap
on s390x like sparc64 or x86-64 does?
I don't think we'll have size of kernel + size of all modules approaching
2 or 4GB size any time soon on any architecture.

	Jakub
