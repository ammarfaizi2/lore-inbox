Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751434AbWHYTDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbWHYTDm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 15:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbWHYTDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 15:03:41 -0400
Received: from xenotime.net ([66.160.160.81]:53484 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751434AbWHYTDl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 15:03:41 -0400
Date: Fri, 25 Aug 2006 12:06:53 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: another NUMA build error
Message-Id: <20060825120653.cd84f1fa.rdunlap@xenotime.net>
In-Reply-To: <20060826032834.ead83dec.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060824213559.1be3d60f.rdunlap@xenotime.net>
	<20060825144350.27530dfb.kamezawa.hiroyu@jp.fujitsu.com>
	<20060825103507.4f2d193e.rdunlap@xenotime.net>
	<20060826032834.ead83dec.kamezawa.hiroyu@jp.fujitsu.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Aug 2006 03:28:34 +0900 KAMEZAWA Hiroyuki wrote:

> On Fri, 25 Aug 2006 10:35:07 -0700
> "Randy.Dunlap" <rdunlap@xenotime.net> wrote:
> 
> > OK, I prefer option 2 because it is more generic (not hardware-
> > specific).  Someone else can prefer option 1 because it is
> > hardware-specific.  :)
> > 
> ok. patch is here. but people who know x86-numa should confirm this.
> 
> -Kame
> --
> compile fix for
> 
> In file included from include/asm/mmzone.h:18,
>                  from include/linux/mmzone.h:439,
> <snip>
> include/asm/srat.h:31:2: error: #error CONFIG_ACPI_SRAT not defined, and srat.h header has been included
> make[1]: *** [arch/i386/kernel/asm-offsets.s] Error 1
> 
> This can happen with CONFIG_NUMA && !CONFIG_ACPI && !CONFIG_X86_NUMAQ
> 
> Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
> 
>  include/asm-i386/mmzone.h |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-2.6.18-rc4/include/asm-i386/mmzone.h
> ===================================================================
> --- linux-2.6.18-rc4.orig/include/asm-i386/mmzone.h
> +++ linux-2.6.18-rc4/include/asm-i386/mmzone.h
> @@ -14,7 +14,7 @@ extern struct pglist_data *node_data[];
>  
>  #ifdef CONFIG_X86_NUMAQ
>  	#include <asm/numaq.h>
> -#else	/* summit or generic arch */
> +#elif defined(CONFIG_ACPI_SRAT)/* summit or generic arch */
>  	#include <asm/srat.h>
>  #endif


That fixes mmzone.h but it still doesn't produce kernel that
will build without error:

arch/i386/mm/discontig.c: In function ‘zone_sizes_init’:
arch/i386/mm/discontig.c:388: warning: implicit declaration of function ‘get_zholes_size’
arch/i386/mm/discontig.c:388: warning: assignment makes pointer from integer without a cast

and:
  LD      .tmp_vmlinux1
arch/i386/mm/built-in.o: In function `zone_sizes_init':
(.init.text+0xd05): undefined reference to `get_zholes_size'
make: *** [.tmp_vmlinux1] Error 1

Same .config as in previous email.

---
~Randy
