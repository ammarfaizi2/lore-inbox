Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933403AbWF0EkJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933403AbWF0EkJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933397AbWF0EkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:40:07 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:30683 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933312AbWF0EkC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:40:02 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 11/13] [Suspend2] Launch a userspace helper.
Date: Tue, 27 Jun 2006 14:40:01 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627044000.14630.3196.stgit@nigel.suspend2.net>
In-Reply-To: <20060627043923.14630.565.stgit@nigel.suspend2.net>
References: <20060627043923.14630.565.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Launch a userspace helper. The usermodehelper function can't take a simple
string with args, so we split the arguments up into words (as required)
before invoking usermodehelper.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/netlink.c |   54 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/kernel/power/netlink.c b/kernel/power/netlink.c
index 7b75f4f..d7a3a90 100644
--- a/kernel/power/netlink.c
+++ b/kernel/power/netlink.c
@@ -290,3 +290,57 @@ void suspend_netlink_close(struct user_h
 	}
 }
 
+int suspend2_launch_userspace_program(char *command, int channel_no)
+{
+	int retval;
+	static char *envp[] = {
+			"HOME=/",
+			"TERM=linux",
+			"PATH=/sbin:/usr/sbin:/bin:/usr/bin",
+			NULL };
+	static char *argv[] = { NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL };
+	char *channel = kmalloc(6, GFP_KERNEL);
+	int arg = 0, size;
+	char test_read[255];
+	char *orig_posn = command;
+
+	if (!strlen(orig_posn))
+		return 1;
+
+	/* Up to 7 args supported */
+	while (arg < 7) {
+		sscanf(orig_posn, "%s", test_read);
+		size = strlen(test_read);
+		if (!(size))
+			break;
+		argv[arg] = kmalloc(size + 1, GFP_ATOMIC);
+		strcpy(argv[arg], test_read);
+		orig_posn += size + 1;
+		*test_read = 0;
+		arg++;
+	}
+	
+	if (channel_no) {
+		sprintf(channel, "-c%d", channel_no);
+		argv[arg] = channel;
+	} else
+		arg--;
+
+	retval = call_usermodehelper(argv[0], argv, envp, 0);
+
+	if (retval)
+		printk("Failed to launch userspace program '%s': Error %d\n",
+				command, retval);
+
+	{
+		int i;
+		for (i = 0; i < arg; i++)
+			if (argv[i] && argv[i] != channel)
+				kfree(argv[i]);
+	}
+
+	kfree(channel);
+
+	return retval;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
