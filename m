Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267043AbTBCT5e>; Mon, 3 Feb 2003 14:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267024AbTBCTyq>; Mon, 3 Feb 2003 14:54:46 -0500
Received: from d12lmsgate-5.de.ibm.com ([194.196.100.238]:64941 "EHLO
	d12lmsgate-5.de.ibm.com") by vger.kernel.org with ESMTP
	id <S266994AbTBCTwk> convert rfc822-to-8bit; Mon, 3 Feb 2003 14:52:40 -0500
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH, =?iso-8859-1?q?B=F6blingen?=
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 fixes (9/12).
Date: Mon, 3 Feb 2003 20:47:39 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200302032047.39245.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

update qdio driver
diff -urN linux-2.5.59/drivers/s390/cio/qdio.c linux-2.5.59-s390/drivers/s390/cio/qdio.c
--- linux-2.5.59/drivers/s390/cio/qdio.c	Fri Jan 17 03:22:19 2003
+++ linux-2.5.59-s390/drivers/s390/cio/qdio.c	Mon Feb  3 20:50:01 2003
@@ -55,7 +55,7 @@
 #include "qdio.h"
 #include "ioasm.h"
 
-#define VERSION_QDIO_C "$Revision: 1.18 $"
+#define VERSION_QDIO_C "$Revision: 1.23 $"
 
 /****************** MODULE PARAMETER VARIABLES ********************/
 MODULE_AUTHOR("Utz Bacher <utz.bacher@de.ibm.com>");
@@ -752,7 +752,7 @@
 #endif /* QDIO_DBF_LIKE_HELL */
 
 	if (q->state==QDIO_IRQ_STATE_ACTIVE)
-		q->handler(q->irq,
+		q->handler(q->cdev,
 			   QDIO_STATUS_INBOUND_INT|q->error_status_flags,
 			   q->qdio_error,q->siga_error,q->q_no,start,count,
 			   q->int_parm);
@@ -1039,7 +1039,7 @@
 #endif /* QDIO_DBF_LIKE_HELL */
 
 	if (q->state==QDIO_IRQ_STATE_ACTIVE)
-		q->handler(q->irq,QDIO_STATUS_OUTBOUND_INT|
+		q->handler(q->cdev,QDIO_STATUS_OUTBOUND_INT|
 			   q->error_status_flags,
 			   q->qdio_error,q->siga_error,q->q_no,start,count,
 			   q->int_parm);
@@ -1283,7 +1283,8 @@
 }
 
 static int
-qdio_alloc_qs(struct qdio_irq *irq_ptr, int no_input_qs, int no_output_qs,
+qdio_alloc_qs(struct qdio_irq *irq_ptr, struct ccw_device *cdev,
+	      int no_input_qs, int no_output_qs,
 	      qdio_handler_t *input_handler,
 	      qdio_handler_t *output_handler,
 	      unsigned long int_parm,int q_format,
@@ -1327,6 +1328,7 @@
 		q->int_parm=int_parm;
 		irq_ptr->input_qs[i]=q;
 		q->irq=irq_ptr->irq;
+		q->cdev = cdev;
 		q->mask=1<<(31-i);
 		q->q_no=i;
 		q->is_input_q=1;
@@ -1403,6 +1405,7 @@
 		irq_ptr->output_qs[i]=q;
 		q->is_input_q=0;
 		q->irq=irq_ptr->irq;
+		q->cdev = cdev;
 		q->mask=1<<(31-i);
 		q->q_no=i;
 		q->first_to_check=0;
@@ -1626,7 +1629,7 @@
 				       "device %s!?\n", cdev->dev.bus_id);
 			goto omit_handler_call;
 		}
-		q->handler(q->irq,QDIO_STATUS_ACTIVATE_CHECK_CONDITION|
+		q->handler(q->cdev,QDIO_STATUS_ACTIVATE_CHECK_CONDITION|
 			   QDIO_STATUS_LOOK_FOR_ERROR,
 			   0,0,0,-1,-1,q->int_parm);
 	omit_handler_call:
@@ -1882,6 +1885,27 @@
 qdio_cleanup(struct ccw_device *cdev, int how)
 {
 	struct qdio_irq *irq_ptr;
+	char dbf_text[15];
+	int rc;
+
+	irq_ptr = cdev->private->qdio_data;
+	if (!irq_ptr)
+		return -ENODEV;
+
+	sprintf(dbf_text,"qcln%4x",irq_ptr->irq);
+	QDIO_DBF_TEXT1(0,trace,dbf_text);
+	QDIO_DBF_TEXT0(0,setup,dbf_text);
+
+	rc = qdio_shutdown(cdev, how);
+	if (rc == 0)
+		rc = qdio_free(cdev);
+	return rc;
+}
+
+int
+qdio_shutdown(struct ccw_device *cdev, int how)
+{
+	struct qdio_irq *irq_ptr;
 	int i,result;
 	unsigned long flags;
 	int timeout;
@@ -1891,7 +1915,7 @@
 	if (!irq_ptr)
 		return -ENODEV;
 
-	sprintf(dbf_text,"qcln%4x",irq_ptr->irq);
+	sprintf(dbf_text,"qsqs%4x",irq_ptr->irq);
 	QDIO_DBF_TEXT1(0,trace,dbf_text);
 	QDIO_DBF_TEXT0(0,setup,dbf_text);
 
@@ -1923,6 +1947,9 @@
 			result=-EINPROGRESS;
 	}
 
+	if (result)
+		return result;
+
 	/* cleanup subchannel */
 	spin_lock_irqsave(get_ccwdev_lock(cdev),flags);
 	if (how&QDIO_FLAG_CLEANUP_USING_CLEAR) {
@@ -1955,6 +1982,29 @@
 	qdio_set_state(irq_ptr,QDIO_IRQ_STATE_INACTIVE);
 }
 
+int
+qdio_free(struct ccw_device *cdev)
+{
+	struct qdio_irq *irq_ptr;
+	char dbf_text[15];
+
+	irq_ptr = cdev->private->qdio_data;
+	if (!irq_ptr)
+		return -ENODEV;
+
+	sprintf(dbf_text,"qfqs%4x",irq_ptr->irq);
+	QDIO_DBF_TEXT1(0,trace,dbf_text);
+	QDIO_DBF_TEXT0(0,setup,dbf_text);
+
+	if (cdev->private->state != DEV_STATE_ONLINE)
+		return -EINVAL;
+
+	qdio_cleanup_finish(irq_ptr);
+	cdev->private->qdio_data = 0;
+	qdio_release_irq_memory(irq_ptr);
+	return 0;
+}
+
 static void
 qdio_cleanup_handle_timeout(struct ccw_device *cdev)
 {
@@ -1967,14 +2017,10 @@
 	QDIO_PRINT_INFO("Did not get interrupt on cleanup, irq=0x%x.\n",
 			irq_ptr->irq);
 
-	qdio_cleanup_finish(irq_ptr);
-
 	spin_unlock_irqrestore(get_ccwdev_lock(cdev),flags);
 
 	spin_unlock(&irq_ptr->setting_up_lock);
 
-	cdev->private->qdio_data = 0;
-	qdio_release_irq_memory(irq_ptr);
 	cdev->private->state = DEV_STATE_ONLINE;
 	wake_up(&cdev->private->wait_q);
 }
@@ -1984,10 +2030,6 @@
 			struct irb *irb)
 {
 	struct qdio_irq *irq_ptr;
-	int cstat,dstat;
-
-	cstat = irb->scsw.cstat;
-        dstat = irb->scsw.dstat;
 
 	if (intparm == 0)
 		QDIO_PRINT_WARN("Got unsolicited interrupt on cleanup "
@@ -1997,22 +2039,18 @@
 
 	qdio_irq_check_sense(irq_ptr->irq, irb);
 
-	qdio_cleanup_finish(irq_ptr);
-
 	spin_unlock(&irq_ptr->setting_up_lock);
 
-	cdev->private->qdio_data = 0;
-	qdio_release_irq_memory(irq_ptr);
 	cdev->private->state = DEV_STATE_ONLINE;
 	wake_up(&cdev->private->wait_q);
 }
 
 static inline void
-qdio_initialize_do_dbf(struct qdio_initialize *init_data)
+qdio_allocate_do_dbf(struct qdio_initialize *init_data)
 {
 	char dbf_text[20]; /* if a printf would print out more than 8 chars */
 
-	sprintf(dbf_text,"qini%4x",init_data->cdev->private->irq);
+	sprintf(dbf_text,"qalc%4x",init_data->cdev->private->irq);
 	QDIO_DBF_TEXT0(0,setup,dbf_text);
 	QDIO_DBF_TEXT0(0,trace,dbf_text);
 	sprintf(dbf_text,"qfmt:%x",init_data->q_format);
@@ -2045,7 +2083,7 @@
 }
 
 static inline void
-qdio_initialize_fill_input_desc(struct qdio_irq *irq_ptr, int i, int iqfmt)
+qdio_allocate_fill_input_desc(struct qdio_irq *irq_ptr, int i, int iqfmt)
 {
 	irq_ptr->input_qs[i]->is_iqdio_q = iqfmt;
 
@@ -2063,8 +2101,8 @@
 }
 
 static inline void
-qdio_initialize_fill_output_desc(struct qdio_irq *irq_ptr, int i, 
-				 int j, int iqfmt)
+qdio_allocate_fill_output_desc(struct qdio_irq *irq_ptr, int i,
+			       int j, int iqfmt)
 {
 	irq_ptr->output_qs[i]->is_iqdio_q = iqfmt;
 
@@ -2093,7 +2131,7 @@
 		       irq_ptr->irq);
 	QDIO_DBF_TEXT2(1,setup,"eq:timeo");
 	spin_unlock(&irq_ptr->setting_up_lock);
-	qdio_cleanup(cdev,QDIO_FLAG_CLEANUP_USING_CLEAR);
+	qdio_shutdown(cdev,QDIO_FLAG_CLEANUP_USING_CLEAR);
 
 	up(&init_sema);
 }
@@ -2164,7 +2202,7 @@
 			       "device end: dstat=%02x, cstat=%02x\n",
 			       irq_ptr->irq, dstat, cstat);
 		spin_unlock(&irq_ptr->setting_up_lock);
-		qdio_cleanup(cdev,QDIO_FLAG_CLEANUP_USING_CLEAR);
+		qdio_shutdown(cdev,QDIO_FLAG_CLEANUP_USING_CLEAR);
 		up(&init_sema);
 		return 1;
 	}
@@ -2243,13 +2281,32 @@
 int
 qdio_initialize(struct qdio_initialize *init_data)
 {
+	int rc;
+	char dbf_text[15];
+
+	sprintf(dbf_text,"qini%4x",init_data->cdev->private->irq);
+	QDIO_DBF_TEXT0(0,setup,dbf_text);
+	QDIO_DBF_TEXT0(0,trace,dbf_text);
+
+	rc = qdio_allocate(init_data);
+	if (rc == 0) {
+		rc = qdio_establish(init_data->cdev);
+		if (rc != 0)
+			qdio_free(init_data->cdev);
+	}
+
+	return rc;
+}
+
+
+int
+qdio_allocate(struct qdio_initialize *init_data)
+{
 	int i;
-	unsigned long saveflags;
 	struct qdio_irq *irq_ptr;
 	struct ciw *ciw;
-	int result,result2;
+	int result;
 	int is_iqdio;
-	char dbf_text[20]; /* if a printf would print out more than 8 chars */
 
 	down_interruptible(&init_sema);
 
@@ -2270,7 +2327,7 @@
 		goto out;
 	}
 
-	qdio_initialize_do_dbf(init_data);
+	qdio_allocate_do_dbf(init_data);
 
 	/* create irq */
 	irq_ptr=kmalloc(sizeof(struct qdio_irq),GFP_DMA);
@@ -2325,7 +2382,8 @@
 	irq_ptr->aqueue.cmd=DEFAULT_ACTIVATE_QS_CMD;
 	irq_ptr->aqueue.count=DEFAULT_ACTIVATE_QS_COUNT;
 
-	if (!qdio_alloc_qs(irq_ptr,init_data->no_input_qs,
+	if (!qdio_alloc_qs(irq_ptr, init_data->cdev,
+			   init_data->no_input_qs,
 			   init_data->no_output_qs,
 			   init_data->input_handler,
 			   init_data->output_handler,init_data->int_parm,
@@ -2383,12 +2441,12 @@
 	/* first input descriptors, then output descriptors */
 	is_iqdio = (init_data->q_format == QDIO_IQDIO_QFMT) ? 1 : 0;
 	for (i=0;i<init_data->no_input_qs;i++)
-		qdio_initialize_fill_input_desc(irq_ptr, i, is_iqdio);
+		qdio_allocate_fill_input_desc(irq_ptr, i, is_iqdio);
 
 	for (i=0;i<init_data->no_output_qs;i++)
-		qdio_initialize_fill_output_desc(irq_ptr, i,
-						 init_data->no_input_qs,
-						 is_iqdio);
+		qdio_allocate_fill_output_desc(irq_ptr, i,
+					       init_data->no_input_qs,
+					       is_iqdio);
 
 	/* qdr, qib, sls, slsbs, slibs, sbales filled. */
 
@@ -2423,7 +2481,8 @@
 			goto out2;
 		}
 		iqdio_set_delay_target(irq_ptr,IQDIO_DELAY_TARGET);
-	}
+	} else
+		result = 0;
 
 	/* Set callback functions. */
 	irq_ptr->cleanup_irq = qdio_cleanup_handle_irq;
@@ -2431,6 +2490,36 @@
 	irq_ptr->establish_irq = qdio_establish_handle_irq;
 	irq_ptr->establish_timeout = qdio_establish_handle_timeout;
 	irq_ptr->handler = qdio_handler;
+	
+out:
+	if (irq_ptr)
+		spin_unlock(&irq_ptr->setting_up_lock);
+out2:
+	up(&init_sema);
+
+	return result;
+}
+
+int
+qdio_establish(struct ccw_device *cdev)
+{
+	struct qdio_irq *irq_ptr;
+	unsigned long saveflags;
+	int result, result2;
+	char dbf_text[20];
+
+	irq_ptr = cdev->private->qdio_data;
+	if (!irq_ptr)
+		return -EINVAL;
+
+	if (cdev->private->state != DEV_STATE_ONLINE)
+		return -EINVAL;
+	
+	spin_lock(&irq_ptr->setting_up_lock);
+
+	sprintf(dbf_text,"qest%4x",cdev->private->irq);
+	QDIO_DBF_TEXT0(0,setup,dbf_text);
+	QDIO_DBF_TEXT0(0,trace,dbf_text);
 
 	/* establish q */
 	irq_ptr->ccw.cmd_code=irq_ptr->equeue.cmd;
@@ -2438,14 +2527,14 @@
 	irq_ptr->ccw.count=irq_ptr->equeue.count;
 	irq_ptr->ccw.cda=QDIO_GET_ADDR(irq_ptr->qdr);
 
-	spin_lock_irqsave(get_ccwdev_lock(init_data->cdev),saveflags);
+	spin_lock_irqsave(get_ccwdev_lock(cdev),saveflags);
 
-	ccw_device_set_timeout(init_data->cdev, QDIO_ESTABLISH_TIMEOUT);
-	ccw_device_set_options(init_data->cdev, 0);
-	result=ccw_device_start(init_data->cdev,&irq_ptr->ccw,
+	ccw_device_set_timeout(cdev, QDIO_ESTABLISH_TIMEOUT);
+	ccw_device_set_options(cdev, 0);
+	result=ccw_device_start(cdev,&irq_ptr->ccw,
 				QDIO_DOING_ESTABLISH,0,0);
 	if (result) {
-		result2=ccw_device_start(init_data->cdev,&irq_ptr->ccw,
+		result2=ccw_device_start(cdev,&irq_ptr->ccw,
 					 QDIO_DOING_ESTABLISH,0,0);
 		sprintf(dbf_text,"eq:io%4x",result);
 		QDIO_DBF_TEXT2(1,setup,dbf_text);
@@ -2459,28 +2548,26 @@
 		result=result2;
 	}
 	if (result == 0)
-		init_data->cdev->private->state = DEV_STATE_QDIO_INIT;
-	spin_unlock_irqrestore(get_ccwdev_lock(init_data->cdev),saveflags);
+		cdev->private->state = DEV_STATE_QDIO_INIT;
+	spin_unlock_irqrestore(get_ccwdev_lock(cdev),saveflags);
 
 	if (result) {
 		spin_unlock(&irq_ptr->setting_up_lock);
-		qdio_cleanup(init_data->cdev,QDIO_FLAG_CLEANUP_USING_CLEAR);
-		goto out2;
+		qdio_shutdown(cdev,QDIO_FLAG_CLEANUP_USING_CLEAR);
+		goto out;
 	}
 	
-	wait_event(init_data->cdev->private->wait_q,
-		   dev_fsm_final_state(init_data->cdev) ||
+	wait_event(cdev->private->wait_q,
+		   dev_fsm_final_state(cdev) ||
 		   (irq_ptr->state == QDIO_IRQ_STATE_ESTABLISHED));
 
-	if (init_data->cdev->private->state == DEV_STATE_QDIO_INIT)
-		return 0;
+	if (cdev->private->state == DEV_STATE_QDIO_INIT)
+		result = 0;
+	else 
+		result = -EIO;
 
-	result = -EIO;
- out:
-	if (irq_ptr)
-		spin_unlock(&irq_ptr->setting_up_lock);
- out2:
-	up(&init_sema);
+out:
+	spin_unlock(&irq_ptr->setting_up_lock);
 
 	return result;
 	
@@ -2564,6 +2651,8 @@
 		}
 	}
 
+	qdio_wait_nonbusy(QDIO_ACTIVATE_DELAY);
+
 	qdio_set_state(irq_ptr,QDIO_IRQ_STATE_ACTIVE);
 
  out:
@@ -3051,8 +3140,12 @@
 module_init(init_QDIO);
 module_exit(cleanup_QDIO);
 
+EXPORT_SYMBOL(qdio_allocate);
+EXPORT_SYMBOL(qdio_establish);
 EXPORT_SYMBOL(qdio_initialize);
 EXPORT_SYMBOL(qdio_activate);
 EXPORT_SYMBOL(do_QDIO);
+EXPORT_SYMBOL(qdio_shutdown);
+EXPORT_SYMBOL(qdio_free);
 EXPORT_SYMBOL(qdio_cleanup);
 EXPORT_SYMBOL(qdio_synchronize);
diff -urN linux-2.5.59/drivers/s390/cio/qdio.h linux-2.5.59-s390/drivers/s390/cio/qdio.h
--- linux-2.5.59/drivers/s390/cio/qdio.h	Fri Jan 17 03:21:44 2003
+++ linux-2.5.59-s390/drivers/s390/cio/qdio.h	Mon Feb  3 20:50:01 2003
@@ -1,7 +1,7 @@
 #ifndef _CIO_QDIO_H
 #define _CIO_QDIO_H
 
-#define VERSION_CIO_QDIO_H "$Revision: 1.8 $"
+#define VERSION_CIO_QDIO_H "$Revision: 1.10 $"
 
 //#define QDIO_DBF_LIKE_HELL
 
@@ -48,6 +48,10 @@
 #define QDIO_STATS_CLASSES 2
 #define QDIO_STATS_COUNT_NEEDED 2*/
 
+#define QDIO_ACTIVATE_DELAY 5 /* according to brenton belmar and paul
+				 gioquindo it can take up to 5ms before
+				 queues are really active */
+
 #define QDIO_NO_USE_COUNT_TIME 10
 #define QDIO_NO_USE_COUNT_TIMEOUT 1000 /* wait for 1 sec on each q before
 					  exiting without having use_count
@@ -579,6 +583,7 @@
 
 	int is_input_q;
 	int irq;
+	struct ccw_device *cdev;
 
 	unsigned int is_iqdio_q;
 
diff -urN linux-2.5.59/include/asm-s390/qdio.h linux-2.5.59-s390/include/asm-s390/qdio.h
--- linux-2.5.59/include/asm-s390/qdio.h	Fri Jan 17 03:21:42 2003
+++ linux-2.5.59-s390/include/asm-s390/qdio.h	Mon Feb  3 20:50:01 2003
@@ -50,11 +50,11 @@
 } __attribute__ ((packed,aligned(256)));
 
 
-/* params are: irq, status, qdio_error, siga_error,
+/* params are: ccw_device, status, qdio_error, siga_error,
    queue_number, first element processed, number of elements processed,
    int_parm */
-typedef void qdio_handler_t(int,unsigned int,unsigned int,unsigned int,
-			    unsigned int,int,int,unsigned long);
+typedef void qdio_handler_t(struct ccw_device *,unsigned int,unsigned int,
+			    unsigned int,unsigned int,int,int,unsigned long);
 
 
 #define QDIO_STATUS_INBOUND_INT 0x01
@@ -100,6 +100,8 @@
 	void **output_sbal_addr_array; /* addr of n*128 void ptrs */
 };
 extern int qdio_initialize(struct qdio_initialize *init_data);
+extern int qdio_allocate(struct qdio_initialize *init_data);
+extern int qdio_establish(struct ccw_device *);
 
 extern int qdio_activate(struct ccw_device *,int flags);
 
@@ -127,6 +129,8 @@
 			    unsigned int queue_number);
 
 extern int qdio_cleanup(struct ccw_device*, int how);
+extern int qdio_shutdown(struct ccw_device*, int how);
+extern int qdio_free(struct ccw_device*);
 
 unsigned char qdio_get_slsb_state(struct ccw_device*, unsigned int flag,
 				  unsigned int queue_number,
diff -urN linux-2.5.59/include/asm-s390x/qdio.h linux-2.5.59-s390/include/asm-s390x/qdio.h
--- linux-2.5.59/include/asm-s390x/qdio.h	Fri Jan 17 03:22:09 2003
+++ linux-2.5.59-s390/include/asm-s390x/qdio.h	Mon Feb  3 20:50:01 2003
@@ -50,11 +50,11 @@
 } __attribute__ ((packed,aligned(256)));
 
 
-/* params are: irq, status, qdio_error, siga_error,
+/* params are: ccw_device, status, qdio_error, siga_error,
    queue_number, first element processed, number of elements processed,
    int_parm */
-typedef void qdio_handler_t(int,unsigned int,unsigned int,unsigned int,
-			    unsigned int,int,int,unsigned long);
+typedef void qdio_handler_t(struct ccw_device *,unsigned int,unsigned int,
+			    unsigned int,unsigned int,int,int,unsigned long);
 
 
 #define QDIO_STATUS_INBOUND_INT 0x01
@@ -100,6 +100,8 @@
 	void **output_sbal_addr_array; /* addr of n*128 void ptrs */
 };
 extern int qdio_initialize(struct qdio_initialize *init_data);
+extern int qdio_allocate(struct qdio_initialize *init_data);
+extern int qdio_establish(struct ccw_device *);
 
 extern int qdio_activate(struct ccw_device *,int flags);
 
@@ -127,6 +129,8 @@
 			    unsigned int queue_number);
 
 extern int qdio_cleanup(struct ccw_device*, int how);
+extern int qdio_shutdown(struct ccw_device*, int how);
+extern int qdio_free(struct ccw_device*);
 
 unsigned char qdio_get_slsb_state(struct ccw_device*, unsigned int flag,
 				  unsigned int queue_number,

