Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317870AbSFMVzU>; Thu, 13 Jun 2002 17:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317866AbSFMVy1>; Thu, 13 Jun 2002 17:54:27 -0400
Received: from psmtp2.dnsg.net ([193.168.128.42]:31655 "HELO psmtp2.dnsg.net")
	by vger.kernel.org with SMTP id <S317852AbSFMVvp>;
	Thu, 13 Jun 2002 17:51:45 -0400
Subject: [PATCH][2.5.21] s390 tape fixes.
To: linux-kernel@vger.kernel.org
Date: Fri, 14 Jun 2002 01:43:00 +0200 (CEST)
CC: torvalds@transmeta.com
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E17IeFM-0000CW-00@skybase>
From: Martin Schwidefsky <martin.schwidefsky@debitel.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
the new tape driver in 2.5.21 is a more or less 1:1 copy of the 2.4 code.
To get it to work some adaptions are needed. Here they are.

blue skies,
  Martin.


diff -urN linux-2.5.21/drivers/s390/char/tape.c linux-2.5.21-s390/drivers/s390/char/tape.c
--- linux-2.5.21/drivers/s390/char/tape.c	Sun Jun  9 07:30:37 2002
+++ linux-2.5.21-s390/drivers/s390/char/tape.c	Tue Jun 11 18:43:32 2002
@@ -47,7 +47,9 @@
 #define TAPE_NO_IO          0
 #define TAPE_DO_IO          1
 
-#define TAPE_CIO_PRIVATE_DATA
+#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,4,16))
+	#define TAPE_CIO_PRIVATE_DATA
+#endif
 
 #ifdef CONFIG_KMOD
 #define tape_request_module(a) request_module(a)
@@ -142,9 +144,12 @@
 	"WTM",
 	"MSN",
 	"LOA",
-	"RCF", /* 3590 */
-	"RAT", /* 3590 */
-	"NOT"
+	"RCF",
+	"RAT",
+	"NOT",
+	"DIS",
+	"ASS",
+	"UAS"
 };
 
 /*******************************************************************
@@ -204,12 +209,21 @@
 	release:tape_proc_devices_release,	/* close */
 };
 
+static struct inode_operations tape_proc_devices_inode_ops =
+{
+#if !(LINUX_VERSION_CODE > KERNEL_VERSION(2,3,98))
+	default_file_ops:&tape_proc_devices_file_ops		/* file ops */
+#endif				/* LINUX_IS_24 */
+};
+
+
 /* 
  * Initialize procfs stuff on startup
  */
 
 static inline void
 tape_proc_init (void) {
+#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,3,98))
 	tape_proc_devices = create_proc_entry ("tapedevices",
 						S_IFREG | S_IRUGO | S_IWUSR,
 						&proc_root);
@@ -217,6 +231,24 @@
 	        goto error;
 	tape_proc_devices->proc_fops = &tape_proc_devices_file_ops;
 	tape_proc_devices->proc_iops = &tape_proc_devices_inode_ops;
+#else
+	tape_proc_devices = (struct proc_dir_entry *) kmalloc 
+            (sizeof (struct proc_dir_entry), GFP_ATOMIC);
+	if (tape_proc_devices == NULL) 
+	        goto error;
+	memset (tape_proc_devices, 0, sizeof (struct proc_dir_entry));
+	tape_proc_devices->name = "tapedevices";
+	tape_proc_devices->namelen = strlen ("tapedevices");
+	tape_proc_devices->low_ino = 0;
+	tape_proc_devices->mode = (S_IFREG | S_IRUGO | S_IWUSR);
+	tape_proc_devices->nlink = 1;
+	tape_proc_devices->uid = 0;
+	tape_proc_devices->gid = 0;
+	tape_proc_devices->size = 0;
+	tape_proc_devices->get_info = NULL;
+	tape_proc_devices->ops = &tape_proc_devices_inode_ops;
+	proc_register (&proc_root, tape_proc_devices);
+#endif
 	return;
  error:
 	PRINT_WARN ("tape: Cannot register procfs entry tapedevices\n");
@@ -359,8 +391,14 @@
 static inline void
 tape_proc_cleanup (void)
 {
-        if (tape_proc_devices != NULL)
+        if (tape_proc_devices != NULL){
+#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,3,98))
 		remove_proc_entry ("tapedevices", &proc_root);
+#else
+		proc_unregister (&proc_root, tape_proc_devices->low_ino);
+		kfree (tape_proc_devices);
+#endif /* LINUX_IS_24 */
+	}
 }
 
 #endif /* CONFIG_PROC_FS */
@@ -384,12 +422,12 @@
         wake_up_interruptible(&treq->wq);
 }
  
-#ifdef CONFIG_S390_TAPE_BLOCK
 static void tape_schedule_tapeblock(tape_ccw_req_t* treq){
         treq->wakeup = NULL;
+#ifdef CONFIG_S390_TAPE_BLOCK
         tapeblock_schedule_exec_io((tape_dev_t*)(treq->tape_dev));;
-}
 #endif
+}
  
 static void tape_wait_event(tape_ccw_req_t* treq){
         wait_event (treq->wq,(treq->wakeup == NULL));
@@ -400,9 +438,9 @@
 	if (signal_pending (current)) {
 		treq->rc = tape_halt_io(treq->tape_dev);
 		if(treq->rc == -ERESTARTSYS)
-		        PRINT_INFO("IO stopped on irq %d\n",treq->tape_dev->devinfo.irq); /* FIXME: only put into dbf */
+		        tape_sprintf_event(tape_dbf_area, 3, "IO stopped on irq %d\n", treq->tape_dev->devinfo.irq);
                 else if(treq->rc == 0)
-		        PRINT_INFO("could not stop IO,irq was faster on irq %d\n",treq->tape_dev->devinfo.irq); /* FIXME: only put into dbf */
+		        tape_sprintf_event(tape_dbf_area, 3, "could not stop IO,irq was faster on irq %d\n", treq->tape_dev->devinfo.irq);
                 else
 			PRINT_WARN("IO error while stopping IO on irq %d\n",treq->tape_dev->devinfo.irq);
 	}
@@ -632,7 +670,9 @@
 	return 1;
 }
 
+#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,3,99))
 __setup("tape=", tape_parm_call_setup);
+#endif   /* kernel >2.3.99 */
 #endif   /* not defined MODULE */
 
 
@@ -736,9 +776,8 @@
 	}
 		
 	for (frontend=tape_first_front;frontend!=NULL;frontend=frontend->next){
-		if(frontend->mkdevfstree(td) == NULL){
+		if(frontend->setup_device(td) != 0)
 			goto out_undo;
-		}
 	}
 #endif
 #ifdef TAPE_CIO_PRIVATE_DATA
@@ -771,7 +810,7 @@
 	free_irq (td->devinfo.irq, &(td->devstat)); 
 #ifdef CONFIG_DEVFS_FS
         for (frontend=tape_first_front;frontend!=NULL;frontend=frontend->next)
-                frontend->rmdevfstree(td);
+                frontend->cleanup_device(td);
         tape_rmdevfsroot(td);
 #endif
 	tape_state_set(td,TS_NOT_OPER);
@@ -1007,8 +1046,8 @@
 			/* Wrong type - try next one */
 			continue;
 
-		tape_sprintf_event (tape_dbf_area,3,"det irq:  %x\n",irq);
-		tape_sprintf_event (tape_dbf_area,3,"cu     :  %x\n",disc->cu_type);
+		tape_sprintf_event (tape_dbf_area, 4, "det irq:  %x\n", irq);
+		tape_sprintf_event (tape_dbf_area, 4, "cu     :  %x\n", disc->cu_type);
 
 
 		if(!tape_autoprobe) {
@@ -1219,13 +1258,13 @@
 			rc = -ERESTARTSYS;
 			goto out;
 		case -ENODEV:
-		        PRINT_INFO ("device gone, retry\n"); /* FIXME: s390dbf only */
+		        tape_sprintf_exception(tape_dbf_area, 2, "device gone, retry\n");
 			break;
 		case -EIO:
-			PRINT_INFO ("I/O error, retry\n"); /* FIXME: s390dbf only */
+			tape_sprintf_exception(tape_dbf_area, 2, "I/O error, retry\n");
 			break;
 		case -EBUSY:
-			PRINT_INFO ( "device busy, retry later\n"); /* FIXME: s390dbf only */
+			tape_sprintf_exception(tape_dbf_area, 2, "device busy, retry later\n");
 			break;
 		default:
 			PRINT_ERR ( "line %d unknown RC=%d, please report"
@@ -1709,9 +1748,9 @@
 
 	tape_init_devregs();
 #ifdef TAPE_DEBUG
-        tape_dbf_area = debug_register ( "tape", 2, 2, 3*sizeof(long));
+        tape_dbf_area = debug_register ( "tape", 1, 2, 3*sizeof(long));
         debug_register_view(tape_dbf_area,&debug_sprintf_view);
-        tape_sprintf_event (tape_dbf_area,3,"begin init\n");
+        tape_sprintf_event (tape_dbf_area,3,"begin init: ($Revision: 1.87 $)\n");
 #endif /* TAPE_DEBUG */
 	tape_print_banner();
 #ifndef MODULE
@@ -1720,7 +1759,6 @@
 #ifdef CONFIG_DEVFS_FS
         tape_devfs_root_entry=devfs_mk_dir (NULL, "tape", NULL);
 #endif /* CONFIG_DEVFS_FS */
-
         tape_sprintf_event (tape_dbf_area,3,"dev detect\n");
 	/* Allocate the tape structures */
         if (*tape!=NULL) { /* if parameters are present */
@@ -1766,7 +1804,7 @@
 
 #ifdef MODULE
 MODULE_AUTHOR("(C) 2001 IBM Deutschland Entwicklung GmbH by Carsten Otte and Michael Holzheu (cotte@de.ibm.com,holzheu@de.ibm.com)");
-MODULE_DESCRIPTION("Linux on zSeries channel attached tape device driver");
+MODULE_DESCRIPTION("Linux on zSeries channel attached tape device driver ($Revision: 1.87 $)");
 MODULE_PARM (tape, "1-" __MODULE_STRING (256) "s");
 
 /*
@@ -1820,7 +1858,7 @@
 	tape_cleanup_disciplines();
 #ifdef CONFIG_DEVFS_FS
 	devfs_unregister (tape_devfs_root_entry); /* devfs checks for NULL */
-#endif CONFIG_DEVFS_FS
+#endif /* CONFIG_DEVFS_FS */
 #ifdef CONFIG_PROC_FS
 	tape_proc_cleanup();
 #endif 
@@ -1879,7 +1917,7 @@
 		case MS_LOADED:
 			PRINT_INFO("(%x): Tape has been mounted\n",td->devstat.devno);
 			break;
-		default:
+		default: 
 			// print nothing
 			break;
 	}
diff -urN linux-2.5.21/drivers/s390/char/tape.h linux-2.5.21-s390/drivers/s390/char/tape.h
--- linux-2.5.21/drivers/s390/char/tape.h	Sun Jun  9 07:30:53 2002
+++ linux-2.5.21-s390/drivers/s390/char/tape.h	Tue Jun 11 18:43:32 2002
@@ -94,10 +94,12 @@
 	TO_WTM,
 	TO_MSEN,
 	TO_LOAD,
-	TO_READ_CONFIG, /* 3590 */
-	TO_READ_ATTMSG, /* 3590 */
+	TO_READ_CONFIG,
+	TO_READ_ATTMSG,
 	TO_NOTHING,
 	TO_DIS,
+	TO_ASSIGN,
+	TO_UNASSIGN,
 	TO_SIZE
 } tape_op_t;
 
@@ -142,6 +144,8 @@
 typedef int (*tape_setup_device_t) (struct _tape_dev_t*);
 typedef void (*tape_cleanup_device_t) (struct _tape_dev_t*);
 typedef int (*tape_disc_ioctl_overl_t)(struct _tape_dev_t*, unsigned int,unsigned long);
+typedef tape_ccw_req_t* (*tape_assign_dev_t)(struct _tape_dev_t*);
+typedef tape_ccw_req_t* (*tape_unassign_dev_t)(struct _tape_dev_t*);
 #ifdef CONFIG_DEVFS_FS
 typedef devfs_handle_t (*tape_devfs_constructor_t) (struct _tape_dev_t*);
 typedef void (*tape_devfs_destructor_t) (struct _tape_dev_t*);
@@ -165,17 +169,16 @@
 	tape_reqgen_ioctl_t         ioctl;
 	tape_disc_shutdown_t        shutdown;
 	tape_disc_ioctl_overl_t     discipline_ioctl_overload;
+        tape_assign_dev_t           assign;
+        tape_unassign_dev_t         unassign;
 	void*                       next;
 } tape_discipline_t  __attribute__ ((aligned(8)));
 
 /* Frontend */
 
 typedef struct _tape_frontend_t {
-	tape_setup_device_t device_setup;
-#ifdef CONFIG_DEVFS_FS
-	tape_devfs_constructor_t mkdevfstree;
-	tape_devfs_destructor_t rmdevfstree;
-#endif
+	tape_setup_device_t setup_device;
+	tape_cleanup_device_t cleanup_device;
 	void* next;
 } tape_frontend_t  __attribute__ ((aligned(8)));
 
@@ -194,6 +197,7 @@
 
 typedef struct _tape_blk_front_data_t{
 	request_queue_t request_queue;
+	spinlock_t request_queue_lock;
 	struct request* current_request;
 	int blk_retries;
 	long position;
@@ -215,6 +219,7 @@
 	struct file *filp;             /* backpointer to file structure */
 	int tape_state;                /* State of the device. See tape_stat */
 	int medium_state;              /* loaded, unloaded, unkown etc. */
+        int assigned;                  /* for reserve on open */
 	tape_discipline_t* discipline; /* The used discipline */
 	void* discdata;                /* discipline specific data */
 	tape_ccw_req_t* treq;          /* Active Tape request */
diff -urN linux-2.5.21/drivers/s390/char/tape3480.c linux-2.5.21-s390/drivers/s390/char/tape3480.c
--- linux-2.5.21/drivers/s390/char/tape3480.c	Sun Jun  9 07:27:21 2002
+++ linux-2.5.21-s390/drivers/s390/char/tape3480.c	Tue Jun 11 18:43:32 2002
@@ -18,6 +18,15 @@
 #include "tape34xx.h"
 #include "tape3480.h"
 
+#ifdef  TAPE_DEBUG
+#ifdef  MODULE
+#define TAPE_DBF (tape_dbf_3480)
+        debug_info_t *tape_dbf_3480 = NULL;
+#else
+#define TAPE_DBF (tape_dbf_area)
+#endif  /* MODULE */
+#endif  /* TAPE_DEBUG */
+
 #ifdef CONFIG_S390_TAPE_3480_MODULE
 static tape_discipline_t* disc;
 
@@ -36,14 +45,25 @@
 		tape_unregister_discipline(disc);
 		kfree(disc);
 	}
+#ifdef TAPE_DEBUG
+#ifdef MODULE
+       debug_unregister(tape_dbf_3480);
+#endif /* MODULE */
+#endif /* TAPE_DEBUG */
 }
+
+#ifdef MODULE
+MODULE_AUTHOR("(C) 2001-2002 IBM Deutschland Entwicklung GmbH");
+MODULE_DESCRIPTION("Linux on zSeries channel attached 3480 tape device driver ($Revision: 1.30 $)");
+#endif /* MODULE */
+
 #endif /* CONFIG_S390_TAPE_3480_MODULE */
 
 int
 tape3480_setup_device(tape_dev_t * td)
 {
 	tape3480_disc_data_t *data = NULL;
-	tape_sprintf_event (tape_dbf_area,6,"3480 dsetup:  %x\n",td->first_minor);
+	tape_sprintf_event (TAPE_DBF, 6, "3480 minor1: %x\n", td->first_minor);
 	data = kmalloc (sizeof (tape3480_disc_data_t), GFP_KERNEL | GFP_DMA);
 	if(data == NULL)
 		return -1;
@@ -69,10 +89,16 @@
 tape3480_init (void)
 {
 	tape_discipline_t *disc;
-	tape_sprintf_event (tape_dbf_area,3,"3480 init\n");
+#ifdef TAPE_DEBUG
+#ifdef MODULE
+        tape_dbf_3480 = debug_register("tape3480", 1, 2, 3*sizeof(long));
+        debug_register_view(tape_dbf_3480, &debug_sprintf_view);
+#endif /* MODULE */
+#endif /* TAPE_DEBUG */
+	tape_sprintf_event (TAPE_DBF,3,"3480 init: $Revision: 1.30 $\n");
 	disc = kmalloc (sizeof (tape_discipline_t), GFP_ATOMIC);
 	if (disc == NULL) {
-	        tape_sprintf_exception (tape_dbf_area,3,"disc:nomem\n");
+	        tape_sprintf_exception (TAPE_DBF,3,"disc:nomem\n");
 		return disc;
 	}
 	disc->owner = THIS_MODULE;
@@ -90,7 +116,9 @@
 	disc->bread = tape34xx_bread;
 	disc->free_bread = tape34xx_free_bread;
 	disc->bread_enable_locate = tape34xx_bread_enable_locate;
+	disc->assign = tape34xx_assign;
+	disc->unassign = tape34xx_unassign;
 	disc->next = NULL;
-	tape_sprintf_event (tape_dbf_area,3,"3480 regis\n");
+	tape_sprintf_event (TAPE_DBF,3,"3480 registered\n");
 	return disc;
 }
diff -urN linux-2.5.21/drivers/s390/char/tape3490.c linux-2.5.21-s390/drivers/s390/char/tape3490.c
--- linux-2.5.21/drivers/s390/char/tape3490.c	Sun Jun  9 07:31:25 2002
+++ linux-2.5.21-s390/drivers/s390/char/tape3490.c	Tue Jun 11 18:43:32 2002
@@ -18,6 +18,15 @@
 #include "tape34xx.h"
 #include "tape3490.h"
 
+#ifdef  TAPE_DEBUG
+#ifdef  MODULE
+#define TAPE_DBF (tape_dbf_3490)
+        debug_info_t *tape_dbf_3490 = NULL;
+#else
+#define TAPE_DBF (tape_dbf_area)
+#endif  /* MODULE */
+#endif  /* TAPE_DEBUG */
+
 #ifdef CONFIG_S390_TAPE_3490_MODULE 
 static tape_discipline_t* disc;
 
@@ -36,14 +45,25 @@
 		tape_unregister_discipline(disc);
 		kfree(disc);
 	}
+#ifdef TAPE_DEBUG
+#ifdef MODULE
+       debug_unregister(tape_dbf_3490);
+#endif /* MODULE */
+#endif /* TAPE_DEBUG */
 }
+
+#ifdef MODULE
+MODULE_AUTHOR("(C) 2001-2002 IBM Deutschland Entwicklung GmbH");
+MODULE_DESCRIPTION("Linux on zSeries channel attached 3490 tape device driver ($Revision: 1.34 $)");
+#endif /* MODULE */
+
 #endif /* CONFIG_S390_TAPE_3490_MODULE */
 
 int
 tape3490_setup_device (tape_dev_t * td)
 {
 	tape3490_disc_data_t *data = NULL;
-	tape_sprintf_event (tape_dbf_area,1,"3490 dsetup: %x\n",td->first_minor);
+	tape_sprintf_event (TAPE_DBF, 6, "3490 minor1: %x\n", td->first_minor);
 	data = kmalloc (sizeof (tape3490_disc_data_t), GFP_KERNEL | GFP_DMA);
 	if(data == NULL)
 		return -1;
@@ -70,10 +90,16 @@
 tape3490_init (void)
 {
 	tape_discipline_t *disc;
-	tape_sprintf_event (tape_dbf_area,3,"3490 init\n");
+#ifdef TAPE_DEBUG
+#ifdef MODULE
+        tape_dbf_3490 = debug_register("tape3490", 1, 2, 3*sizeof(long));
+        debug_register_view(tape_dbf_3490, &debug_sprintf_view);
+#endif /* MODULE */
+#endif /* TAPE_DEBUG */
+	tape_sprintf_event (TAPE_DBF,3,"3490 init: $Revision: 1.34 $\n");
 	disc = kmalloc (sizeof (tape_discipline_t), GFP_ATOMIC);
 	if (disc == NULL) {
-	        tape_sprintf_exception (tape_dbf_area,3,"disc:nomem\n");
+	        tape_sprintf_exception (TAPE_DBF,3,"disc:nomem\n");
 		return disc;
 	}
 	disc->owner = THIS_MODULE;
@@ -91,7 +117,9 @@
 	disc->bread = tape34xx_bread;
 	disc->free_bread = tape34xx_free_bread;
 	disc->bread_enable_locate = tape34xx_bread_enable_locate;
+	disc->assign = tape34xx_assign;
+	disc->unassign = tape34xx_unassign;
 	disc->next = NULL;
-	tape_sprintf_event (tape_dbf_area,3,"3490 regis\n");
+	tape_sprintf_event (TAPE_DBF,3,"3490 registered\n");
 	return disc;
 }
diff -urN linux-2.5.21/drivers/s390/char/tape34xx.c linux-2.5.21-s390/drivers/s390/char/tape34xx.c
--- linux-2.5.21/drivers/s390/char/tape34xx.c	Sun Jun  9 07:27:22 2002
+++ linux-2.5.21-s390/drivers/s390/char/tape34xx.c	Wed Jun 12 14:32:25 2002
@@ -21,6 +21,7 @@
 #include <linux/compatmac.h>
 #include "tape.h"
 #include "tape34xx.h"
+#include "tapeblock.h"
 #include <asm/idals.h>
 #include <asm/ebcdic.h>
 #include <asm/tape390.h>
@@ -59,6 +60,8 @@
 			tape_med_state_set(td,MS_LOADED);
 			break;
 		case TO_NOP:
+	        case TO_ASSIGN:
+	        case TO_UNASSIGN:
 			break;
 		case TO_RUN:
 			tape_med_state_set(td,MS_UNLOADED);
@@ -102,6 +105,66 @@
         }
 }
 
+/* 
+ * tape34xx_assign
+ */
+
+tape_ccw_req_t *
+tape34xx_assign (tape_dev_t* td)
+{
+        tape_ccw_req_t *treq = NULL;
+	ccw1_t *ccw = NULL;
+	int ccw_cnt = 2;
+        int ds = 11;
+        int op = TO_ASSIGN;
+
+	treq = tape_alloc_ccw_req(ccw_cnt, ds, 0, op);
+	if (!treq) {
+	        tape_sprintf_event(tape_dbf_area, 3, "T34xx: assign failed\n");
+	        goto error;
+	}
+	ccw = treq->cpaddr;
+	ccw = tape_ccw_cc(ccw, ASSIGN, ds, treq->kernbuf, 1);
+	ccw = tape_ccw_end(ccw, NOP, 0, 0, 1);
+
+	return(treq);
+
+error:
+	if (treq)
+                tape_free_ccw_req(treq);
+	return NULL;
+}
+
+/* 
+ * tape34xx_unassign
+ */
+
+tape_ccw_req_t *
+tape34xx_unassign (tape_dev_t* td)
+{
+        tape_ccw_req_t *treq = NULL;
+	ccw1_t *ccw = NULL;
+	int ccw_cnt = 2;
+        int ds = 11;
+        int op = TO_UNASSIGN;
+
+	treq = tape_alloc_ccw_req(ccw_cnt, ds, 0, op);
+	if (!treq) {
+	        tape_sprintf_event(tape_dbf_area, 3, "T34xx: unassign failed\n");
+	        goto error;
+	}
+	ccw = treq->cpaddr;
+	ccw = tape_ccw_cc(ccw, UNASSIGN, ds, treq->kernbuf, 1);
+	ccw = tape_ccw_end(ccw, NOP, 0, 0, 1);
+
+	return(treq);
+
+error:
+	if (treq)
+                tape_free_ccw_req(treq);
+	return NULL;
+}
+
 
 /*
  * tape34xx_display 
@@ -122,15 +185,15 @@
         if (rc != 0)
                 goto error;
 
-        treq=tape_alloc_ccw_req(ccw_cnt, ds, 0, op);
+        treq = tape_alloc_ccw_req(ccw_cnt, ds, 0, op);
         if (!treq)
 	        goto error;
 
         ((unsigned char *)treq->kernbuf)[0] = d_struct.cntrl;
 
         for (i = 0; i < 8; i++) {
-                ((unsigned char *)treq->kernbuf)[i+1] = d_struct.message1[i];
-                ((unsigned char *)treq->kernbuf)[i+9] = d_struct.message2[i];
+	        ((unsigned char *)treq->kernbuf)[i+1] = d_struct.message1[i];
+	        ((unsigned char *)treq->kernbuf)[i+9] = d_struct.message2[i];
         }
 
         ASCEBC (((unsigned char*)treq->kernbuf) + 1, 16);
@@ -142,7 +205,6 @@
         tape_do_io_and_wait(td,treq,TAPE_WAIT_INTERRUPTIBLE);
     
         tape_free_ccw_req(treq);
-
         return(0);
 
  error:
@@ -363,6 +425,11 @@
 		case MTCOMPRESSION:
 			if((count < 0) || (count > 1)){
 				tape_sprintf_exception (tape_dbf_area,6,"xcom parm\n");
+				if (MOD_BYTE && 0x08)
+					PRINT_INFO("(%x) Compression is currently on\n", td->devstat.devno);
+				else
+					PRINT_INFO("(%x) Compression is currently off\n", td->devstat.devno);
+				PRINT_INFO("Use 1 to switch compression on, 0 to switch it off\n");
 				goto error;
 			}
 			if(count == 0){
@@ -510,19 +577,20 @@
 	tape_ccw_req_t *treq;
 	ccw1_t *ccw;
 	__u8 *data;
-	int s2b = blksize_size[tapeblock_major][td->first_minor]/hardsect_size[tapeblock_major][td->first_minor];
-	int realcount = 0;
-	int size,bhct = 0;
-	struct buffer_head* bh;
-	for (bh = req->bh; bh; bh = bh->b_reqnext) {
-		if (bh->b_size > blksize_size[tapeblock_major][td->first_minor])
-			for (size = 0; size < bh->b_size; size += blksize_size[tapeblock_major][td->first_minor])
-				bhct++;
-		else
-			bhct++;
-	}
+	int count = 0,realcount,i;
+	unsigned off;
+	char* dst;
+	struct bio_vec *bv;
+	struct bio *bio;
+
+        rq_for_each_bio(bio, req) {
+		bio_for_each_segment(bv, bio, i) {
+			count += bv->bv_len >> (S2B + 9);
+                }
+        }
+
 	tape_sprintf_event (tape_dbf_area,6,"xBREDid:");
-	treq = tape_alloc_ccw_req (2+bhct+1, 4,0,TO_BLOCK);
+	treq = tape_alloc_ccw_req (2+count+1, 4,0,TO_BLOCK);
 	if (!treq) {
 		tape_sprintf_exception (tape_dbf_area,6,"xBREDnomem\n");
                 goto error;
@@ -531,7 +599,7 @@
 	data = treq->kernbuf;
 	data[0] = 0x01;
 	data[1] = data[2] = data[3] = 0x00;
-	realcount=req->sector/s2b;
+	realcount=req->sector >> S2B;
 	if (MOD_BYTE & 0x08)	// IDRC on
 		data[1] = data[1] | 0x80;
 	data[3] += realcount % 256;
@@ -545,21 +613,23 @@
 		ccw = tape_ccw_cc(ccw,LOCATE,4,treq->kernbuf,1);
 	else
 		ccw = tape_ccw_cc(ccw,NOP,0,0,1);
-	td->blk_data.position=realcount+req->nr_sectors/s2b;
-	for (bh=req->bh;bh!=NULL;) {
-		if (bh->b_size >= blksize_size[tapeblock_major][td->first_minor]) {
-			for (size = 0; size < bh->b_size; size += blksize_size[tapeblock_major][td->first_minor]){
+
+	td->blk_data.position=realcount + (req->nr_sectors >> S2B);
+
+	rq_for_each_bio(bio, req) {
+                bio_for_each_segment(bv, bio, i) {
+                        dst = kmap(bv->bv_page) + bv->bv_offset;
+                        for (off = 0; off < bv->bv_len; off += TAPEBLOCK_HSEC_SIZE) {
 				ccw->flags = CCW_FLAG_CC;
 				ccw->cmd_code = READ_FORWARD;
-				ccw->count = blksize_size[tapeblock_major][td->first_minor];
-				set_normalized_cda(ccw,__pa(bh->b_data+size));
-				ccw++;
-			}
-			bh = bh->b_reqnext;
-		} else {	/* group N bhs to fit into byt_per_blk */
-		    BUG();
-		}
-	}
+				ccw->count = TAPEBLOCK_HSEC_SIZE;
+				set_normalized_cda(ccw,(void*)__pa(dst));
+                                ccw++;
+                                dst += TAPEBLOCK_HSEC_SIZE;
+                        }
+                }
+        }
+
 	ccw = tape_ccw_end(ccw,NOP,0,0,1);
 	tape_sprintf_event (tape_dbf_area,6,"xBREDccwg\n");
 	return treq;
@@ -603,7 +673,7 @@
 	tape_ccw_req_t* treq = tape_get_active_ccw_req(td);
 	tape_sprintf_event (tape_dbf_area,6,"xdefhandle\n");
 	PRINT_ERR ("TAPE34XX: An unexpected Unit Check occurred.\n");
-	PRINT_ERR ("TAPE34XX: Please read Documentation/s390/TAPE and report it!\n");
+	PRINT_ERR ("TAPE34XX: Please report it to linux390@de.ibm.com.\n");
 	PRINT_ERR ("TAPE34XX: Current op is: %s",tape_op_verbose[treq->op]);
 	tape_dump_sense (td);
 	treq->rc = -EIO;
@@ -633,28 +703,30 @@
 	tape34xx_error_recovery_has_failed(td,EIO);
 	return;
     }
-    if (sense[0]&SENSE_COMMAND_REJECT)
-	switch (treq->op) {
-	case TO_DSE:
-	case TO_EGA:
-	case TO_WRI:
-	case TO_WTM:
-	    if (sense[1]&SENSE_WRITE_PROTECT) {
-		// trying to write, but medium is write protected
-		tape34xx_error_recovery_has_failed(td,EACCES);
-		return;
-	    }
-	default:
-	    tape34xx_error_recovery_HWBUG(td,1);
-	    return;
-	}
+
+    if ((sense[0]&SENSE_COMMAND_REJECT) && (td->assigned == 0))
+	  switch (treq->op) {
+	          case TO_DSE:
+	          case TO_EGA:
+	          case TO_WRI:
+	          case TO_WTM:
+		    if (sense[1]&SENSE_WRITE_PROTECT) {
+		      // trying to write, but medium is write protected
+		      tape34xx_error_recovery_has_failed(td,EACCES);
+		      return;
+		    }
+	          default:
+		    tape34xx_error_recovery_HWBUG(td,1);
+		    return;
+	  }
+
     // special cases for various tape-states when reaching end of recorded area
     if (((sense[0]==0x08) || (sense[0]==0x10) || (sense[0]==0x12)) &&
 	((sense[1]==0x40) || (sense[1]==0x0c)))
 	switch (treq->op) {
 	case TO_FSF:
 	    // Trying to seek beyond end of recorded area
-	    tape34xx_error_recovery_has_failed(td,EIO);
+	    tape34xx_error_recovery_has_failed(td,ENOSPC);
 	    return;
 	case TO_LBL:
 	    // Block could not be located.
@@ -970,7 +1042,7 @@
 	return;
     case 0x45:
 	// The drive is assigned elsewhere [to a different channel path/computer].
-	PRINT_WARN("The drive is assigned elsewhere.\n");
+        PRINT_WARN("The drive is assigned elsewhere.\n");
 	tape34xx_error_recovery_has_failed(td,EIO);
 	return;
     case 0x46:
@@ -1013,7 +1085,7 @@
       	    tape34xx_error_recovery_HWBUG(td,21);
 	    return;
 	case 0x3490:
-	    // Resetting event received. Since the driver does not support resetting event recovery
+	    // Resetting event recieved. Since the driver does not support resetting event recovery
 	    // (which has to be handled by the I/O Layer), we'll report and retry our command.
 	    tape34xx_error_recovery_do_retry(td);
 	    return;
@@ -1080,7 +1152,7 @@
 	    return;
 	case 0x3490:
 	    // Global status intercept. We have to reissue the command.
-	    PRINT_WARN("An global status intercept was received, which will be recovered.\n");
+	    PRINT_WARN("An global status intercept was recieved, which will be recovered.\n");
 	    tape34xx_error_recovery_do_retry(td);
 	    return;
 	}
@@ -1176,12 +1248,14 @@
 void 
 tape34xx_error_recovery_HWBUG (tape_dev_t* td,int condno) {
 	tape_ccw_req_t *treq = tape_get_active_ccw_req(td);
-	PRINT_WARN("An unexpected condition #%d was caught in tape error recovery.\n",condno);
-	PRINT_WARN("Please report this incident.\n");
-	if(treq)
-	PRINT_WARN("Operation of tape:%s\n", tape_op_verbose[treq->op]);
-	tape_dump_sense(td);
-	tape34xx_error_recovery_has_failed(td,EIO);
+	if (treq->op != TO_ASSIGN) {
+	        PRINT_WARN("An unexpected condition #%d was caught in tape error recovery.\n",condno);
+		PRINT_WARN("Please report this incident.\n");
+		if(treq)
+		        PRINT_WARN("Operation of tape:%s\n", tape_op_verbose[treq->op]);
+		tape_dump_sense(td);
+	}
+	  tape34xx_error_recovery_has_failed(td,EIO);
 }
 
 /*
@@ -1251,4 +1325,6 @@
 EXPORT_SYMBOL(tape34xx_free_bread);
 EXPORT_SYMBOL(tape34xx_process_eov);
 EXPORT_SYMBOL(tape34xx_bread_enable_locate);
+EXPORT_SYMBOL(tape34xx_assign);
+EXPORT_SYMBOL(tape34xx_unassign);
 
diff -urN linux-2.5.21/drivers/s390/char/tape34xx.h linux-2.5.21-s390/drivers/s390/char/tape34xx.h
--- linux-2.5.21/drivers/s390/char/tape34xx.h	Sun Jun  9 07:30:37 2002
+++ linux-2.5.21-s390/drivers/s390/char/tape34xx.h	Tue Jun 11 18:43:32 2002
@@ -113,6 +113,8 @@
 tape_ccw_req_t * tape34xx_read_block (const char *data, size_t count, tape_dev_t* td);
 tape_ccw_req_t * tape34xx_ioctl(tape_dev_t* td, int op,int count, int* rc);
 tape_ccw_req_t * tape34xx_bread (struct request *req, tape_dev_t* td,int tapeblock_major);
+tape_ccw_req_t * tape34xx_assign(tape_dev_t* td);
+tape_ccw_req_t * tape34xx_unassign(tape_dev_t* td);
 void tape34xx_free_bread (tape_ccw_req_t* treq);
 void tape34xx_bread_enable_locate (tape_ccw_req_t * treq);
 tape_ccw_req_t * tape34xx_bwrite (struct request *req, tape_dev_t* td,int tapeblock_major);
diff -urN linux-2.5.21/drivers/s390/char/tapeblock.c linux-2.5.21-s390/drivers/s390/char/tapeblock.c
--- linux-2.5.21/drivers/s390/char/tapeblock.c	Sun Jun  9 07:29:15 2002
+++ linux-2.5.21-s390/drivers/s390/char/tapeblock.c	Wed Jun 12 14:32:25 2002
@@ -18,6 +18,7 @@
 #include <linux/blk.h>
 #include <linux/version.h>
 #include <linux/interrupt.h>
+#include <linux/buffer_head.h>
 #include <asm/debug.h>
 #include <asm/s390dyn.h>
 #include <linux/compatmac.h>
@@ -79,15 +80,44 @@
 }
 #endif
 
-void 
-tapeblock_setup(tape_dev_t* td) {
-    blk_size[tapeblock_major][td->first_minor]=0; // this will be detected
-    blk_queue_hardsect_size(&ti->request_queue, 2048);
-    blk_init_queue (&td->blk_data.request_queue, tape_request_fn); 
+static int
+tapeblock_setup_device(tape_dev_t* td) {
+	int rc = 0;	
+	rc = blk_init_queue (&td->blk_data.request_queue, tape_request_fn, &td->blk_data.request_queue_lock);
+	if(rc){
+		PRINT_ERR("blk_init_queue failed\n");
+		goto out;
+	}
+
+	elevator_exit(&td->blk_data.request_queue, &td->blk_data.request_queue.elevator);
+        rc = elevator_init(&td->blk_data.request_queue,
+                           &td->blk_data.request_queue.elevator,
+                           elevator_noop);
+        if (rc) {
+		PRINT_ERR("elevator_init failed\n");
+                blk_cleanup_queue(&td->blk_data.request_queue);
+		goto out;
+        }
+	blk_queue_hardsect_size(&td->blk_data.request_queue,TAPEBLOCK_HSEC_SIZE);
+	blk_queue_max_sectors(&td->blk_data.request_queue, -1L /* 0xffff XXX*/);
+	blk_queue_max_phys_segments(&td->blk_data.request_queue, -1L);
+	blk_queue_max_hw_segments(&td->blk_data.request_queue, -1L);
+	blk_queue_max_segment_size(&td->blk_data.request_queue, -1L);
+	blk_queue_segment_boundary(&td->blk_data.request_queue, -1L);
 #ifdef CONFIG_DEVFS_FS
-    tapeblock_mkdevfstree(td);
+	if(!tapeblock_mkdevfstree(td))
+		rc = -1;
+#endif
+out:
+	set_device_ro (mk_kdev(tapeblock_major, td->first_minor), 1);
+	return rc;
+}
+
+static void
+tapeblock_cleanup_device(tape_dev_t* td) {
+#ifdef CONFIG_DEVFS_FS
+		tapeblock_rmdevfstree(td);
 #endif
-    set_device_ro (MKDEV(tapeblock_major, td->first_minor), 1);
 }
 
 int
@@ -98,34 +128,32 @@
 	tape_init();
 	/* Register the tape major number to the kernel */
 #ifdef CONFIG_DEVFS_FS
-	result = devfs_register_blkdev(tapeblock_major, "tBLK", &tapeblock_fops);
-#else
-	result = register_blkdev(tapeblock_major, "tBLK", &tapeblock_fops);
+	if(tapeblock_major == 0)
+	 	tapeblock_major = devfs_alloc_major (DEVFS_SPECIAL_BLK);
+
+// XXX	result = devfs_register_blkdev(tapeblock_major, "tBLK", &tapeblock_fops);
 #endif
+        result = register_blkdev(tapeblock_major, "tBLK", &tapeblock_fops);
+        if(tapeblock_major == 0) {
+                tapeblock_major = result;
+        }
+
 	if (result < 0) {
 		PRINT_WARN(KERN_ERR "tape: can't get major %d for block device\n", tapeblock_major);
 		result=-ENODEV;
 		goto out;
 	}
-	if (tapeblock_major == 0) tapeblock_major = result;   /* accept dynamic major number*/
 	INIT_BLK_DEV(tapeblock_major,tape_request_fn,tapeblock_getqueue,NULL);
 	PRINT_WARN(KERN_ERR " tape gets major %d for block device\n", tapeblock_major);
 	blk_size[tapeblock_major] = (int*) kmalloc (256*sizeof(int),GFP_KERNEL);
 	if (blk_size[tapeblock_major]==NULL) goto out_undo_bdev;
 	memset(blk_size[tapeblock_major],0,256*sizeof(int));
-	hardsect_size[tapeblock_major] = (int*) kmalloc (256*sizeof(int),GFP_KERNEL);
-	if (hardsect_size[tapeblock_major]==NULL) goto out_undo_blk_size;
-	memset(hardsect_size[tapeblock_major],0,256*sizeof(int));
-	max_sectors[tapeblock_major] = (int*) kmalloc (256*sizeof(int),GFP_KERNEL);
-	if (max_sectors[tapeblock_major]==NULL) goto out_undo_hardsect_size;
-	memset(max_sectors[tapeblock_major],0,256*sizeof(int));
+
 	blkfront = kmalloc(sizeof(tape_frontend_t),GFP_KERNEL);
-	if (blkfront==NULL) goto out_undo_max_sectors;
-	blkfront->device_setup=(tape_setup_device_t)tapeblock_setup;
-#ifdef CONFIG_DEVFS_FS
-	blkfront->mkdevfstree = tapeblock_mkdevfstree;
-	blkfront->rmdevfstree = tapeblock_rmdevfstree;
-#endif
+	if (blkfront==NULL) 
+		goto out_undo_size;
+	blkfront->setup_device=tapeblock_setup_device;
+	blkfront->cleanup_device=tapeblock_cleanup_device;
 	blkfront->next=NULL;
 	if (tape_first_front==NULL) {
 		tape_first_front=blkfront;
@@ -137,16 +165,12 @@
 	}
 	td=tape_first_dev;
 	while (td!=NULL) {
-		tapeblock_setup(td);
+		tapeblock_setup_device(td);
 		td=td->next;
 	}
 	result=0;
 	goto out;
-out_undo_max_sectors:
-	kfree(max_sectors[tapeblock_major]);
-out_undo_hardsect_size:
-	kfree(hardsect_size[tapeblock_major]);
-out_undo_blk_size:
+out_undo_size:
 	kfree(blk_size[tapeblock_major]);
 out_undo_bdev:
 #ifdef CONFIG_DEVFS_FS
@@ -155,9 +179,6 @@
 	unregister_blkdev(tapeblock_major, "tBLK");
 #endif
 	result=-ENOMEM;
-	blk_size[tapeblock_major]=
-	hardsect_size[tapeblock_major]=
-	max_sectors[tapeblock_major]=NULL;
 	tapeblock_major=-1;    
 out:
 	return result;
@@ -168,19 +189,8 @@
 tapeblock_uninit(void) {
 	if (tapeblock_major==-1)
 	        goto out; /* init failed so there is nothing to clean up */
-	if (blk_size[tapeblock_major]!=NULL) {
-		kfree(blk_size[tapeblock_major]);
-		blk_size[tapeblock_major]=NULL;
-	}
-	if (hardsect_size[tapeblock_major]!=NULL) {
-		kfree (hardsect_size[tapeblock_major]);
-		hardsect_size[tapeblock_major]=NULL;
-	}
-	if (max_sectors[tapeblock_major]!=NULL) {
-		kfree (max_sectors[tapeblock_major]);
-		max_sectors[tapeblock_major]=NULL;
-	}
 
+	blk_dev[tapeblock_major].queue = NULL;
 #ifdef CONFIG_DEVFS_FS
 	devfs_unregister_blkdev(tapeblock_major, "tBLK");
 #else
@@ -202,7 +212,7 @@
 
 	inode = filp->f_dentry->d_inode;
 
-	td = tape_get_device_by_minor(MINOR (inode->i_rdev));
+	td = tape_get_device_by_minor(minor (inode->i_rdev));
 	if (td == NULL){
 		rc = -ENODEV;
 		goto error;
@@ -247,11 +257,12 @@
 	long lockflags;
 	tape_dev_t *td = NULL;
 	int rc = 0;
-	if((!inode) || !(inode->i_rdev)) {
+	if((!inode) || kdev_none(inode->i_rdev) /* XXX !(inode->i_rdev) */) {
+		PRINT_ERR("no device in release\n");
 		rc = -EINVAL;
 		goto out;
 	}
-	td = tape_get_device_by_minor(MINOR (inode->i_rdev));
+	td = tape_get_device_by_minor(minor (inode->i_rdev));
 	if (td==NULL) {
 		rc = -ENODEV;
 		goto out;
@@ -261,24 +272,32 @@
 	tape_sprintf_event (tape_dbf_area,6,"b:release: %x\n",td->first_minor);
 	if(tape_state_get(td) == TS_IN_USE)
 		tape_state_set (td, TS_UNUSED);
-	else if (tape_state_get(td) != TS_NOT_OPER) 
+	else if (tape_state_get(td) == TS_UNUSED){
+		PRINT_ERR("Release on tape in unused state.\n");
+		PRINT_ERR("Perhaps tape was detached while it was mounted!\n");
+		PRINT_ERR("Detaching mounted tapes is not allowed!\n");
+		s390irq_spin_unlock_irqrestore (td->devinfo.irq, lockflags);
+		rc = -ENODEV;
+		goto out;
+	} else if (tape_state_get(td) != TS_NOT_OPER) {
 		BUG();
+	}
 	s390irq_spin_unlock_irqrestore (td->devinfo.irq, lockflags);
 	tape_put_device(td);
 	tape_put_device(td); /* 2x ! */
 	if ( td->discipline->owner )
 		__MOD_DEC_USE_COUNT(td->discipline->owner);
-	invalidate_bdev(inode->i_rdev, 0);
+	invalidate_buffers(inode->i_rdev);
 out:
 	return rc;
 }
 
 static void
 tapeblock_end_request(tape_dev_t* td) {
-    struct buffer_head *bh;
     int uptodate;
     tape_ccw_req_t *treq = tape_get_active_ccw_req(td);
     if(treq == NULL){
+	PRINT_ERR("tapeblock_end_request: no request!\n");
 	uptodate = 0;
     }
     else
@@ -288,15 +307,18 @@
     } else {
 	tape_sprintf_event (tape_dbf_area,3,"b:failed: %x\n",(unsigned long)treq);
     }
+#if 0
     // now inform ll_rw_block about a request status
     while ((bh = td->blk_data.current_request->bh) != NULL) {
 	td->blk_data.current_request->bh = bh->b_reqnext;
 	bh->b_reqnext = NULL;
 	bh->b_end_io (bh, uptodate);
     }
-    if (!end_that_request_first (td->blk_data.current_request, uptodate, "tBLK")) {
+#endif
+
+    if (!end_that_request_first (td->blk_data.current_request, uptodate, td->blk_data.current_request->hard_nr_sectors  /* XXX "tBLK" */)) {
 #ifndef DEVICE_NO_RANDOM
-	add_blkdev_randomness (MAJOR (td->blk_data.current_request->rq_dev));
+	add_blkdev_randomness (major (td->blk_data.current_request->rq_dev));
 #endif
 	end_that_request_last (td->blk_data.current_request);
     }
@@ -333,11 +355,15 @@
     if (tape_state_get (td) == TS_NOT_OPER) {
 	return;
     }
+#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,4,98))
+	if(blk_queue_empty(&td->blk_data.request_queue)) {
+#else
 #if (LINUX_VERSION_CODE > KERNEL_VERSION(2,3,98))
 	if (list_empty (&td->blk_data.request_queue.queue_head)) {
 #else
 	if (td->blk_data.request_queue==NULL) {
 #endif
+#endif
 	// nothing more to do or device has dissapeared;)
 	tape_sprintf_event (tape_dbf_area,6,"b:Qempty\n");
 	return;
@@ -347,9 +373,10 @@
     if (req==NULL) {
 	BUG(); // Yo. The queue was not reported empy, but no request found. This is _bad_.
     }
-    if (req->cmd!=READ) { // we only support reading
+    if (rq_data_dir(req) !=READ) { // we only support reading
+	PRINT_ERR("tried to write on readonly tape!\n");
 	tapeblock_end_request (td); // check state, inform user, free mem, dev=idl
-	tapeblock_schedule_exec_io(td);
+	// XXX tapeblock_schedule_exec_io(td);
 	return;
     }
     treq=td->discipline->bread(req,td,tapeblock_major); //build channel program from request
@@ -391,14 +418,12 @@
 static void
 run_tapeblock_exec_IO (tape_dev_t* td) {
     long flags_390irq,flags_ior;
-    request_queue_t *q = &tape->request_queue;
-
-    spin_lock_irqsave (&q->queue_lock, flags_ior);
+    spin_lock_irqsave (&td->blk_data.request_queue_lock, flags_ior);
     s390irq_spin_lock_irqsave(td->devinfo.irq,flags_390irq);
     atomic_set(&td->blk_data.bh_scheduled,0);
     tapeblock_exec_IO(td);
     s390irq_spin_unlock_irqrestore(td->devinfo.irq,flags_390irq);
-    spin_unlock_irqrestore (&q->queue_lock, flags_ior);
+    spin_unlock_irqrestore (&td->blk_data.request_queue_lock, flags_ior);
 }
 
 void
@@ -445,7 +470,7 @@
 #endif
 
 static request_queue_t* tapeblock_getqueue (kdev_t kdev) {
-	tape_dev_t* td=tape_get_device_by_minor(MINOR(kdev));
+	tape_dev_t* td=tape_get_device_by_minor(minor(kdev));
 	if (td!=NULL) return &td->blk_data.request_queue;
 	else return NULL;
 }
@@ -453,6 +478,7 @@
 int tapeblock_mediumdetect(tape_dev_t* td) {
 	tape_ccw_req_t *treq;
 	unsigned int nr_of_blks;
+	unsigned short max;
 	int rc;
 	PRINT_INFO("Detecting media size...\n");
 
@@ -500,5 +526,11 @@
         tape_free_ccw_req (treq);
 	if(rc)	
 		return rc;
+
+	PRINT_INFO("Found %i blocks on media\n",nr_of_blks);
+	max = nr_of_blks << S2B;
+        blk_queue_max_sectors(&td->blk_data.request_queue, max);
+
+	// blk_size[tapeblock_major][td->first_minor]=nr_of_blks*(blksize_size[tapeblock_major][td->first_minor]/1024); */
 	return 0;
 }
diff -urN linux-2.5.21/drivers/s390/char/tapeblock.h linux-2.5.21-s390/drivers/s390/char/tapeblock.h
--- linux-2.5.21/drivers/s390/char/tapeblock.h	Sun Jun  9 07:29:15 2002
+++ linux-2.5.21-s390/drivers/s390/char/tapeblock.h	Wed Jun 12 14:32:25 2002
@@ -17,14 +17,15 @@
 #define TAPEBLOCK_H
 #include <linux/config.h>
 
-#define TAPEBLOCK_READAHEAD 30
 #define TAPEBLOCK_MAJOR 0
 
 #define TAPEBLOCK_DEVFSMODE 0060644 // blkdev, rwx for user, rw for group&others
 
+#define TAPEBLOCK_HSEC_SIZE 2048
+#define S2B 2 /* bits to shift 512 to get a block (2048) */
+
 int tapeblock_open(struct inode *, struct file *);
 int tapeblock_release(struct inode *, struct file *);
-void tapeblock_setup(tape_dev_t* td);
 void tapeblock_schedule_exec_io (tape_dev_t *td);
 int tapeblock_mediumdetect(tape_dev_t* td);
 #ifdef CONFIG_DEVFS_FS
diff -urN linux-2.5.21/drivers/s390/char/tapechar.c linux-2.5.21-s390/drivers/s390/char/tapechar.c
--- linux-2.5.21/drivers/s390/char/tapechar.c	Sun Jun  9 07:29:30 2002
+++ linux-2.5.21-s390/drivers/s390/char/tapechar.c	Tue Jun 11 18:43:32 2002
@@ -106,11 +106,23 @@
  * This function is called for every new tapedevice
  */
 
-void
-tapechar_setup (tape_dev_t * td)
+
+static int
+tapechar_setup_device (tape_dev_t * td)
 {
+	int rc = 0;
+#ifdef CONFIG_DEVFS_FS
+	if(!tapechar_mkdevfstree(td))
+		rc = -1;
+#endif
+	return rc;
+	
+}
+
+static void
+tapechar_cleanup_device(tape_dev_t* td) {
 #ifdef CONFIG_DEVFS_FS
-    tapechar_mkdevfstree(td);
+	tapechar_rmdevfstree(td);
 #endif
 }
 
@@ -129,30 +141,33 @@
 
 	/* Register the tape major number to the kernel */
 #ifdef CONFIG_DEVFS_FS
-	result = devfs_register_chrdev (tapechar_major, "tape", &tape_fops);
-#else
-	result = register_chrdev (tapechar_major, "tape", &tape_fops);
+	if(tapechar_major == 0)
+		tapechar_major = devfs_alloc_major (DEVFS_SPECIAL_CHR);
+// XXX	result = devfs_register_chrdev (tapechar_major, "tape", &tape_fops);
 #endif
+        result = register_chrdev(tapechar_major, "tape", &tape_fops);
+        if(tapechar_major == 0) {
+                tapechar_major = result;
+        }
+
 	if (result < 0) {
-		PRINT_WARN (KERN_ERR "tape: can't get major %d\n", tapechar_major);
-		tape_sprintf_event (tape_dbf_area,3,"c:initfail\n");
+		PRINT_WARN (KERN_ERR "TCHAR: can't get major %d\n", tapechar_major);
+		tape_sprintf_event (tape_dbf_area, 3, "TCHAR:initfail\n");
 		goto out;
 	}
 	if (tapechar_major == 0)
 		tapechar_major = result;	/* accept dynamic major number */
-	PRINT_WARN (KERN_ERR " tape gets major %d for character device\n", result);
+	PRINT_WARN (KERN_ERR "Tape gets major %d for char device\n", tapechar_major);
+	tape_sprintf_event(tape_dbf_area, 3, "Tape gets major %d for char device\n", result);
 	charfront = kmalloc (sizeof (tape_frontend_t), GFP_KERNEL);
 	if (charfront == NULL) {
-	        PRINT_WARN (KERN_ERR "tapechar: cannot alloc memory for the frontend_t structure\n");
-                tape_sprintf_event (tape_dbf_area,3,"c:initfail no mem\n");
+	        PRINT_WARN (KERN_ERR "TCHAR: cannot alloc memory for the frontend_t structure\n");
+                tape_sprintf_event (tape_dbf_area, 3, "TCHAR:initfail no mem\n");
 		goto out;
 	}
-	charfront->device_setup = (tape_setup_device_t)tapechar_setup;
-#ifdef CONFIG_DEVFS_FS
-	charfront->mkdevfstree = tapechar_mkdevfstree;
-	charfront->rmdevfstree = tapechar_rmdevfstree;
-#endif
-        tape_sprintf_event (tape_dbf_area,3,"c:init ok\n");
+	charfront->setup_device = tapechar_setup_device;
+	charfront->cleanup_device = tapechar_cleanup_device;
+        tape_sprintf_event (tape_dbf_area, 3, "TCHAR:init ok\n");
 	charfront->next=NULL;
 	if (tape_first_front==NULL) {
 	    tape_first_front=charfront;
@@ -164,7 +179,7 @@
 	}
 	td=tape_first_dev;
 	while (td!=NULL) {
-	    tapechar_setup(td);
+	    tapechar_setup_device(td);
 	    td=td->next;
 	}
  out:
@@ -247,14 +262,14 @@
 	int rc = 0;
 	size_t cpysize;
 
-        tape_sprintf_event (tape_dbf_area,6,"c:read\n");
+        tape_sprintf_event (tape_dbf_area,6,"TCHAR:read\n");
 	td = (tape_dev_t*)filp->private_data;
 	
 	if (ppos != &filp->f_pos) {
 		/* "A request was outside the capabilities of the device." */
 		/* This check uses internal knowledge about how pread and */
 		/* read work... */
-	        tape_sprintf_event (tape_dbf_area,6,"c:ppos wrong\n");
+	        tape_sprintf_event (tape_dbf_area,6,"TCHAR:ppos wrong\n");
 		rc = -EOVERFLOW;      /* errno=75 Value too large for def. data type */
 		goto out;
 	}
@@ -263,12 +278,12 @@
 	} else {
 	        if (count < td->char_data.block_size) {
 		        rc = -EINVAL; // invalid argument+
-			tape_sprintf_event (tape_dbf_area,3,"tapechar:read smaller than block size was requested\n");
+			tape_sprintf_event (tape_dbf_area,3,"TCHAR:read smaller than block size was requested\n");
 			goto out;
 		}
 		block_size = td->char_data.block_size;
 	}
-	tape_sprintf_event (tape_dbf_area,6,"c:nbytes: %x\n",block_size);
+	tape_sprintf_event (tape_dbf_area,6,"TCHAR:nbytes: %x\n",block_size);
 	treq = td->discipline->read_block (data, block_size, td);
 	if (!treq) {
 		rc = -ENOBUFS;
@@ -284,7 +299,7 @@
 		tape_sprintf_exception (tape_dbf_area,6,"xfrb segf.\n");
 		rc = -EFAULT;
 	}
-	tape_sprintf_event (tape_dbf_area,6,"c:rbytes:  %x\n", cpysize);
+	tape_sprintf_event (tape_dbf_area,6,"TCHAR:rbytes:  %x\n", cpysize);
 	filp->f_pos += cpysize;
 out_free:
 	tape_free_ccw_req(treq);
@@ -304,14 +319,14 @@
 	tape_ccw_req_t *treq;
 	int nblocks, i = 0,rc = 0;
 	size_t written = 0;
-	tape_sprintf_event (tape_dbf_area,6,"c:write\n");
+	tape_sprintf_event (tape_dbf_area,6,"TCHAR:write\n");
 
 	td = (tape_dev_t*)filp->private_data;
 	block_size = count;
         
 	if (ppos != &filp->f_pos) {
 		/* "A request was outside the capabilities of the device." */
-	        tape_sprintf_event (tape_dbf_area,6,"c:ppos wrong\n");
+	        tape_sprintf_event (tape_dbf_area,6,"TCHAR:ppos wrong\n");
 		rc = -EOVERFLOW; /* errno=75 Value too large for def. data type */
 		goto out;
 	}
@@ -326,8 +341,8 @@
 		block_size = td->char_data.block_size;
 		nblocks = count / block_size;
 	}
-	tape_sprintf_event (tape_dbf_area,6,"c:nbytes: %x\n",block_size);
-        tape_sprintf_event (tape_dbf_area,6,"c:nblocks: %x\n",nblocks);
+	tape_sprintf_event (tape_dbf_area,6,"TCHAR:nbytes: %x\n",block_size);
+        tape_sprintf_event (tape_dbf_area,6,"TCHAR:nblocks: %x\n",nblocks);
 	for (i = 0; i < nblocks; i++) {
 		treq = td->discipline->write_block (data + i * block_size, block_size, td);
 		if (!treq) {
@@ -340,14 +355,14 @@
 		tape_free_ccw_req(treq);
 		if(rc < 0)
 			goto out;
-	        tape_sprintf_event (tape_dbf_area,6,"c:wbytes: %x\n",block_size - td->devstat.rescnt); 
+	        tape_sprintf_event (tape_dbf_area,6,"TCHAR:wbytes: %x\n",block_size - td->devstat.rescnt); 
 		filp->f_pos += block_size - td->devstat.rescnt;
 		written += block_size - td->devstat.rescnt;
 		rc = written;
 		if (td->devstat.rescnt > 0)
 			goto out;
 	}
-	tape_sprintf_event (tape_dbf_area,6,"c:wtotal: %x\n",written);
+	tape_sprintf_event (tape_dbf_area,6,"TCHAR:wtotal: %x\n",written);
 
 out:
 	if (rc==-ENOSPC){
@@ -374,9 +389,9 @@
 
 	td = (tape_dev_t*)filp->private_data; 
 
-	tape_sprintf_event (tape_dbf_area,6,"c:mtio\n");
-	tape_sprintf_event (tape_dbf_area,6,"c:ioop: %x\n",mt_op);
-	tape_sprintf_event (tape_dbf_area,6,"c:arg:  %x\n",mt_count);
+	tape_sprintf_event (tape_dbf_area,6,"TCHAR:mtio\n");
+	tape_sprintf_event (tape_dbf_area,6,"TCHAR:ioop: %x\n",mt_op);
+	tape_sprintf_event (tape_dbf_area,6,"TCHAR:arg:  %x\n",mt_count);
 
 	switch (mt_op) {
 		case MTRETEN:		// retension the tape
@@ -399,17 +414,17 @@
 			goto out;
 		case MTSETBLK:
 			td->char_data.block_size = mt_count;
-			tape_sprintf_event (tape_dbf_area,6,"c:setblk:\n");
+			tape_sprintf_event (tape_dbf_area,6,"TCHAR:setblk:\n");
 			goto out;
 		case MTRESET:
 			td->char_data.block_size = 0;
-			tape_sprintf_event (tape_dbf_area,6,"c:devreset:\n");
+			tape_sprintf_event (tape_dbf_area,6,"TCHAR:devreset:\n");
 			goto out;
 		default:
 			treq = td->discipline->ioctl (td, mt_op,mt_count,&rc);
 	}
 	if (treq == NULL) {
-	        tape_sprintf_event (tape_dbf_area,6,"c:ccwg fail\n");
+	        tape_sprintf_event (tape_dbf_area,6,"TCHAR:ccwg fail\n");
 		goto out;
 	}
 
@@ -442,7 +457,7 @@
 	        case MTBSF:		//need to skip forward over the filemark
 			return tapechar_mtioctop (filp, MTFSF, 1);
 	}
-	tape_sprintf_event (tape_dbf_area,6,"c:mtio done\n");
+	tape_sprintf_event (tape_dbf_area,6,"TCHAR:mtio done\n");
 out:
 	return rc;
 }
@@ -462,13 +477,13 @@
 	struct mtget get;
 	int rc;
 
-	tape_sprintf_event (tape_dbf_area,6,"c:ioct\n");
+	tape_sprintf_event (tape_dbf_area,6,"TCHAR:ioct\n");
 
         td = (tape_dev_t*)filp->private_data;
 
 	// check for discipline ioctl overloading
 	if ((rc = td->discipline->discipline_ioctl_overload (td, cmd, arg)) != -EINVAL) {
-		tape_sprintf_event (tape_dbf_area,6,"c:ioverloa\n");
+		tape_sprintf_event (tape_dbf_area,6,"TCHAR:ioverloa\n");
 		goto out;
 	}
 	rc = 0;
@@ -537,7 +552,7 @@
 		tape_free_ccw_req(treq);
 		goto out;
 	default:
-	        tape_sprintf_event (tape_dbf_area,3,"c:ioct inv\n");
+	        tape_sprintf_event (tape_dbf_area,3,"TCHAR:ioct inv\n");
 		rc = -EINVAL;
 		goto out;
 	}
@@ -553,47 +568,82 @@
 tapechar_open (struct inode *inode, struct file *filp)
 {
 	tape_dev_t *td = NULL;
+	tape_ccw_req_t *treq = NULL;
 	int  rc = 0;
+	int  a_rc = 0;
 	long lockflags;
 
 	MOD_INC_USE_COUNT;
 
-	tape_sprintf_event (tape_dbf_area,6,"c:open: %x\n",td->first_minor); 
+	tape_sprintf_event (tape_dbf_area,6,"TCHAR:open: %x\n",td->first_minor); 
 
 	inode = filp->f_dentry->d_inode;
 
 	td = tape_get_device_by_minor(minor (inode->i_rdev));
-	if (td == NULL){
+	if (td == NULL) {
 		rc = -ENODEV;
 		goto error;
 	}
+
+	/* assign device to the specific channel path */
+        treq = td->discipline->assign(td);
+	if (!treq) {
+	        rc = -ENOBUFS;
+		goto error;
+	}
+
+	rc = tape_do_io_and_wait(td,treq,TAPE_WAIT);
+	tape_free_ccw_req(treq);
+	if(rc < 0) {
+	        PRINT_WARN("(%04x): assign failed - device might be busy\n", td->devstat.devno);
+	        tape_sprintf_event(tape_dbf_area, 3, "(%04x): assign failed - device might be busy\n", td->devstat.devno);
+		goto error;
+	}
+	td->assigned = 1;
+	tape_sprintf_event(tape_dbf_area, 3, "(%04x): assign lpum = %02x\n", td->devstat.devno, td->devstat.lpum);
+
 	s390irq_spin_lock_irqsave(td->devinfo.irq,lockflags);
 	if (tape_state_get(td) == TS_NOT_OPER) {
-		tape_sprintf_event (tape_dbf_area,6,"c:nodev\n");
+		tape_sprintf_event (tape_dbf_area,6,"TCHAR:nodev\n");
 		rc = -ENODEV;
 		goto out;
 	}
 
-	if (tape_state_get (td) != TS_UNUSED) {
-		tape_sprintf_event (tape_dbf_area,6,"c:dbusy\n");
+	if (tape_state_get (td) == TS_IN_USE) {
+		tape_sprintf_event (tape_dbf_area,6,"TCHAR:dbusy\n");
 		rc = -EBUSY;
 		goto out;
 	}
 	if ( td->discipline->owner )
 		__MOD_INC_USE_COUNT(td->discipline->owner);
 	tape_state_set (td, TS_IN_USE);
-	td->filp = filp; /* save for later reference     */
+	td->filp = filp;            /* save for later reference */
 	filp->private_data = td;    /* save the dev.info for later reference */
 out:
 	s390irq_spin_unlock_irqrestore(td->devinfo.irq,lockflags);
+	if(rc != 0) {
+	        treq = td->discipline->unassign(td);
+		if (!treq) {
+		        rc = -ENOBUFS;
+			goto error;
+		}
+		a_rc = tape_do_io_and_wait(td,treq,TAPE_WAIT);
+		tape_free_ccw_req(treq);
+		if(a_rc < 0) {
+		        PRINT_WARN("(%04x): unassign failed\n", td->devstat.devno);
+	                tape_sprintf_event(tape_dbf_area, 3, "(%04x): unassign failed\n", td->devstat.devno);
+			goto error;
+		}
+		td->assigned = 0;
+	}
 error:
-	if(rc != 0){
+	if (rc != 0) {
 		MOD_DEC_USE_COUNT;
-		if (td!=NULL)
-			tape_put_device(td);
+	        if (td != NULL)
+		        tape_put_device(td);
+
 	}
 	return rc;
-
 }
 
 /*
@@ -608,7 +658,7 @@
 	int rc = 0;
 	long lockflags;
 
-	tape_sprintf_event (tape_dbf_area,6,"c:release: %x\n",td->first_minor);
+	tape_sprintf_event (tape_dbf_area,6,"TCHAR:release: %x\n",td->first_minor);
 
 	td = (tape_dev_t*)filp->private_data;
 
@@ -618,18 +668,37 @@
 	if (minor (inode->i_rdev) == TAPECHAR_REW_MINOR(td->first_minor)) {
 		treq = td->discipline->ioctl (td, MTREW,1,&rc);
 		if (treq != NULL) {
-		        tape_sprintf_event (tape_dbf_area,6,"c:rewrelea\n");
+		        tape_sprintf_event (tape_dbf_area,6,"TCHAR:rewrelea\n");
 			rc = tape_do_io_and_wait(td, treq, TAPE_WAIT);
 			tape_free_ccw_req (treq);
 		}
 	}
 
+	/* unassign from the channel path on release */
+	treq = td->discipline->unassign(td);
+	if (!treq) {
+	        rc = -ENOBUFS;
+		goto out;
+	}
+	rc = tape_do_io_and_wait(td,treq,TAPE_WAIT);
+	tape_free_ccw_req(treq);
+	if(rc < 0) {
+	        PRINT_WARN("(%04x): unassign failed\n", td->devstat.devno);
+		tape_sprintf_event(tape_dbf_area, 3, "(%04x): unassign failed\n", td->devstat.devno);
+		goto out;
+	}
+	tape_sprintf_event(tape_dbf_area, 3, "(%04x): unassign lpum = %02x\n", td->devstat.devno, td->devstat.lpum);
+ out:
 	s390irq_spin_lock_irqsave(td->devinfo.irq,lockflags);
+	td->assigned = 0;
+
 	if(tape_state_get(td) == TS_IN_USE)
 		tape_state_set (td, TS_UNUSED);
 	else if (tape_state_get(td) != TS_NOT_OPER) 
 		BUG();
+
 	s390irq_spin_unlock_irqrestore(td->devinfo.irq,lockflags);
+
 	if ( td->discipline->owner )
 		__MOD_DEC_USE_COUNT(td->discipline->owner);
 	tape_put_device(td);
diff -urN linux-2.5.21/drivers/s390/char/tapedefs.h linux-2.5.21-s390/drivers/s390/char/tapedefs.h
--- linux-2.5.21/drivers/s390/char/tapedefs.h	Sun Jun  9 07:27:16 2002
+++ linux-2.5.21-s390/drivers/s390/char/tapedefs.h	Tue Jun 11 18:43:32 2002
@@ -33,6 +33,9 @@
 #define CONFIG_S390_TAPE_DYNAMIC // allow devices to be attached or detached on the fly
 #define TAPEBLOCK_RETRIES 20     // number of retries, when a block-dev request fails.
 
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,4,98))
+	#define rq_data_dir(req) ((req)->cmd)
+#endif
 
 #if (LINUX_VERSION_CODE > KERNEL_VERSION(2,3,98))
 #define INIT_BLK_DEV(d_major,d_request_fn,d_queue_fn,d_current) \
@@ -40,10 +43,17 @@
         blk_dev[d_major].queue = d_queue_fn; \
 } while(0)
 static inline struct request * 
+#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,4,99))
+tape_next_request( request_queue_t *queue )
+{
+	return elv_next_request(queue);
+}
+#else
 tape_next_request( request_queue_t *queue ) 
 {
-        return elv_next_request(queue);
+        return blkdev_entry_next_request(&queue->queue_head);
 }
+#endif
 static inline void 
 tape_dequeue_request( request_queue_t * q, struct request *req )
 {
