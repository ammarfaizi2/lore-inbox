Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263199AbTCLOuI>; Wed, 12 Mar 2003 09:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263198AbTCLOuI>; Wed, 12 Mar 2003 09:50:08 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:38151 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263199AbTCLOuA>; Wed, 12 Mar 2003 09:50:00 -0500
Date: Wed, 12 Mar 2003 15:00:23 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.64: i2c-proc kills machine at boot
Message-ID: <20030312150023.A12157@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>
References: <20030311104721.GA401@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030311104721.GA401@elf.ucw.cz>; from pavel@ucw.cz on Tue, Mar 11, 2003 at 11:47:22AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 11, 2003 at 11:47:22AM +0100, Pavel Machek wrote:
> Hi!
> 
> If I turn #ifdef DEBUG in i2c_register_entry() into #if 1, it prints 
> 
> i2c-proc.o: NULL pointer when trying to install fill_inode fix!\n
> 
> but boots.

The following patch should fix it (and make the code actually readable..):


--- 1.16/drivers/i2c/i2c-proc.c	Thu Feb 20 15:02:00 2003
+++ edited/drivers/i2c/i2c-proc.c	Wed Mar 12 15:25:38 2003
@@ -35,8 +35,6 @@
 #include <linux/i2c-proc.h>
 #include <asm/uaccess.h>
 
-static int i2c_create_name(char **name, const char *prefix,
-			       struct i2c_adapter *adapter, int addr);
 static int i2c_parse_reals(int *nrels, void *buffer, int bufsize,
 			       long *results, int magnitude);
 static int i2c_write_reals(int nrels, void *buffer, size_t *bufsize,
@@ -54,15 +52,6 @@
 
 static struct i2c_client *i2c_clients[SENSORS_ENTRY_MAX];
 
-static ctl_table sysctl_table[] = {
-	{CTL_DEV, "dev", NULL, 0, 0555},
-	{0},
-	{DEV_SENSORS, "sensors", NULL, 0, 0555},
-	{0},
-	{0, NULL, NULL, 0, 0555},
-	{0}
-};
-
 static ctl_table i2c_proc_dev_sensors[] = {
 	{SENSORS_CHIPS, "chips", NULL, 0, 0644, NULL, &i2c_proc_chips,
 	 &i2c_sysctl_chips},
@@ -87,36 +76,40 @@
    (for a LM78 chip on the ISA bus at port 0x310), or lm75-i2c-3-4e (for
    a LM75 chip on the third i2c bus at address 0x4e).  
    name is allocated first. */
-static int i2c_create_name(char **name, const char *prefix,
-			struct i2c_adapter *adapter, int addr)
+static char *generate_name(struct i2c_client *client, const char *prefix)
 {
-	char name_buffer[50];
-	int id, i, end;
-	if (i2c_is_isa_adapter(adapter))
+	struct i2c_adapter *adapter = client->adapter;
+	int addr = client->addr;
+	char name_buffer[50], *name;
+
+	if (i2c_is_isa_adapter(adapter)) {
 		sprintf(name_buffer, "%s-isa-%04x", prefix, addr);
-	else if (!adapter->algo->smbus_xfer && !adapter->algo->master_xfer) {
-		/* dummy adapter, generate prefix */
+	} else if (adapter->algo->smbus_xfer || adapter->algo->master_xfer) {
+		int id = i2c_adapter_id(adapter);
+		if (id < 0)
+			return ERR_PTR(-ENOENT);
+		sprintf(name_buffer, "%s-i2c-%d-%02x", prefix, id, addr);
+	} else {	/* dummy adapter, generate prefix */
+		int end, i;
+
 		sprintf(name_buffer, "%s-", prefix);
 		end = strlen(name_buffer);
-		for(i = 0; i < 32; i++) {
-			if(adapter->algo->name[i] == ' ')
+
+		for (i = 0; i < 32; i++) {
+			if (adapter->algo->name[i] == ' ')
 				break;
 			name_buffer[end++] = tolower(adapter->algo->name[i]);
 		}
+
 		name_buffer[end] = 0;
 		sprintf(name_buffer + end, "-%04x", addr);
-	} else {
-		if ((id = i2c_adapter_id(adapter)) < 0)
-			return -ENOENT;
-		sprintf(name_buffer, "%s-i2c-%d-%02x", prefix, id, addr);
-	}
-	*name = kmalloc(strlen(name_buffer) + 1, GFP_KERNEL);
-	if (!*name) {
-		printk (KERN_WARNING "i2c_create_name: not enough memory\n");
-		return -ENOMEM;
 	}
-	strcpy(*name, name_buffer);
-	return 0;
+
+	name = kmalloc(strlen(name_buffer) + 1, GFP_KERNEL);
+	if (unlikely(!name))
+		return ERR_PTR(-ENOMEM);
+	strcpy(name, name_buffer);
+	return name;
 }
 
 /* This rather complex function must be called when you want to add an entry
@@ -127,93 +120,80 @@
    If any driver wants subdirectories within the newly created directory,
    this function must be updated!  */
 int i2c_register_entry(struct i2c_client *client, const char *prefix,
-			   ctl_table * ctl_template)
+		       struct ctl_table *leaf)
 {
-	int i, res, len, id;
-	ctl_table *new_table, *client_tbl, *tbl;
-	char *name;
-	struct ctl_table_header *new_header;
-
-	if ((res = i2c_create_name(&name, prefix, client->adapter,
-				       client->addr))) return res;
-
-	for (id = 0; id < SENSORS_ENTRY_MAX; id++)
-		if (!i2c_entries[id]) {
-			break;
-		}
-	if (id == SENSORS_ENTRY_MAX) {
-		kfree(name);
-		return -ENOMEM;
-	}
-
-	id += 256;
-	
-	len = 0;
-	while (ctl_template[len].procname)
-		len++;
-	if (!(new_table = kmalloc(sizeof(sysctl_table) + sizeof(ctl_table) * (len + 1), 
-				  GFP_KERNEL))) {
-		kfree(name);
-		return -ENOMEM;
-	}
-
-	memcpy(new_table, sysctl_table, sizeof(sysctl_table));
-	tbl = new_table; /* sys/ */
-	tbl = tbl->child = tbl + 2; /* dev/ */
-	tbl = tbl->child = tbl + 2; /* sensors/ */	
-       	client_tbl = tbl->child = tbl + 2; /* XX-chip-YY-ZZ/ */
-
-	client_tbl->procname = name;
-	client_tbl->ctl_name = id;
-	client_tbl->child = client_tbl + 2;
-
-	/* Next the client sysctls. --km */
-	tbl = client_tbl->child;
-	memcpy(tbl, ctl_template, sizeof(ctl_table) * (len+1));
-	for (i = 0; i < len; i++)
-		tbl[i].extra2 = client;
-
-	if (!(new_header = register_sysctl_table(new_table, 0))) {
-		printk(KERN_ERR "i2c-proc.o: error: sysctl interface not supported by kernel!\n");
-		kfree(new_table);
-		kfree(name);
-		return -EPERM;
-	}
-
- 	i2c_entries[id - 256] = new_header;
-
-	i2c_clients[id - 256] = client;
-
-#ifdef DEBUG
-	if (!new_header || !new_header->ctl_table ||
-	    !new_header->ctl_table->child ||
-	    !new_header->ctl_table->child->child ||
-	    !new_header->ctl_table->child->child->de ) {
-		printk
-		    (KERN_ERR "i2c-proc.o: NULL pointer when trying to install fill_inode fix!\n");
-		return id;
-	}
-#endif				/* DEBUG */
-	client_tbl->de->owner = client->driver->owner;
-	return id;
+	struct { struct ctl_table root[2], dev[2], sensors[2]; } *tbl;
+	struct ctl_table_header *hdr;
+	struct ctl_table *tmp;
+	const char *name;
+	int id;
+
+	name = generate_name(client, prefix);
+	if (IS_ERR(name))
+		return PTR_ERR(name);
+
+	for (id = 0; id < SENSORS_ENTRY_MAX; id++) {
+		if (!i2c_entries[id])
+			goto free_slot;
+	}
+
+	goto out_free_name;
+
+ free_slot:
+	tbl = kmalloc(sizeof(*tbl), GFP_KERNEL);
+	if (unlikely(!tbl))
+		goto out_free_name;
+	memset(tbl, 0, sizeof(*tbl));
+
+	for (tmp = leaf; tmp->ctl_name; tmp++)
+		tmp->extra2 = client;
+
+	tbl->sensors->ctl_name = id+256;
+	tbl->sensors->procname = name;
+	tbl->sensors->mode = 0555;
+	tbl->sensors->child = leaf;
+
+	tbl->dev->ctl_name = DEV_SENSORS;
+	tbl->dev->procname = "sensors";
+	tbl->dev->mode = 0555;
+	tbl->dev->child = tbl->sensors;
+
+	tbl->root->ctl_name = CTL_DEV;
+	tbl->root->procname = "dev";
+	tbl->root->mode = 0555;
+	tbl->root->child = tbl->dev;
+
+	hdr = register_sysctl_table(tbl->root, 0);
+	if (unlikely(!hdr))
+		goto out_free_tbl;
+
+	i2c_entries[id] = hdr;
+	i2c_clients[id] = client;
+
+	return (id + 256);	/* XXX(hch) why?? */
+
+ out_free_tbl:
+	kfree(tbl);
+ out_free_name:
+	kfree(name);
+	return -ENOMEM;
 }
 
 void i2c_deregister_entry(int id)
 {
-	ctl_table *table;
-	char *temp;
+	id -= 256;
 
-	id -= 256;	
 	if (i2c_entries[id]) {
-		table = i2c_entries[id]->ctl_table;
-		unregister_sysctl_table(i2c_entries[id]);
-		/* 2-step kfree needed to keep gcc happy about const points */
-		(const char *) temp = table[4].procname;
-		kfree(temp);
-		kfree(table);
-		i2c_entries[id] = NULL;
-		i2c_clients[id] = NULL;
+		struct ctl_table_header *hdr = i2c_entries[id];
+		struct ctl_table *tbl = hdr->ctl_table;
+
+		unregister_sysctl_table(hdr);
+		kfree(tbl->child->child->procname);
+		kfree(tbl); /* actually the whole anonymous struct */
 	}
+
+	i2c_entries[id] = NULL;
+	i2c_clients[id] = NULL;
 }
 
 static int i2c_proc_chips(ctl_table * ctl, int write, struct file *filp,
