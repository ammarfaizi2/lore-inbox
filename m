Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135787AbRDTC4E>; Thu, 19 Apr 2001 22:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135788AbRDTCzz>; Thu, 19 Apr 2001 22:55:55 -0400
Received: from c526559-a.rchdsn1.tx.home.com ([24.0.107.130]:7296 "EHLO
	ledzep.dyndns.org") by vger.kernel.org with ESMTP
	id <S135787AbRDTCzw>; Thu, 19 Apr 2001 22:55:52 -0400
Message-ID: <3ADFA532.CAEE58BB@home.com>
Date: Thu, 19 Apr 2001 21:55:46 -0500
From: Jordan <ledzep37@home.com>
Organization: University of Texas at Dallas - Student
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-ac10-preempt-reiserfs-3.6.25 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bill Nottingham <notting@redhat.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ac10 ide-cd oopses on boot
In-Reply-To: <20010420004914.A1052@werewolf.able.es> <E14qNWF-0008Jc-00@the-village.bc.nu> <20010420013429.A1054@werewolf.able.es> <20010419223850.A2177@nostromo.devel.redhat.com>
Content-Type: multipart/mixed;
 boundary="------------749052B4423F6009507D1CAF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------749052B4423F6009507D1CAF
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Bill Nottingham wrote:
> 
> J . A . Magallon (jamagallon@able.es) said:
> > > Can you back out the ide-cd changes Jens did and see if that fixes it ?
> >
> > Reverted the changes in ide-cd.[hc], and same result.
> 
> You want to back out the stuff from drivers/cdrom/cdrom.c; I backed
> out the parts of the patch new there to ac10, and it worked again
> for me...
> 
> Bill
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

That worked here as well...here is a patch that should restore
linux/drivers/cdrom/cdrom.c back to its working ac9 state from ac10.

Jordan
--------------749052B4423F6009507D1CAF
Content-Type: text/plain; charset=us-ascii;
 name="patch-fix-cdrom-ac10"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-fix-cdrom-ac10"

--- linux_corrupt_cdrom/drivers/cdrom/cdrom.c	Thu Apr 19 19:31:00 2001
+++ linux/drivers/cdrom/cdrom.c	Wed Apr 18 01:49:05 2001
@@ -279,9 +279,6 @@
 static int lockdoor = 1;
 /* will we ever get to use this... sigh. */
 static int check_media_type;
-static unsigned long *cdrom_numbers;
-static DECLARE_MUTEX(cdrom_sem);
-
 MODULE_PARM(debug, "i");
 MODULE_PARM(autoclose, "i");
 MODULE_PARM(autoeject, "i");
@@ -343,38 +340,6 @@
 	check_media_change:	cdrom_media_changed,
 };
 
-/*
- * get or clear a new cdrom number, run under cdrom_sem
- */
-static int cdrom_get_entry(void)
-{
-	int i, nr, foo;
-
-	nr = 0;
-	foo = -1;
-	for (i = 0; i < CDROM_MAX_CDROMS / (sizeof(unsigned long) * 8); i++) {
-		if (cdrom_numbers[i] == ~0UL) {
-			nr += sizeof(unsigned long) * 8;
-			continue;
-		}
-		foo = ffz(cdrom_numbers[i]);
-		set_bit(foo, &cdrom_numbers[i]);
-		nr += foo;
-		break;
-	}
-
-	return foo == -1 ? foo : nr;
-}
-
-static void cdrom_clear_entry(struct cdrom_device_info *cdi)
-{
-	int bit_nr = cdi->nr & ~(sizeof(unsigned long) * 8);
-	int cd_index = cdi->nr / (sizeof(unsigned long) * 8);
-
-	clear_bit(bit_nr, &cdrom_numbers[cd_index]);
-}
-
-
 /* This macro makes sure we don't have to check on cdrom_device_ops
  * existence in the run-time routines below. Change_capability is a
  * hack to have the capability flags defined const, while we can still
@@ -389,6 +354,7 @@
         struct cdrom_device_ops *cdo = cdi->ops;
         int *change_capability = (int *)&cdo->capability; /* hack */
 	char vname[16];
+	static unsigned int cdrom_counter;
 
 	cdinfo(CD_OPEN, "entering register_cdrom\n"); 
 
@@ -429,17 +395,7 @@
 
 	if (!devfs_handle)
 		devfs_handle = devfs_mk_dir (NULL, "cdroms", NULL);
-
-	/*
-	 * get new cdrom number
-	 */
-	down(&cdrom_sem);
-	cdi->nr = cdrom_get_entry();
-	up(&cdrom_sem);
-	if (cdi->nr == -1)
-		return -ENOMEM;
-
-	sprintf(vname, "cdrom%u", cdi->nr);
+	sprintf (vname, "cdrom%u", cdrom_counter++);
 	if (cdi->de) {
 		int pos;
 		devfs_handle_t slave;
@@ -462,13 +418,9 @@
 				    S_IFBLK | S_IRUGO | S_IWUGO,
 				    &cdrom_fops, NULL);
 	}
-
-	down(&cdrom_sem);
+	cdinfo(CD_REG_UNREG, "drive \"/dev/%s\" registered\n", cdi->name);
 	cdi->next = topCdromPtr; 	
 	topCdromPtr = cdi;
-	up(&cdrom_sem);
-
-	cdinfo(CD_REG_UNREG, "drive \"/dev/%s\" registered\n", cdi->name);
 	return 0;
 }
 #undef ENSURE
@@ -477,14 +429,12 @@
 {
 	struct cdrom_device_info *cdi, *prev;
 	int major = MAJOR(unreg->dev);
-	int bit_nr, cd_index;
 
 	cdinfo(CD_OPEN, "entering unregister_cdrom\n"); 
 
 	if (major < 0 || major >= MAX_BLKDEV)
 		return -1;
 
-	down(&cdrom_sem);
 	prev = NULL;
 	cdi = topCdromPtr;
 	while (cdi != NULL && cdi->dev != unreg->dev) {
@@ -492,20 +442,14 @@
 		cdi = cdi->next;
 	}
 
-	if (cdi == NULL) {
-		up(&cdrom_sem);
+	if (cdi == NULL)
 		return -2;
-	}
-
-	cdrom_clear_entry(cdi);
-
 	if (prev)
 		prev->next = cdi->next;
 	else
 		topCdromPtr = cdi->next;
-	up(&cdrom_sem);
 	cdi->ops->n_minors--;
-	devfs_unregister(cdi->de);
+	devfs_unregister (cdi->de);
 	cdinfo(CD_REG_UNREG, "drive \"/dev/%s\" unregistered\n", cdi->name);
 	return 0;
 }
@@ -514,14 +458,10 @@
 {
 	struct cdrom_device_info *cdi;
 
-	down(&cdrom_sem);
-
 	cdi = topCdromPtr;
 	while (cdi != NULL && cdi->dev != dev)
 		cdi = cdi->next;
 
-	up(&cdrom_sem);
-
 	return cdi;
 }
 
@@ -2489,8 +2429,6 @@
 	}
 
 	pos = sprintf(info, "CD-ROM information, " VERSION "\n");
-
-	down(&cdrom_sem);
 	
 	pos += sprintf(info+pos, "\ndrive name:\t");
 	for (cdi=topCdromPtr;cdi!=NULL;cdi=cdi->next)
@@ -2560,8 +2498,6 @@
 	for (cdi=topCdromPtr;cdi!=NULL;cdi=cdi->next)
 	    pos += sprintf(info+pos, "\t%d", CDROM_CAN(CDC_DVD_RAM) != 0);
 
-	up(&cdrom_sem);
-
 	strcpy(info+pos,"\n\n");
 		
         return proc_dostring(ctl, write, filp, buffer, lenp);
@@ -2708,10 +2644,6 @@
 
 static int __init cdrom_init(void)
 {
-	int n_entries = CDROM_MAX_CDROMS / (sizeof(unsigned long) * 8);
-
-	cdrom_numbers = kmalloc(n_entries * sizeof(unsigned long), GFP_KERNEL);
-
 #ifdef CONFIG_SYSCTL
 	cdrom_sysctl_register();
 #endif
@@ -2722,7 +2654,6 @@
 static void __exit cdrom_exit(void)
 {
 	printk(KERN_INFO "Uniform CD-ROM driver unloaded\n");
-	kfree(cdrom_numbers);
 #ifdef CONFIG_SYSCTL
 	cdrom_sysctl_unregister();
 #endif

--------------749052B4423F6009507D1CAF--

