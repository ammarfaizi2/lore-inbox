Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422695AbWBOEOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422695AbWBOEOE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 23:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422719AbWBOEOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 23:14:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:24797 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422695AbWBOEOD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 23:14:03 -0500
Date: Tue, 14 Feb 2006 20:12:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: kbuild: fix make -jN with multiple targets with O=...
Message-Id: <20060214201257.479cb4fc.akpm@osdl.org>
In-Reply-To: <20060215040433.GA17334@kvack.org>
References: <200601170510.k0H5AtSJ005682@hera.kernel.org>
	<20060215040433.GA17334@kvack.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise <bcrl@kvack.org> wrote:
>
> Hello folks,
> 
> This patch causes a ~95% increase in build time for the kernel.  Before: 
> 4m21s after: 8m1.403s.  Can we revert this until another approach is found?
> 

Yowch.  Is that with a regular old build-in-place, or is it specific to
out-of-tree builds, or what?


> 		-ben
> 
> On Mon, Jan 16, 2006 at 09:10:55PM -0800, Linux Kernel Mailing List wrote:
> tree b918bb866edc339d51b2b71176265f6d424600e7
> parent 60f33b80443a3e7e79e2a3ddc625ab6246a61d3d
> author Sam Ravnborg <sam@mars.ravnborg.org> Sun, 15 Jan 2006 20:02:31 +0100
> committer Sam Ravnborg <sam@mars.ravnborg.org> Sun, 15 Jan 2006 20:02:31 +0100
> 
> kbuild: fix make -jN with multiple targets with O=...
> 
> The way multiple targets was handled with make O=...
> broke because for each high-level target make spawned
> a parallel make resulting in a broken build.
> Reported by Keith Owens <kaos@ocs.com.au>
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> 
>  Makefile |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index deedaf7..b3dd9db 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -106,12 +106,13 @@ KBUILD_OUTPUT := $(shell cd $(KBUILD_OUT
>  $(if $(KBUILD_OUTPUT),, \
>       $(error output directory "$(saved-output)" does not exist))
>  
> -.PHONY: $(MAKECMDGOALS)
> +.PHONY: $(MAKECMDGOALS) cdbuilddir
> +$(MAKECMDGOALS) _all: cdbuilddir
>  
> -$(filter-out _all,$(MAKECMDGOALS)) _all:
> +cdbuilddir:
>  	$(if $(KBUILD_VERBOSE:1=),@)$(MAKE) -C $(KBUILD_OUTPUT) \
>  	KBUILD_SRC=$(CURDIR) \
> -	KBUILD_EXTMOD="$(KBUILD_EXTMOD)" -f $(CURDIR)/Makefile $@
> +	KBUILD_EXTMOD="$(KBUILD_EXTMOD)" -f $(CURDIR)/Makefile $(MAKECMDGOALS)
>  
>  # Leave processing to above invocation of make
>  skip-makefile := 1
