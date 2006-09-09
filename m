Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbWIIJbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbWIIJbl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 05:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbWIIJbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 05:31:41 -0400
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:6254 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751099AbWIIJbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 05:31:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=jTF9UFd7o6ZXEMz1X+KUnH81rN32iqSwG8WotvAiqa+HznsLpiuWe8PK3GHE3CYLKeCGBystqVaE1g8syR4eox2T5PeGBUcEm0iKvZABaL7700MnakSDNK9HBxQwJWfpsOmeGUFnf368IXLDaeETTyXZ15PGIp0v1wDwoYqLdQE=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: i.r.wezeman@hetnet.nl
Subject: Re: [uml-devel] Re: Partial fix! - Was: Re: [BUG report] UML linux-2.6 latest BK doesn't compile
Date: Sat, 9 Sep 2006 11:31:36 +0200
User-Agent: KMail/1.9.1
Cc: user-mode-linux-devel@lists.sourceforge.net,
       "Jeff Dike" <jdike@addtoit.com>, "Anton Altaparmakov" <aia21@cam.ac.uk>,
       "lkml" <linux-kernel@vger.kernel.org>
References: <1107857395.15872.2.camel@imp.csi.cam.ac.uk> <200503132106.35599.blaisorblade@yahoo.it> <EBD0B8CF381E8B44BB99E8EA137E27C0021AD010@CPEXBE-EML06.kpnsp.local>
In-Reply-To: <EBD0B8CF381E8B44BB99E8EA137E27C0021AD010@CPEXBE-EML06.kpnsp.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609091131.36909.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 09 September 2006 00:25, i.r.wezeman@hetnet.nl wrote:
> Hi there.
> 
> I got a error undefined reference to `__bb_init_func' when
> compiling uml with kernel 2.6.17.6, gcc 4.1.1 and glibc-2.4

Ok, that's new. The below mail is about a very similar problem but with an 
older Gcc, and since these symbols are provided by gcc, this makes a 
difference.

Try removing from arch/um/kernel/gmon_syms.c these 2 lines:

extern void __bb_init_func(void *);
EXPORT_SYMBOL(__bb_init_func);

and recompiling. Better yet, try if adding the weak attribute like below fixes 
the problem:

extern void __bb_init_func(void *) __attribute__((weak));
EXPORT_SYMBOL(__bb_init_func);

Another possible thing to check is what happens with CONFIG_STATIC_LINK=y 
(edit it by hand and do not enable GPROF for now, that is yet another thing).

> Done: make clean && make distclean && make allmodconfig ARCH=um

> # CONFIG_GPROF is not set
> CONFIG_GCOV=y

This results from allmodconfig? Mmpf, that is not so nice (allmodconfig should 
not result in a debug kernel). Even if allmodconfig is not a _smart_ setting 
(set to y or m everything).

> #
> # UML-specific options
> #
> # CONFIG_MODE_TT is not set
> # CONFIG_STATIC_LINK is not set
> CONFIG_MODE_SKAS=y

> Build: make linux ARCH=um
> 
> 
> edit file: uml/arch/um/os-Linux/sys-i386/registers.c

> Ending:
> 
> arch/um/kernel/built-in.o:(__ksymtab+0x238): undefined reference to
> `__bb_init_func'
> arch/um/os-Linux/built-in.o: In function `do_syscall_stub':
> arch/um/os-Linux/skas/mem.c:63: undefined reference to
> `get_safe_registers'
> arch/um/os-Linux/built-in.o: In function `copy_context_skas0':
> arch/um/os-Linux/skas/process.c:333: undefined reference to
> `get_safe_registers'

Since it arrives to this point, get_safe_register should be undefined only 
because of the previous failure.

> I see it must be solved. So wat is happend now?
> 
> Ron Wezeman
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
