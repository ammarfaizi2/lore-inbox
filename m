Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266009AbUFDUrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266009AbUFDUrq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 16:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266005AbUFDUqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 16:46:40 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:677 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S265996AbUFDUpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 16:45:46 -0400
Message-ID: <40C0DF74.7090306@acm.org>
Date: Fri, 04 Jun 2004 15:45:40 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030428
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan De Luyck <lkml@kcore.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.6] badness when removing ipmi_si module
References: <200405201318.17054.lkml@kcore.org>
In-Reply-To: <200405201318.17054.lkml@kcore.org>
Content-Type: multipart/mixed;
 boundary="------------010809050603090704070906"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010809050603090704070906
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I believe the attached patch will fix this problem.  Sorry this took so 
long, but things have been very busy.

This patch tracks all proc entries for an IPMI interface and unregisters 
them all upon removal.

-Corey

Jan De Luyck wrote:

>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>Hello List,
>
>This popped up when calling rmmod ipmi_si:
>
>Badness in remove_proc_entry at fs/proc/generic.c:685
>Call Trace:
> [<c017e24a>] remove_proc_entry+0xfa/0x130
> [<c8971649>] ipmi_unregister_smi+0x79/0x150 [ipmi_msghandler]
> [<c8934a74>] cleanup_one_si+0xa4/0x100 [ipmi_si]
> [<c0132a66>] stop_machine_run+0x16/0x1a
> [<c8934aed>] cleanup_ipmi_si+0x1d/0x31 [ipmi_si]
> [<c012fbb2>] sys_delete_module+0x132/0x170
> [<c014410a>] unmap_vma_list+0x1a/0x30
> [<c01445a7>] do_munmap+0x137/0x180
> [<c0103edb>] syscall_call+0x7/0xb
>
>On a related note, does anyone know any implementations of ipmi-management 
>tools that work on an ipmi 1.0 machine? The ipmi-tools only work on 1.5...
>
>Thanks.
>
>Jan
>
>  
>


--------------010809050603090704070906
Content-Type: text/plain;
 name="linux-ipmi-remproc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-ipmi-remproc.diff"

--- linux-v31/drivers/char/ipmi/ipmi_msghandler.c	2004-03-04 12:56:01.000000000 -0600
+++ linux/drivers/char/ipmi/ipmi_msghandler.c	2004-06-04 15:37:59.000000000 -0500
@@ -123,6 +123,12 @@
 	unsigned char protocol;
 };
 
+struct ipmi_proc_entry
+{
+	char                   *name;
+	struct ipmi_proc_entry *next;
+};
+
 #define IPMI_IPMB_NUM_SEQ	64
 #define IPMI_MAX_CHANNELS       8
 struct ipmi_smi
@@ -149,6 +155,11 @@
 	struct ipmi_smi_handlers *handlers;
 	void                     *send_info;
 
+	/* A list of proc entries for this interface.  This does not
+	   need a lock, only one thread creates it and only one thread
+	   destroys it. */
+	struct ipmi_proc_entry *proc_entries;
+
 	/* A table of sequence numbers for this interface.  We use the
            sequence numbers for IPMB messages that go out of the
            interface to match them up with their responses.  A routine
@@ -1515,18 +1526,36 @@
 			    read_proc_t *read_proc, write_proc_t *write_proc,
 			    void *data, struct module *owner)
 {
-	struct proc_dir_entry *file;
-	int                   rv = 0;
+	struct proc_dir_entry  *file;
+	int                    rv = 0;
+	struct ipmi_proc_entry *entry;
+
+	/* Create a list element. */
+	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+	entry->name = kmalloc(strlen(name)+1, GFP_KERNEL);
+	if (!entry->name) {
+		kfree(entry);
+		return -ENOMEM;
+	}
+	strcpy(entry->name, name);
 
 	file = create_proc_entry(name, 0, smi->proc_dir);
-	if (!file)
+	if (!file) {
+		kfree(entry->name);
+		kfree(entry);
 		rv = -ENOMEM;
-	else {
+	} else {
 		file->nlink = 1;
 		file->data = data;
 		file->read_proc = read_proc;
 		file->write_proc = write_proc;
 		file->owner = owner;
+
+		/* Stick it on the list. */
+		entry->next = smi->proc_entries;
+		smi->proc_entries = entry;
 	}
 
 	return rv;
@@ -1562,6 +1591,21 @@
 	return rv;
 }
 
+static void remove_proc_entries(ipmi_smi_t smi)
+{
+	struct ipmi_proc_entry *entry;
+
+	while (smi->proc_entries) {
+		entry = smi->proc_entries;
+		smi->proc_entries = entry->next;
+
+		remove_proc_entry(entry->name, smi->proc_dir);
+		kfree(entry->name);
+		kfree(entry);
+	}
+	remove_proc_entry(smi->proc_dir_name, proc_ipmi_root);
+}
+
 static int
 send_channel_info_cmd(ipmi_smi_t intf, int chan)
 {
@@ -1749,8 +1793,7 @@
 
 	if (rv) {
 		if (new_intf->proc_dir)
-			remove_proc_entry(new_intf->proc_dir_name,
-					  proc_ipmi_root);
+			remove_proc_entries(new_intf);
 		kfree(new_intf);
 	}
 
@@ -1806,8 +1849,7 @@
 	{
 		for (i=0; i<MAX_IPMI_INTERFACES; i++) {
 			if (ipmi_interfaces[i] == intf) {
-				remove_proc_entry(intf->proc_dir_name,
-						  proc_ipmi_root);
+				remove_proc_entries(intf);
 				spin_lock_irqsave(&interfaces_lock, flags);
 				ipmi_interfaces[i] = NULL;
 				clean_up_interface_data(intf);

--------------010809050603090704070906--

