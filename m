Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264270AbUFPRgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264270AbUFPRgX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 13:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264279AbUFPRgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 13:36:22 -0400
Received: from cmt33.neoplus.adsl.tpnet.pl ([83.31.147.33]:23813 "EHLO
	satan.blackhosts") by vger.kernel.org with ESMTP id S264270AbUFPRgJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 13:36:09 -0400
Date: Wed, 16 Jun 2004 19:36:53 +0200
From: Jakub Bogusz <qboosh@pld-linux.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.7 compile errors due to include loops on sparc(32)
Message-ID: <20040616173652.GA10529@satan.blackhosts>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  CC      init/do_mounts.o
In file included from include/linux/mm.h:29,
                 from include/linux/pagemap.h:7,
                 from include/linux/swap.h:7,
                 from include/linux/suspend.h:7,
                 from init/do_mounts.c:6:
include/asm/pgtable.h:386: warning: parameter names (without types) in function declaration
include/asm/pgtable.h:387: warning: parameter names (without types) in function declaration
include/asm/pgtable.h:388: error: parse error before "___f___swp_entry"
include/asm/pgtable.h:388: warning: type defaults to `int' in declaration of `___f___swp_entry'
include/asm/pgtable.h:388: warning: data definition has no type or storage class
make[1]: *** [init/do_mounts.o] Error 1
make: *** [init] Error 2

That's because swp_entry_t used in BTFIXUPDEF_CALL macro uses in
<asm-sparc/pgtable.h> - swp_entry_t is defined in <linux/swap.h>,
which indirectly includes <asm/pgtable.h> before defining swp_entry_t -
so <linux/swap.h> include in <asm-sparc/pgtable.h> is skipped as
_LINUX_SWAP_H is already defined.

Workaround is to move swp_entry_t typedef on top of <linux/swap.h>,
before includes - but it's ugly.

The next problem is:

  CC      arch/sparc/kernel/process.o
[...]
In file included from include/linux/swap.h:18,
                 from include/asm/pgtable.h:14,
                 from include/linux/mm.h:29,
                 from arch/sparc/kernel/process.c:19:
include/linux/pagemap.h: In function `linear_page_index':
include/linux/pagemap.h:145: error: dereferencing pointer to incomplete type
include/linux/pagemap.h:146: error: dereferencing pointer to incomplete type
include/linux/pagemap.h: In function `lock_page':
include/linux/pagemap.h:155: warning: implicit declaration of function `TestSetPageLocked'
include/linux/pagemap.h: In function `wait_on_page_locked':
include/linux/pagemap.h:174: warning: implicit declaration of function `PageLocked'
include/linux/pagemap.h:175: error: `PG_locked' undeclared (first use in this function)
include/linux/pagemap.h:175: error: (Each undeclared identifier is reported only once
include/linux/pagemap.h:175: error: for each function it appears in.)
include/linux/pagemap.h: In function `wait_on_page_writeback':

quite similar case - struct vma_area_struct is defined in <linux/mm.h>,
which indirectly includes <linux/pagemap.h>, which uses it.
On other archs <asm/pgtable.h> doesn't include <linux/swap.h>, so this
problem is sparc-specific too; but removing #include <linux/swap.h> from
<asm-sparc/pgtable.h> doesn't work without hacking many files, so
I couldn't find any simple workaround...


-- 
Jakub Bogusz    http://cyber.cs.net.pl/~qboosh/
