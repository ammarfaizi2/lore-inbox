Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbWHPSzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbWHPSzh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 14:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbWHPSzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 14:55:36 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:35204 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750832AbWHPSzg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 14:55:36 -0400
Date: Wed, 16 Aug 2006 20:55:38 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de
Subject: Re: [patch 5/5] -fstack-protector feature: Enable the compiler flags in CFLAGS
Message-ID: <20060816185538.GE5852@mars.ravnborg.org>
References: <1155746902.3023.63.camel@laptopd505.fenrus.org> <1155747197.3023.73.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155747197.3023.73.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 06:53:17PM +0200, Arjan van de Ven wrote:
> Subject: [patch 5/5] Add the -fstack-protector option to the CFLAGS
> From: Arjan van de Ven <arjan@linux.intel.com>
> 
> Add a feature check that checks that the gcc compiler has stack-protector
> support and has the bugfix for PR28281 to make this work in kernel mode.
> The easiest solution I could find was to have a shell script in scripts/
> to do the detection; if needed we can make this fancier in the future 
> without making the makefile too complex.
> 
> Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
> CC: Andi Kleen <ak@suse.de>
> CC: Sam Ravnborg <sam@ravnborg.org>
> 
> ---
>  arch/x86_64/Makefile                      |    3 +++
>  scripts/gcc-x86_64-has-stack-protector.sh |    8 ++++++++
>  2 files changed, 11 insertions(+)
> 
> Index: linux-2.6.18-rc4-stackprot/arch/x86_64/Makefile
> ===================================================================
> --- linux-2.6.18-rc4-stackprot.orig/arch/x86_64/Makefile
> +++ linux-2.6.18-rc4-stackprot/arch/x86_64/Makefile
> @@ -55,6 +55,9 @@ cflags-y += $(call cc-option,-funit-at-a
>  # prevent gcc from generating any FP code by mistake
>  cflags-y += $(call cc-option,-mno-sse -mno-mmx -mno-sse2 -mno-3dnow,)
>  
> +cflags-$(CONFIG_CC_STACKPROTECTOR) += $(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-x86_64-has-stack-protector.sh $(CC) -fstack-protector )
> +cflags-$(CONFIG_CC_STACKPROTECTOR_ALL) += $(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-x86_64-has-stack-protector.sh $(CC) -fstack-protector-all )
> +
I agree with the pricinple on hiding the check in the script.
But please try to keep lines within 80 coloumn limit.
something like this which is functionality wise equal:

stack-protector = $(shell $(CONFIG_SHELL) \
                   $(srctree)/scripts/gcc-x86_64-has-stack-protector.sh $(1))
cflags-$(CONFIG_CC_STACKPROTECTOR) += \
                   $(call stack-protector, $(CC) -fstack-protector)
cflags-$(CONFIG_CC_STACKPROTECTOR_ALL) += \
                   $(call stack-protector, $(CC) -fstack-protector-all)

I do not like the broken lines either but with these long CONFIG_ names
it is needed.

Otherwised Acked-by: Sam Ravnborg <sam@ravnborg.org>

PS - above is untested...

	Sam
