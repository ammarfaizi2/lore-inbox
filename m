Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932563AbVLMI2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932563AbVLMI2x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 03:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932557AbVLMI2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 03:28:20 -0500
Received: from mail.kroah.org ([69.55.234.183]:36740 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932565AbVLMIZO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 03:25:14 -0500
Date: Tue, 13 Dec 2005 00:24:04 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       drzeus@drzeus.cx, pavel@suse.cz, dwmw2@infradead.org
Subject: [patch 26/26] Add try_to_freeze to kauditd
Message-ID: <20051213082404.GA5823@kroah.com>
References: <20051213073430.558435000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="add-try_to_freeze-to-kauditd.patch"
In-Reply-To: <20051213082143.GA5823@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Pierre Ossman <drzeus@drzeus.cx>

kauditd was causing suspends to fail because it refused to freeze.  Adding
a try_to_freeze() to its sleep loop solves the issue.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
Acked-by: Pavel Machek <pavel@suse.cz>
Cc: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

diff --git a/kernel/audit.c b/kernel/audit.c
index 0c56320..32fa03a 100644
---
 kernel/audit.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- linux-2.6.14.3.orig/kernel/audit.c
+++ linux-2.6.14.3/kernel/audit.c
@@ -291,8 +291,10 @@ int kauditd_thread(void *dummy)
 			set_current_state(TASK_INTERRUPTIBLE);
 			add_wait_queue(&kauditd_wait, &wait);
 
-			if (!skb_queue_len(&audit_skb_queue))
+			if (!skb_queue_len(&audit_skb_queue)) {
+				try_to_freeze();
 				schedule();
+			}
 
 			__set_current_state(TASK_RUNNING);
 			remove_wait_queue(&kauditd_wait, &wait);

--
