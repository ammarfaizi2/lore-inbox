Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261276AbSJLPzT>; Sat, 12 Oct 2002 11:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261277AbSJLPzT>; Sat, 12 Oct 2002 11:55:19 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:50838 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S261276AbSJLPzS>; Sat, 12 Oct 2002 11:55:18 -0400
Date: Sat, 12 Oct 2002 11:01:06 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
cc: linux-kernel@vger.kernel.org, <torvalds@transmeta.com>,
       <user-mode-linux-devel@lists.sourceforge.net>
Subject: Re: [PATCH] 2.5.42: UML build error
In-Reply-To: <877kgn7kmk.fsf@goat.bogus.local>
Message-ID: <Pine.LNX.4.44.0210121056080.17947-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Oct 2002, Olaf Dietsche wrote:

> When building 2.5.42 UML it fails with:
> 
> make -C arch/um/sys-i386/util mk_sc
>   gcc -Wp,-MD,./.mk_sc.o.d -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer  -c -o mk_sc
> .o mk_sc.c
> /bin/sh: scripts/fixdep: No such file or directory
> make[1]: *** [mk_sc.o] Error 1
> make[1]: Target `mk_sc' not remade because of errors.
> make: *** [arch/um/sys-i386/util/mk_sc] Error 2
> 
> This patch readds the path to scripts/fixdep in Rules.make. It doesn't
> break _my_ regular build, but I can't tell for others.
> 
> diff -urN a/Rules.make b/Rules.make
> --- a/Rules.make	Sat Oct 12 14:24:11 2002
> +++ b/Rules.make	Sat Oct 12 16:45:47 2002
> @@ -561,7 +561,7 @@
>  	@set -e; \
>  	$(if $($(quiet)cmd_$(1)),echo '  $($(quiet)cmd_$(1))';) \
>  	$(cmd_$(1)); \
> -	scripts/fixdep $(depfile) $@ '$(cmd_$(1))' > $(@D)/.$(@F).tmp; \
> +	$(TOPDIR)/scripts/fixdep $(depfile) $@ '$(cmd_$(1))' > $(@D)/.$(@F).tmp; \
>  	rm -f $(depfile); \
>  	mv -f $(@D)/.$(@F).tmp $(@D)/.$(@F).cmd)

This is actually intentionally broken, since fixdep expects to be called 
from the top-level dir only now - it doesn't take the previous "$(TOPDIR)" 
argument anymore which allowed for $(PWD) != $(TOPDIR) before 2.5.41.

Descending into directories needs to be adjusted to use

	$(call descend,<dir>,<target>)

now, and the Makefile in <dir> possibly needs adjusting to take into
account that $(PWD) == $(TOPDIR).

--Kai


