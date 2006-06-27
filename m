Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030697AbWF0Esb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030697AbWF0Esb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030691AbWF0El6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:41:58 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:47579 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933426AbWF0Elv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:41:51 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 11/21] [Suspend2] Wait for keypress.
Date: Tue, 27 Jun 2006 14:41:49 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627044148.14883.12763.stgit@nigel.suspend2.net>
In-Reply-To: <20060627044112.14883.55823.stgit@nigel.suspend2.net>
References: <20060627044112.14883.55823.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wait for a keypress. This might be via userspace (normal case), or in the
special case of an emergency message early in the process, via reading
/dev/console. In these later cases, we can't rely on the userspace process
existing, and want to give the user some control over what happens. We do
implement a timeout though, so unattended boots don't hang indefinitely.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/ui.c |   71 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/kernel/power/ui.c b/kernel/power/ui.c
index 3378766..6271a24 100644
--- a/kernel/power/ui.c
+++ b/kernel/power/ui.c
@@ -331,3 +331,74 @@ void __suspend_message(unsigned long sec
 			&msg, sizeof(msg));
 }
 
+static void wait_for_key_via_userui(void)
+{
+	DECLARE_WAITQUEUE(wait, current);
+
+	add_wait_queue(&userui_wait_for_key, &wait);
+	set_current_state(TASK_INTERRUPTIBLE);
+
+	interruptible_sleep_on(&userui_wait_for_key);
+
+	set_current_state(TASK_RUNNING);
+	remove_wait_queue(&userui_wait_for_key, &wait);
+}
+
+char suspend_wait_for_keypress(int timeout)
+{
+	int fd;
+	char key = '\0';
+	struct termios t, t_backup;
+
+	if (ui_helper_data.pid != -1) {
+		wait_for_key_via_userui();
+		key = ' ';
+		goto out;
+	}
+	
+	/* We should be guaranteed /dev/console exists after populate_rootfs() in
+	 * init/main.c
+	 */
+	if ((fd = sys_open("/dev/console", O_RDONLY, 0)) < 0) {
+		printk("Couldn't open /dev/console.\n");
+		goto out;
+	}
+
+	if (sys_ioctl(fd, TCGETS, (long)&t) < 0)
+		goto out_close;
+
+	memcpy(&t_backup, &t, sizeof(t));
+
+	t.c_lflag &= ~(ISIG|ICANON|ECHO);
+	t.c_cc[VMIN] = 0;
+	if (timeout)
+		t.c_cc[VTIME] = timeout*10;
+
+	if (sys_ioctl(fd, TCSETS, (long)&t) < 0)
+		goto out_restore;
+
+	while (1) {
+		if (sys_read(fd, &key, 1) <= 0) {
+			key = '\0';
+			break;
+		}
+		key = tolower(key);
+		if (test_suspend_state(SUSPEND_SANITY_CHECK_PROMPT)) {
+			if (key == 'c') {
+				set_suspend_state(SUSPEND_CONTINUE_REQ);
+				break;
+			} else if (key == ' ')
+				break;
+		} else
+			break;
+	}
+
+out_restore:
+	sys_ioctl(fd, TCSETS, (long)&t_backup);
+
+out_close:
+	sys_close(fd);
+out:
+	return key;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
