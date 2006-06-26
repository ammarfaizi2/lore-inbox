Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbWFZQiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbWFZQiy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbWFZQiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:38:54 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:44012 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1750786AbWFZQiv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:38:51 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 1/2] [Suspend2] Disable load updating during suspending.
Date: Tue, 27 Jun 2006 02:38:54 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626163852.10345.788.stgit@nigel.suspend2.net>
In-Reply-To: <20060626163850.10345.13807.stgit@nigel.suspend2.net>
References: <20060626163850.10345.13807.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suspend2 uses the cpu very intensively, with the result that the load
average can be quite high when a cycle has just completed. This in turn can
cause problems with mail delivery and other activities that suspend
activities when the load average gets too high. To avoid this, we suspend
updates of the load average while the freezer is on.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/timer.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/kernel/timer.c b/kernel/timer.c
index 9e49dee..44a17fc 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -34,6 +34,7 @@
 #include <linux/cpu.h>
 #include <linux/syscalls.h>
 #include <linux/delay.h>
+#include <linux/freezer.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -869,6 +870,16 @@ static inline void calc_load(unsigned lo
 	count -= ticks;
 	if (count < 0) {
 		count += LOAD_FREQ;
+
+		/* Suspend2 does a lot of work (pagecache I/O) before
+		 * and after the atomic copy. If we let the load average
+		 * be updated while suspending, it will be very high post
+		 * resume. Processes such as some MTAs that stop work
+		 * while the average is high will be unnecessarily disrupted.
+		 */
+		if (freezer_is_on())
+			return;
+
 		active_tasks = count_active_tasks();
 		CALC_LOAD(avenrun[0], EXP_1, active_tasks);
 		CALC_LOAD(avenrun[1], EXP_5, active_tasks);

--
Nigel Cunningham		nigel at suspend2 dot net
