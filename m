Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264479AbTH1WfZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 18:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264481AbTH1WfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 18:35:25 -0400
Received: from aneto.able.es ([212.97.163.22]:9686 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S264479AbTH1WfT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 18:35:19 -0400
Date: Fri, 29 Aug 2003 00:35:11 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [2.4] gcc3 warns about type-punned pointers ?
Message-ID: <20030828223511.GA23528@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

gcc3 gives this warning when using the __set_64bit_var function:

/usr/src/linux/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules

Is it a potential problem ?

This seems to cure it:

--- linux-2.4.22-jam1m/include/asm-i386/system.h.orig	2003-08-29 00:26:41.000000000 +0200
+++ linux-2.4.22-jam1m/include/asm-i386/system.h	2003-08-29 00:26:55.000000000 +0200
@@ -181,8 +181,8 @@
 {
 	__set_64bit(ptr,(unsigned int)(value), (unsigned int)((value)>>32ULL));
 }
-#define ll_low(x)	*(((unsigned int*)&(x))+0)
-#define ll_high(x)	*(((unsigned int*)&(x))+1)
+#define ll_low(x)	*(((unsigned int*)(void*)&(x))+0)
+#define ll_high(x)	*(((unsigned int*)(void*)&(x))+1)
 
 static inline void __set_64bit_var (unsigned long long *ptr,
 			 unsigned long long value)

A collateral question: why is the reason for this function ?
long long assignments are not atomic in gcc ?

TIA

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.22-jam1m (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-1mdk))
