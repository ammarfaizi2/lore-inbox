Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319209AbSIKQRU>; Wed, 11 Sep 2002 12:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319173AbSIKQPq>; Wed, 11 Sep 2002 12:15:46 -0400
Received: from d06lmsgate-5.uk.ibm.com ([195.212.29.5]:19638 "EHLO
	d06lmsgate-5.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S319209AbSIKQHB> convert rfc822-to-8bit; Wed, 11 Sep 2002 12:07:01 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.34 s390 fixes (8/10): signal quiesce.
Date: Wed, 11 Sep 2002 18:09:11 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209111805.42098.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
add support for a new feature in the hardware console. A signal quiesce 
is sent from VM or the service element every time the system should shut
down. We receive the quiesce signal and call ctrl_alt_del(). Finally the
mainframes have ctrl-alt-del as well :-)

blue skies,
  Martin.

diff -urN linux-2.5.34/drivers/s390/char/hwc.h linux-2.5.34-s390/drivers/s390/char/hwc.h
--- linux-2.5.34/drivers/s390/char/hwc.h	Mon Sep  9 19:35:13 2002
+++ linux-2.5.34-s390/drivers/s390/char/hwc.h	Tue Sep 10 17:29:55 2002
@@ -22,6 +22,7 @@
 #define ET_PMsgCmd		0x09
 #define ET_CntlProgOpCmd	0x20
 #define ET_CntlProgIdent	0x0B
+#define ET_SigQuiesce	0x1D
 
 #define ET_OpCmd_Mask	0x80000000
 #define ET_Msg_Mask		0x40000000
@@ -29,6 +30,7 @@
 #define ET_PMsgCmd_Mask	0x00800000
 #define ET_CtlProgOpCmd_Mask	0x00000001
 #define ET_CtlProgIdent_Mask	0x00200000
+#define ET_SigQuiesce_Mask	0x00000008
 
 #define GMF_DOM		0x8000
 #define GMF_SndAlrm	0x4000
@@ -218,7 +220,8 @@
 	0x0000,
 	0x0000,
 	sizeof (_hwcb_mask_t),
-	ET_OpCmd_Mask | ET_PMsgCmd_Mask | ET_StateChange_Mask,
+	ET_OpCmd_Mask | ET_PMsgCmd_Mask |
+	ET_StateChange_Mask | ET_SigQuiesce_Mask,
 	ET_Msg_Mask | ET_PMsgCmd_Mask | ET_CtlProgIdent_Mask
 };
 
diff -urN linux-2.5.34/drivers/s390/char/hwc_rw.c linux-2.5.34-s390/drivers/s390/char/hwc_rw.c
--- linux-2.5.34/drivers/s390/char/hwc_rw.c	Tue Sep 10 17:29:26 2002
+++ linux-2.5.34-s390/drivers/s390/char/hwc_rw.c	Tue Sep 10 17:29:55 2002
@@ -35,6 +35,8 @@
 #define MIN(a,b) (((a<b) ? a : b))
 #endif
 
+extern void ctrl_alt_del (void);
+
 #define HWC_RW_PRINT_HEADER "hwc low level driver: "
 
 #define  USE_VM_DETECTION
@@ -172,6 +174,7 @@
 	unsigned char read_nonprio:1;
 	unsigned char read_prio:1;
 	unsigned char read_statechange:1;
+	unsigned char sig_quiesce:1;
 
 	unsigned char flags;
 
@@ -222,6 +225,7 @@
 	    0,
 	    0,
 	    0,
+	    0,
 	    NULL,
 	    NULL
 
@@ -1529,6 +1533,19 @@
 				       HWC_RW_PRINT_HEADER
 				 "can not read state change notifications\n");
 
+	hwc_data.sig_quiesce
+	    = ((mask & ET_SigQuiesce_Mask) == ET_SigQuiesce_Mask);
+	if (hwc_data.sig_quiesce)
+		internal_print (
+				       DELAYED_WRITE,
+				       HWC_RW_PRINT_HEADER
+				       "can receive signal quiesce\n");
+	else
+		internal_print (
+				       DELAYED_WRITE,
+				       HWC_RW_PRINT_HEADER
+				       "can not receive signal quiesce\n");
+
 	hwc_data.read_nonprio
 	    = ((mask & ET_OpCmd_Mask) == ET_OpCmd_Mask);
 	if (hwc_data.read_nonprio)
@@ -1609,6 +1626,47 @@
 	return retval;
 }
 
+#ifdef CONFIG_SMP
+static volatile unsigned long cpu_quiesce_map;
+
+static void 
+do_load_quiesce_psw (void)
+{
+	psw_t quiesce_psw;
+
+	clear_bit (smp_processor_id (), &cpu_quiesce_map);
+	if (smp_processor_id () == 0) {
+
+		while (cpu_quiesce_map != 0) ;
+
+		quiesce_psw.mask = PSW_BASE_BITS | PSW_MASK_WAIT;
+		quiesce_psw.addr = 0xfff;
+		__load_psw (quiesce_psw);
+	}
+	signal_processor (smp_processor_id (), sigp_stop);
+}
+
+static void 
+do_machine_quiesce (void)
+{
+	cpu_quiesce_map = cpu_online_map;
+	smp_call_function (do_load_quiesce_psw, NULL, 0, 0);
+	do_load_quiesce_psw ();
+}
+
+#else
+static void 
+do_machine_quiesce (void)
+{
+	psw_t quiesce_psw;
+
+	quiesce_psw.mask = PSW_BASE_BITS | PSW_MASK_WAIT;
+	queisce_psw.addr = 0xfff;
+	__load_psw (quiesce_psw);
+}
+
+#endif
+
 static int 
 process_evbufs (void *start, void *end)
 {
@@ -1644,6 +1702,13 @@
 			retval += eval_statechangebuf
 			    ((statechangebuf_t *) evbuf);
 			break;
+		case ET_SigQuiesce:
+
+			_machine_restart = do_machine_quiesce;
+			_machine_halt = do_machine_quiesce;
+			_machine_power_off = do_machine_quiesce;
+			ctrl_alt_del ();
+			break;
 		default:
 			internal_print (
 					       DELAYED_WRITE,

