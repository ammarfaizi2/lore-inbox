Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750700AbWFEUvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWFEUvO (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 16:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750701AbWFEUvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 16:51:14 -0400
Received: from xenotime.net ([66.160.160.81]:54421 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750700AbWFEUvN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 16:51:13 -0400
Date: Mon, 5 Jun 2006 13:54:01 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: davej@redhat.com, mingo@elte.hu, mbligh@google.com, akpm@osdl.org,
        apw@shadowen.org, linux-kernel@vger.kernel.org
Subject: [PATCH] poison: add & use more constants
Message-Id: <20060605135401.f7941311.rdunlap@xenotime.net>
In-Reply-To: <20060605131447.4f46bbaf.rdunlap@xenotime.net>
References: <44845C27.3000006@google.com>
	<20060605194422.GB14709@elte.hu>
	<20060605130039.db1ac80c.rdunlap@xenotime.net>
	<20060605200554.GB6143@redhat.com>
	<20060605131447.4f46bbaf.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Add more poison values to include/linux/poison.h.
It's not clear to me whether some others should be added or not,
so I haven't added any of these:

./include/linux/libata.h:#define ATA_TAG_POISON		0xfafbfcfdU
./arch/ppc/8260_io/fcc_enet.c:1918:	memset((char *)(&(immap->im_dprambase[(mem_addr+64)])), 0x88, 32);
./drivers/usb/mon/mon_text.c:429:	memset(mem, 0xe5, sizeof(struct mon_event_text));
./drivers/char/ftape/lowlevel/ftape-ctl.c:738:		memset(ft_buffer[i]->address, 0xAA, FT_BUFF_SIZE);
./drivers/block/sx8.c:/* 0xf is just arbitrary, non-zero noise; this is sorta like poisoning */

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 include/linux/poison.h |    7 +++++++
 kernel/mutex-debug.c   |    5 +++--
 security/keys/key.c    |    3 ++-
 3 files changed, 12 insertions(+), 3 deletions(-)

--- linux-2617-rc5mm3.orig/include/linux/poison.h
+++ linux-2617-rc5mm3/include/linux/poison.h
@@ -45,6 +45,13 @@
 /********** drivers/atm/ **********/
 #define ATM_POISON_FREE		0x12
 
+/********** kernel/mutexes **********/
+#define MUTEX_DEBUG_INIT	0x11
+#define MUTEX_DEBUG_FREE	0x22
+
+/********** security/ **********/
+#define KEY_DESTROY		0xbd
+
 /********** sound/oss/ **********/
 #define OSS_POISON_FREE		0xAB
 
--- linux-2617-rc5mm3.orig/kernel/mutex-debug.c
+++ linux-2617-rc5mm3/kernel/mutex-debug.c
@@ -16,6 +16,7 @@
 #include <linux/sched.h>
 #include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/poison.h>
 #include <linux/spinlock.h>
 #include <linux/kallsyms.h>
 #include <linux/interrupt.h>
@@ -155,7 +156,7 @@ void debug_mutex_set_owner(struct mutex 
 
 void debug_mutex_lock_common(struct mutex *lock, struct mutex_waiter *waiter)
 {
-	memset(waiter, 0x11, sizeof(*waiter));
+	memset(waiter, MUTEX_DEBUG_INIT, sizeof(*waiter));
 	waiter->magic = waiter;
 	INIT_LIST_HEAD(&waiter->list);
 }
@@ -171,7 +172,7 @@ void debug_mutex_wake_waiter(struct mute
 void debug_mutex_free_waiter(struct mutex_waiter *waiter)
 {
 	DEBUG_WARN_ON(!list_empty(&waiter->list));
-	memset(waiter, 0x22, sizeof(*waiter));
+	memset(waiter, MUTEX_DEBUG_FREE, sizeof(*waiter));
 }
 
 void debug_mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
--- linux-2617-rc5mm3.orig/security/keys/key.c
+++ linux-2617-rc5mm3/security/keys/key.c
@@ -11,6 +11,7 @@
 
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/poison.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/security.h>
@@ -986,7 +987,7 @@ void unregister_key_type(struct key_type
 		if (key->type == ktype) {
 			if (ktype->destroy)
 				ktype->destroy(key);
-			memset(&key->payload, 0xbd, sizeof(key->payload));
+			memset(&key->payload, KEY_DESTROY, sizeof(key->payload));
 		}
 	}
 



---
