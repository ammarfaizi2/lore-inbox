Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129625AbRBMCOl>; Mon, 12 Feb 2001 21:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129578AbRBMCOc>; Mon, 12 Feb 2001 21:14:32 -0500
Received: from adsl-64-109-89-110.chicago.il.ameritech.net ([64.109.89.110]:36174
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S129204AbRBMCOP>; Mon, 12 Feb 2001 21:14:15 -0500
Message-Id: <200102130214.UAA03431@localhost.localdomain>
X-Mailer: exmh version 2.1.1 10/15/1999
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.1 SCSI reservation/reset handling
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-6111894560"
Date: Mon, 12 Feb 2001 20:14:01 -0600
From: James Bottomley <James.Bottomley@SteelEye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_-6111894560
Content-Type: text/plain; charset=us-ascii

The attached patch corrects the linux kernel reservation handling.  Currently 
linux fails badly when presented with SCSI reservations in a clustered 
environment.  The patch also completes Doug Gilbert's reset injection system 
in the sg driver.  The patches have no effect on the main line SCSI code, but 
they are fairly essential to those of us working in clustering and using 
reservations for I/O fencing.

I've run the patch through a 12 hour stress test in a two node cluster using 
the sym53c875 and aic7xxx (AHA 2944/UW) SCSI cards.

James Bottomley


--==_Exmh_-6111894560
Content-Type: text/plain ; name="scsi_reset_2_4_1.diff"; charset=us-ascii
Content-Description: scsi_reset_2_4_1.diff
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="scsi_reset_2_4_1.diff"

Index: linux/drivers/scsi/scsi.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/cvs/CVSROOT/linux/2.4/drivers/scsi/scsi.c,v
retrieving revision 1.1.1.4
retrieving revision 1.1.1.4.6.4
diff -u -r1.1.1.4 -r1.1.1.4.6.4
--- linux/drivers/scsi/scsi.c	2000/11/30 17:19:15	1.1.1.4
+++ linux/drivers/scsi/scsi.c	2001/02/12 04:58:05	1.1.1.4.6.4
@@ -146,7 +146,12 @@
  */
 extern void scsi_old_done(Scsi_Cmnd * SCpnt);
 extern void scsi_old_times_out(Scsi_Cmnd * SCpnt);
+extern int scsi_old_reset(Scsi_Cmnd *SCpnt, unsigned int flag);
 =

+/* =

+ * private interface into the new error handling code
+ */
+extern int scsi_new_reset(Scsi_Cmnd *SCpnt, unsigned int flag);
 =

 /*
  * Function:    scsi_initialize_queue()
@@ -2657,6 +2662,67 @@
          */
 	scsi_release_commandblocks(SDpnt);
         kfree(SDpnt);
+}
+
+/* Dummy done routine.  We don't want the bogus command used for the
+ * bus/device reset to find its way into the mid-layer so we intercept
+ * it here */
+static void
+scsi_reset_provider_done_command(Scsi_Cmnd *SCpnt) {
+        /* Empty function.  Some low level drivers will call scsi_done
+         * (and end up here), others won't bother */
+}
+
+
+/*
+ * Function:	scsi_reset_provider
+ *
+ * Purpose:	Send requested reset to a bus or device at any phase.
+ *
+ * Arguments:	device	- device to send reset to
+ *		flag - reset type (see scsi.h)
+ *
+ * Returns:	SUCCESS/FAILURE.
+ *
+ * Notes:	This is used by the SCSI Generic driver to provide
+ *		Bus/Device reset capability.
+ */
+int
+scsi_reset_provider(Scsi_Device *dev, int flag)
+{
+        int rtn;
+        Scsi_Cmnd *SCpnt;
+
+        /* get a dummy command to issue the reset to */
+        SCpnt =3D scsi_allocate_device(dev, 1, 1);
+        /* NULL indicates interrupt */
+        if(SCpnt =3D=3D NULL)
+                return -EINTR;
+
+        /* initialise the command */
+        memset(&SCpnt->cmnd, '\0', sizeof(SCpnt->cmnd));
+
+        SCpnt->channel =3D dev->channel;
+        SCpnt->lun =3D dev->lun;
+        SCpnt->target =3D dev->id;
+        SCpnt->owner =3D SCSI_OWNER_MIDLEVEL;
+        SCpnt->scsi_done =3D scsi_reset_provider_done_command;
+        SCpnt->done =3D NULL;
+        SCpnt->reset_chain =3D NULL;
+
+        SCpnt->internal_timeout =3D NORMAL_TIMEOUT;
+        SCpnt->abort_reason =3D DID_ABORT;
+        =

+        if(dev->host->hostt->use_new_eh_code) {
+                rtn =3D scsi_new_reset(SCpnt, flag);
+        } else {
+                rtn =3D scsi_old_reset(SCpnt, flag);
+        }
+        if(timer_pending(&SCpnt->eh_timeout))
+                scsi_delete_timer(SCpnt);
+        scsi_release_command(SCpnt);
+
+        return rtn;
 }
 =

 /*
Index: linux/drivers/scsi/scsi.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/cvs/CVSROOT/linux/2.4/drivers/scsi/scsi.h,v
retrieving revision 1.1.1.3
diff -u -r1.1.1.3 scsi.h
--- linux/drivers/scsi/scsi.h	2001/01/11 16:39:27	1.1.1.3
+++ linux/drivers/scsi/scsi.h	2001/02/12 17:58:41
@@ -842,6 +842,14 @@
 	remove_wait_queue(QUEUE, &wait);\
 	current->state =3D TASK_RUNNING;	\
     }; }
+/* reset request from external source (private to sg.c, scsi.c
+ * scsi_error.c and scsi_obsolete.c)
+ * */
+#define SCSI_TRY_RESET_DEVICE	1
+#define SCSI_TRY_RESET_BUS	2
+#define SCSI_TRY_RESET_HOST	3
+
+extern int scsi_reset_provider(Scsi_Device *, int);
 =

 #endif
 =

Index: linux/drivers/scsi/scsi_error.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/cvs/CVSROOT/linux/2.4/drivers/scsi/scsi_error.c,v
retrieving revision 1.1.1.2
retrieving revision 1.1.1.2.6.1
diff -u -r1.1.1.2 -r1.1.1.2.6.1
--- linux/drivers/scsi/scsi_error.c	2000/09/30 17:38:23	1.1.1.2
+++ linux/drivers/scsi/scsi_error.c	2001/02/11 17:33:42	1.1.1.2.6.1
@@ -996,9 +996,17 @@
 	case DID_SOFT_ERROR:
 		goto maybe_retry;
 =

+        case DID_ERROR:
+                if(msg_byte(SCpnt->result) =3D=3D COMMAND_COMPLETE =

+                   && status_byte(SCpnt->result) =3D=3D RESERVATION_CONF=
LICT)
+                        /* execute reservation conflict processing
+                           code lower down */
+                        break;
+                /* fall through */
+
+
 	case DID_BUS_BUSY:
 	case DID_PARITY:
-	case DID_ERROR:
 		goto maybe_retry;
 	case DID_TIME_OUT:
 		/*
@@ -1065,8 +1073,12 @@
 		 */
 		return SUCCESS;
 	case BUSY:
-	case RESERVATION_CONFLICT:
-		goto maybe_retry;
+
+        case RESERVATION_CONFLICT:
+                printk("scsi%d (%d,%d,%d) : RESERVATION CONFLICT\n", =

+                       SCpnt->host->host_no, SCpnt->channel,
+                       SCpnt->device->id, SCpnt->device->lun);
+                return SUCCESS;          /* causes immediate I/O error *=
/
 	default:
 		return FAILED;
 	}
@@ -1959,6 +1971,44 @@
 	 */
 	if (host->eh_notify !=3D NULL)
 		up(host->eh_notify);
+}
+
+/*
+ * Function:	scsi_new_reset
+ *
+ * Purpose:	Send requested reset to a bus or device at any phase.
+ *
+ * Arguments:	SCpnt	- command ptr to send reset with (usually a dummy)
+ *		flag - reset type (see scsi.h)
+ *
+ * Returns:	SUCCESS/FAILURE.
+ *
+ * Notes:	This is used by the SCSI Generic driver to provide
+ *		Bus/Device reset capability.
+ */
+int
+scsi_new_reset(Scsi_Cmnd *SCpnt, int flag)
+{
+        int rtn;
+
+        switch(flag) {
+        case SCSI_TRY_RESET_DEVICE:
+                rtn =3D scsi_try_bus_device_reset(SCpnt, 0);
+                if(rtn =3D=3D SUCCESS)
+                        break;
+                /* fall through */
+        case SCSI_TRY_RESET_BUS:
+                rtn =3D scsi_try_bus_reset(SCpnt);
+                if(rtn =3D=3D SUCCESS)
+                        break;
+                /* fall through */
+        case SCSI_TRY_RESET_HOST:
+                rtn =3D scsi_try_host_reset(SCpnt);
+                break;
+        default:
+                rtn =3D FAILED;
+        }
+        return rtn;
 }
 =

 /*
Index: linux/drivers/scsi/scsi_obsolete.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/cvs/CVSROOT/linux/2.4/drivers/scsi/scsi_obsolete.c,v
retrieving revision 1.1.1.2
retrieving revision 1.1.1.2.6.1
diff -u -r1.1.1.2 -r1.1.1.2.6.1
--- linux/drivers/scsi/scsi_obsolete.c	2000/11/30 17:19:23	1.1.1.2
+++ linux/drivers/scsi/scsi_obsolete.c	2001/02/11 17:33:42	1.1.1.2.6.1
@@ -502,11 +502,17 @@
 					break;
 =

 				case RESERVATION_CONFLICT:
-					printk("scsi%d, channel %d : RESERVATION CONFLICT performing"
-					       " reset.\n", SCpnt->host->host_no, SCpnt->channel);
-					scsi_reset(SCpnt, SCSI_RESET_SYNCHRONOUS);
-					status =3D REDO;
-					break;
+                                        /* Most HAs will return an
+                                         * error for this, so usually
+                                         * reservation conflicts will
+                                         * be processed under
+                                         * DID_ERROR code */
+                                        printk("scsi%d (%d,%d,%d) : RESE=
RVATION CONFLICT\n", =

+                                               SCpnt->host->host_no, SCp=
nt->channel,
+                                               SCpnt->device->id, SCpnt-=
>device->lun);
+                                        status =3D CMD_FINISHED; /* retu=
rns I/O error */
+                                        break;
+                                        =

 				default:
 					printk("Internal error %s %d \n"
 					 "status byte =3D %d \n", __FILE__,
@@ -556,6 +562,14 @@
 		exit =3D (DRIVER_HARD | SUGGEST_ABORT);
 		break;
 	case DID_ERROR:
+                if(msg_byte(result) =3D=3D COMMAND_COMPLETE
+                   && status_byte(result) =3D=3D RESERVATION_CONFLICT) {=

+                        printk("scsi%d (%d,%d,%d) : RESERVATION CONFLICT=
\n", =

+                               SCpnt->host->host_no, SCpnt->channel,
+                               SCpnt->device->id, SCpnt->device->lun);
+                        status =3D CMD_FINISHED; /* returns I/O error */=

+                        break;
+                }
 		status =3D MAYREDO;
 		exit =3D (DRIVER_HARD | SUGGEST_ABORT);
 		break;
@@ -1097,6 +1111,31 @@
 	return rtn;
 }
 =

+
+/* This function exports SCSI Bus, Device or Host reset capability
+ * and is for use with the SCSI generic driver.
+ */
+int
+scsi_old_reset(Scsi_Cmnd *SCpnt, unsigned int flag)
+{
+        int rtn;
+        unsigned int old_flags =3D SCSI_RESET_SYNCHRONOUS;
+
+        switch(flag) {
+        case SCSI_TRY_RESET_DEVICE:
+                /* no suggestion flags to add, device reset is default *=
/
+                break;
+        case SCSI_TRY_RESET_BUS:
+                old_flags |=3D SCSI_RESET_SUGGEST_BUS_RESET;
+                break;
+        case SCSI_TRY_RESET_HOST:
+                old_flags |=3D SCSI_RESET_SUGGEST_HOST_RESET;
+                break;
+        default:
+                return FAILED;
+        }
+        return (scsi_reset(SCpnt, old_flags) =3D=3D 0) ? SUCCESS : FAILE=
D;
+}
 =

 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
Index: linux/drivers/scsi/scsi_syms.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/cvs/CVSROOT/linux/2.4/drivers/scsi/scsi_syms.c,v
retrieving revision 1.1.1.2
retrieving revision 1.1.1.2.6.1
diff -u -r1.1.1.2 -r1.1.1.2.6.1
--- linux/drivers/scsi/scsi_syms.c	2000/11/30 17:19:11	1.1.1.2
+++ linux/drivers/scsi/scsi_syms.c	2001/02/11 17:33:42	1.1.1.2.6.1
@@ -84,6 +84,10 @@
 EXPORT_SYMBOL(scsi_deregister_blocked_host);
 =

 /*
+ * This symbol is for the sg device only
+ */
+EXPORT_SYMBOL(scsi_reset_provider);
+/*
  * These are here only while I debug the rest of the scsi stuff.
  */
 EXPORT_SYMBOL(scsi_hostlist);

--==_Exmh_-6111894560--


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
