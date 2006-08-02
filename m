Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751239AbWHBGJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbWHBGJO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 02:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbWHBGJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 02:09:14 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:41564 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750836AbWHBGJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 02:09:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=FrKf+PEUg11NJSRAOxFktoDu/gLJYOyW211VCX3Y9QjdlfTsPEwGiJc5PyxkNzXmvU8+snGakHghjSqc8B3s4UVlhLKLXXWDgSu4aAFR6Kc0A6Lem+DylhSLnqW7bRLpj9uxROQK+mf65MznS4a5dJ9MjYvU1BpxGIg0UBF4lhQ=
Message-ID: <6de39a910608012309l519c4642va349734e275cc4fd@mail.gmail.com>
Date: Tue, 1 Aug 2006 23:09:11 -0700
From: "Handle X" <xhandle@gmail.com>
To: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
Subject: cleanup, fix for potential crash of hotkey.c
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
While going through the code, I found out some memory leaks and
potential crashes in drivers/acpi/hotkey.c Please find the patch to
fix them.

This patch does the following,
1. Fixes memory leaks in error paths of hotkey_write_config
2. Fixes freeing unallocated pointers in the error paths of hotkey_write_config
3. Uses a loop instead of linear searching for parsing the userspace
input in get_params
4. Uses array of char * instead of passing 4 pointer parameters
explicitly into the init_{poll_}hotkey_* static functions

Please let me know your comments.

Regards,
Om.


 drivers/acpi/hotkey.c |  293 +++++++++++++++++++++----------------------------
 1 files changed, 127 insertions(+), 166 deletions(-)

diff --git a/drivers/acpi/hotkey.c b/drivers/acpi/hotkey.c
index 32c9d88..036287a 100644
--- a/drivers/acpi/hotkey.c
+++ b/drivers/acpi/hotkey.c
@@ -91,6 +91,14 @@ enum {
 	HK_EVENT_ENTERRING_S5,
 };

+enum conf_entry_enum {
+	bus_handle = 0,
+	bus_method = 1,
+	action_handle = 2,
+	method = 3,
+	LAST_CONF_ENTRY
+};
+
 /*  procdir we use */
 static struct proc_dir_entry *hotkey_proc_dir;
 static struct proc_dir_entry *hotkey_config;
@@ -244,19 +252,15 @@ static int hotkey_info_open_fs(struct in

 static char *format_result(union acpi_object *object)
 {
-	char *buf = NULL;
-
-	buf = (char *)kmalloc(RESULT_STR_LEN, GFP_KERNEL);
-	if (buf)
-		memset(buf, 0, RESULT_STR_LEN);
-	else
-		goto do_fail;
+	char *buf;

+	buf = (char *)kzalloc(RESULT_STR_LEN, GFP_KERNEL);
+	if (!buf)
+		return NULL;
 	/* Now, just support integer type */
 	if (object->type == ACPI_TYPE_INTEGER)
 		sprintf(buf, "%d\n", (u32) object->integer.value);
-      do_fail:
-	return (buf);
+	return buf;
 }

 static int hotkey_polling_seq_show(struct seq_file *seq, void *offset)
@@ -486,98 +490,106 @@ static void free_hotkey_device(union acp

 static void free_hotkey_buffer(union acpi_hotkey *key)
 {
-	kfree(key->event_hotkey.action_method);
+	if (key && key->event_hotkey.action_method)
+		kfree(key->event_hotkey.action_method);
 }

 static void free_poll_hotkey_buffer(union acpi_hotkey *key)
 {
-	kfree(key->poll_hotkey.action_method);
-	kfree(key->poll_hotkey.poll_method);
-	kfree(key->poll_hotkey.poll_result);
+	if (!key)
+		return;
+	if (key->poll_hotkey.action_method)
+		kfree(key->poll_hotkey.action_method);
+	if (key->poll_hotkey.poll_method)
+		kfree(key->poll_hotkey.poll_method);
+	if (key->poll_hotkey.poll_result)
+		kfree(key->poll_hotkey.poll_result);
 }
 static int
-init_hotkey_device(union acpi_hotkey *key, char *bus_str, char *action_str,
-		   char *method, int std_num, int external_num)
+init_hotkey_device(union acpi_hotkey *key, char **config_entry,
+		   int std_num, int external_num)
 {
 	acpi_handle tmp_handle;
 	acpi_status status = AE_OK;

-
 	if (std_num < 0 || IS_POLL(std_num) || !key)
 		goto do_fail;

-	if (!bus_str || !action_str || !method)
+	if (!config_entry[bus_handle] || !config_entry[action_handle]
+			|| !config_entry[method])
 		goto do_fail;

 	key->link.hotkey_type = ACPI_HOTKEY_EVENT;
 	key->link.hotkey_standard_num = std_num;
 	key->event_hotkey.flag = 0;
-	key->event_hotkey.action_method = method;
+	key->event_hotkey.action_method = config_entry[method];

-	status =
-	    acpi_get_handle(NULL, bus_str, &(key->event_hotkey.bus_handle));
+	status = acpi_get_handle(NULL, config_entry[bus_handle],
+			   &(key->event_hotkey.bus_handle));
 	if (ACPI_FAILURE(status))
-		goto do_fail;
+		goto do_fail_zero;
 	key->event_hotkey.external_hotkey_num = external_num;
-	status =
-	    acpi_get_handle(NULL, action_str,
+	status = acpi_get_handle(NULL, config_entry[action_handle],
 			    &(key->event_hotkey.action_handle));
 	if (ACPI_FAILURE(status))
-		goto do_fail;
+		goto do_fail_zero;
 	status = acpi_get_handle(key->event_hotkey.action_handle,
-				 method, &tmp_handle);
+				 config_entry[method], &tmp_handle);
 	if (ACPI_FAILURE(status))
-		goto do_fail;
+		goto do_fail_zero;
 	return AE_OK;
-      do_fail:
+do_fail_zero:
+	key->event_hotkey.action_method = NULL;
+do_fail:
 	return -ENODEV;
 }

 static int
-init_poll_hotkey_device(union acpi_hotkey *key,
-			char *poll_str,
-			char *poll_method,
-			char *action_str, char *action_method, int std_num)
+init_poll_hotkey_device(union acpi_hotkey *key, char **config_entry,
+			int std_num)
 {
 	acpi_status status = AE_OK;
 	acpi_handle tmp_handle;

-
 	if (std_num < 0 || IS_EVENT(std_num) || !key)
 		goto do_fail;
-
-	if (!poll_str || !poll_method || !action_str || !action_method)
+	if (!config_entry[bus_handle] ||!config_entry[bus_method] ||
+		!config_entry[action_handle] || !config_entry[method])
 		goto do_fail;

 	key->link.hotkey_type = ACPI_HOTKEY_POLLING;
 	key->link.hotkey_standard_num = std_num;
 	key->poll_hotkey.flag = 0;
-	key->poll_hotkey.poll_method = poll_method;
-	key->poll_hotkey.action_method = action_method;
+	key->poll_hotkey.poll_method = config_entry[bus_method];
+	key->poll_hotkey.action_method = config_entry[method];

-	status =
-	    acpi_get_handle(NULL, poll_str, &(key->poll_hotkey.poll_handle));
+	status = acpi_get_handle(NULL, config_entry[bus_handle],
+		      &(key->poll_hotkey.poll_handle));
 	if (ACPI_FAILURE(status))
-		goto do_fail;
+		goto do_fail_zero;
 	status = acpi_get_handle(key->poll_hotkey.poll_handle,
-				 poll_method, &tmp_handle);
+				 config_entry[bus_method], &tmp_handle);
 	if (ACPI_FAILURE(status))
-		goto do_fail;
+		goto do_fail_zero;
 	status =
-	    acpi_get_handle(NULL, action_str,
+	    acpi_get_handle(NULL, config_entry[action_handle],
 			    &(key->poll_hotkey.action_handle));
 	if (ACPI_FAILURE(status))
-		goto do_fail;
+		goto do_fail_zero;
 	status = acpi_get_handle(key->poll_hotkey.action_handle,
-				 action_method, &tmp_handle);
+				 config_entry[method], &tmp_handle);
 	if (ACPI_FAILURE(status))
-		goto do_fail;
+		goto do_fail_zero;
 	key->poll_hotkey.poll_result =
 	    (union acpi_object *)kmalloc(sizeof(union acpi_object), GFP_KERNEL);
 	if (!key->poll_hotkey.poll_result)
-		goto do_fail;
+		goto do_fail_zero;
 	return AE_OK;
-      do_fail:
+
+do_fail_zero:
+	key->poll_hotkey.poll_method = NULL;
+	key->poll_hotkey.action_method = NULL;
+do_fail:
 	return -ENODEV;
 }

@@ -652,17 +664,18 @@ static int hotkey_poll_config_seq_show(s
 }

 static int
-get_parms(char *config_record,
-	  int *cmd,
-	  char **bus_handle,
-	  char **bus_method,
-	  char **action_handle,
-	  char **method, int *internal_event_num, int *external_event_num)
+get_parms(char *config_record, int *cmd, char **config_entry,
+	       int *internal_event_num, int *external_event_num)
 {
+/* the format of *config_record =
+ * "1:\d+:*" : "cmd:internal_event_num"
+ * "\d+:\w+:\w+:\w+:\w+:\d+:\d+" :
+ * "cmd:bus_handle:bus_method:action_handle:method:internal_event_num:external_event_num"
+ */
 	char *tmp, *tmp1, count;
+	int i;

 	sscanf(config_record, "%d", cmd);
-
 	if (*cmd == 1) {
 		if (sscanf(config_record, "%d:%d", cmd, internal_event_num) !=
 		    2)
@@ -674,59 +687,28 @@ get_parms(char *config_record,
 	if (!tmp)
 		goto do_fail;
 	tmp++;
-	tmp1 = strchr(tmp, ':');
-	if (!tmp1)
-		goto do_fail;
-
-	count = tmp1 - tmp;
-	*bus_handle = (char *)kmalloc(count + 1, GFP_KERNEL);
-	if (!*bus_handle)
-		goto do_fail;
-	strncpy(*bus_handle, tmp, count);
-	*(*bus_handle + count) = 0;
-
-	tmp = tmp1;
-	tmp++;
-	tmp1 = strchr(tmp, ':');
-	if (!tmp1)
-		goto do_fail;
-	count = tmp1 - tmp;
-	*bus_method = (char *)kmalloc(count + 1, GFP_KERNEL);
-	if (!*bus_method)
-		goto do_fail;
-	strncpy(*bus_method, tmp, count);
-	*(*bus_method + count) = 0;
-
-	tmp = tmp1;
-	tmp++;
-	tmp1 = strchr(tmp, ':');
-	if (!tmp1)
-		goto do_fail;
-	count = tmp1 - tmp;
-	*action_handle = (char *)kmalloc(count + 1, GFP_KERNEL);
-	if (!*action_handle)
-		goto do_fail;
-	strncpy(*action_handle, tmp, count);
-	*(*action_handle + count) = 0;
-
-	tmp = tmp1;
-	tmp++;
-	tmp1 = strchr(tmp, ':');
-	if (!tmp1)
-		goto do_fail;
-	count = tmp1 - tmp;
-	*method = (char *)kmalloc(count + 1, GFP_KERNEL);
-	if (!*method)
-		goto do_fail;
-	strncpy(*method, tmp, count);
-	*(*method + count) = 0;
-
-	if (sscanf(tmp1 + 1, "%d:%d", internal_event_num, external_event_num) <=
-	    0)
-		goto do_fail;
-
-	return 6;
-      do_fail:
+	for (i = 0; i < LAST_CONF_ENTRY; i++) {
+		tmp1 = strchr(tmp, ':');
+		if (!tmp1) {
+			goto do_fail;
+		}
+		count = tmp1 - tmp;
+		config_entry[i]= (char *)kzalloc(count + 1, GFP_KERNEL);
+		if (!config_entry[i])
+			goto handle_failure;
+		strncpy(config_entry[i], tmp, count);
+		tmp = tmp1 + 1;
+	}
+	if (sscanf(tmp, "%d:%d", internal_event_num, external_event_num) <= 0)
+		goto handle_failure;
+	if (!IS_OTHERS(*internal_event_num)) {
+		return 6;
+	}
+handle_failure:
+	while (i-- > 0) {
+		kfree (config_entry[i]);
+	}
+do_fail:
 	return -1;
 }

@@ -736,50 +718,33 @@ static ssize_t hotkey_write_config(struc
 				   size_t count, loff_t * data)
 {
 	char *config_record = NULL;
-	char *bus_handle = NULL;
-	char *bus_method = NULL;
-	char *action_handle = NULL;
-	char *method = NULL;
+	char *config_entry[LAST_CONF_ENTRY];
 	int cmd, internal_event_num, external_event_num;
 	int ret = 0;
-	union acpi_hotkey *key = NULL;
-
+	union acpi_hotkey *key = kzalloc(sizeof(union acpi_hotkey), GFP_KERNEL);

-	config_record = (char *)kmalloc(count + 1, GFP_KERNEL);
+	if (!key) {
+		return -ENOMEM;
+	}
+	config_record = (char *)kzalloc(count + 1, GFP_KERNEL);
 	if (!config_record)
+		kfree (key);
 		return -ENOMEM;

 	if (copy_from_user(config_record, buffer, count)) {
 		kfree(config_record);
+		kfree (key);
 		printk(KERN_ERR PREFIX "Invalid data\n");
 		return -EINVAL;
 	}
-	config_record[count] = 0;
-
-	ret = get_parms(config_record,
-			&cmd,
-			&bus_handle,
-			&bus_method,
-			&action_handle,
-			&method, &internal_event_num, &external_event_num);
-
+	ret = get_parms(config_record, &cmd, config_entry,
+		       &internal_event_num, &external_event_num);
 	kfree(config_record);
-	if (IS_OTHERS(internal_event_num))
-		goto do_fail;
 	if (ret != 6) {
-	      do_fail:
-		kfree(bus_handle);
-		kfree(bus_method);
-		kfree(action_handle);
-		kfree(method);
 		printk(KERN_ERR PREFIX "Invalid data format ret=%d\n", ret);
 		return -EINVAL;
 	}

-	key = kmalloc(sizeof(union acpi_hotkey), GFP_KERNEL);
-	if (!key)
-		goto do_fail;
-	memset(key, 0, sizeof(union acpi_hotkey));
 	if (cmd == 1) {
 		union acpi_hotkey *tmp = NULL;
 		tmp = get_hotkey_by_event(&global_hotkey_list,
@@ -791,34 +756,19 @@ static ssize_t hotkey_write_config(struc
 		goto cont_cmd;
 	}
 	if (IS_EVENT(internal_event_num)) {
-		kfree(bus_method);
-		ret = init_hotkey_device(key, bus_handle, action_handle, method,
-					 internal_event_num,
-					 external_event_num);
-	} else
-		ret = init_poll_hotkey_device(key, bus_handle, bus_method,
-					      action_handle, method,
-					      internal_event_num);
-	if (ret) {
-		kfree(bus_handle);
-		kfree(action_handle);
-		if (IS_EVENT(internal_event_num))
-			free_hotkey_buffer(key);
-		else
-			free_poll_hotkey_buffer(key);
-		kfree(key);
-		printk(KERN_ERR PREFIX "Invalid hotkey\n");
-		return -EINVAL;
+		if (init_hotkey_device(key, config_entry,
+			internal_event_num, external_event_num))
+			goto init_hotkey_fail;
+	} else {
+		if (init_poll_hotkey_device(key, config_entry,
+			       internal_event_num))
+			goto init_poll_hotkey_fail;
 	}
-
-      cont_cmd:
-	kfree(bus_handle);
-	kfree(action_handle);
-
+cont_cmd:
 	switch (cmd) {
 	case 0:
-		if (get_hotkey_by_event
-		    (&global_hotkey_list, key->link.hotkey_standard_num))
+		if (get_hotkey_by_event(&global_hotkey_list,
+				key->link.hotkey_standard_num))
 			goto fail_out;
 		else
 			hotkey_add(key);
@@ -827,6 +777,7 @@ static ssize_t hotkey_write_config(struc
 		hotkey_remove(key);
 		break;
 	case 2:
+		/* key is kfree()ed if matched*/
 		if (hotkey_update(key))
 			goto fail_out;
 		break;
@@ -835,11 +786,22 @@ static ssize_t hotkey_write_config(struc
 		break;
 	}
 	return count;
-      fail_out:
-	if (IS_EVENT(internal_event_num))
-		free_hotkey_buffer(key);
-	else
-		free_poll_hotkey_buffer(key);
+
+init_poll_hotkey_fail:		/* failed init_poll_hotkey_device */
+	kfree(config_entry[bus_method]);
+	config_entry[bus_method] = NULL;
+init_hotkey_fail:		/* failed init_hotkey_device */
+	kfree(config_entry[method]);
+fail_out:
+	kfree(config_entry[bus_handle]);
+	kfree(config_entry[action_handle]);
+	/* No double free since elements =NULL for error cases */
+	if (IS_EVENT(internal_event_num)) {
+		if (config_entry[bus_method])
+			kfree(config_entry[bus_method]);
+		free_hotkey_buffer(key);	/* frees [method] */
+	} else
+		free_poll_hotkey_buffer(key);  /* frees [bus_method]+[method] */
 	kfree(key);
 	printk(KERN_ERR PREFIX "invalid key\n");
 	return -EINVAL;
@@ -923,10 +885,9 @@ static ssize_t hotkey_execute_aml_method
 	union acpi_hotkey *key;


-	arg = (char *)kmalloc(count + 1, GFP_KERNEL);
+	arg = (char *)kzalloc(count + 1, GFP_KERNEL);
 	if (!arg)
 		return -ENOMEM;
-	arg[count] = 0;

 	if (copy_from_user(arg, buffer, count)) {
 		kfree(arg);
