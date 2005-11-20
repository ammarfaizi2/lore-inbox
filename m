Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750862AbVKTHF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbVKTHF7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 02:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750859AbVKTHF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 02:05:59 -0500
Received: from smtp102.sbc.mail.re2.yahoo.com ([68.142.229.103]:42132 "HELO
	smtp102.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750862AbVKTHF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 02:05:59 -0500
Message-Id: <20051120064420.736244000.dtor_core@ameritech.net>
References: <20051120063611.269343000.dtor_core@ameritech.net>
Date: Sun, 20 Nov 2005 01:36:23 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [git pull 12/14] Input - help swsusp
Content-Disposition: inline; filename=input-help-swsusp.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: make serio and gameport more swsusp friendly

kseriod and kgameportd used to process all pending events before
checking for freeze condition. This may cause swsusp to time out
while stopping tasks when resuming. Switch to process events one
by one to check freeze status more often.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/gameport/gameport.c |   12 +++++++++---
 drivers/input/serio/serio.c       |   12 +++++++++---
 2 files changed, 18 insertions(+), 6 deletions(-)

Index: work/drivers/input/serio/serio.c
===================================================================
--- work.orig/drivers/input/serio/serio.c
+++ work/drivers/input/serio/serio.c
@@ -269,14 +269,20 @@ static struct serio_event *serio_get_eve
 	return event;
 }
 
-static void serio_handle_events(void)
+static void serio_handle_event(void)
 {
 	struct serio_event *event;
 	struct serio_driver *serio_drv;
 
 	down(&serio_sem);
 
-	while ((event = serio_get_event())) {
+	/*
+	 * Note that we handle only one event here to give swsusp
+	 * a chance to freeze kseriod thread. Serio events should
+	 * be pretty rare so we are not concerned about taking
+	 * performance hit.
+	 */
+	if ((event = serio_get_event())) {
 
 		switch (event->type) {
 			case SERIO_REGISTER_PORT:
@@ -368,7 +374,7 @@ static struct serio *serio_get_pending_c
 static int serio_thread(void *nothing)
 {
 	do {
-		serio_handle_events();
+		serio_handle_event();
 		wait_event_interruptible(serio_wait,
 			kthread_should_stop() || !list_empty(&serio_event_list));
 		try_to_freeze();
Index: work/drivers/input/gameport/gameport.c
===================================================================
--- work.orig/drivers/input/gameport/gameport.c
+++ work/drivers/input/gameport/gameport.c
@@ -339,14 +339,20 @@ static struct gameport_event *gameport_g
 	return event;
 }
 
-static void gameport_handle_events(void)
+static void gameport_handle_event(void)
 {
 	struct gameport_event *event;
 	struct gameport_driver *gameport_drv;
 
 	down(&gameport_sem);
 
-	while ((event = gameport_get_event())) {
+	/*
+	 * Note that we handle only one event here to give swsusp
+	 * a chance to freeze kgameportd thread. Gameport events
+	 * should be pretty rare so we are not concerned about
+	 * taking performance hit.
+	 */
+	if ((event = gameport_get_event())) {
 
 		switch (event->type) {
 			case GAMEPORT_REGISTER_PORT:
@@ -433,7 +439,7 @@ static struct gameport *gameport_get_pen
 static int gameport_thread(void *nothing)
 {
 	do {
-		gameport_handle_events();
+		gameport_handle_event();
 		wait_event_interruptible(gameport_wait,
 			kthread_should_stop() || !list_empty(&gameport_event_list));
 		try_to_freeze();

