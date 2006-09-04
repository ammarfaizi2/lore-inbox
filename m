Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964964AbWIDTYb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964964AbWIDTYb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 15:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964962AbWIDTYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 15:24:30 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:29710 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751534AbWIDTY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 15:24:29 -0400
Date: Mon, 4 Sep 2006 21:24:25 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg Banks <gnb@melbourne.sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc5-mm1: ARCH_DISCONTIGMEM_ENABLE=y, SMP=n compile error
Message-ID: <20060904192425.GZ4416@stusta.de>
References: <20060901015818.42767813.akpm@osdl.org> <20060904170411.GT4416@stusta.de> <20060904120430.a2ab9479.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060904120430.a2ab9479.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2006 at 12:04:30PM -0700, Andrew Morton wrote:
> On Mon, 4 Sep 2006 19:04:11 +0200
> Adrian Bunk <bunk@stusta.de> wrote:
> 
> > cpumask-add-highest_possible_node_id.patch causes the following compile 
> > error with CONFIG_ARCH_DISCONTIGMEM_ENABLE=y, CONFIG_SMP=n
> > (and CONFIG_SUNRPC=y):
> > 
> > <--  snip  -->
> > 
> > ...
> >   LD      vmlinux
> > net/built-in.o: In function `svc_create_pooled':
> > (.text+0x675fc): undefined reference to `highest_possible_node_id'
> > net/built-in.o: In function `svc_create_pooled':
> > (.text+0x675fc): relocation truncated to fit: R_M32R_26_PCREL_RELA against undefined symbol `highest_possible_node_id'
> > make[1]: *** [vmlinux] Error 1
> 
> On m32r?
> 
> If so, could it be a binutils or m32r bug?

No, it is a kernel bug (don't be confused by the second message, the 
first one describes the bug).

The problem is simple:

- net/sunrpc/svc.c uses highest_possible_node_id()
- include/linux/nodemask.h says highest_possible_node_id() is
  out-of-line #if MAX_NUMNODES > 1
- the out-of-line highest_possible_node_id() is in lib/cpumask.c
- lib/Makefile: lib-$(CONFIG_SMP) += cpumask.o

CONFIG_ARCH_DISCONTIGMEM_ENABLE=y, CONFIG_SMP=n, CONFIG_SUNRPC=y
-> highest_possible_node_id() is used in net/sunrpc/svc.c
   CONFIG_NODES_SHIFT defined and > 0
-> include/linux/numa.h: MAX_NUMNODES > 1
-> compile error

The bug is not present on architectures where ARCH_DISCONTIGMEM_ENABLE 
depends on NUMA (but m32r isn't the only affected architecture).

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

