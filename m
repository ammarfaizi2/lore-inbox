Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261376AbTAWT0r>; Thu, 23 Jan 2003 14:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261456AbTAWT0r>; Thu, 23 Jan 2003 14:26:47 -0500
Received: from inet-mail4.oracle.com ([148.87.2.204]:27099 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id <S261376AbTAWT0q>; Thu, 23 Jan 2003 14:26:46 -0500
Date: Thu, 23 Jan 2003 11:35:40 -0800
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Thomas Schlichter <schlicht@uni-mannheim.de>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: no version magic, tainting kernel.
Message-ID: <20030123193540.GD13137@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <200301231459.22789.schlicht@uni-mannheim.de> <20030123165256.GA1092@mars.ravnborg.org> <200301231832.59942.schlicht@uni-mannheim.de> <20030123182236.GA14184@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030123182236.GA14184@mars.ravnborg.org>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can't the stuff in init/vermagic.c be moved into a header file? Maybe
vermagic.h? Most of the code can be cut 'n pasted right out of vermagic.c
and the bit that defines "const char vermagic[]..." could be placed inside a
macro which modules would then stick in the bottom of one of their c files.
This is what I'm getting at (warning I haven't checked this code or even
tried to clean it up):

in vermagic.h:
#include <linux/version.h>
#include <linux/module.h>

/* Simply sanity version stamp for modules. */
#ifdef CONFIG_SMP
#define MODULE_VERMAGIC_SMP "SMP "
#else
#define MODULE_VERMAGIC_SMP ""
#endif
#ifdef CONFIG_PREEMPT
#define MODULE_VERMAGIC_PREEMPT "preempt "
#else
#define MODULE_VERMAGIC_PREEMPT ""
#endif
#ifndef MODULE_ARCH_VERMAGIC
#define MODULE_ARCH_VERMAGIC ""
#endif

#define KERNEL_VERSIONMAGIC const char vermagic[]			\
__attribute__((section("__vermagic"))) =				\
       UTS_RELEASE " "							\
       MODULE_VERMAGIC_SMP MODULE_VERMAGIC_PREEMPT MODULE_ARCH_VERMAGIC	\
       "gcc-" __stringify(__GNUC__) "." __stringify(__GNUC_MINOR__)


in my_external_module.c, and init/vermagic.c I'd just do:
#include <linux/vermagic.h>
KERNEL_VERSIONMAGIC();

and be done with it.

Modules that ship with the kernel wouldn't have to change a thing (and still
be linked against vermagic.c, and it'd only add two lines of code to
everyones externally shipped modules. I don't really think that this would be
"doing too much" for those whose modules are included in Linus's kernel, and
it wouldn't require people to keep entire source tree's around to compile a
module or two...
Am I totally missing something here or wouldn't this solve our problem?
Someone please correct me if I'm wrong :)
	--Mark

On Thu, Jan 23, 2003 at 07:22:36PM +0100, Sam Ravnborg wrote:
> As it is today the only sane way is to have the full kernel src available.
> It should be possible to minimize that - but I do not feel tempted to
> do so.
> 
> We want to do too much to rely on whatever makefile people write for
> their module.
> 
> 	Sam
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--
Mark Fasheh
Software Developer, Oracle Corp
mark.fasheh@oracle.com
