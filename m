Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751059AbVI0WUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbVI0WUU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 18:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbVI0WUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 18:20:19 -0400
Received: from packet.digeo.com ([12.110.80.53]:51967 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id S1751059AbVI0WUT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 18:20:19 -0400
Message-ID: <4339C597.3070409@namesys.com>
Date: Tue, 27 Sep 2005 15:20:07 -0700
From: Nate Diller <nate@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: axboe@suse.de, akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] block cleanups: Add kconfig default iosched submenu
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Sep 2005 22:20:03.0278 (UTC) FILETIME=[9B57D6E0:01C5C3B1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a kconfig submenu to select the default I/O scheduler, in case anticipatory is not compiled 
in or another default is preferred.  Also, since no-op is always available, we should use it 
whenever the selected default is not.

I saw a patch recently to add this option, and I don't think it got picked up.  This version is 
cleaner, since it eliminates all the #ifdef's in the code itself.

Thanks

NATE

Signed-off-by: Nate Diller <nate@namesys.com>

---

  Kconfig.iosched |   28 ++++++++++++++++++++++++++++
  elevator.c      |   24 +++++++++---------------
  2 files changed, 37 insertions(+), 15 deletions(-)

diff -urpN a/drivers/block/elevator.c b/drivers/block/elevator.c
--- a/drivers/block/elevator.c	2005-09-26 19:17:59.000000000 -0700
+++ b/drivers/block/elevator.c	2005-09-27 11:05:15.000000000 -0700
@@ -153,23 +153,17 @@ static char chosen_elevator[16];

  static void elevator_setup_default(void)
  {
-	/*
-	 * check if default is set and exists
+	/*
+	 * If default has not been set, use the compiled-in selection.
  	 */
-	if (chosen_elevator[0] && elevator_find(chosen_elevator))
-		return;
+	if (!chosen_elevator[0])
+		strcpy(chosen_elevator, CONFIG_DEFAULT_IOSCHED);

-#if defined(CONFIG_IOSCHED_AS)
-	strcpy(chosen_elevator, "anticipatory");
-#elif defined(CONFIG_IOSCHED_DEADLINE)
-	strcpy(chosen_elevator, "deadline");
-#elif defined(CONFIG_IOSCHED_CFQ)
-	strcpy(chosen_elevator, "cfq");
-#elif defined(CONFIG_IOSCHED_NOOP)
-	strcpy(chosen_elevator, "noop");
-#else
-#error "You must build at least 1 IO scheduler into the kernel"
-#endif
+	/*
+	 * If the given scheduler is not available, fall back to no-op.
+	 */
+	if (!elevator_find(chosen_elevator))
+		strcpy(chosen_elevator, "noop");
  }

  static int __init elevator_setup(char *str)
diff -urpN a/drivers/block/Kconfig.iosched b/drivers/block/Kconfig.iosched
--- a/drivers/block/Kconfig.iosched	2005-08-28 16:41:01.000000000 -0700
+++ b/drivers/block/Kconfig.iosched	2005-09-26 20:14:06.000000000 -0700
@@ -38,4 +28,32 @@ config IOSCHED_CFQ
  	  among all processes in the system. It should provide a fair
  	  working environment, suitable for desktop systems.

+choice
+	prompt "Default I/O scheduler"
+	default DEFAULT_AS
+	help
+	  Select the I/O scheduler which will be used by default for all
+	  block devices.
+
+	config DEFAULT_AS
+		bool "Anticipatory" if IOSCHED_AS
+
+	config DEFAULT_DEADLINE
+		bool "Deadline" if IOSCHED_DEADLINE
+
+	config DEFAULT_CFQ
+		bool "CFQ" if IOSCHED_CFQ
+
+	config DEFAULT_NOOP
+		bool "No-op"
+
+endchoice
+
+config DEFAULT_IOSCHED
+	string
+	default "anticipatory" if DEFAULT_AS
+	default "deadline" if DEFAULT_DEADLINE
+	default "cfq" if DEFAULT_CFQ
+	default "noop" if DEFAULT_NOOP
+
  endmenu
