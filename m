Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266868AbTAZMXz>; Sun, 26 Jan 2003 07:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266876AbTAZMXz>; Sun, 26 Jan 2003 07:23:55 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:44538 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id <S266868AbTAZMXx>; Sun, 26 Jan 2003 07:23:53 -0500
Date: Sun, 26 Jan 2003 14:29:23 +0100
From: Christian Zander <zander@minion.de>
To: Mark Fasheh <mark.fasheh@oracle.com>
Cc: Thomas Schlichter <schlicht@uni-mannheim.de>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: no version magic, tainting kernel.
Message-ID: <20030126132923.GB396@kugai>
Reply-To: Christian Zander <zander@minion.de>
References: <200301231459.22789.schlicht@uni-mannheim.de> <20030123165256.GA1092@mars.ravnborg.org> <200301231832.59942.schlicht@uni-mannheim.de> <20030123182236.GA14184@mars.ravnborg.org> <20030123193540.GD13137@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030123193540.GD13137@ca-server1.us.oracle.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2003 at 11:35:40AM -0800, Mark Fasheh wrote:
>
> Can't the stuff in init/vermagic.c be moved into a header file?
> Maybe vermagic.h? Most of the code can be cut 'n pasted right out of
> vermagic.c and the bit that defines "const char vermagic[]..." could
> be placed inside a macro which modules would then stick in the
> bottom of one of their c files.  This is what I'm getting at
> (warning I haven't checked this code or even tried to clean it up):
> 
> in vermagic.h:
> #include <linux/version.h>
> #include <linux/module.h>
> 
> /* Simply sanity version stamp for modules. */
> #ifdef CONFIG_SMP
> #define MODULE_VERMAGIC_SMP "SMP "
> #else
> #define MODULE_VERMAGIC_SMP ""
> #endif
> #ifdef CONFIG_PREEMPT
> #define MODULE_VERMAGIC_PREEMPT "preempt "
> #else
> #define MODULE_VERMAGIC_PREEMPT ""
> #endif
> #ifndef MODULE_ARCH_VERMAGIC
> #define MODULE_ARCH_VERMAGIC ""
> #endif
> 
> #define KERNEL_VERSIONMAGIC const char vermagic[]			\
> __attribute__((section("__vermagic"))) =				\
>        UTS_RELEASE " "							\
>        MODULE_VERMAGIC_SMP MODULE_VERMAGIC_PREEMPT MODULE_ARCH_VERMAGIC	\
>        "gcc-" __stringify(__GNUC__) "." __stringify(__GNUC_MINOR__)
> 
> 
> in my_external_module.c, and init/vermagic.c I'd just do:
> #include <linux/vermagic.h>
> KERNEL_VERSIONMAGIC();
> 
> and be done with it.
> 
> Modules that ship with the kernel wouldn't have to change a thing
> (and still be linked against vermagic.c, and it'd only add two lines
> of code to everyones externally shipped modules. I don't really
> think that this would be "doing too much" for those whose modules
> are included in Linus's kernel, and it wouldn't require people to
> keep entire source tree's around to compile a module or two...  Am I
> totally missing something here or wouldn't this solve our problem?
> Someone please correct me if I'm wrong :)
>

I wouldn't go as far as saying that the current solution imposes an
onerous requirement on any user wishing to build third-party modules
by relying on a complete and properly configured kernel source tree,
but it certainly seems like a step backwards from Linux 2.4, where
properly configured kernel headers are sufficient.

Of course, this only holds true for external projects using kbuild to
build the modules; other build systems would not only require that a
complete, configured kernel source tree be installed, they would also
rely on that source tree to be uncleaned since they have no knowledge
of how init/vermagic.o is to be built (and shouldn't make assumptions,
not considering possible legal/licensing implications). This I really
do consider an unnecessary, burdensome prerequisite.


Since I'm not intimately familiar with kbuild, I'm also wondering if
this scenario would be a problem:

Somebody downloaded Linux 2.5.59, configured it and built it using a
pre-3.0 version of gcc, e.g. gcc 2.95. The user had plenty of disk
space and decided, based on past experiences, that leaving the source
tree uncleaned is least likely to cause problems, should he/she ever
be intersted in building third-party modules. For some time, the user
placed no interest in external modules and used his/her system quite
happily; with the release of a new, improved version of a driver, the
user decided that he wants to give it a try, however, and built the
driver module, which picked up init/vermagic.o; our imaginary user is
using a distribution that provides frequent updates and he/she makes
regular use of this service - it just so happens that one of these
updates installed gcc 3.0 as the new default compiler. The new module
is thus built using gcc 3.0, but init/vermagic.o still indicates gcc
2.95; the module loader will erroneously believe everything is fine.


I agree with Mark that moving the code in init/vermagic.c into a new
header file like linux/vermagic.h is a better solution.

-- 
christian zander
zander@minion.de
