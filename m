Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267091AbTBDBdY>; Mon, 3 Feb 2003 20:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267099AbTBDBdY>; Mon, 3 Feb 2003 20:33:24 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:38025 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S267091AbTBDBdQ>;
	Mon, 3 Feb 2003 20:33:16 -0500
Date: Mon, 3 Feb 2003 20:43:25 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Jaroslav Kysela <perex@perex.cz>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "greg@kroah.com" <greg@kroah.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PnP model
Message-ID: <20030203204325.GA7425@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Jaroslav Kysela <perex@perex.cz>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"greg@kroah.com" <greg@kroah.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <20030202203641.GA22089@neo.rr.com> <Pine.LNX.4.44.0302031437310.1116-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302031437310.1116-100000@pnote.perex-int.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2003 at 02:55:37PM +0100, Jaroslav Kysela wrote:
> Hi all,
>
> 	I think that we need to discuss deeply the right PnP model. The

I'm confident this is the right pnp model.

> actual changes proposed by Adam are going to be more and more complex
> without allowing the user interactions inside the "auto" steps. The
> auto-configuration might be good and bad as we all know, but having an
> method to skip it is necessary.

In many cases, Auto configuration can be better then manual configuration.
1.) The auto configuration engine in my patch is able to resolve almost any
resource conflict and provides the greatest chance for all devices to have
resources allocated.
2.) Certainly some driver developers would like to manually set resources
but many may prefer the option to auto config.
3.) Drivers under the existing system are not aware of many forms of
resource conflicts and could set resources incorrectly.
4.) Some users do not want to worry about manual configuration and would
welcome an auto configuration system that makes intelligent choices
without user input.  This autoconfiguration system monitors many variables
that a user would have a hard time keeping track of and never overlooks any
potential conflicts in its analysis.

The above stated reasons are why I introduced these auto configuration
(Resource Management) improvements.

I feel that one solution is to support both manual and auto configuration so
the user can use what he or she prefers, however, I am confident that in most
cases the auto configuration will be the best option.

Perhaps I didn't make this clear earlier, it was not my intent to remove
support for manual resource configurations.  This was only temporary and
intended for the first release.  Here is a patch against my other 4
patches that updates the pnp code to support manual resource
configurations.  It also merges the pnpbios GPF fix and addresses a few
other issues.

-Adam

P.S.: The new manual config API is pnp_manual_config_dev.

P.S.: I'm currently working on an improved user interface that will allow
the user to manually set resources through the sysfs interface.  It will
include reports on where the conflicts are in order to assist the user in
making decisions.

P.S.: I intend to resolve all of these issues but my top priority is to
convert pnp drivers.  For example, I recently submitted pnp driver
conversions and am currently working on pnp card service revisions.



This patch needs to be tested.  I appreciate any and all feedback.

diff -urN a/drivers/pnp/base.h b/drivers/pnp/base.h
--- a/drivers/pnp/base.h	Sun Feb  2 11:40:10 2003
+++ b/drivers/pnp/base.h	Mon Feb  3 18:11:16 2003
@@ -4,7 +4,6 @@
 extern int pnp_interface_attach_device(struct pnp_dev *dev);
 extern void pnp_name_device(struct pnp_dev *dev);
 extern void pnp_fixup_device(struct pnp_dev *dev);
-extern int pnp_configure_device(struct pnp_dev *dev);
 extern void pnp_free_resources(struct pnp_resources *resources);
 extern int __pnp_add_device(struct pnp_dev *dev);
 extern void __pnp_remove_device(struct pnp_dev *dev);
diff -urN a/drivers/pnp/core.c b/drivers/pnp/core.c
--- a/drivers/pnp/core.c	Sun Feb  2 11:40:10 2003
+++ b/drivers/pnp/core.c	Mon Feb  3 18:06:33 2003
@@ -122,7 +122,7 @@
 	list_add_tail(&dev->global_list, &pnp_global);
 	list_add_tail(&dev->protocol_list, &dev->protocol->devices);
 	spin_unlock(&pnp_lock);
-	pnp_configure_device(dev);
+	pnp_auto_config_dev(dev);
 	ret = device_register(&dev->dev);
 	if (ret == 0)
 		pnp_interface_attach_device(dev);
diff -urN a/drivers/pnp/interface.c b/drivers/pnp/interface.c
--- a/drivers/pnp/interface.c	Sun Feb  2 12:26:25 2003
+++ b/drivers/pnp/interface.c	Mon Feb  3 17:37:32 2003
@@ -232,10 +232,11 @@
 	char *str = buf;
 	int i;

-	if (!dev->active){
-		str += sprintf(str,"DISABLED\n");
-		goto done;
-	}
+	str += sprintf(str,"state = ");
+	if (dev->active)
+		str += sprintf(str,"active\n");
+	else
+		str += sprintf(str,"disabled\n");
 	for (i = 0; i < PNP_MAX_PORT; i++) {
 		if (pnp_port_valid(dev, i)) {
 			str += sprintf(str,"io");
@@ -280,22 +281,6 @@
 	num_args = sscanf(buf,"%10s %i",command,&depnum);
 	if (!num_args)
 		goto done;
-	if (!strnicmp(command,"lock",4)) {
-		if (dev->active) {
-			dev->lock_resources = 1;
-		} else {
-			error = -EINVAL;
-		}
-		goto done;
-	}
-	if (!strnicmp(command,"unlock",6)) {
-		if (dev->lock_resources) {
-			dev->lock_resources = 0;
-		} else {
-			error = -EINVAL;
-		}
-		goto done;
-	}
 	if (!strnicmp(command,"disable",7)) {
 		error = pnp_disable_dev(dev);
 		goto done;
diff -urN a/drivers/pnp/pnpbios/core.c b/drivers/pnp/pnpbios/core.c
--- a/drivers/pnp/pnpbios/core.c	Sun Feb  2 19:25:15 2003
+++ b/drivers/pnp/pnpbios/core.c	Mon Feb  3 15:43:06 2003
@@ -142,11 +142,13 @@
 set_limit(cpu_gdt_table[cpu][(selname) >> 3], size); \
 } while(0)
 
+static struct desc_struct bad_bios_desc = { 0, 0x00409200 };
+
 /*
  * At some point we want to use this stack frame pointer to unwind
- * after PnP BIOS oopses. 
+ * after PnP BIOS oopses.
  */
- 
+
 u32 pnp_bios_fault_esp;
 u32 pnp_bios_fault_eip;
 u32 pnp_bios_is_utter_crap = 0;
@@ -160,6 +162,8 @@
 {
 	unsigned long flags;
 	u16 status;
+	struct desc_struct save_desc_40;
+	int cpu;
 
 	/*
 	 * PnP BIOSes are generally not terribly re-entrant.
@@ -168,6 +172,10 @@
 	if(pnp_bios_is_utter_crap)
 		return PNP_FUNCTION_NOT_SUPPORTED;
 
+	cpu = get_cpu();
+	save_desc_40 = cpu_gdt_table[cpu][0x40 / 8];
+	cpu_gdt_table[cpu][0x40 / 8] = bad_bios_desc;
+
 	/* On some boxes IRQ's during PnP BIOS calls are deadly.  */
 	spin_lock_irqsave(&pnp_bios_lock, flags);
 
@@ -207,6 +215,9 @@
 		: "memory"
 	);
 	spin_unlock_irqrestore(&pnp_bios_lock, flags);
+
+	cpu_gdt_table[cpu][0x40 / 8] = save_desc_40;
+	put_cpu();
 	
 	/* If we get here and this is set then the PnP BIOS faulted on us. */
 	if(pnp_bios_is_utter_crap)
@@ -236,7 +247,8 @@
 	void *p = kmalloc( size, f );
 	if ( p == NULL )
 		printk(KERN_ERR "PnPBIOS: kmalloc() failed\n");
-	memset(p, 0, size);
+	else
+		memset(p, 0, size);
 	return p;
 }
 
@@ -886,14 +898,7 @@
 
 	for(nodenum=0; nodenum<0xff; ) {
 		u8 thisnodenum = nodenum;
-		/* We build the list from the "boot" config because
-		 * we know that the resources couldn't have changed
-		 * at this stage.  Furthermore some buggy PnP BIOSes
-		 * will crash if we request the "current" config
-		 * from devices that are can only be static such as
-		 * those controlled by the "system" driver.
-		 */
-		if (pnp_bios_get_dev_node(&nodenum, (char )1, node))
+		if (pnp_bios_get_dev_node(&nodenum, (char )0, node))
 			break;
 		nodes_got++;
 		dev =  pnpbios_kmalloc(sizeof (struct pnp_dev), GFP_KERNEL);
@@ -996,6 +1001,8 @@
 		pnp_bios_callpoint.segment = PNP_CS16;
 		pnp_bios_hdr = check;
 
+		set_base(bad_bios_desc, __va((unsigned long)0x40 << 4));
+		_set_limit((char *)&bad_bios_desc, 4095 - (0x40 << 4));
 		for(i=0; i < NR_CPUS; i++)
 		{
 			Q2_SET_SEL(i, PNP_CS32, &pnp_bios_callfunc, 64 * 1024);
diff -urN a/drivers/pnp/resource.c b/drivers/pnp/resource.c
--- a/drivers/pnp/resource.c	Sun Feb  2 18:43:34 2003
+++ b/drivers/pnp/resource.c	Mon Feb  3 19:29:12 2003
@@ -989,7 +989,8 @@
 {
 	struct pnp_change * change = pnp_add_change(parent,dev);
 	move--;
-	spin_lock(&pnp_lock);
+	if (!dev->rule)
+		goto fail;
 	if (!pnp_can_configure(dev))
 		goto fail;
 	if (!dev->rule->depnum) {
@@ -1001,7 +1002,6 @@
 			goto fail;
 		pnp_init_resource_table(&dev->res);
 	}
-	spin_unlock(&pnp_lock);
 	if (!parent) {
 		pnp_free_changes(change);
 		kfree(change);
@@ -1009,7 +1009,6 @@
 	return 1;
 
 fail:
-	spin_unlock(&pnp_lock);
 	if (!parent)
 		kfree(change);
 	return 0;
@@ -1027,19 +1026,25 @@
 			return -ENOMEM;
 	}
 	for (move = 1; move <= pnp_max_moves; move++) {
+		spin_lock(&pnp_lock);
 		dev->rule->depnum = 0;
 		pnp_init_resource_table(&dev->res);
-		if (pnp_next_config(dev,move,NULL))
+		if (pnp_next_config(dev,move,NULL)) {
+			spin_unlock(&pnp_lock);
 			return 1;
+		}
+		spin_unlock(&pnp_lock);
 	}
 
+	spin_lock(&pnp_lock);
 	pnp_init_resource_table(&dev->res);
 	dev->rule->depnum = 0;
-	pnp_err("res: Unable to resolve resource conflicts for the device '%s', this device will not be usable.", dev->dev.bus_id);
+	spin_unlock(&pnp_lock);
+	pnp_err("res: Unable to resolve resource conflicts for the device '%s', some devices may not be usable.", dev->dev.bus_id);
 	return 0;
 }
 
-static int pnp_process_active(struct pnp_dev *dev)
+static int pnp_resolve_conflicts(struct pnp_dev *dev)
 {
 	int i;
 	struct pnp_dev * cdev;
@@ -1079,24 +1084,6 @@
 	return 1;
 }
 
-/**
- * pnp_configure_device - determines the best possible resource configuration based on available information
- * @dev: pointer to the desired device
- */
-
-int pnp_configure_device(struct pnp_dev *dev)
-{
-	int error;
-	if(!dev)
-		return -EINVAL;
-	if(dev->active) {
-		error = pnp_process_active(dev);
-	} else {
-		error = pnp_generate_config(dev);
-	}
-	return error;
-}
-
 static int pnp_compare_resources(struct pnp_resource_table * resa, struct pnp_resource_table * resb)
 {
 	int idx;
@@ -1128,6 +1115,92 @@
  * PnP Device Resource Management
  */
 
+
+/**
+ * pnp_resource_change - change one resource
+ * @resource: pointer to resource to be changed
+ * @start: start of region
+ * @size: size of region
+ *
+ */
+
+void pnp_resource_change(struct resource *resource, unsigned long start, unsigned long size)
+{
+	if (resource == NULL)
+		return;
+	resource->flags &= ~IORESOURCE_AUTO;
+	resource->start = start;
+	resource->end = start + size - 1;
+}
+
+/**
+ * pnp_auto_config_dev - determines the best possible resource configuration based on available information
+ * @dev: pointer to the desired device
+ */
+
+int pnp_auto_config_dev(struct pnp_dev *dev)
+{
+	int error;
+	if(!dev)
+		return -EINVAL;
+
+	dev->config_mode = PNP_CONFIG_AUTO;
+
+	if(dev->active)
+		error = pnp_resolve_conflicts(dev);
+	else
+		error = pnp_generate_config(dev);
+	return error;
+}
+
+/**
+ * pnp_manual_config_dev - Disables Auto Config and Manually sets the resource table
+ * @dev: pointer to the desired device
+ * @res: pointer to the new resource config
+ */
+
+int pnp_manual_config_dev(struct pnp_dev *dev, struct pnp_resource_table * res, int mode)
+{
+	int i;
+	struct pnp_resource_table bak = dev->res;
+	if (!dev || !res)
+		return -EINVAL;
+	if (dev->active)
+		return -EBUSY;
+	spin_lock(&pnp_lock);
+	dev->res = *res;
+
+	if (!(mode & PNP_CONFIG_FORCE)) {
+		for (i = 0; i < PNP_MAX_PORT; i++) {
+			if(pnp_check_port(dev,i))
+				goto fail;
+		}
+		for (i = 0; i < PNP_MAX_MEM; i++) {
+			if(pnp_check_mem(dev,i))
+				goto fail;
+		}
+		for (i = 0; i < PNP_MAX_IRQ; i++) {
+			if(pnp_check_irq(dev,i))
+				goto fail;
+		}
+		for (i = 0; i < PNP_MAX_DMA; i++) {
+			if(pnp_check_dma(dev,i))
+				goto fail;
+		}
+	}
+	spin_unlock(&pnp_lock);
+
+	if (mode & PNP_CONFIG_RESOLVE)
+		pnp_resolve_conflicts(dev);
+
+	dev->config_mode = PNP_CONFIG_MANUAL;
+
+fail:
+	dev->res = bak;
+	spin_unlock(&pnp_lock);
+	return -EINVAL;
+}
+
 /**
  * pnp_activate_dev - activates a PnP device for use
  * @dev: pointer to the desired device
@@ -1141,11 +1214,27 @@
 		return -EINVAL;
 	if (dev->active) {
 		pnp_info("res: The PnP device '%s' is already active.", dev->dev.bus_id);
+		return -EBUSY;
+	}
+	/* if the auto config failed, try again now, because this device was requested before others it's best to find a config at all costs */
+	if (!pnp_is_active(dev)) {
+		spin_lock(&pnp_lock);
+		if (!pnp_next_config(dev,1,NULL)) {
+			pnp_init_resource_table(&dev->res);
+			dev->rule->depnum = 0;
+			pnp_err("res: Unable to resolve resource conflicts for the device '%s'", dev->dev.bus_id);
+			spin_unlock(&pnp_lock);
+			return -EBUSY;
+		}
+		spin_unlock(&pnp_lock);
+	}
+	if (dev->config_mode & PNP_CONFIG_INVALID) {
+		pnp_info("res: Unable to activate the PnP device '%s' because its resource configuration is invalid", dev->dev.bus_id);
 		return -EINVAL;
 	}
 	if (dev->status != PNP_READY && dev->status != PNP_ATTACHED){
 		pnp_err("res: Activation failed because the PnP device '%s' is busy", dev->dev.bus_id);
-		return -EINVAL;
+		return -EBUSY;
 	}
 	if (!pnp_can_write(dev)) {
 		pnp_info("res: Unable to activate the PnP device '%s' because this feature is not supported", dev->dev.bus_id);
@@ -1165,7 +1254,10 @@
 	} else
 		dev->active = pnp_is_active(dev);
 	pnp_dbg("res: the device '%s' has been activated", dev->dev.bus_id);
-	kfree(dev->rule);
+	if (dev->rule) {
+		kfree(dev->rule);
+		dev->rule = NULL;
+	}
 	return 0;
 }
 
@@ -1200,22 +1292,6 @@
 	return 0;
 }
 
-/**
- * pnp_resource_change - change one resource
- * @resource: pointer to resource to be changed
- * @start: start of region
- * @size: size of region
- *
- */
-
-void pnp_resource_change(struct resource *resource, unsigned long start, unsigned long size)
-{
-	if (resource == NULL)
-		return;
-	resource->flags &= ~IORESOURCE_AUTO;
-	resource->start = start;
-	resource->end = start + size - 1;
-}
 
 EXPORT_SYMBOL(pnp_build_resource);
 EXPORT_SYMBOL(pnp_find_resources);
diff -urN a/drivers/pnp/support.c b/drivers/pnp/support.c
--- a/drivers/pnp/support.c	Sun Feb  2 18:43:34 2003
+++ b/drivers/pnp/support.c	Mon Feb  3 15:49:22 2003
@@ -168,7 +168,7 @@
 				break;
 			}
 			} /* switch */
-                        p += len + 3;
+			p += len + 3;
 			continue;
 		} /* end large tag */
 
@@ -410,8 +410,8 @@
 			possible_dma(p,len,depnum,dev);
 			break;
 		}
-                case SMALL_TAG_STARTDEP:
-                {
+		case SMALL_TAG_STARTDEP:
+		{
 			if (len > 1)
 				goto sm_err;
 			dependent = 0x100 | PNP_RES_PRIORITY_ACCEPTABLE;
@@ -419,15 +419,15 @@
 				dependent = 0x100 | p[1];
 			pnp_build_resource(dev,dependent);
 			depnum = pnp_get_max_depnum(dev);
-                        break;
-                }
-                case SMALL_TAG_ENDDEP:
-                {
+			break;
+		}
+		case SMALL_TAG_ENDDEP:
+		{
 			if (len != 0)
 				goto sm_err;
 			depnum = 0;
-                        break;
-                }
+			break;
+		}
 		case SMALL_TAG_PORT:
 		{
 			if (len != 7)
diff -urN a/include/linux/pnp.h b/include/linux/pnp.h
--- a/include/linux/pnp.h	Sun Feb  2 18:43:34 2003
+++ b/include/linux/pnp.h	Mon Feb  3 19:07:00 2003
@@ -253,7 +253,7 @@
 	struct pnp_resource_table	res;		/* contains the currently chosen resources */
 	struct pnp_resources	      * possible;	/* a list of possible resources */
 	struct pnp_rule_table	      * rule;		/* the current possible resource set */
-	int 				lock_resources;	/* resources are locked */
+	int 				config_mode;	/* flags that determine how the device's resources should be configured */
 
 	void * protocol_data;		/* Used to store protocol specific data */
 	unsigned short	regs;		/* ISAPnP: supported registers */
@@ -300,6 +300,13 @@
 	void (*quirk_function)(struct pnp_dev *dev);	/* fixup function */
 };
 
+/* config modes */
+#define PNP_CONFIG_AUTO		0x0001	/* Use the Resource Configuration Engine to determine resource settings */
+#define PNP_CONFIG_MANUAL	0x0002	/* the config has been manually specified */
+#define PNP_CONFIG_FORCE	0x0003	/* disables validity checking */
+#define PNP_CONFIG_RESOLVE	0x0008	/* moves other configs out of the way, use only when absolutely necessary */
+#define PNP_CONFIG_INVALID	0x0010	/* If this flag is set, the pnp layer will refuse to activate the device */
+
 /* capabilities */
 #define PNP_READ		0x0001
 #define PNP_WRITE		0x0002
@@ -313,7 +320,7 @@
 				 ((dev)->capabilities & PNP_WRITE))
 #define pnp_can_disable(dev)	(((dev)->protocol) && ((dev)->protocol->disable) && \
 				 ((dev)->capabilities & PNP_DISABLE))
-#define pnp_can_configure(dev)	((!(dev)->active) && (!(dev)->lock_resources) && \
+#define pnp_can_configure(dev)	((!(dev)->active) && ((dev)->config_mode & PNP_CONFIG_AUTO) && \
 				 ((dev)->capabilities & PNP_CONFIGURABLE))
 
 /* status */
@@ -377,6 +384,8 @@
 int pnp_activate_dev(struct pnp_dev *dev);
 int pnp_disable_dev(struct pnp_dev *dev);
 void pnp_resource_change(struct resource *resource, unsigned long start, unsigned long size);
+int pnp_manual_config_dev(struct pnp_dev *dev, struct pnp_resource_table *res, int mode);
+int pnp_auto_config_dev(struct pnp_dev *dev);
 
 /* driver */
 int compare_pnp_id(struct pnp_id * pos, const char * id);
@@ -415,6 +424,8 @@
 static inline int pnp_activate_dev(struct pnp_dev *dev) { return -ENODEV; }
 static inline int pnp_disable_dev(struct pnp_dev *dev) { return -ENODEV; }
 static inline void pnp_resource_change(struct resource *resource, unsigned long start, unsigned long size) { ; }
+static inline int pnp_manual_config_dev(struct pnp_dev *dev, struct pnp_resource_table *res, int mode) { return -ENODEV; }
+static inline int pnp_auto_config_dev(struct pnp_dev *dev) { return -ENODEV; }
 
 /* driver */
 static inline int compare_pnp_id(struct list_head * id_list, const char * id) { return -ENODEV; }
