Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261238AbREXQ2o>; Thu, 24 May 2001 12:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261214AbREXQ2e>; Thu, 24 May 2001 12:28:34 -0400
Received: from mail-3.addcom.de ([62.96.128.37]:55560 "HELO mail-3.addcom.de")
	by vger.kernel.org with SMTP id <S261238AbREXQ2U>;
	Thu, 24 May 2001 12:28:20 -0400
Date: Thu, 24 May 2001 18:27:16 +0200 (CEST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: <kai@vaio>
To: Praveen Srinivasan <praveens@stanford.edu>
cc: Karsten Keil <kkeil@suse.de>, <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] fsm.c - null ptr fixes for 2.4.4
In-Reply-To: <200105240726.f4O7QNH22947@smtp2.Stanford.EDU>
Message-ID: <Pine.LNX.4.33.0105241820090.1164-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 May 2001, Praveen Srinivasan wrote:

> Using the Stanford checker, we searched for null-pointer bugs in the linux
> kernel code. This patch fixes numerous unchecked pointers in the ISDN hisax
> card driver (fsm.c).

Is one numerous? Anyway, thanks for you effort. Your fix is not
correct though, because it replaces the bug with another one.

In case the allocation fails, the current code will oops directly, so it's
quite easy to track down what went wrong. After applying your patch, the
code will still oops, but at a later time, when one of the not correctly
initialized state machines is actually used, so the problem is harder to
track.

The correct way to fix the problem is something along the lines of the
appended patch. You need to notify the caller of the allocation failure
and handle it correctly.

Thanks for your work, I'll take care of submitting the right fix to Linus.

--Kai

Index: callc.c
===================================================================
RCS file: /scratch/kai/cvsroot/linux_2_4/drivers/isdn/hisax/callc.c,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 callc.c
--- callc.c	2001/04/23 22:51:03	1.1.1.2
+++ callc.c	2001/05/24 16:04:16
@@ -850,14 +850,14 @@

 #define FNCOUNT (sizeof(fnlist)/sizeof(struct FsmNode))

-void __init
+int __init
 CallcNew(void)
 {
 	callcfsm.state_count = STATE_COUNT;
 	callcfsm.event_count = EVENT_COUNT;
 	callcfsm.strEvent = strEvent;
 	callcfsm.strState = strState;
-	FsmNew(&callcfsm, fnlist, FNCOUNT);
+	return FsmNew(&callcfsm, fnlist, FNCOUNT);
 }

 void
Index: config.c
===================================================================
RCS file: /scratch/kai/cvsroot/linux_2_4/drivers/isdn/hisax/config.c,v
retrieving revision 1.1.1.4.32.1
diff -u -r1.1.1.4.32.1 config.c
--- config.c	2001/05/24 07:52:56	1.1.1.4.32.1
+++ config.c	2001/05/24 16:17:00
@@ -1332,18 +1332,28 @@

 static int __init HiSax_init(void)
 {
-	int i;
+	int i, retval;
 #ifdef MODULE
 	int j;
 	int nzproto = 0;
 #endif

 	HiSaxVersion();
-	CallcNew();
-	Isdnl3New();
-	Isdnl2New();
-	TeiNew();
-	Isdnl1New();
+	retval = CallcNew();
+	if (retval)
+		goto out;
+	retval = Isdnl3New();
+	if (retval)
+		goto out_callc;
+	retval = Isdnl2New();
+	if (retval)
+		goto out_isdnl3;
+	retval = TeiNew();
+	if (retval)
+		goto out_isdnl2;
+	retval = Isdnl1New();
+	if (retval)
+		goto out_tei;

 #ifdef MODULE
 	if (!type[0]) {
@@ -1490,17 +1500,26 @@
 	printk(KERN_DEBUG "HiSax: Total %d card%s defined\n",
 	       nrcards, (nrcards > 1) ? "s" : "");

-	if (HiSax_inithardware(NULL)) {
-		/* Install only, if at least one card found */
-		return (0);
-	} else {
-		Isdnl1Free();
-		TeiFree();
-		Isdnl2Free();
-		Isdnl3Free();
-		CallcFree();
-		return -EIO;
+	/* Install only, if at least one card found */
+	if (!HiSax_inithardware(NULL)) {
+		retval = -EIO;
+		goto out_isdnl1;
 	}
+
+	return 0;
+
+ out_isdnl1:
+	Isdnl1Free();
+ out_tei:
+	TeiFree();
+ out_isdnl2:
+	Isdnl2Free();
+ out_isdnl3:
+	Isdnl3Free();
+ out_callc:
+	CallcFree();
+ out:
+	return retval;
 }

 static void __exit HiSax_exit(void)
Index: fsm.c
===================================================================
RCS file: /scratch/kai/cvsroot/linux_2_4/drivers/isdn/hisax/fsm.c,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 fsm.c
--- fsm.c	2001/04/23 22:51:00	1.1.1.2
+++ fsm.c	2001/05/24 16:03:22
@@ -15,13 +15,16 @@

 #define FSM_TIMER_DEBUG 0

-void __init
+int __init
 FsmNew(struct Fsm *fsm, struct FsmNode *fnlist, int fncount)
 {
 	int i;

 	fsm->jumpmatrix = (FSMFNPTR *)
 		kmalloc(sizeof (FSMFNPTR) * fsm->state_count * fsm->event_count, GFP_KERNEL);
+	if (!fsm->jumpmatrix)
+		return -ENOMEM;
+
 	memset(fsm->jumpmatrix, 0, sizeof (FSMFNPTR) * fsm->state_count * fsm->event_count);

 	for (i = 0; i < fncount; i++)
@@ -32,6 +35,7 @@
 		} else
 			fsm->jumpmatrix[fsm->state_count * fnlist[i].event +
 				fnlist[i].state] = (FSMFNPTR) fnlist[i].routine;
+	return 0;
 }

 void
Index: hisax.h
===================================================================
RCS file: /scratch/kai/cvsroot/linux_2_4/drivers/isdn/hisax/hisax.h,v
retrieving revision 1.1.1.4
diff -u -r1.1.1.4 hisax.h
--- hisax.h	2001/04/24 00:23:56	1.1.1.4
+++ hisax.h	2001/05/24 16:09:43
@@ -1304,7 +1304,7 @@
 int getcallref(u_char * p);
 int newcallref(void);

-void FsmNew(struct Fsm *fsm, struct FsmNode *fnlist, int fncount);
+int FsmNew(struct Fsm *fsm, struct FsmNode *fnlist, int fncount);
 void FsmFree(struct Fsm *fsm);
 int FsmEvent(struct FsmInst *fi, int event, void *arg);
 void FsmChangeState(struct FsmInst *fi, int newstate);
@@ -1335,19 +1335,19 @@

 int ll_run(struct IsdnCardState *cs, int addfeatures);
 void ll_stop(struct IsdnCardState *cs);
-void CallcNew(void);
+int CallcNew(void);
 void CallcFree(void);
 int CallcNewChan(struct IsdnCardState *cs);
 void CallcFreeChan(struct IsdnCardState *cs);
-void Isdnl1New(void);
+int Isdnl1New(void);
 void Isdnl1Free(void);
-void Isdnl2New(void);
+int Isdnl2New(void);
 void Isdnl2Free(void);
-void Isdnl3New(void);
+int Isdnl3New(void);
 void Isdnl3Free(void);
 void init_tei(struct IsdnCardState *cs, int protocol);
 void release_tei(struct IsdnCardState *cs);
 char *HiSax_getrev(const char *revision);
-void TeiNew(void);
+int TeiNew(void);
 void TeiFree(void);
 int certification_check(int output);
Index: isdnl1.c
===================================================================
RCS file: /scratch/kai/cvsroot/linux_2_4/drivers/isdn/hisax/isdnl1.c,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 isdnl1.c
--- isdnl1.c	2001/04/23 22:51:01	1.1.1.2
+++ isdnl1.c	2001/05/24 16:06:14
@@ -736,26 +736,41 @@

 #define L1B_FN_COUNT (sizeof(L1BFnList)/sizeof(struct FsmNode))

-void __init
+int __init
 Isdnl1New(void)
 {
-#ifdef HISAX_UINTERFACE
-	l1fsm_u.state_count = L1U_STATE_COUNT;
-	l1fsm_u.event_count = L1_EVENT_COUNT;
-	l1fsm_u.strEvent = strL1Event;
-	l1fsm_u.strState = strL1UState;
-	FsmNew(&l1fsm_u, L1UFnList, L1U_FN_COUNT);
-#endif
+	int retval;
+
 	l1fsm_s.state_count = L1S_STATE_COUNT;
 	l1fsm_s.event_count = L1_EVENT_COUNT;
 	l1fsm_s.strEvent = strL1Event;
 	l1fsm_s.strState = strL1SState;
-	FsmNew(&l1fsm_s, L1SFnList, L1S_FN_COUNT);
+	retval = FsmNew(&l1fsm_s, L1SFnList, L1S_FN_COUNT);
+	if (retval)
+		return retval;
+
 	l1fsm_b.state_count = L1B_STATE_COUNT;
 	l1fsm_b.event_count = L1_EVENT_COUNT;
 	l1fsm_b.strEvent = strL1Event;
 	l1fsm_b.strState = strL1BState;
-	FsmNew(&l1fsm_b, L1BFnList, L1B_FN_COUNT);
+	retval = FsmNew(&l1fsm_b, L1BFnList, L1B_FN_COUNT);
+	if (retval) {
+		FsmFree(&l1fsm_s);
+		return retval;
+	}
+#ifdef HISAX_UINTERFACE
+	l1fsm_u.state_count = L1U_STATE_COUNT;
+	l1fsm_u.event_count = L1_EVENT_COUNT;
+	l1fsm_u.strEvent = strL1Event;
+	l1fsm_u.strState = strL1UState;
+	retval = FsmNew(&l1fsm_u, L1UFnList, L1U_FN_COUNT);
+	if (retval) {
+		FsmFree(&l1fsm_s);
+		FsmFree(&l1fsm_b);
+		return retval;
+	}
+#endif
+	return 0;
 }

 void Isdnl1Free(void)
Index: isdnl2.c
===================================================================
RCS file: /scratch/kai/cvsroot/linux_2_4/drivers/isdn/hisax/isdnl2.c,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 isdnl2.c
--- isdnl2.c	2001/04/23 22:51:01	1.1.1.2
+++ isdnl2.c	2001/05/24 16:06:36
@@ -1831,14 +1831,14 @@
 {
 }

-void __init
+int __init
 Isdnl2New(void)
 {
 	l2fsm.state_count = L2_STATE_COUNT;
 	l2fsm.event_count = L2_EVENT_COUNT;
 	l2fsm.strEvent = strL2Event;
 	l2fsm.strState = strL2State;
-	FsmNew(&l2fsm, L2FnList, L2_FN_COUNT);
+	return FsmNew(&l2fsm, L2FnList, L2_FN_COUNT);
 }

 void
Index: isdnl3.c
===================================================================
RCS file: /scratch/kai/cvsroot/linux_2_4/drivers/isdn/hisax/isdnl3.c,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 isdnl3.c
--- isdnl3.c	2001/04/23 22:51:01	1.1.1.2
+++ isdnl3.c	2001/05/24 16:07:16
@@ -591,14 +591,14 @@
 	}
 }

-void __init
+int __init
 Isdnl3New(void)
 {
 	l3fsm.state_count = L3_STATE_COUNT;
 	l3fsm.event_count = L3_EVENT_COUNT;
 	l3fsm.strEvent = strL3Event;
 	l3fsm.strState = strL3State;
-	FsmNew(&l3fsm, L3FnList, L3_FN_COUNT);
+	return FsmNew(&l3fsm, L3FnList, L3_FN_COUNT);
 }

 void
Index: tei.c
===================================================================
RCS file: /scratch/kai/cvsroot/linux_2_4/drivers/isdn/hisax/tei.c,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 tei.c
--- tei.c	2001/04/23 22:51:00	1.1.1.2
+++ tei.c	2001/05/24 16:07:11
@@ -446,14 +446,14 @@

 #define TEI_FN_COUNT (sizeof(TeiFnList)/sizeof(struct FsmNode))

-void __init
+int __init
 TeiNew(void)
 {
 	teifsm.state_count = TEI_STATE_COUNT;
 	teifsm.event_count = TEI_EVENT_COUNT;
 	teifsm.strEvent = strTeiEvent;
 	teifsm.strState = strTeiState;
-	FsmNew(&teifsm, TeiFnList, TEI_FN_COUNT);
+	return FsmNew(&teifsm, TeiFnList, TEI_FN_COUNT);
 }

 void

