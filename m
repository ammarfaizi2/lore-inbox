Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265013AbUFMGki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265013AbUFMGki (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 02:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265015AbUFMGkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 02:40:36 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:24154 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S265013AbUFMGke (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 02:40:34 -0400
Date: Sat, 12 Jun 2004 23:39:37 -0700
From: Paul Jackson <pj@sgi.com>
To: Clemens Schwaighofer <schwaigl@eunet.at>
Cc: gullevek@gullevek.org, linux-kernel@vger.kernel.org, cs@tequila.co.jp
Subject: Re: compile error with 2.6.7-rc3-mm1
Message-Id: <20040612233937.4367e7fe.pj@sgi.com>
In-Reply-To: <40CBF29D.3080400@eunet.at>
References: <40C9AF48.2040807@gullevek.org>
	<20040611062829.574db94f.pj@sgi.com>
	<40CA6835.2070405@eunet.at>
	<20040612034430.72a8207e.pj@sgi.com>
	<40CBC809.3000102@eunet.at>
	<20040612204207.0136b76f.pj@sgi.com>
	<40CBD251.4000601@eunet.at>
	<20040612212024.0bbec683.pj@sgi.com>
	<40CBF29D.3080400@eunet.at>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> okay, I have the "Bad" one. Whatever that means, it seems bad :)

Ok - that's progress.

Then whatever cpumask.h file you are using to compile that code does not
have the fix you think it has.

If you're still stuck, send the output of doing the four commands:

    rm -f drivers/perfctr/x86.i
    make V=1 drivers/perfctr/x86.i | fmt -s
    grep -2 define.CPU_MASK_NONE include/linux/cpumask.h
    grep -2 old_mask.= drivers/perfctr/x86.i

By way of example, when I do these four commands, I get:

    $ rm -f drivers/perfctr/x86.i
    $ make V=1 drivers/perfctr/x86.i | fmt -s
    make -f scripts/Makefile.build obj=scripts/basic
    make -f scripts/Makefile.build obj=scripts
    make -f scripts/Makefile.build obj=drivers/perfctr drivers/perfctr/x86.i
      gcc -E -Wp,-MD,drivers/perfctr/.x86.i.d -nostdinc -iwithprefix
      include -D__KERNEL__ -Iinclude  -Wall -Wstrict-prototypes
      -Wno-trigraphs -fno-strict-aliasing -fno-common -pipe
      -msoft-float -mpreferred-stack-boundary=2  -march=pentium4
      -mregparm=3 -Iinclude/asm-i386/mach-default -O2 -fomit-frame-pointer
      -DKBUILD_BASENAME=x86 -DKBUILD_MODNAME=x86   -o drivers/perfctr/x86.i
      drivers/perfctr/x86.c
    $ grep -2 define.CPU_MASK_NONE include/linux/cpumask.h
    #endif

    #define CPU_MASK_NONE                                                   \
    ((cpumask_t){ {                                                         \
	    [0 ... BITS_TO_LONGS(NR_CPUS)-1] =  0UL                         \
    $ grep -2  old_mask.= drivers/perfctr/x86.i
	    cpumask_t old_mask;

	    old_mask = ((cpumask_t){ { [0 ... (((8)+32 -1)/32)-1] = 0UL } });
	    clear_perfctr_cpus_forbidden_mask();



-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
