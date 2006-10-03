Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030398AbWJCUyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030398AbWJCUyL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 16:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030404AbWJCUyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 16:54:10 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:25487 "EHLO pasmtpB.tele.dk")
	by vger.kernel.org with ESMTP id S1030389AbWJCUyI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 16:54:08 -0400
Date: Tue, 3 Oct 2006 22:54:07 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@ftp.linux.org.uk>
Cc: git-commits-head@vger.kernel.org
Subject: Re: kbuild: make modpost processing configurable
Message-ID: <20061003205407.GD720@uranus.ravnborg.org>
References: <200610031659.k93GxIOi011555@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610031659.k93GxIOi011555@hera.kernel.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al.

This is the requested funtionality so you can make modpost errors
warnings instead.
And as bonus the possibility to skip the last-time consuming part of a
kernel build.

Let me know if this does not satisfy your original request.

	Sam

On Tue, Oct 03, 2006 at 04:59:18PM +0000, Linux Kernel Mailing List wrote:
> commit ea837f1c050344c3f884531a195c6e339b1a54e8
> tree 269e1188358452e7f4fda5052ab6363d7e5b5b87
> parent e94c5bde703f2f9f86d098b6bf8275c64fab10eb
> author Sam Ravnborg <sam@neptun.ravnborg.org> 1159695324 +0200
> committer Sam Ravnborg <sam@neptun.ravnborg.org> 1159695324 +0200
> 
> kbuild: make modpost processing configurable
> 
> On request from Al Viro make modpost processing configurable.
> 
> KBUILD_MODPOST_WARN can be set to make modpost warn instead of
> error out in case on unresolved symbols in final module link.
> 
> KBUILD_MODPOST_NOFINAL can be set to avoid the final and timeconsuming
> .c file generation and link of .ko files. This is solely useful for
> speeding up when doing compile checks with for example allmodconfig
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> 
>  scripts/Makefile.modpost |   11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
> index 4b2721c..6c5469b 100644
> --- a/scripts/Makefile.modpost
> +++ b/scripts/Makefile.modpost
> @@ -32,6 +32,10 @@ #     - See include/linux/module.h for m
>  # Step 4 is solely used to allow module versioning in external modules,
>  # where the CRC of each module is retrieved from the Module.symers file.
>  
> +# KBUILD_MODPOST_WARN can be set to avoid error out in case of undefined
> +# symbols in the final module linking stage
> +# KBUILD_MODPOST_NOFINAL can be set to skip the final link of modules.
> +# This is solely usefull to speed up test compiles
>  PHONY := _modpost
>  _modpost: __modpost
>  
> @@ -46,7 +50,8 @@ # Step 1), find all modules listed in $(
>  __modules := $(sort $(shell grep -h '\.ko' /dev/null $(wildcard $(MODVERDIR)/*.mod)))
>  modules   := $(patsubst %.o,%.ko, $(wildcard $(__modules:.ko=.o)))
>  
> -_modpost: $(modules)
> +# Stop after building .o files if NOFINAL is set. Makes compile tests quicker
> +_modpost: $(if $(KBUILD_MODPOST_NOFINAL), $(modules:.ko:.o),$(modules))
>  
>  
>  # Step 2), invoke modpost
> @@ -58,7 +63,7 @@ quiet_cmd_modpost = MODPOST $(words $(fi
>  	$(if $(KBUILD_EXTMOD),-i,-o) $(kernelsymfile) \
>  	$(if $(KBUILD_EXTMOD),-I $(modulesymfile)) \
>  	$(if $(KBUILD_EXTMOD),-o $(modulesymfile)) \
> -	$(if $(KBUILD_EXTMOD),-w) \
> +	$(if $(KBUILD_EXTMOD)$(KBUILD_MODPOST_WARN),-w) \
>  	$(wildcard vmlinux) $(filter-out FORCE,$^)
>  
>  PHONY += __modpost
> @@ -92,7 +97,7 @@ targets += $(modules:.ko=.mod.o)
>  
>  # Step 6), final link of the modules
>  quiet_cmd_ld_ko_o = LD [M]  $@
> -      cmd_ld_ko_o = $(LD) $(LDFLAGS) $(LDFLAGS_MODULE) -o $@ 		\
> +      cmd_ld_ko_o = $(LD) $(LDFLAGS) $(LDFLAGS_MODULE) -o $@		\
>  			  $(filter-out FORCE,$^)
>  
>  $(modules): %.ko :%.o %.mod.o FORCE
> -
> To unsubscribe from this list: send the line "unsubscribe git-commits-head" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
