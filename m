Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbUKEWaa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbUKEWaa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 17:30:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261224AbUKEW17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 17:27:59 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:4207 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261237AbUKEWYl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 17:24:41 -0500
Date: Sat, 6 Nov 2004 00:25:58 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Alexander Stohr <Alexander.Stohr@gmx.de>
Cc: linux-kernel@vger.kernel.org, kai@germaschewski.name, sam@ravnborg.org
Subject: Re: [PATCH] fix for pseudo symbol swapping with scripts/kallsyms - linux-2.6.10-rc1-bk12 & gcc 3.4.2
Message-ID: <20041105232558.GA9844@mars.ravnborg.org>
Mail-Followup-To: Alexander Stohr <Alexander.Stohr@gmx.de>,
	linux-kernel@vger.kernel.org, kai@germaschewski.name,
	sam@ravnborg.org
References: <31629.1099492414@www8.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31629.1099492414@www8.gmx.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 03:33:34PM +0100, Alexander Stohr wrote:
> Hello,
> 
> when trying out gcc 3.4.2 (in contrast to my former gcc 3.3.3)
> with a recent bitkeeper snapshot of the linux kernel (2.6.10-rc1-bk12)
> i suddenly got a notification about problems with symbol check
> and hinting me for turning on CONFIG_KALLSYMS_EXTRA_PASS, thus
> suggesting me to turn on tripple pass bzImage linking as a 
> short term work around.
> 
> a deeper analysis of the symbols (using nm and a hacked in table
> dump for kallsyms) showed me that the symbols "__sched_text_start"
> and "__down" did fall onto the very same memory location in 
> linker run 2 and 3 and further did swap their order! (a-z sorted?)
> in linker run 1, there was a small offset between them for whatever
> reason which prevented them from beeing consolidated and swapped.
> (i dont see what makes up the difference here. take it as a hint.)

The linker will adhere to any alingment demands in the section,
but not the labels. So the real fix is to make sure the labels are
defined inside the section.
Please try attached (untested) patch.

Check that error is present without patch, and it is fixed with the patch.

	Sam
	
===== include/asm-generic/vmlinux.lds.h 1.16 vs edited =====
--- 1.16/include/asm-generic/vmlinux.lds.h	2004-10-06 18:45:06 +02:00
+++ edited/include/asm-generic/vmlinux.lds.h	2004-11-06 00:22:27 +01:00
@@ -77,11 +77,15 @@
 	}
 
 #define SCHED_TEXT							\
+	.sched.text: {							\
 		VMLINUX_SYMBOL(__sched_text_start) = .;			\
 		*(.sched.text)						\
-		VMLINUX_SYMBOL(__sched_text_end) = .;
+		VMLINUX_SYMBOL(__sched_text_end) = .;			\
+	}
 
 #define LOCK_TEXT							\
+	.spinlock.text: {						\
 		VMLINUX_SYMBOL(__lock_text_start) = .;			\
 		*(.spinlock.text)					\
-		VMLINUX_SYMBOL(__lock_text_end) = .;
+		VMLINUX_SYMBOL(__lock_text_end) = .;			\
+	}
