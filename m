Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263111AbSJGQCt>; Mon, 7 Oct 2002 12:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263139AbSJGQCs>; Mon, 7 Oct 2002 12:02:48 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:38334 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S263111AbSJGQCq>;
	Mon, 7 Oct 2002 12:02:46 -0400
Date: Mon, 7 Oct 2002 18:08:24 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200210071608.SAA03742@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.40 kbuild bug: mrproper removes files it shouldn't remove
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

'make mrproper' incorrectly deletes *~-style editor backup files
from the top-level directory. This bug was introduced in 2.5.29
when the top-level Makefile was changed to remain in the top-level
directory when invoking DocBook's Makefile:

(snippet from patch-2.5.29):
>--- a/Makefile	Fri Jul 26 19:58:50 2002
>+++ b/Makefile	Fri Jul 26 19:58:50 2002
>@@ -650,7 +650,7 @@
> 		-name .\*.tmp -o -name .\*.d \) -type f -print \
> 		| grep -v lxdialog/ | xargs rm -f
> 	@rm -f $(CLEAN_FILES)
>-	@$(MAKE) -C Documentation/DocBook clean
>+	@$(MAKE) -f Documentation/DocBook/Makefile clean
> 
> mrproper: clean archmrproper
> 	@echo 'Making mrproper'

The problem is that DocBook's 'make clean' rule contains

clean:
	@echo 'Cleaning up (DocBook)'
	@rm -f core *~

so the rm now removes files from the wrong directory. Not good.

Since the top-level Makefile removes all core files, I suggest
simply removing the problematic rm line. Patch below.

/Mikael

--- linux-2.5.40/Documentation/DocBook/Makefile.~1~	Sat Aug  3 00:40:00 2002
+++ linux-2.5.40/Documentation/DocBook/Makefile	Mon Oct  7 17:05:16 2002
@@ -155,7 +155,6 @@
 
 clean:
 	@echo 'Cleaning up (DocBook)'
-	@rm -f core *~
 	@rm -f $(BOOKS)
 	@rm -f $(DVI) $(AUX) $(TEX) $(LOG) $(OUT)
 	@rm -f $(PNG-parportbook) $(EPS-parportbook)
