Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284427AbRLDBpx>; Mon, 3 Dec 2001 20:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281852AbRLDANo>; Mon, 3 Dec 2001 19:13:44 -0500
Received: from 42-VALL-X13.libre.retevision.es ([62.83.208.42]:38661 "EHLO
	ragnar-hojland.com") by vger.kernel.org with ESMTP
	id <S284860AbRLCRrJ>; Mon, 3 Dec 2001 12:47:09 -0500
Date: Mon, 3 Dec 2001 19:37:51 +0100
From: Ragnar Hojland Espinosa <ragnar@ragnar-hojland.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.16: kmalloc tidying
Message-ID: <20011203193751.A10125@ragnar-hojland.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
Organization: Mediocrity Naysayers Ltd
X-Homepage: http://lightside.eresmas.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just please have a look on the binfmt_elf one, which im not absolutely sure
on whether there's nothing else to clean up.

-- 
____/|  Ragnar Højland      Freedom - Linux - OpenGL |    Brainbench MVP
\ o.O|  PGP94C4B2F0D27DE025BE2302C104B78C56 B72F0822 | for Unix Programming
 =(_)=  "Thou shalt not follow the NULL pointer for  | (www.brainbench.com)
   U     chaos and madness await thee at its end."

diff -rup -x '*~' linux-2.4.16-O/drivers/i2c/i2c-proc.c linux-2.4.16/drivers/i2c/i2c-proc.c
--- linux-2.4.16-O/drivers/i2c/i2c-proc.c	Tue Nov 13 05:31:33 2001
+++ linux-2.4.16/drivers/i2c/i2c-proc.c	Mon Dec  3 16:33:55 2001
@@ -119,6 +119,10 @@ int i2c_create_name(char **name, const c
 		sprintf(name_buffer, "%s-i2c-%d-%02x", prefix, id, addr);
 	}
 	*name = kmalloc(strlen(name_buffer) + 1, GFP_KERNEL);
+	if (!*name) {
+		printk (KERN_WARNING "i2c_create_name: not enough memory\n");
+		return -ENOMEM;
+	}
 	strcpy(*name, name_buffer);
 	return 0;
 }
diff -rup -x '*~' linux-2.4.16-O/drivers/net/wireless/airo_cs.c linux-2.4.16/drivers/net/wireless/airo_cs.c
--- linux-2.4.16-O/drivers/net/wireless/airo_cs.c	Tue Nov 13 05:28:44 2001
+++ linux-2.4.16/drivers/net/wireless/airo_cs.c	Mon Dec  3 17:12:32 2001
@@ -244,6 +244,11 @@ static dev_link_t *airo_attach(void)
 	
 	/* Allocate space for private device-specific data */
 	local = kmalloc(sizeof(local_info_t), GFP_KERNEL);
+	if (!local) {
+		printk(KERN_ERR "airo_cs: no memory for new device\n");
+		kfree (link);
+		return NULL;
+	}
 	memset(local, 0, sizeof(local_info_t));
 	link->priv = local;
 	
diff -rup -x '*~' linux-2.4.16-O/drivers/parport/parport_cs.c linux-2.4.16/drivers/parport/parport_cs.c
--- linux-2.4.16-O/drivers/parport/parport_cs.c	Tue Nov 13 05:30:14 2001
+++ linux-2.4.16/drivers/parport/parport_cs.c	Mon Dec  3 16:01:09 2001
@@ -311,6 +311,10 @@ void parport_config(dev_link_t *link)
 #if (LINUX_VERSION_CODE >= VERSION(2,2,8))
     p->private_data = kmalloc(sizeof(struct parport_pc_private),
 			      GFP_KERNEL);
+    if (p->private_data == NULL) {
+        printk(KERN_WARNING "parport_cs: not enough memory\n");
+	goto failed;
+    }
     ((struct parport_pc_private *)(p->private_data))->ctr = 0x0c;
 #endif
     parport_proc_register(p);
diff -rup -x '*~' linux-2.4.16-O/drivers/sbus/char/envctrl.c linux-2.4.16/drivers/sbus/char/envctrl.c
--- linux-2.4.16-O/drivers/sbus/char/envctrl.c	Mon Dec  3 17:17:13 2001
+++ linux-2.4.16/drivers/sbus/char/envctrl.c	Tue Nov 13 05:31:02 2001
@@ -897,10 +897,6 @@ static void envctrl_init_i2c_child(struc
 		}
 
                 pchild->tables = kmalloc(tbls_size, GFP_KERNEL);
-		if (!pchild->tables) {
-			printk("envctrl: Failed to get table, not enough memory.\n");
-			return;
-		}
                 len = prom_getproperty(node, "tables",
 				       (char *) pchild->tables, tbls_size);
                 if (len <= 0) {
diff -rup -x '*~' linux-2.4.16-O/drivers/sbus/dvma.c linux-2.4.16/drivers/sbus/dvma.c
--- linux-2.4.16-O/drivers/sbus/dvma.c	Thu Feb 22 13:40:13 2001
+++ linux-2.4.16/drivers/sbus/dvma.c	Mon Dec  3 16:26:05 2001
@@ -90,7 +90,10 @@ void __init dvma_init(struct sbus_bus *s
 
 		/* Found one... */
 		dma = kmalloc(sizeof(struct sbus_dma), GFP_ATOMIC);
-
+		if (!dma) {
+			printk (KERN_WARNING "dvma_init: not enough memory\n");
+			return;
+		}
 		dma->sdev = this_dev;
 
 		/* Put at end of dma chain */
@@ -126,7 +129,12 @@ void __init sun4_dvma_init(void)
 
 	if(sun4_dma_physaddr) {
 		dma = kmalloc(sizeof(struct sbus_dma), GFP_ATOMIC);
-
+		if (!dma) {
+			printk (KERN_WARNING "sun4_dvma_init: not enough memory\n");
+			dma_chain = NULL;
+			return;
+		}
+		
 		/* No SBUS */
 		dma->sdev = NULL;
 
diff -rup -x '*~' linux-2.4.16-O/drivers/sound/btaudio.c linux-2.4.16/drivers/sound/btaudio.c
--- linux-2.4.16-O/drivers/sound/btaudio.c	Tue Nov 13 05:31:48 2001
+++ linux-2.4.16/drivers/sound/btaudio.c	Mon Dec  3 16:09:27 2001
@@ -885,6 +885,12 @@ static int __devinit btaudio_probe(struc
 	}
 
 	bta = kmalloc(sizeof(*bta),GFP_ATOMIC);
+	if (!bta) {
+		printk(KERN_WARNING 
+		       "btaudio: not enough memory\n");
+		rc = -ENOMEM;
+		goto fail1;
+	}
 	memset(bta,0,sizeof(*bta));
 
 	bta->pci  = pci_dev;
diff -rup -x '*~' linux-2.4.16-O/fs/binfmt_elf.c linux-2.4.16/fs/binfmt_elf.c
--- linux-2.4.16-O/fs/binfmt_elf.c	Tue Nov 13 05:31:51 2001
+++ linux-2.4.16/fs/binfmt_elf.c	Mon Dec  3 17:05:53 2001
@@ -609,7 +609,9 @@ static int load_elf_binary(struct linux_
 	/* Do this so that we can load the interpreter, if need be.  We will
 	   change some of these later */
 	current->mm->rss = 0;
-	setup_arg_pages(bprm); /* XXX: check error */
+	retval = setup_arg_pages(bprm);
+	if (retval) 
+		goto out_free_dentry;
 	current->mm->start_stack = bprm->p;
 
 	/* Now we do a little grungy work by mmaping the ELF image into
diff -rup -x '*~' linux-2.4.16-O/fs/qnx4/inode.c linux-2.4.16/fs/qnx4/inode.c
--- linux-2.4.16-O/fs/qnx4/inode.c	Tue Nov 13 05:30:44 2001
+++ linux-2.4.16/fs/qnx4/inode.c	Mon Dec  3 14:37:14 2001
@@ -318,6 +318,10 @@ static const char *qnx4_checkroot(struct
 					if (!strncmp(rootdir->di_fname, QNX4_BMNAME, sizeof QNX4_BMNAME)) {
 						found = 1;
 						sb->u.qnx4_sb.BitMap = kmalloc( sizeof( struct qnx4_inode_entry ), GFP_KERNEL );
+						if (!sb->u.qnx4_sb.BitMap) {
+							brelse (bh);
+							return "not enough memory for bitmap inode";
+						}
 						memcpy( sb->u.qnx4_sb.BitMap, rootdir, sizeof( struct qnx4_inode_entry ) );	/* keep bitmap inode known */
 						break;
 					}
