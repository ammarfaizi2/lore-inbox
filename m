Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319004AbSHSUFk>; Mon, 19 Aug 2002 16:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319036AbSHSUFk>; Mon, 19 Aug 2002 16:05:40 -0400
Received: from newman.msbb.uc.edu ([129.137.2.198]:9734 "EHLO smtp.uc.edu")
	by vger.kernel.org with ESMTP id <S319004AbSHSUFc>;
	Mon, 19 Aug 2002 16:05:32 -0400
From: kuebelr@email.uc.edu
Date: Mon, 19 Aug 2002 16:09:27 -0400
To: linux-kernel@vger.kernel.org
Subject: [RFC] [PATCH] cdrom per drive sysctl's
Message-Id: <20020819200927.GA8771@cartman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

currently, users cannot change cdrom sysctls (debug, autoclose, lock,
etc.) on a per drive basis.  this patch implements a per-drive
sysctl/proc interface based on Jens Axboe's TODO list in cdrom.c.

with cdrom support in the kernel you will get a layout like this:

/proc/sys/dev/cdrom/default/{autoclose,autoeject,check_media,debug,lock}

add any cd drivers (ide-cd, sr_mod) and you get this:

/proc/sys/dev/cdrom/{hdc,sr0}/{autoclose,autoeject,check_media,debug,info,lock}

any changes made to the default tree will be inherited by cdrom modules
loaded after the change.

notice `info' is missing from default.

i want to know what people think of this. feel free to pick nits. if
this looks like garbage, let me know. i'll try to fix it.

this will apply to 2.4.19 (and last time i checked 2.5 also).

diff -Nru a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
--- a/drivers/cdrom/cdrom.c	Mon Aug 19 14:40:56 2002
+++ b/drivers/cdrom/cdrom.c	Mon Aug 19 14:40:56 2002
@@ -14,15 +14,6 @@
    actually talk to the hardware. Suggestions are welcome.
    Patches that work are more welcome though.  ;-)
 
- To Do List:
- ----------------------------------
-
- -- Modify sysctl/proc interface. I plan on having one directory per
- drive, with entries for outputing general drive information, and sysctl
- based tunable parameters such as whether the tray should auto-close for
- that drive. Suggestions (or patches) for this welcome!
-
-
  Revision History
  ----------------------------------
  1.00  Date Unknown -- David van Leeuwen <david@tm.tno.nl>
@@ -228,10 +219,13 @@
    3.12 Oct 18, 2000 - Jens Axboe <axboe@suse.de>
   -- Use quiet bit on packet commands not known to work
 
+   3.13 Jul, 2002 - Robert Kuebel
+  -- Implemented per drive sysctl/procfs interface.
+
 -------------------------------------------------------------------------*/
 
-#define REVISION "Revision: 3.12"
-#define VERSION "Id: cdrom.c 3.12 2000/10/18"
+#define REVISION "Revision: 3.13"
+#define VERSION "Id: cdrom.c 3.13 2002/07/04"
 
 /* I use an error-log mask to give fine grain control over the type of
    messages dumped to the system logs.  The available masks include: */
@@ -321,13 +315,176 @@
 int cdrom_get_last_written(kdev_t dev, long *last_written);
 int cdrom_get_next_writable(kdev_t dev, long *next_writable);
 
-#ifdef CONFIG_SYSCTL
-static void cdrom_sysctl_register(void);
-#endif /* CONFIG_SYSCTL */ 
 static struct cdrom_device_info *topCdromPtr;
 static devfs_handle_t devfs_handle;
 static struct unique_numspace cdrom_numspace = UNIQUE_NUMBERSPACE_INITIALISER;
 
+#ifdef CONFIG_SYSCTL
+
+#define CDROM_STR_SIZE 500
+char cdrom_info[CDROM_STR_SIZE];	/* general info */
+
+static int cdrom_sysctl_min = 0;
+static int cdrom_sysctl_max = 1;
+
+int cdrom_sysctl_info(ctl_table *ctl, int write, struct file * filp, void *buffer, size_t *lenp)
+{
+	int pos;
+	struct cdrom_device_info *cdi = (struct cdrom_device_info *)ctl->extra1;
+	char *info = ctl->data;
+	
+	if (!*lenp || (filp->f_pos && !write)) {
+		*lenp = 0;
+		return 0;
+	}
+
+	pos = sprintf(info, "CD-ROM information, " VERSION "\n");
+	
+	pos += sprintf(info+pos, "\ndrive name:\t");
+	pos += sprintf(info+pos, "\t%s", cdi->name);
+
+	pos += sprintf(info+pos, "\ndrive speed:\t");
+	pos += sprintf(info+pos, "\t%d", cdi->speed);
+
+	pos += sprintf(info+pos, "\ndrive # of slots:");
+	pos += sprintf(info+pos, "\t%d", cdi->capacity);
+
+	pos += sprintf(info+pos, "\nCan close tray:\t");
+	pos += sprintf(info+pos, "\t%d", CDROM_CAN(CDC_CLOSE_TRAY) != 0);
+
+	pos += sprintf(info+pos, "\nCan open tray:\t");
+	pos += sprintf(info+pos, "\t%d", CDROM_CAN(CDC_OPEN_TRAY) != 0);
+
+	pos += sprintf(info+pos, "\nCan lock tray:\t");
+	pos += sprintf(info+pos, "\t%d", CDROM_CAN(CDC_LOCK) != 0);
+
+	pos += sprintf(info+pos, "\nCan change speed:");
+	pos += sprintf(info+pos, "\t%d", CDROM_CAN(CDC_SELECT_SPEED) != 0);
+
+	pos += sprintf(info+pos, "\nCan select disk:");
+	pos += sprintf(info+pos, "\t%d", CDROM_CAN(CDC_SELECT_DISC) != 0);
+
+	pos += sprintf(info+pos, "\nCan read multisession:");
+	pos += sprintf(info+pos, "\t%d", CDROM_CAN(CDC_MULTI_SESSION) != 0);
+
+	pos += sprintf(info+pos, "\nCan read MCN:\t");
+	pos += sprintf(info+pos, "\t%d", CDROM_CAN(CDC_MCN) != 0);
+
+	pos += sprintf(info+pos, "\nReports media changed:");
+	pos += sprintf(info+pos, "\t%d", CDROM_CAN(CDC_MEDIA_CHANGED) != 0);
+
+	pos += sprintf(info+pos, "\nCan play audio:\t");
+	pos += sprintf(info+pos, "\t%d", CDROM_CAN(CDC_PLAY_AUDIO) != 0);
+
+	pos += sprintf(info+pos, "\nCan write CD-R:\t");
+	pos += sprintf(info+pos, "\t%d", CDROM_CAN(CDC_CD_R) != 0);
+
+	pos += sprintf(info+pos, "\nCan write CD-RW:");
+	pos += sprintf(info+pos, "\t%d", CDROM_CAN(CDC_CD_RW) != 0);
+
+	pos += sprintf(info+pos, "\nCan read DVD:\t");
+	pos += sprintf(info+pos, "\t%d", CDROM_CAN(CDC_DVD) != 0);
+
+	pos += sprintf(info+pos, "\nCan write DVD-R:");
+	pos += sprintf(info+pos, "\t%d", CDROM_CAN(CDC_DVD_R) != 0);
+
+	pos += sprintf(info+pos, "\nCan write DVD-RAM:");
+	pos += sprintf(info+pos, "\t%d", CDROM_CAN(CDC_DVD_RAM) != 0);
+
+	strcpy(info+pos,"\n\n");
+		
+	return proc_dostring(ctl, write, filp, buffer, lenp);
+}
+
+static struct cdrom_sysctl_table cdrom_table = {
+	NULL,
+	{{ DEV_CDROM_DRIVE_AUTOCLOSE, "autoclose", &cdrom_table.options.autoclose, sizeof(int), 0644, NULL,
+			proc_dointvec_minmax, NULL, NULL, &cdrom_sysctl_min, &cdrom_sysctl_max},
+		{ DEV_CDROM_DRIVE_AUTOEJECT, "autoeject", &cdrom_table.options.autoeject, sizeof(int), 0644, NULL,
+			proc_dointvec_minmax, NULL, NULL, &cdrom_sysctl_min, &cdrom_sysctl_max},
+		{ DEV_CDROM_DRIVE_DEBUG, "debug", &cdrom_table.options.debug, sizeof(int), 0644, NULL,
+			proc_dointvec_minmax, NULL, NULL, &cdrom_sysctl_min, &cdrom_sysctl_max},
+		{ DEV_CDROM_DRIVE_LOCK, "lock", &cdrom_table.options.lock, sizeof(int), 0644, NULL,
+			proc_dointvec_minmax, NULL, NULL, &cdrom_sysctl_min, &cdrom_sysctl_max},
+		{ DEV_CDROM_DRIVE_CHECK_MEDIA, "check_media", &cdrom_table.options.check_media, sizeof(int), 0644, NULL,
+			proc_dointvec_minmax, NULL, NULL, &cdrom_sysctl_min, &cdrom_sysctl_max},
+		{ DEV_CDROM_DRIVE_INFO, NULL, &cdrom_info, CDROM_STR_SIZE, 0444, NULL,
+			cdrom_sysctl_info}},
+	{{ DEV_CDROM_DEFAULT, "default", NULL, 0, 0555, cdrom_table.options_table}},
+	{{ DEV_CDROM, "cdrom", NULL, 0, 0555, cdrom_table.drive_table}},
+	{{ CTL_DEV, "dev", NULL, 0, 0555, cdrom_table.cdrom_table}}
+};
+
+struct ctl_table_header *cdrom_sysctl_header;
+
+static void cdrom_sysctl_init(void) {
+	cdrom_table.options.debug = debug;
+	cdrom_table.options.autoclose = autoclose;
+	cdrom_table.options.autoeject = autoeject;
+	cdrom_table.options.lock = lockdoor;
+	cdrom_table.options.check_media = check_media_type;
+
+	cdrom_sysctl_header = register_sysctl_table(cdrom_table.dev_table, 0);
+	if (!cdrom_sysctl_header)
+		cdinfo(CD_WARNING, "%s: failed to register sysctl table\n", __FUNCTION__);
+}
+
+static void cdrom_sysctl_exit(void) {
+	if (cdrom_sysctl_header)
+		unregister_sysctl_table(cdrom_sysctl_header);
+}
+
+static void cdrom_register_sysctl(struct cdrom_device_info *cdi) {
+	struct cdrom_sysctl_table *cst;
+
+	cdi->sysctl_table = kmalloc(sizeof(struct cdrom_sysctl_table), GFP_KERNEL);
+	if (!cdi->sysctl_table)
+		goto err;
+
+	cst = cdi->sysctl_table;
+
+	/* copy the default settings for the new drive */
+	memcpy(cst, &cdrom_table, sizeof(struct cdrom_sysctl_table));
+
+	cst->options_table[0].data = &cst->options.autoclose;
+	cst->options_table[1].data = &cst->options.autoeject;
+	cst->options_table[2].data = &cst->options.debug;
+	cst->options_table[3].data = &cst->options.lock;
+	cst->options_table[4].data = &cst->options.check_media;
+	cst->options_table[5].procname = "info";
+	cst->options_table[5].extra1 = cdi;
+	cst->drive_table[0].child = cst->options_table;
+	cst->drive_table[0].procname = cdi->name;
+	cst->drive_table[0].ctl_name = kdev_t_to_nr(cdi->dev);
+	cst->cdrom_table[0].child = cst->drive_table;
+	cst->dev_table[0].child = cst->cdrom_table;
+
+	cst->sysctl_header = register_sysctl_table(cst->dev_table, 0);
+	if (cst->sysctl_header)
+		return;
+
+	kfree(cdi->sysctl_table);
+err:
+	cdinfo(CD_WARNING, "failed to register sysctl table for %s\n", cdi->name);
+	return;
+}
+
+static void cdrom_unregister_sysctl(struct cdrom_device_info *cdi) {
+	if (cdi && cdi->sysctl_table) {
+		unregister_sysctl_table(cdi->sysctl_table->sysctl_header);
+		kfree(cdi->sysctl_table);
+	}
+}
+
+#else
+
+static inline void cdrom_sysctl_init() {}
+static inline void cdrom_sysctl_exit() {}
+static inline void cdrom_register_sysctl(struct cdrom_device_info *cdi) {}
+static inline void cdrom_unregister_sysctl(struct cdrom_device_info *cdi) {}
+
+#endif /* CONFIG_SYSCTL */
+
 /* This macro makes sure we don't have to check on cdrom_device_ops
  * existence in the run-time routines below. Change_capability is a
  * hack to have the capability flags defined const, while we can still
@@ -351,9 +508,6 @@
 	if ( !banner_printed ) {
 		printk(KERN_INFO "Uniform CD-ROM driver " REVISION "\n");
 		banner_printed = 1;
-#ifdef CONFIG_SYSCTL
-		cdrom_sysctl_register();
-#endif /* CONFIG_SYSCTL */ 
 	}
 	ENSURE(drive_status, CDC_DRIVE_STATUS );
 	ENSURE(media_changed, CDC_MEDIA_CHANGED);
@@ -379,6 +533,7 @@
 	if (check_media_type==1)
 		cdi->options |= (int) CDO_CHECK_TYPE;
 
+	cdrom_register_sysctl(cdi);
 	if (!devfs_handle)
 		devfs_handle = devfs_mk_dir (NULL, "cdroms", NULL);
 	cdi->number = devfs_alloc_unique_number (&cdrom_numspace);
@@ -430,6 +585,7 @@
 	else
 		topCdromPtr = cdi->next;
 	cdi->ops->n_minors--;
+	cdrom_unregister_sysctl(cdi);
 	devfs_unregister (cdi->de);
 	devfs_dealloc_unique_number (&cdrom_numspace, cdi->number);
 	cdinfo(CD_REG_UNREG, "drive \"/dev/%s\" unregistered\n", cdi->name);
@@ -2381,251 +2537,9 @@
 EXPORT_SYMBOL(init_cdrom_command);
 EXPORT_SYMBOL(cdrom_find_device);
 
-#ifdef CONFIG_SYSCTL
-
-#define CDROM_STR_SIZE 1000
-
-struct cdrom_sysctl_settings {
-	char	info[CDROM_STR_SIZE];	/* general info */
-	int	autoclose;		/* close tray upon mount, etc */
-	int	autoeject;		/* eject on umount */
-	int	debug;			/* turn on debugging messages */
-	int	lock;			/* lock the door on device open */
-	int	check;			/* check media type */
-} cdrom_sysctl_settings;
-
-int cdrom_sysctl_info(ctl_table *ctl, int write, struct file * filp,
-                           void *buffer, size_t *lenp)
-{
-        int pos;
-	struct cdrom_device_info *cdi;
-	char *info = cdrom_sysctl_settings.info;
-	
-	if (!*lenp || (filp->f_pos && !write)) {
-		*lenp = 0;
-		return 0;
-	}
-
-	pos = sprintf(info, "CD-ROM information, " VERSION "\n");
-	
-	pos += sprintf(info+pos, "\ndrive name:\t");
-	for (cdi=topCdromPtr;cdi!=NULL;cdi=cdi->next)
-	    pos += sprintf(info+pos, "\t%s", cdi->name);
-
-	pos += sprintf(info+pos, "\ndrive speed:\t");
-	for (cdi=topCdromPtr;cdi!=NULL;cdi=cdi->next)
-	    pos += sprintf(info+pos, "\t%d", cdi->speed);
-
-	pos += sprintf(info+pos, "\ndrive # of slots:");
-	for (cdi=topCdromPtr;cdi!=NULL;cdi=cdi->next)
-	    pos += sprintf(info+pos, "\t%d", cdi->capacity);
-
-	pos += sprintf(info+pos, "\nCan close tray:\t");
-	for (cdi=topCdromPtr;cdi!=NULL;cdi=cdi->next)
-	    pos += sprintf(info+pos, "\t%d", CDROM_CAN(CDC_CLOSE_TRAY) != 0);
-
-	pos += sprintf(info+pos, "\nCan open tray:\t");
-	for (cdi=topCdromPtr;cdi!=NULL;cdi=cdi->next)
-	    pos += sprintf(info+pos, "\t%d", CDROM_CAN(CDC_OPEN_TRAY) != 0);
-
-	pos += sprintf(info+pos, "\nCan lock tray:\t");
-	for (cdi=topCdromPtr;cdi!=NULL;cdi=cdi->next)
-	    pos += sprintf(info+pos, "\t%d", CDROM_CAN(CDC_LOCK) != 0);
-
-	pos += sprintf(info+pos, "\nCan change speed:");
-	for (cdi=topCdromPtr;cdi!=NULL;cdi=cdi->next)
-	    pos += sprintf(info+pos, "\t%d", CDROM_CAN(CDC_SELECT_SPEED) != 0);
-
-	pos += sprintf(info+pos, "\nCan select disk:");
-	for (cdi=topCdromPtr;cdi!=NULL;cdi=cdi->next)
-	    pos += sprintf(info+pos, "\t%d", CDROM_CAN(CDC_SELECT_DISC) != 0);
-
-	pos += sprintf(info+pos, "\nCan read multisession:");
-	for (cdi=topCdromPtr;cdi!=NULL;cdi=cdi->next)
-	    pos += sprintf(info+pos, "\t%d", CDROM_CAN(CDC_MULTI_SESSION) != 0);
-
-	pos += sprintf(info+pos, "\nCan read MCN:\t");
-	for (cdi=topCdromPtr;cdi!=NULL;cdi=cdi->next)
-	    pos += sprintf(info+pos, "\t%d", CDROM_CAN(CDC_MCN) != 0);
-
-	pos += sprintf(info+pos, "\nReports media changed:");
-	for (cdi=topCdromPtr;cdi!=NULL;cdi=cdi->next)
-	    pos += sprintf(info+pos, "\t%d", CDROM_CAN(CDC_MEDIA_CHANGED) != 0);
-
-	pos += sprintf(info+pos, "\nCan play audio:\t");
-	for (cdi=topCdromPtr;cdi!=NULL;cdi=cdi->next)
-	    pos += sprintf(info+pos, "\t%d", CDROM_CAN(CDC_PLAY_AUDIO) != 0);
-
-	pos += sprintf(info+pos, "\nCan write CD-R:\t");
-	for (cdi=topCdromPtr;cdi!=NULL;cdi=cdi->next)
-	    pos += sprintf(info+pos, "\t%d", CDROM_CAN(CDC_CD_R) != 0);
-
-	pos += sprintf(info+pos, "\nCan write CD-RW:");
-	for (cdi=topCdromPtr;cdi!=NULL;cdi=cdi->next)
-	    pos += sprintf(info+pos, "\t%d", CDROM_CAN(CDC_CD_RW) != 0);
-
-	pos += sprintf(info+pos, "\nCan read DVD:\t");
-	for (cdi=topCdromPtr;cdi!=NULL;cdi=cdi->next)
-	    pos += sprintf(info+pos, "\t%d", CDROM_CAN(CDC_DVD) != 0);
-
-	pos += sprintf(info+pos, "\nCan write DVD-R:");
-	for (cdi=topCdromPtr;cdi!=NULL;cdi=cdi->next)
-	    pos += sprintf(info+pos, "\t%d", CDROM_CAN(CDC_DVD_R) != 0);
-
-	pos += sprintf(info+pos, "\nCan write DVD-RAM:");
-	for (cdi=topCdromPtr;cdi!=NULL;cdi=cdi->next)
-	    pos += sprintf(info+pos, "\t%d", CDROM_CAN(CDC_DVD_RAM) != 0);
-
-	strcpy(info+pos,"\n\n");
-		
-        return proc_dostring(ctl, write, filp, buffer, lenp);
-}
-
-/* Unfortunately, per device settings are not implemented through
-   procfs/sysctl yet. When they are, this will naturally disappear. For now
-   just update all drives. Later this will become the template on which
-   new registered drives will be based. */
-void cdrom_update_settings(void)
-{
-	struct cdrom_device_info *cdi;
-
-	for (cdi = topCdromPtr; cdi != NULL; cdi = cdi->next) {
-		if (autoclose && CDROM_CAN(CDC_CLOSE_TRAY))
-			cdi->options |= CDO_AUTO_CLOSE;
-		else if (!autoclose)
-			cdi->options &= ~CDO_AUTO_CLOSE;
-		if (autoeject && CDROM_CAN(CDC_OPEN_TRAY))
-			cdi->options |= CDO_AUTO_EJECT;
-		else if (!autoeject)
-			cdi->options &= ~CDO_AUTO_EJECT;
-		if (lockdoor && CDROM_CAN(CDC_LOCK))
-			cdi->options |= CDO_LOCK;
-		else if (!lockdoor)
-			cdi->options &= ~CDO_LOCK;
-		if (check_media_type)
-			cdi->options |= CDO_CHECK_TYPE;
-		else
-			cdi->options &= ~CDO_CHECK_TYPE;
-	}
-}
-
-static int cdrom_sysctl_handler(ctl_table *ctl, int write, struct file * filp,
-				void *buffer, size_t *lenp)
-{
-	int *valp = ctl->data;
-	int val = *valp;
-	int ret;
-	
-	ret = proc_dointvec(ctl, write, filp, buffer, lenp);
-
-	if (write && *valp != val) {
-	
-		/* we only care for 1 or 0. */
-		if (*valp)
-			*valp = 1;
-		else
-			*valp = 0;
-
-		switch (ctl->ctl_name) {
-		case DEV_CDROM_AUTOCLOSE: {
-			if (valp == &cdrom_sysctl_settings.autoclose)
-				autoclose = cdrom_sysctl_settings.autoclose;
-			break;
-			}
-		case DEV_CDROM_AUTOEJECT: {
-			if (valp == &cdrom_sysctl_settings.autoeject)
-				autoeject = cdrom_sysctl_settings.autoeject;
-			break;
-			}
-		case DEV_CDROM_DEBUG: {
-			if (valp == &cdrom_sysctl_settings.debug)
-				debug = cdrom_sysctl_settings.debug;
-			break;
-			}
-		case DEV_CDROM_LOCK: {
-			if (valp == &cdrom_sysctl_settings.lock)
-				lockdoor = cdrom_sysctl_settings.lock;
-			break;
-			}
-		case DEV_CDROM_CHECK_MEDIA: {
-			if (valp == &cdrom_sysctl_settings.check)
-				check_media_type = cdrom_sysctl_settings.check;
-			break;
-			}
-		}
-		/* update the option flags according to the changes. we
-		   don't have per device options through sysctl yet,
-		   but we will have and then this will disappear. */
-		cdrom_update_settings();
-	}
-
-        return ret;
-}
-
-/* Place files in /proc/sys/dev/cdrom */
-ctl_table cdrom_table[] = {
-	{DEV_CDROM_INFO, "info", &cdrom_sysctl_settings.info, 
-		CDROM_STR_SIZE, 0444, NULL, &cdrom_sysctl_info},
-	{DEV_CDROM_AUTOCLOSE, "autoclose", &cdrom_sysctl_settings.autoclose,
-		sizeof(int), 0644, NULL, &cdrom_sysctl_handler },
-	{DEV_CDROM_AUTOEJECT, "autoeject", &cdrom_sysctl_settings.autoeject,
-		sizeof(int), 0644, NULL, &cdrom_sysctl_handler },
-	{DEV_CDROM_DEBUG, "debug", &cdrom_sysctl_settings.debug,
-		sizeof(int), 0644, NULL, &cdrom_sysctl_handler },
-	{DEV_CDROM_LOCK, "lock", &cdrom_sysctl_settings.lock,
-		sizeof(int), 0644, NULL, &cdrom_sysctl_handler },
-	{DEV_CDROM_CHECK_MEDIA, "check_media", &cdrom_sysctl_settings.check,
-		sizeof(int), 0644, NULL, &cdrom_sysctl_handler },
-	{0}
-	};
-
-ctl_table cdrom_cdrom_table[] = {
-	{DEV_CDROM, "cdrom", NULL, 0, 0555, cdrom_table},
-	{0}
-	};
-
-/* Make sure that /proc/sys/dev is there */
-ctl_table cdrom_root_table[] = {
-#ifdef CONFIG_PROC_FS
-	{CTL_DEV, "dev", NULL, 0, 0555, cdrom_cdrom_table},
-#endif /* CONFIG_PROC_FS */
-	{0}
-	};
-static struct ctl_table_header *cdrom_sysctl_header;
-
-static void cdrom_sysctl_register(void)
-{
-	static int initialized;
-
-	if (initialized == 1)
-		return;
-
-	cdrom_sysctl_header = register_sysctl_table(cdrom_root_table, 1);
-	cdrom_root_table->child->de->owner = THIS_MODULE;
-
-	/* set the defaults */
-	cdrom_sysctl_settings.autoclose = autoclose;
-	cdrom_sysctl_settings.autoeject = autoeject;
-	cdrom_sysctl_settings.debug = debug;
-	cdrom_sysctl_settings.lock = lockdoor;
-	cdrom_sysctl_settings.check = check_media_type;
-
-	initialized = 1;
-}
-
-static void cdrom_sysctl_unregister(void)
-{
-	if (cdrom_sysctl_header)
-		unregister_sysctl_table(cdrom_sysctl_header);
-}
-
-#endif /* CONFIG_SYSCTL */
-
 static int __init cdrom_init(void)
 {
-#ifdef CONFIG_SYSCTL
-	cdrom_sysctl_register();
-#endif
+	cdrom_sysctl_init();
 	if (!devfs_handle)
 		devfs_handle = devfs_mk_dir(NULL, "cdroms", NULL);
 	return 0;
@@ -2634,9 +2548,7 @@
 static void __exit cdrom_exit(void)
 {
 	printk(KERN_INFO "Uniform CD-ROM driver unloaded\n");
-#ifdef CONFIG_SYSCTL
-	cdrom_sysctl_unregister();
-#endif
+	cdrom_sysctl_exit();
 	devfs_unregister(devfs_handle);
 }
 
diff -Nru a/include/linux/cdrom.h b/include/linux/cdrom.h
--- a/include/linux/cdrom.h	Mon Aug 19 14:40:56 2002
+++ b/include/linux/cdrom.h	Mon Aug 19 14:40:56 2002
@@ -13,6 +13,10 @@
 
 #include <asm/byteorder.h>
 
+#ifdef CONFIG_SYSCTL
+#include <linux/sysctl.h>
+#endif 
+
 /*******************************************************
  * As of Linux 2.1.x, all Linux CD-ROM application programs will use this 
  * (and only this) include file.  It is my hope to provide Linux with
@@ -724,6 +728,25 @@
 	unsigned char writeable;	/* cdrom is writeable */
 };
 
+struct cdrom_options {
+	int debug;
+	int autoclose;
+	int autoeject;
+	int lock;
+	int check_media;
+};
+
+#ifdef CONFIG_SYSCTL
+struct cdrom_sysctl_table {
+	struct ctl_table_header *sysctl_header;
+	struct ctl_table options_table[7];
+	struct ctl_table drive_table[2];
+	struct ctl_table cdrom_table[2];
+	struct ctl_table dev_table[2];
+	struct cdrom_options options;
+};
+#endif
+
 /* Uniform cdrom data structures for cdrom.c */
 struct cdrom_device_info {
 	struct cdrom_device_ops  *ops;  /* link to device_ops */
@@ -745,6 +768,9 @@
         __u8 sanyo_slot		: 2;	/* Sanyo 3 CD changer support */
         __u8 reserved		: 6;	/* not used yet */
 	struct cdrom_write_settings write;
+#ifdef CONFIG_SYSCTL
+	struct cdrom_sysctl_table *sysctl_table;
+#endif
 };
 
 struct cdrom_device_ops {
diff -Nru a/include/linux/sysctl.h b/include/linux/sysctl.h
--- a/include/linux/sysctl.h	Mon Aug 19 14:40:56 2002
+++ b/include/linux/sysctl.h	Mon Aug 19 14:40:56 2002
@@ -561,12 +561,17 @@
 
 /* /proc/sys/dev/cdrom */
 enum {
-	DEV_CDROM_INFO=1,
-	DEV_CDROM_AUTOCLOSE=2,
-	DEV_CDROM_AUTOEJECT=3,
-	DEV_CDROM_DEBUG=4,
-	DEV_CDROM_LOCK=5,
-	DEV_CDROM_CHECK_MEDIA=6
+	DEV_CDROM_DEFAULT=-2
+};
+
+/* /proc/sys/dev/cdrom/<drive>/ */
+enum {
+	DEV_CDROM_DRIVE_INFO=1,
+	DEV_CDROM_DRIVE_AUTOCLOSE=2,
+	DEV_CDROM_DRIVE_AUTOEJECT=3,
+	DEV_CDROM_DRIVE_DEBUG=4,
+	DEV_CDROM_DRIVE_LOCK=5,
+	DEV_CDROM_DRIVE_CHECK_MEDIA=6
 };
 
 /* /proc/sys/dev/parport */
