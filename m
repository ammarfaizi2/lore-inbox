Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933113AbWFZWdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933113AbWFZWdz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933135AbWFZWdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:33:51 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:22943 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933130AbWFZWdo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:33:44 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 08/16] [Suspend2] Can suspend?
Date: Tue, 27 Jun 2006 08:33:42 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223341.3832.99142.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223314.3832.23435.stgit@nigel.suspend2.net>
References: <20060626223314.3832.23435.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Test whether resume2= points to a recognised signature. That is, can we
even try to suspend?

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 504eed7..bda4c2a 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -575,3 +575,27 @@ void suspend_cleanup(void)
 	up(&pm_sem);
 }
 
+static int can_suspend(void)
+{
+	if (down_trylock(&pm_sem)) {
+		set_result_state(SUSPEND_ABORTED);
+		set_result_state(SUSPEND_PM_SEM);
+		return 0;
+	}
+
+	if (!test_suspend_state(SUSPEND_CAN_SUSPEND))
+		suspend_attempt_to_parse_resume_device();
+
+	if (!test_suspend_state(SUSPEND_CAN_SUSPEND)) {
+		printk(name_suspend "Software suspend is disabled.\n"
+			"This may be because you haven't put something along "
+			"the lines of\n\nresume2=swap:/dev/hda1\n\n"
+			"in lilo.conf or equivalent. (Where /dev/hda1 is your "
+			"swap partition).\n");
+		set_result_state(SUSPEND_ABORTED);
+		return 0;
+	}
+	
+	return 1;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
