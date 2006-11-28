Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758016AbWK1Xjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758016AbWK1Xjj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 18:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758042AbWK1Xjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 18:39:39 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:15772 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1758016AbWK1Xji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 18:39:38 -0500
Date: Tue, 28 Nov 2006 15:36:35 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>,
       "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>,
       linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: 2.6.19-rc5-mm2: paravirt X86_PAE=y compile error
Message-Id: <20061128153635.abaeb1fc.randy.dunlap@oracle.com>
In-Reply-To: <20061115153614.a71f944d.akpm@osdl.org>
References: <20061114014125.dd315fff.akpm@osdl.org>
	<20061115231626.GC31879@stusta.de>
	<20061115153614.a71f944d.akpm@osdl.org>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2006 15:36:14 -0800 Andrew Morton wrote:

> On Thu, 16 Nov 2006 00:16:26 +0100
> Adrian Bunk <bunk@stusta.de> wrote:
> 
> > Paravirt breaks CONFIG_X86_PAE=y compilation:
> > 
> > <--  snip  -->
> > 
> > ...
> >   CC      init/main.o
> > In file included from include2/asm/pgtable.h:245,
> >                  from 
> > /home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/include/linux/mm.h:40,
> >                  from 
> > /home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/include/linux/poll.h:11,
> >                  from 
> > /home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/include/linux/rtc.h:113,
> >                  from 
> > /home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/include/linux/efi.h:19,
> >                  from 
> > /home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/init/main.c:43:
> > include2/asm/pgtable-3level.h:108: error: redefinition of 'pte_clear'
> > include2/asm/paravirt.h:365: error: previous definition of 'pte_clear' was here
> > include2/asm/pgtable-3level.h:115: error: redefinition of 'pmd_clear'
> > include2/asm/paravirt.h:370: error: previous definition of 'pmd_clear' was here
> > make[2]: *** [init/main.o] Error 1
> > 
> 
> So it does.  Zach will save us.
> 
> How come allmodconfig doesn't select highmem?

Must be because of "choice" and its default:

choice
	prompt "High Memory Support"
	default NOHIGHMEM

Changing the default fixes it.  I suppose conf.c could be
hacked to do something different on choices, but it's not
clear how/what to do there as a general rule.

---
From: Randy Dunlap <randy.dunlap@oracle.com>

Make ix86 default to HIGHMEM4G instead of NOHIGHMEM.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 arch/i386/Kconfig |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.19-rc6-git10.orig/arch/i386/Kconfig
+++ linux-2.6.19-rc6-git10/arch/i386/Kconfig
@@ -443,7 +443,8 @@ source "drivers/firmware/Kconfig"
 
 choice
 	prompt "High Memory Support"
-	default NOHIGHMEM
+	default HIGHMEM4G if !X86_NUMAQ
+	default HIGHMEM64G if X86_NUMAQ
 
 config NOHIGHMEM
 	bool "off"

