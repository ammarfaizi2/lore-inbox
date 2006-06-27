Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932755AbWF0Esa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932755AbWF0Esa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932589AbWF0Es3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:48:29 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:50651 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S932755AbWF0EmM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:42:12 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 17/21] [Suspend2] Early boot message support.
Date: Tue, 27 Jun 2006 14:42:10 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627044209.14883.17428.stgit@nigel.suspend2.net>
In-Reply-To: <20060627044112.14883.55823.stgit@nigel.suspend2.net>
References: <20060627044112.14883.55823.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Give the user the option of continuing or rebooting when we discover a
problem really early in the resume, prior to userspace program being
started. We may not even be able to start the userspace program, so we need
limited support for user interaction - that or we need to always invalidate
images if problems occur or such like.

Some would complain that the kernel shouldn't be seeking to interact with
the user. While I see that argument, it seems to me that helping the user
do what they want to do is far more important. The prompt has a timeout, so
we won't hang indefinitely if there's no response.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/ui.c |  108 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 108 insertions(+), 0 deletions(-)

diff --git a/kernel/power/ui.c b/kernel/power/ui.c
index 2012c2a..3d246e4 100644
--- a/kernel/power/ui.c
+++ b/kernel/power/ui.c
@@ -563,3 +563,111 @@ void suspend_cleanup_console(void)
 }
 #endif
 
+/* suspend_early_boot_message()
+ * Description:	Handle errors early in the process of booting.
+ * 		The user may press C to continue booting, perhaps
+ * 		invalidating the image,  or space to reboot. 
+ * 		This works from either the serial console or normally 
+ * 		attached keyboard.
+ *
+ * 		Note that we come in here from init, while the kernel is
+ * 		locked. If we want to get events from the serial console,
+ * 		we need to temporarily unlock the kernel.
+ *
+ * 		suspend_early_boot_message may also be called post-boot.
+ * 		In this case, it simply printks the message and returns.
+ *
+ * Arguments:	int	Whether we are able to erase the image.
+ * 		int	default_answer. What to do when we timeout. This
+ * 			will normally be continue, but the user might
+ * 			provide command line options (__setup) to override
+ * 			particular cases.
+ * 		Char *. Pointer to a string explaining why we're moaning.
+ */
+
+#define say(message, a...) printk(KERN_EMERG message, ##a)
+#define message_timeout 25 /* message_timeout * 10 must fit in 8 bits */
+
+int suspend_early_boot_message(int message_detail, int default_answer, char *warning_reason, ...)
+{
+	unsigned long orig_state = get_suspend_state(), continue_req = 0;
+	va_list args;
+	int printed_len;
+
+	if (warning_reason) {
+		va_start(args, warning_reason);
+		printed_len = vsnprintf(local_printf_buf, 
+				sizeof(local_printf_buf), 
+				warning_reason,
+				args);
+		va_end(args);
+	}
+
+	if (!test_suspend_state(SUSPEND_BOOT_TIME)) {
+		printk(name_suspend "%s\n", local_printf_buf);
+		return default_answer;
+	}
+
+	/* We might be called directly from do_mounts_initrd if the
+	 * user fails to set up their initrd properly. We need to
+	 * enable the keyboard handler by setting the running flag */
+	set_suspend_state(SUSPEND_RUNNING);
+
+#if defined(CONFIG_VT) || defined(CONFIG_SERIAL_CONSOLE)
+	console_loglevel = 7;
+
+	say("=== Suspend2 ===\n\n");
+	if (warning_reason) {
+		say("BIG FAT WARNING!! %s\n\n", local_printf_buf);
+		switch (message_detail) {
+		 case 0:
+			say("If you continue booting, note that any image WILL NOT BE REMOVED.\n");
+			say("Suspend is unable to do so because the appropriate modules aren't\n");
+			say("loaded. You should manually remove the image to avoid any\n");
+			say("possibility of corrupting your filesystem(s) later.\n");
+			break;
+		 case 1:
+			say("If you want to use the current suspend image, reboot and try\n");
+			say("again with the same kernel that you suspended from. If you want\n");
+			say("to forget that image, continue and the image will be erased.\n");
+			break;
+		}
+		say("Press SPACE to reboot or C to continue booting with this kernel\n\n");
+		say("Default action if you don't select one in %d seconds is: %s.\n",
+			message_timeout,
+			default_answer == SUSPEND_CONTINUE_REQ ?
+			"continue booting" : "reboot");
+	} else {
+		say("BIG FAT WARNING!!\n\n");
+		say("You have tried to resume from this image before.\n");
+		say("If it failed once, it may well fail again.\n");
+		say("Would you like to remove the image and boot normally?\n");
+		say("This will be equivalent to entering noresume2 on the\n");
+		say("kernel command line.\n\n");
+		say("Press SPACE to remove the image or C to continue resuming.\n\n");
+		say("Default action if you don't select one in %d seconds is: %s.\n",
+			message_timeout,
+			!!default_answer ?
+			"continue resuming" : "remove the image");
+	}
+	
+	set_suspend_state(SUSPEND_SANITY_CHECK_PROMPT);
+	clear_suspend_state(SUSPEND_CONTINUE_REQ);
+
+	if (suspend_wait_for_keypress(message_timeout) == 0) /* We timed out */
+		continue_req = !!default_answer;
+	else
+		continue_req = test_suspend_state(SUSPEND_CONTINUE_REQ);
+
+	if ((warning_reason) && (!continue_req))
+		machine_restart(NULL);
+	
+	restore_suspend_state(orig_state);
+	if (continue_req)
+		set_suspend_state(SUSPEND_CONTINUE_REQ);
+
+#endif /* CONFIG_VT or CONFIG_SERIAL_CONSOLE */
+	return -EPERM;
+}
+#undef say
+

--
Nigel Cunningham		nigel at suspend2 dot net
