Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263502AbTJLSUP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 14:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263504AbTJLSUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 14:20:15 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:16132 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S263502AbTJLSUL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 14:20:11 -0400
Date: Sun, 12 Oct 2003 20:19:50 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Mikael Pettersson <mikpe@csd.uu.se>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: non-modular 2.6 ppc kernels miscompiled by gcc-3.3.1?
Message-ID: <20031012181950.GB2328@mars.ravnborg.org>
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Mikael Pettersson <mikpe@csd.uu.se>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
References: <200310121310.h9CDASEI006119@harpo.it.uu.se> <1065964761.993.34.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1065964761.993.34.camel@gaston>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 12, 2003 at 03:19:22PM +0200, Benjamin Herrenschmidt wrote:
> Smells like some section alignement issues. Can you check
> how the __ex_table  section is aligned and where __start___ex_table
> points to ? (using objdump)

Or you could try to apply the following patch - it will fix mis-
alignmnet of above section.

	Sam

===== arch/ppc/kernel/vmlinux.lds.S 1.24 vs edited =====
--- 1.24/arch/ppc/kernel/vmlinux.lds.S	Fri Sep 12 18:26:52 2003
+++ edited/arch/ppc/kernel/vmlinux.lds.S	Sun Oct 12 20:17:25 2003
@@ -47,13 +47,17 @@
 
   .fixup   : { *(.fixup) }
 
-  __start___ex_table = .;
-  __ex_table : { *(__ex_table) }
-  __stop___ex_table = .;
+	__ex_table : {
+		__start___ex_table = .;
+		*(__ex_table)
+		__stop___ex_table = .;
+	}
 
-  __start___bug_table = .;
-  __bug_table : { *(__bug_table) }
-  __stop___bug_table = .;
+	__bug_table : {
+		__start___bug_table = .;
+		*(__bug_table)
+		__stop___bug_table = .;
+	}
 
   /* Read-write section, merged into data segment: */
   . = ALIGN(4096);
