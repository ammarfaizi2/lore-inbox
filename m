Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161102AbWBHQvk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161102AbWBHQvk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 11:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161108AbWBHQvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 11:51:40 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:39389 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1161102AbWBHQvk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 11:51:40 -0500
Message-ID: <43EA33B3.4D67CA97@tv-sign.ru>
Date: Wed, 08 Feb 2006 21:08:51 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] fix copy_sighand() vs do_sigaction() race
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

copy_sighand() should hold ->sighand->siglock while copying
->sighand->action, another thread may be doing sigaction().

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- RC-1/kernel/fork.c~	2006-02-07 01:41:14.000000000 +0300
+++ RC-1/kernel/fork.c	2006-02-08 23:38:56.000000000 +0300
@@ -766,7 +766,9 @@ static inline int copy_sighand(unsigned 
 		return -ENOMEM;
 	spin_lock_init(&sig->siglock);
 	atomic_set(&sig->count, 1);
+	spin_lock_irq(&current->sighand->siglock);
 	memcpy(sig->action, current->sighand->action, sizeof(sig->action));
+	spin_unlock_irq(&current->sighand->siglock);
 	return 0;
 }
