Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265978AbUHSSy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265978AbUHSSy5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 14:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267259AbUHSSy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 14:54:57 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:47656 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S265978AbUHSSyw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 14:54:52 -0400
Date: Thu, 19 Aug 2004 22:55:06 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Jeff Dike <jdike@addtoit.com>
Subject: Re: [PATCH] 2.6.8.1-mm2 --- UML build fixes
Message-ID: <20040819205506.GA7440@mars.ravnborg.org>
Mail-Followup-To: Chris Wedgwood <cw@f00f.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Jeff Dike <jdike@addtoit.com>
References: <20040819014204.2d412e9b.akpm@osdl.org> <20040819122915.GA2085@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040819122915.GA2085@taniwha.stupidest.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2004 at 05:29:15AM -0700, Chris Wedgwood wrote:
> On Thu, Aug 19, 2004 at 01:42:04AM -0700, Andrew Morton wrote:
> 
> > +uml-remove-cow-driver.patch
> > +uml-updates-2.patch
> >
> >  UML fixes
> 
> This (merged from jdike earlier email) is required to get uml to
> build.
A few comments below.

> ===== Makefile 1.514 vs edited =====
> --- 1.514/Makefile	2004-08-19 04:32:25 -07:00
> +++ edited/Makefile	2004-08-19 04:38:27 -07:00
> @@ -523,6 +523,7 @@
>  	$(drivers-y) \
>  	$(net-y) \
>  	--end-group \
> +	$(post-y) \
>  	$(filter .tmp_kallsyms%,$^) \

I recall Jeff introduced post-y to bypass the "check for
undefined symbols in vmlinux" stuff.
That's gone again.


> ===== arch/um/Makefile 1.27 vs edited =====
> --- 1.27/arch/um/Makefile	2004-08-19 04:33:04 -07:00
> +++ edited/arch/um/Makefile	2004-08-19 04:38:27 -07:00
> @@ -21,6 +21,10 @@
>  			   $(ARCH_DIR)/drivers/          \
>  			   $(ARCH_DIR)/sys-$(SUBARCH)/
>  
> +post-y			= --wrap malloc --wrap free --wrap calloc \
> +			  $(ARCH_DIR)/main.o -lutil \
> +			  --start-group -lgcc -lgcc_eh -lc --end-group
So this part can go as well.

  
> -#$(LD_SCRIPT-y) : $(LD_SCRIPT-y:.s=.S) scripts FORCE
> -#	$(call if_changed_dep,as_s_S)
> +# More kbuild lossage - I can't get uml.lds to fire the %.lds : %.lds.S rule.
> +# It always ends up going into the .S assembly rule.  So, an explicit rule
> +# here works around that.  Then, it turns out that cmd_cpp_lds_S is undefined,
> +# which I don't understand since I would have thought that the entire Makefile
> +# had been read by the time it executes commands.  So, defining that here works
> +# around that.  Then, it turns out that cpp_flags isn't defined, which I don't
> +# understand for the same reason.  So, I just included the expansion here,
> +# and after much grossness, you get a building and working UML.
> +quiet_cmd_cpp_lds_S = LDS     $@
> +      cmd_cpp_lds_S = $(CPP) -Wp,-MD,$(depfile) -Iinclude $(CPPFLAGS_vmlinux.lds) -P -C -Uum $(NOSTDINC_FLAGS) -D__ASSEMBLY__ -o $@ $<
> +
> +$(LD_SCRIPT-y) : $(LD_SCRIPT-y).S scripts FORCE
> +	$(call if_changed_dep,cpp_lds_S)

What makes um so speciel that it cannot handle .lds files in
arch/um/kernel like all other architectures?
That would allow um to utilise the kbuild infrastructure,
and no need for duplication.

> ===== arch/um/kernel/Makefile 1.21 vs edited =====
> --- 1.21/arch/um/kernel/Makefile	2004-08-19 04:33:10 -07:00
> +++ edited/arch/um/kernel/Makefile	2004-08-19 04:38:27 -07:00
> @@ -3,7 +3,7 @@
>  # Licensed under the GPL
>  #
>  
> -extra-y := vmlinux.lds
> +extra-y := vmlinux.lds ../main.o
Code located in arch/um/ is an error. No code should stay there.

>  obj-y = checksum.o config.o exec_kern.o exitcode.o frame_kern.o frame.o \
>  	helper.o init_task.o irq.o irq_user.o ksyms.o mem.o mem_user.o \
> @@ -24,7 +24,7 @@
>  user-objs-$(CONFIG_TTY_LOG) += tty_log.o
>  
>  USER_OBJS := $(filter %_user.o,$(obj-y))  $(user-objs-y) config.o helper.o \
> -	process.o tempfile.o time.o tty_log.o umid.o user_util.o
> +	process.o tempfile.o time.o tty_log.o umid.o user_util.o ../main.o
>  USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
>  
>  CFLAGS_frame.o := $(patsubst -fomit-frame-pointer,,$(USER_CFLAGS))


It is (way down) on my todo list to go through all of um Makefiles.
In general they seems too complicated for the task solved - but it may be needed.

	Sam
