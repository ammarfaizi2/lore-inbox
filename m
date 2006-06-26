Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbWFZXBB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbWFZXBB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933278AbWFZXAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:00:23 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:26295 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933248AbWFZWkC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:40:02 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 17/35] [Suspend2] Filewriter initrd image support.
Date: Tue, 27 Jun 2006 08:40:01 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223959.4685.63965.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
References: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First cut support for making the initrd itself the image.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_file.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_file.c b/kernel/power/suspend_file.c
index 46527f1..6f298fc 100644
--- a/kernel/power/suspend_file.c
+++ b/kernel/power/suspend_file.c
@@ -544,3 +544,41 @@ static int filewriter_write_header_clean
 	return 0;
 }
 
+/* HEADER READING */
+
+#ifdef CONFIG_DEVFS_FS
+int  create_dev(char *name, dev_t dev, char *devfs_name);
+#else
+static int create_dev(char *name, dev_t dev, char *devfs_name)
+{
+	sys_unlink(name);
+	return sys_mknod(name, S_IFBLK|0600, new_encode_dev(dev));
+}
+#endif
+
+static int rd_init(void)
+{
+	suspend_writer_buffer_posn = 0;
+
+	create_dev("/dev/root", ROOT_DEV, root_device_name);
+	create_dev("/dev/ram", MKDEV(RAMDISK_MAJOR, 0), NULL);
+
+	suspend_read_fd = sys_open("/dev/root", O_RDONLY, 0);
+	if (suspend_read_fd < 0)
+		goto out;
+	
+	sys_read(suspend_read_fd, suspend_writer_buffer, BLOCK_SIZE);
+
+	memcpy(&suspend_writer_posn_save,
+		suspend_writer_buffer + suspend_writer_buffer_posn,
+		sizeof(suspend_writer_posn_save));
+	
+	suspend_writer_buffer_posn += sizeof(suspend_writer_posn_save);
+
+	return 0;
+out:
+	sys_unlink("/dev/ram");
+	sys_unlink("/dev/root");
+	return -EIO;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
