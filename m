Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161135AbWAHTik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161135AbWAHTik (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 14:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161145AbWAHTii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 14:38:38 -0500
Received: from cabal.ca ([134.117.69.58]:64182 "EHLO fattire.cabal.ca")
	by vger.kernel.org with ESMTP id S1161142AbWAHTiK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 14:38:10 -0500
Date: Sun, 8 Jan 2006 14:38:11 -0500
From: Kyle McMartin <kyle@parisc-linux.org>
To: akpm@osdl.org
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       parisc-linux@lists.parisc-linux.org, carlos@parisc-linux.org,
       willy@parisc-linux.org
Subject: [PATCH 5/5] Decrapify evdev.c of per-arch compat hacks
Message-ID: <20060108193811.GL3782@tachyon.int.mcmartin.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kyle McMartin <kyle@parisc-linux.org>

A nice cleanup of evdev.c by using the is_compat_task() macro.

Signed-off-by: Kyle McMartin <kyle@parisc-linux.org>

---

 drivers/input/evdev.c |   18 +++---------------
 1 files changed, 3 insertions(+), 15 deletions(-)

3e7a8822763c01f93afdb2f0011dec6b641df1fb
diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index f7490a0..3cabb4b 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -154,27 +154,15 @@ struct input_event_compat {
 	__s32 value;
 };
 
-#ifdef CONFIG_X86_64
-#  define COMPAT_TEST test_thread_flag(TIF_IA32)
-#elif defined(CONFIG_IA64)
-#  define COMPAT_TEST IS_IA32_PROCESS(ia64_task_regs(current))
-#elif defined(CONFIG_S390)
-#  define COMPAT_TEST test_thread_flag(TIF_31BIT)
-#elif defined(CONFIG_MIPS)
-#  define COMPAT_TEST (current->thread.mflags & MF_32BIT_ADDR)
-#else
-#  define COMPAT_TEST test_thread_flag(TIF_32BIT)
-#endif
-
 static inline size_t evdev_event_size(void)
 {
-	return COMPAT_TEST ?
+	return is_compat_task(current) ?
 		sizeof(struct input_event_compat) : sizeof(struct input_event);
 }
 
 static int evdev_event_from_user(const char __user *buffer, struct input_event *event)
 {
-	if (COMPAT_TEST) {
+	if (is_compat_task(current)) {
 		struct input_event_compat compat_event;
 
 		if (copy_from_user(&compat_event, buffer, sizeof(struct input_event_compat)))
@@ -196,7 +184,7 @@ static int evdev_event_from_user(const c
 
 static int evdev_event_to_user(char __user *buffer, const struct input_event *event)
 {
-	if (COMPAT_TEST) {
+	if (is_compat_task(current)) {
 		struct input_event_compat compat_event;
 
 		compat_event.time.tv_sec = event->time.tv_sec;
-- 
1.0.7

