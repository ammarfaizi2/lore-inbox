Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbWFZQsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbWFZQsI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWFZQrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:47:49 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:34277 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1750819AbWFZQrd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:47:33 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 2/7] [Suspend2] Read a proc file entry.
Date: Tue, 27 Jun 2006 02:47:36 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626164735.10724.72387.stgit@nigel.suspend2.net>
In-Reply-To: <20060626164729.10724.37131.stgit@nigel.suspend2.net>
References: <20060626164729.10724.37131.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Generic (within Suspend2) routine for reading a proc file entry all our
proc entries use this routine, so there is no duplication of code at all.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/proc.c |   70 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 70 insertions(+), 0 deletions(-)

diff --git a/kernel/power/proc.c b/kernel/power/proc.c
index 16ad90e..e072b50 100644
--- a/kernel/power/proc.c
+++ b/kernel/power/proc.c
@@ -28,3 +28,73 @@ static struct suspend_proc_data proc_par
 extern void __suspend_try_resume(void);
 extern void suspend_main(void);
 
+/* suspend_read_proc
+ *
+ * Generic handling for reading the contents of bits, integers,
+ * unsigned longs and strings.
+ */
+static int suspend_read_proc(char *page, char **start, off_t off, int count,
+		int *eof, void *data)
+{
+	int len = 0;
+	struct suspend_proc_data *proc_data = (struct suspend_proc_data *) data;
+
+	if (suspend_start_anything(0))
+		return -EBUSY;
+	
+	if (proc_data->needs_storage_manager & 1)
+		suspend_prepare_usm();
+	
+	switch (proc_data->type) {
+		case SUSPEND_PROC_DATA_CUSTOM:
+			if (proc_data->data.special.read_proc) {
+				read_proc_t *read_proc = proc_data->data.special.read_proc;
+				len = read_proc(page, start, off, count, eof, data);
+			} else
+				len = 0;
+			break;
+		case SUSPEND_PROC_DATA_BIT:
+			len = sprintf(page, "%d\n", 
+				-test_bit(proc_data->data.bit.bit,
+					proc_data->data.bit.bit_vector));
+			break;
+		case SUSPEND_PROC_DATA_INTEGER:
+			{
+				int *variable = proc_data->data.integer.variable;
+				len = sprintf(page, "%d\n", *variable);
+				break;
+			}
+		case SUSPEND_PROC_DATA_LONG:
+			{
+				long *variable = proc_data->data.a_long.variable;
+				len = sprintf(page, "%ld\n", *variable);
+				break;
+			}
+		case SUSPEND_PROC_DATA_UL:
+			{
+				long *variable = proc_data->data.ul.variable;
+				len = sprintf(page, "%lu\n", *variable);
+				break;
+			}
+		case SUSPEND_PROC_DATA_STRING:
+			{
+				char *variable = proc_data->data.string.variable;
+				len = sprintf(page, "%s\n", variable);
+				break;
+			}
+	}
+	/* Side effect routine? */
+	if (proc_data->read_proc)
+		proc_data->read_proc();
+	
+	if (len <= count)
+		*eof = 1;
+	
+	if (proc_data->needs_storage_manager & 1)
+		suspend_cleanup_usm();
+
+	suspend_finish_anything(0);
+	
+	return len;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
