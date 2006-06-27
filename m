Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933445AbWF0Ex4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933445AbWF0Ex4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWF0Exa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:53:30 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:42971 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933407AbWF0ElU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:41:20 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 02/21] [Suspend2] Modify action state.
Date: Tue, 27 Jun 2006 14:41:18 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627044117.14883.49112.stgit@nigel.suspend2.net>
In-Reply-To: <20060627044112.14883.55823.stgit@nigel.suspend2.net>
References: <20060627044112.14883.55823.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the suspend_action state in response to a userspace message. This
variable is an unsigned long treated as bitflags tell us whether to reboot
instead of powering down, pause between step, log everything and so on.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/ui.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/kernel/power/ui.c b/kernel/power/ui.c
index 1ef8957..b952bf7 100644
--- a/kernel/power/ui.c
+++ b/kernel/power/ui.c
@@ -67,3 +67,19 @@ static int progress_granularity = 30;
 
 DECLARE_WAIT_QUEUE_HEAD(userui_wait_for_key);
 
+static void ui_nl_set_state(int n)
+{
+	/* Only let them change certain settings */
+	static const int suspend_action_mask =
+		(1 << SUSPEND_REBOOT) | (1 << SUSPEND_PAUSE) | (1 << SUSPEND_SLOW) |
+		(1 << SUSPEND_LOGALL) | (1 << SUSPEND_SINGLESTEP) |
+		(1 << SUSPEND_PAUSE_NEAR_PAGESET_END);
+
+	suspend_action = (suspend_action & (~suspend_action_mask)) |
+		(n & suspend_action_mask);
+
+	if (!test_action_state(SUSPEND_PAUSE) &&
+			!test_action_state(SUSPEND_SINGLESTEP))
+		wake_up_interruptible(&userui_wait_for_key);
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
