Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbTH2Owh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 10:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbTH2Ow3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 10:52:29 -0400
Received: from amsfep16-int.chello.nl ([213.46.243.26]:10843 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S261305AbTH2OwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 10:52:00 -0400
Date: Fri, 29 Aug 2003 16:51:07 +0200
Message-Id: <200308291451.h7TEp7tI005896@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k free_io_area()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Take the gap into account in free_io_area() (from Michael Müller)

--- linux-2.4.23-pre1/arch/m68k/mm/kmap.c	Mon Feb 19 10:36:43 2001
+++ linux-m68k-2.4.23-pre1/arch/m68k/mm/kmap.c	Tue Jul  1 22:06:18 2003
@@ -71,7 +71,7 @@
 		addr = tmp->size + (unsigned long)tmp->addr;
 	}
 	area->addr = (void *)addr;
-	area->size = size + IO_SIZE;
+	area->size = size + IO_SIZE;	/* leave a gap between */
 	area->next = *p;
 	*p = area;
 	return area;
@@ -87,7 +87,10 @@
 	for (p = &iolist ; (tmp = *p) ; p = &tmp->next) {
 		if (tmp->addr == addr) {
 			*p = tmp->next;
-			__iounmap(tmp->addr, tmp->size);
+			if ( tmp->size > IO_SIZE )
+				__iounmap(tmp->addr, tmp->size - IO_SIZE);
+			else
+				printk("free_io_area: Invalid I/O area size %lu\n", tmp->size);
 			kfree(tmp);
 			return;
 		}

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
