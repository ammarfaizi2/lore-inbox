Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932512AbWF0L4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932512AbWF0L4W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 07:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWF0L4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 07:56:22 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:35480 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932512AbWF0L4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 07:56:20 -0400
Date: Tue, 27 Jun 2006 20:55:24 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: linux-2.6.17.1: undefined reference to `online_page'
Cc: Toralf Foerster <toralf.foerster@gmx.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <1151343992.10877.34.camel@localhost.localdomain>
References: <20060626163235.A022.Y-GOTO@jp.fujitsu.com> <1151343992.10877.34.camel@localhost.localdomain>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060627204448.FBCD.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 2006-06-26 at 16:39 +0900, Yasunori Goto wrote:
> > 
> > ===================================================================
> > --- linux-2.6.17.orig/mm/Kconfig        2006-06-26 14:19:11.000000000
> > +0900
> > +++ linux-2.6.17/mm/Kconfig     2006-06-26 14:19:53.000000000 +0900
> > @@ -115,7 +115,7 @@ config SPARSEMEM_EXTREME
> >  # eventually, we can have this option just 'select SPARSEMEM'
> >  config MEMORY_HOTPLUG
> >         bool "Allow for memory hot-add"
> > -       depends on SPARSEMEM && HOTPLUG && !SOFTWARE_SUSPEND
> > +       depends on SPARSEMEM && HOTPLUG && !SOFTWARE_SUSPEND
> > && !(X86_32 && !HIGHMEM)
> >  
> >  comment "Memory hotplug is currently incompatible with Software
> > Suspend"
> >         depends on SPARSEMEM && HOTPLUG && SOFTWARE_SUSPEND 
> 
> I think it makes a lot more sense to just disable sparsemem when !
> HIGHMEM.  Plus, we can do all of that in the arch-specific Kconfigs and
> not litter the generic ones with this stuff.

Ah, Ok.
I changed this patch as you said.

At first, I thought it might not be good that config memory hotplug was
disabled by config sparsemem. Because, they are not strictly the same. 
But, this is reasonable way for 2.6.17.x. It is less impact, anyway.

Thanks.

------

Memory hotplug code of i386 adds memory to only highmem.
So, if CONFIG_HIGHMEM is not set, CONFIG_MEMORY_HOTPLUG shouldn't be
set. Otherwise, it causes compile error.

But, CONFIG_MEMORY_HOTPLUG is defined mm/Kconfig. So, if it is disabled
on its file when arch is i386 and highmem is not set, 
it may be a bit intrusive.

When CONFIG_SPARSEMEM is not set, its config option is not set too.
CONFIG_ARCH_SPARSEMEM_ENABLE is defined in arch/i386/Kconfig.
Disabling it is not intrusive for other archtecture.

This is patch for it.


Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

---
 arch/i386/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.17/arch/i386/Kconfig
===================================================================
--- linux-2.6.17.orig/arch/i386/Kconfig	2006-06-27 19:33:39.000000000 +0900
+++ linux-2.6.17/arch/i386/Kconfig	2006-06-27 19:38:53.000000000 +0900
@@ -562,7 +562,7 @@ config ARCH_DISCONTIGMEM_DEFAULT
 
 config ARCH_SPARSEMEM_ENABLE
 	def_bool y
-	depends on (NUMA || (X86_PC && EXPERIMENTAL))
+	depends on (NUMA || (X86_PC && EXPERIMENTAL)) && HIGHMEM
 	select SPARSEMEM_STATIC
 
 config ARCH_SELECT_MEMORY_MODEL

-- 
Yasunori Goto 


