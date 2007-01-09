Return-Path: <linux-kernel-owner+w=401wt.eu-S932186AbXAIUoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbXAIUoY (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 15:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbXAIUoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 15:44:23 -0500
Received: from smtp-102-tuesday.nerim.net ([62.4.16.102]:3227 "EHLO
	kraid.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932186AbXAIUoX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 15:44:23 -0500
Date: Tue, 9 Jan 2007 21:44:21 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Andrey Borzenkov <arvidjaar@mail.ru>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>,
       Herbert Poetzl <herbert@13thfloor.at>, Olaf Hering <olaf@aepfle.de>
Subject: Re: .version keeps being updated
Message-Id: <20070109214421.281ff564.khali@linux-fr.org>
In-Reply-To: <20070109170550.AFEF460C343@tzec.mtu.ru>
References: <20070109102057.c684cc78.khali@linux-fr.org>
	<20070109170550.AFEF460C343@tzec.mtu.ru>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On Tue, 09 Jan 2007 20:05:49 +0300, Andrey Borzenkov wrote:
> Jean Delvare wrote:
> > Since 2.6.20-rc1 or so, running "make" always builds a new kernel with
> > an incremented version number, whether there has actually been any
> > change done to the code or configuration or not. This increases the
> > build time quite a bit.
> > 
> > I've tracked it down to include/linux/compile.h always being updated,
> > and this is because .version is updated. I couldn't find what is
> > causing .version to be updated each time though. Can anybody help
> > there? Was this change made on purpose or is this a bug which we should
> > fix? 
> 
> I have been bitten by this as well; I have tracked it down to defining
> CONFIG_KALLSYMS:
> 
> define rule_vmlinux__
>         :
>         $(if $(CONFIG_KALLSYMS),,+$(call cmd,vmlinux_version))
> 
> quiet_cmd_vmlinux_version = GEN     .version
>       cmd_vmlinux_version = set -e;                     \
>         if [ ! -r .version ]; then                      \
>           rm -f .version;                               \
>           echo 1 >.version;                             \
>         else                                            \
>           mv .version .old_version;                     \
>           expr 0$$(cat .old_version) + 1 >.version;     \
>         fi;                                             \
>         $(MAKE) $(build)=init
> 
> 
>  Pondering about it, this may be a feature not a bug. Let's assume you have
> changed a single function name anywhere - you need to rebuild kallsyms
> (ergo vmlinux) for that.
> 
> OTOH I do not know if kallsyms include also symbols from modules; if no,
> this is indeed a bug.

I don't think this is the problem here. The kernel keeps being
recompiled even when _nothing_ has changed. This wasn't the case up to
2.6.19, while the code above has been there untouched since 2.6.14.

I tried a git bisect to find out what commit was reponsible for it, and
the winner is...

8993780a6e44fb4e7ed34e33458506a775356c6e is first bad commit
commit 8993780a6e44fb4e7ed34e33458506a775356c6e
Author: Linus Torvalds <torvalds@woody.osdl.org>
Date:   Mon Dec 11 09:28:46 2006 -0800

    Make SLES9 "get_kernel_version" work on the kernel binary again
    
    As reported by Andy Whitcroft, at least the SLES9 initrd build process
    depends on getting the kernel version from the kernel binary.  It does
    that by simply trawling the binary and looking for the signature of the
    "linux_banner" string (the string "Linux version " to be exact. Which
    is really broken in itself, but whatever..)
    
    That got broken when the string was changed to allow /proc/version to
    change the UTS release information dynamically, and "get_kernel_version"
    thus returned "%s" (see commit a2ee8649ba6d71416712e798276bf7c40b64e6e5:
    "[PATCH] Fix linux banner utsname information").
    
    This just restores "linux_banner" as a static string, which should fix
    the version finding.  And /proc/version simply uses a different string.
    
    To avoid wasting even that miniscule amount of memory, the early boot
    string should really be marked __initdata, but that just causes the same
    bug in SLES9 to re-appear, since it will then find other occurrences of
    "Linux version " first.
    
    Cc: Andy Whitcroft <apw@shadowen.org>
    Acked-by: Herbert Poetzl <herbert@13thfloor.at>
    Cc: Andi Kleen <ak@suse.de>
    Cc: Andrew Morton <akpm@osdl.org>
    Cc: Steve Fox <drfickle@us.ibm.com>
    Acked-by: Olaf Hering <olaf@aepfle.de>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

:040000 040000 1dfdf42f80828c413baba65a1ce8b460c9712ded cdb83fd26232860493d9e993af467e1dff77da83 M      fs
:040000 040000 94ad8c94d5ce333ad8febdc508a37de768736a98 12bc13def90d15921d41d2b285854b3e157a970f M      include
:040000 040000 991e9baa5a61b998a0e4833e142d5c4f72d61729 5673719c3f6b47b329cfc9554c112077634a9b19 M      init

Reverting this from 2.6.20-rc1 made the build behave again, however I
found that reverting it from 2.6.20-rc2 did _not_ fix the problem. I
also had to revert the following patch to make things work as before
again:

commit ef129412b4cbd6686d0749612cb9b76e207271f4
Author: Andrew Morton <akpm@osdl.org>
Date:   Fri Dec 22 01:12:01 2006 -0800

    [PATCH] build compile.h earlier
    
    compile.h is created super-late in the build.  But proc_misc.c want to include
    it, and it's generally not sane to have a header file in include/linux be
    created at the end of the build: it's either not present or, worse, wrong for
    most of the build.
    
    So the patch arranges for compile.h to be built at the start of the build
    process.  It also consolidates the compile.h rules with those for version.h
    and utsname.h, so they all get built together.
    
    I hope.  My chances of having got this right are about 2%.
    
    Cc: Sam Ravnborg <sam@ravnborg.org>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

I can only second Andrew's commit's last sentence ;)

So, Linus, Andrew, can you please take a look and revert or fix what
needs to be? This new behavior of the kernel build system is likely to
make developers angry pretty quickly.

Thanks,
-- 
Jean Delvare
