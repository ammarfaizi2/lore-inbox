Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbWFZQsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWFZQsK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbWFZQrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:47:47 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:34789 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1750810AbWFZQrh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:47:37 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 3/7] [Suspend2] Proc write routine
Date: Tue, 27 Jun 2006 02:47:40 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626164738.10724.37257.stgit@nigel.suspend2.net>
In-Reply-To: <20060626164729.10724.37131.stgit@nigel.suspend2.net>
References: <20060626164729.10724.37131.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The proc write routine shared by all Suspend2 proc entries.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/proc.c |  133 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 133 insertions(+), 0 deletions(-)

diff --git a/kernel/power/proc.c b/kernel/power/proc.c
index e072b50..cdbf9cf 100644
--- a/kernel/power/proc.c
+++ b/kernel/power/proc.c
@@ -98,3 +98,136 @@ static int suspend_read_proc(char *page,
 	return len;
 }
 
+/* suspend_write_proc
+ *
+ * Generic routine for handling writing to files representing
+ * bits, integers and unsigned longs.
+ */
+
+static int suspend_write_proc(struct file *file, const char *buffer,
+		unsigned long count, void *data)
+{
+	struct suspend_proc_data *proc_data = (struct suspend_proc_data *) data;
+	char *my_buf = (char *) get_zeroed_page(GFP_ATOMIC);
+	int result = count, assigned_temp_buffer = 0;
+
+	if (!my_buf)
+		return -ENOMEM;
+
+	if (count > PAGE_SIZE)
+		count = PAGE_SIZE;
+
+	if (copy_from_user(my_buf, buffer, count))
+		return -EFAULT;
+	
+	if (suspend_start_anything(proc_data == &proc_params[0]))
+		return -EBUSY;
+
+	my_buf[count] = 0;
+
+	if (proc_data->needs_storage_manager & 2)
+		suspend_prepare_usm();
+
+	switch (proc_data->type) {
+		case SUSPEND_PROC_DATA_CUSTOM:
+			if (proc_data->data.special.write_proc) {
+				write_proc_t *write_proc = proc_data->data.special.write_proc;
+				result = write_proc(file, buffer, count, data);
+			}
+			break;
+		case SUSPEND_PROC_DATA_BIT:
+			{
+			int value = simple_strtoul(my_buf, NULL, 0);
+			if (value)
+				set_bit(proc_data->data.bit.bit, 
+					(proc_data->data.bit.bit_vector));
+			else
+				clear_bit(proc_data->data.bit.bit,
+					(proc_data->data.bit.bit_vector));
+			}
+			break;
+		case SUSPEND_PROC_DATA_INTEGER:
+			{
+				int *variable = proc_data->data.integer.variable;
+				int minimum = proc_data->data.integer.minimum;
+				int maximum = proc_data->data.integer.maximum;
+				*variable = simple_strtol(my_buf, NULL, 0);
+
+				if (maximum && ((*variable) < minimum))
+					*variable = minimum;
+
+				if (maximum && ((*variable) > maximum))
+					*variable = maximum;
+				break;
+			}
+		case SUSPEND_PROC_DATA_LONG:
+			{
+				long *variable = proc_data->data.a_long.variable;
+				long minimum = proc_data->data.a_long.minimum;
+				long maximum = proc_data->data.a_long.maximum;
+				*variable = simple_strtol(my_buf, NULL, 0);
+
+				if (maximum && ((*variable) < minimum))
+					*variable = minimum;
+
+				if (maximum && ((*variable) > maximum))
+					*variable = maximum;
+				break;
+			}
+		case SUSPEND_PROC_DATA_UL:
+			{
+				unsigned long *variable = proc_data->data.ul.variable;
+				unsigned long minimum = proc_data->data.ul.minimum;
+				unsigned long maximum = proc_data->data.ul.maximum;
+				*variable = simple_strtoul(my_buf, NULL, 0);
+
+				if (maximum && ((*variable) < minimum))
+					*variable = minimum;
+
+				if (maximum && ((*variable) > maximum))
+					*variable = maximum;
+				break;
+			}
+			break;
+		case SUSPEND_PROC_DATA_STRING:
+			{
+				int copy_len = count;
+				char *variable =
+					proc_data->data.string.variable;
+
+				if (proc_data->data.string.max_length &&
+				    (copy_len > proc_data->data.string.max_length))
+					copy_len = proc_data->data.string.max_length;
+
+				if (!variable) {
+					proc_data->data.string.variable =
+						variable = (char *) get_zeroed_page(GFP_ATOMIC);
+					assigned_temp_buffer = 1;
+				}
+				strncpy(variable, my_buf, copy_len);
+				if ((copy_len) &&
+					 (my_buf[copy_len - 1] == '\n'))
+					variable[count - 1] = 0;
+				variable[count] = 0;
+			}
+			break;
+	}
+	free_page((unsigned long) my_buf);
+	/* Side effect routine? */
+	if (proc_data->write_proc)
+		proc_data->write_proc();
+
+	/* Free temporary buffers */
+	if (assigned_temp_buffer) {
+		free_page((unsigned long) proc_data->data.string.variable);
+		proc_data->data.string.variable = NULL;
+	}
+
+	if (proc_data->needs_storage_manager & 2)
+		suspend_cleanup_usm();
+
+	suspend_finish_anything(proc_data == &proc_params[0]);
+	
+	return result;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
