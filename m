Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbVKJOmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbVKJOmI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 09:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbVKJOmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 09:42:08 -0500
Received: from ns.suse.de ([195.135.220.2]:33235 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750714AbVKJOmH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 09:42:07 -0500
From: Andreas Schwab <schwab@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Broken __get_unaligned from <asm-generic/unaligned.h>
X-Yow: Is this an out-take from the ``BRADY BUNCH''?
Date: Thu, 10 Nov 2005 15:42:05 +0100
Message-ID: <jevez0h8ea.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

__get_unaligned can't cope with const-qualified types:

drivers/char/vc_screen.c: In function 'vcs_write':
drivers/char/vc_screen.c:422: error: assignment of read-only variable 'val'
drivers/char/vc_screen.c:422: error: assignment of read-only variable 'val'
drivers/char/vc_screen.c:422: error: assignment of read-only variable 'val'
drivers/char/vc_screen.c:422: error: assignment of read-only variable 'val'

Signed-off-by: Andreas Schwab <schwab@suse.de>

--- linux-2.6.14/include/asm-generic/unaligned.h.~1~	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.14/include/asm-generic/unaligned.h	2005-11-10 14:37:58.356107194 +0100
@@ -78,7 +78,7 @@ static inline void __ustw(__u16 val, __u
 
 #define __get_unaligned(ptr, size) ({		\
 	const void *__gu_p = ptr;		\
-	__typeof__(*(ptr)) val;			\
+	unsigned long val;			\
 	switch (size) {				\
 	case 1:					\
 		val = *(const __u8 *)__gu_p;	\
@@ -95,7 +95,7 @@ static inline void __ustw(__u16 val, __u
 	default:				\
 		bad_unaligned_access_length();	\
 	};					\
-	val;					\
+	(__typeof__(*(ptr)))val;		\
 })
 
 #define __put_unaligned(val, ptr, size)		\

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
