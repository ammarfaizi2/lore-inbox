Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264715AbSJOSWs>; Tue, 15 Oct 2002 14:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264736AbSJOSWs>; Tue, 15 Oct 2002 14:22:48 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:33695 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S264715AbSJOSWq>; Tue, 15 Oct 2002 14:22:46 -0400
Date: Tue, 15 Oct 2002 13:28:36 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
cc: arnd@bergmann-dalldorf.de, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: s390x build warnings from <linux/module.h>
In-Reply-To: <OF83D5DB36.D1321FFF-ONC1256C53.005AFE6B@de.ibm.com>
Message-ID: <Pine.LNX.4.44.0210151310220.10165-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Oct 2002, Martin Schwidefsky wrote:

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

Makes me wonder how you deal with function pointers, where the functions 
are possibly in a module - guess you have to use full 64 bit there? 
Doesn't it possibly make sense to hack module loading to put modules into 
< 4 GB as well, so you can use 32bit everywhere? Oh wait, or do use stub 
functions at < 4 GB for function pointers as well? Well, whatever, I 
obviously don't know much about .got, nor S390x for that matter.

> >The next thing I do not understand is why -fpic has the effect of marking
> >the section writeable, does it make .text writeable as well? And what for?
> 
> Because -fpic code likes to relocated absolute addresses.

I still don't see why someone would want to muck with modifying .text in a
shared lib, and I'm pretty sure that __ksymtab apart from the initial
relocation should not need further modification, OTOH that's a moot point
anyway, since gcc apparently marks it writeable and I don't see an easy
way to change that.

So, as far as I'm concerned I don't really care, modify module.h as you 
suggested or think about mapping module memory closer to the kernel, which 
might be a win performance-wise anyway.

--Kai


