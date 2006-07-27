Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbWG0LFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbWG0LFQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 07:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbWG0LFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 07:05:16 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:21482 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751233AbWG0LFO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 07:05:14 -0400
Date: Thu, 27 Jul 2006 13:04:54 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Roland McGrath <roland@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Jakub Jelinek <jakub@redhat.com>
Subject: Re: [PATCH] vDSO hash-style fix
Message-ID: <20060727110453.GA27162@mars.ravnborg.org>
References: <20060726201502.A14FE18003A@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060726201502.A14FE18003A@magilla.sf.frob.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2006 at 01:15:02PM -0700, Roland McGrath wrote:
> The latest toolchains can produce a new ELF section in DSOs and
> dynamically-linked executables.  The new section ".gnu.hash" replaces
> ".hash", and allows for more efficient runtime symbol lookups by the
> dynamic linker.  The new ld option --hash-style={sysv|gnu|both}
> controls whether to produce the old ".hash", the new ".gnu.hash", or
> both.  In some new systems such as Fedora Core 6, gcc by default
> passes --hash-style=gnu to the linker, so that a standard invocation
> of "gcc -shared" results in producing a DSO with only ".gnu.hash".
> The new ".gnu.hash" sections need to be dealt with the same way as
> ".hash" sections in all respects; only the dynamic linker cares about
> their contents.  To work with older dynamic linkers (i.e. preexisting
> releases of glibc), a binary must have the old ".hash" section.  The
> --hash-style=both option produces binaries that a new dynamic linker
> can use more efficiently, but an old dynamic linker can still handle.
> 
> The new section runs afoul of the custom linker scripts used to
> build vDSO images for the kernel.  On ia64, the failure mode for
> this is a boot-time panic because the vDSO's PT_IA_64_UNWIND
> segment winds up ill-formed.
> 
> This patch addresses the problem in two ways.
> 
> First, it mentions ".gnu.hash" in all the linker scripts alongside
> ".hash".
Any possibility to push this to include/asm-generic/vmlinux.lds.h?

> diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
> index 2180c88..a3c0fdc 100644  
> --- a/scripts/Kbuild.include
> +++ b/scripts/Kbuild.include
> @@ -85,6 +85,12 @@ cc-version = $(shell $(CONFIG_SHELL) $(s
>  cc-ifversion = $(shell if [ $(call cc-version, $(CC)) $(1) $(2) ]; then \
>                         echo $(3); fi;)
>  
> +# ld-option
> +# Usage: ldflags += $(call ld-option, -Wl$(comma)--hash-style=both)
> +ld-option = $(shell if $(CC) $(1) \
> +			     -nostdlib -o /dev/null -xc /dev/null \
> +             > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi)

This is not good. When I introduced something similar for lxdialog I
received lots of reports about /dev/null becoming a regular file.
ld does something strange with the output file when it fails.

When re-done ld-option shall be accompanied by documentation in
Documentation/makefiles.txt like cc-option.

	Sam
