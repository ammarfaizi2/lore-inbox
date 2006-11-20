Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966363AbWKTS14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966363AbWKTS14 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 13:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966364AbWKTS14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 13:27:56 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:13959 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S966363AbWKTS1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 13:27:55 -0500
Date: Mon, 20 Nov 2006 10:24:38 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: zippel@linux-m68k.org, jes@trained-monkey.org
Cc: Adrian Bunk <bunk@stusta.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: xconfig segfault
Message-Id: <20061120102438.94ff4b0a.randy.dunlap@oracle.com>
In-Reply-To: <4560FB07.2040102@oracle.com>
References: <20061119161231.e509e5bf.randy.dunlap@oracle.com>
	<20061120004147.GC31879@stusta.de>
	<4560FB07.2040102@oracle.com>
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

On Sun, 19 Nov 2006 16:47:03 -0800 Randy Dunlap wrote:

> Adrian Bunk wrote:
> > On Sun, Nov 19, 2006 at 04:12:31PM -0800, Randy Dunlap wrote:
> >> make xconfig is segfaulting on me in 2.6.19-rc6 and later
> >> when I do ^F (find/search).
> >> Works fine in 2.6.19-rc5 and earlier.
> >>
> >> The only message log I get is:
> >>
> >> qconf[5839]: segfault at 0000000000000008 rip 00000000004289bc rsp 00007fffa08ccf10 error 4
> >>
> >> I don't see any changes in scripts/kconfig/* in 2.6.19-rc6.
> >> Any ideas/suggestions?
> > 
> > Works fine for me in -rc6.
> > 
> > Did you upgrade Qt, or could there be any other local change that broke 
> > it for you?
> 
> Didn't upgrade Qt.  I started out suspecting that it was a local change
> that broke it, like a library, but I rebuilt/re-tested 2.6.19-rc[123456]
> and rc1..rc5 all work for me, while rc6 segfaults.
> And rc6 works for me on an i386/i686 machine, but fails on x86_64.

I found the problem patch, but not the root cause.

The xconfig segfault begins in 2.6.19-rc5-git3 (-git2 is OK).
A relatively simple Kconfig change causes it (but why?).

(Note:  The running kernel doesn't matter, just which kernel tree
is being viewed/config-ed.)

If I back out the patches below, -git3 (xconfig ^F find/search)
works for me.

---
~Randy


diff -Naurp -X linux-2.6.19-rc5-git2/Documentation/dontdiff linux-2.6.19-rc5-git2/drivers/char/Kconfig linux-2.6.19-rc5-git3/drivers/char/Kconfig
--- linux-2.6.19-rc5-git2/drivers/char/Kconfig	2006-11-20 08:47:26.000000000 -0800
+++ linux-2.6.19-rc5-git3/drivers/char/Kconfig	2006-11-20 08:48:34.000000000 -0800
@@ -409,14 +409,6 @@ config SGI_MBCS
          If you have an SGI Altix with an attached SABrick
          say Y or M here, otherwise say N.
 
-config MSPEC
-	tristate "Memory special operations driver"
-	depends on IA64
-	help
-	  If you have an ia64 and you want to enable memory special
-	  operations support (formerly known as fetchop), say Y here,
-	  otherwise say N.
-
 source "drivers/serial/Kconfig"
 
 config UNIX98_PTYS
diff -Naurp -X linux-2.6.19-rc5-git2/Documentation/dontdiff linux-2.6.19-rc5-git2/arch/ia64/Kconfig linux-2.6.19-rc5-git3/arch/ia64/Kconfig
--- linux-2.6.19-rc5-git2/arch/ia64/Kconfig	2006-11-20 08:47:41.000000000 -0800
+++ linux-2.6.19-rc5-git3/arch/ia64/Kconfig	2006-11-20 08:48:34.000000000 -0800
@@ -484,6 +484,15 @@ source "net/Kconfig"
 
 source "drivers/Kconfig"
 
+config MSPEC
+	tristate "Memory special operations driver"
+	depends on IA64
+	select IA64_UNCACHED_ALLOCATOR
+	help
+	  If you have an ia64 and you want to enable memory special
+	  operations support (formerly known as fetchop), say Y here,
+	  otherwise say N.
+
 source "fs/Kconfig"
 
 source "lib/Kconfig"
