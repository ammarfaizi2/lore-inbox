Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261222AbVABHlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbVABHlW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 02:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbVABHlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 02:41:21 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:27574 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S261222AbVABHlN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 02:41:13 -0500
Date: Sun, 2 Jan 2005 08:41:12 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Nick Warne <nick@linicks.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kswapd0 oops -> debug information
Message-ID: <20050102074112.GA31709@mail.13thfloor.at>
Mail-Followup-To: Nick Warne <nick@linicks.net>,
	linux-kernel@vger.kernel.org
References: <200411271311.25997.nick@linicks.net> <41A8B2EF.5090608@osdl.org> <200411271721.21847.nick@linicks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411271721.21847.nick@linicks.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 27, 2004 at 05:21:21PM +0000, Nick Warne wrote:
> On Saturday 27 November 2004 17:01, Randy.Dunlap wrote:
> 
> > kernel version?
> 
> Heh.  My great debug attempt, eh?
> 
> kernel 2.6.9
> 
> > .config file?
> > full oops message, with stack backtrace?
> > The stack backtrace could tell us who a bad caller is.
> > It can just be a caller's problem, not a bug in (this)
> > one isolated function.
> 
> http://linicks.net/kdebug/
> 
> > Did you read/check linux/REPORTING-BUGS ?
> 
> Yes, but wanted to try and learn myself on what was going on, rather than push 
> the onus onto other people.
> 
> The book I have re the make /dir/file.s states that it will produce assembler 
> with _line_ numbers to corresponding C code.  That is where I got lost, as it 
> doesn't.

hmm, sorry for the late reply, but better late
than not at all ...

if you do 
	
	make fs/file.s V=1

you'll see what make actually does to compile
the source code into assembler code ...

make -f scripts/Makefile.build obj=scripts/basic
make -f scripts/Makefile.build obj=scripts
make -f scripts/Makefile.build obj=fs fs/file.s
  gcc -Wp,-MD,fs/.file.s.d -nostdinc -iwithprefix include -D__KERNEL__ -Iinclude  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -O2     -fomit-frame-pointer -g -pipe -msoft-float -mpreferred-stack-boundary=2  -march=i586 -Iinclude/asm-i386/mach-default     -DKBUILD_BASENAME=file -DKBUILD_MODNAME=file -S -o fs/file.s fs/file.c 

and if that final gcc command does include a -g
(which can be controlled by CONFIG_DEBUG_INFO, or 
simply added by hand), then the output will contain
lines like this:

        .loc 1 45 0
        .loc 1 46 0

which reference the file and line number in the
source code. files are 'declared' with lines:

        .file   "file.c"
        .file 1 "fs/file.c"
        .file 2 "include/linux/posix_types.h"

so you can pretty easy find the code in the
source. a different, but sometimes easier approach
is to use 'addr2line' on the kernel binary (if it
was compiled with CONFIG_DEBUG_INFO) to get the
source line from a kernel address ...

	addr2line -e vmlinux c0123456

HTH,
Herbert

> Thanks,
> 
> Nick.
> 
> -- 
> "When you're chewing on life's gristle,
> Don't grumble, Give a whistle..."
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
