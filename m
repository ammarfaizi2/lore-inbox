Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266292AbSKUCGV>; Wed, 20 Nov 2002 21:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266296AbSKUCGV>; Wed, 20 Nov 2002 21:06:21 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:63247 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S266292AbSKUCGO>; Wed, 20 Nov 2002 21:06:14 -0500
Date: Thu, 21 Nov 2002 00:13:17 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] sched: privatizes the sibling inlines to sched.c, the sole caller of them.
Message-ID: <20021121021317.GM28717@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

	Please pull from:

master.kernel.org:/home/acme/BK/includes-2.5

	Now there are six outstanding changesets.

	Work done by William Lee Irwin (aka wli).

- Arnaldo


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.927, 2002-11-20 23:31:19-02:00, wli@holomorphy.com
  sched: privatizes the sibling inlines to sched.c, the sole caller of them.


 include/linux/sched.h |   54 --------------------------------------------------
 kernel/sched.c        |   18 ++++++++++++++++
 kernel/signal.c       |   30 +++++++++++++++++++++++++++
 3 files changed, 48 insertions(+), 54 deletions(-)


diff -Nru a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	Thu Nov 21 00:09:23 2002
+++ b/include/linux/sched.h	Thu Nov 21 00:09:23 2002
@@ -524,36 +524,6 @@
 extern int do_sigaction(int, const struct k_sigaction *, struct k_sigaction *);
 extern int do_sigaltstack(const stack_t *, stack_t *, unsigned long);
 
-/*
- * Re-calculate pending state from the set of locally pending
- * signals, globally pending signals, and blocked signals.
- */
-static inline int has_pending_signals(sigset_t *signal, sigset_t *blocked)
-{
-	unsigned long ready;
-	long i;
-
-	switch (_NSIG_WORDS) {
-	default:
-		for (i = _NSIG_WORDS, ready = 0; --i >= 0 ;)
-			ready |= signal->sig[i] &~ blocked->sig[i];
-		break;
-
-	case 4: ready  = signal->sig[3] &~ blocked->sig[3];
-		ready |= signal->sig[2] &~ blocked->sig[2];
-		ready |= signal->sig[1] &~ blocked->sig[1];
-		ready |= signal->sig[0] &~ blocked->sig[0];
-		break;
-
-	case 2: ready  = signal->sig[1] &~ blocked->sig[1];
-		ready |= signal->sig[0] &~ blocked->sig[0];
-		break;
-
-	case 1: ready  = signal->sig[0] &~ blocked->sig[0];
-	}
-	return ready !=	0;
-}
-
 /* True if we are on the alternate signal stack.  */
 
 static inline int on_sig_stack(unsigned long sp)
@@ -638,30 +608,6 @@
 		list_add_tail(&(p)->tasks,&init_task.tasks);	\
 	add_parent(p, (p)->parent);				\
 	} while (0)
-
-static inline struct task_struct *eldest_child(struct task_struct *p)
-{
-	if (list_empty(&p->children)) return NULL;
-	return list_entry(p->children.next,struct task_struct,sibling);
-}
-
-static inline struct task_struct *youngest_child(struct task_struct *p)
-{
-	if (list_empty(&p->children)) return NULL;
-	return list_entry(p->children.prev,struct task_struct,sibling);
-}
-
-static inline struct task_struct *older_sibling(struct task_struct *p)
-{
-	if (p->sibling.prev==&p->parent->children) return NULL;
-	return list_entry(p->sibling.prev,struct task_struct,sibling);
-}
-
-static inline struct task_struct *younger_sibling(struct task_struct *p)
-{
-	if (p->sibling.next==&p->parent->children) return NULL;
-	return list_entry(p->sibling.next,struct task_struct,sibling);
-}
 
 #define next_task(p)	list_entry((p)->tasks.next, struct task_struct, tasks)
 #define prev_task(p)	list_entry((p)->tasks.prev, struct task_struct, tasks)
diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Thu Nov 21 00:09:23 2002
+++ b/kernel/sched.c	Thu Nov 21 00:09:23 2002
@@ -1837,6 +1837,24 @@
 	return retval;
 }
 
+static inline struct task_struct *eldest_child(struct task_struct *p)
+{
+	if (list_empty(&p->children)) return NULL;
+	return list_entry(p->children.next,struct task_struct,sibling);
+}
+
+static inline struct task_struct *older_sibling(struct task_struct *p)
+{
+	if (p->sibling.prev==&p->parent->children) return NULL;
+	return list_entry(p->sibling.prev,struct task_struct,sibling);
+}
+
+static inline struct task_struct *younger_sibling(struct task_struct *p)
+{
+	if (p->sibling.next==&p->parent->children) return NULL;
+	return list_entry(p->sibling.next,struct task_struct,sibling);
+}
+
 static void show_task(task_t * p)
 {
 	unsigned long free = 0;
diff -Nru a/kernel/signal.c b/kernel/signal.c
--- a/kernel/signal.c	Thu Nov 21 00:09:23 2002
+++ b/kernel/signal.c	Thu Nov 21 00:09:23 2002
@@ -160,6 +160,36 @@
 static int
 __send_sig_info(int sig, struct siginfo *info, struct task_struct *p);
 
+/*
+ * Re-calculate pending state from the set of locally pending
+ * signals, globally pending signals, and blocked signals.
+ */
+static inline int has_pending_signals(sigset_t *signal, sigset_t *blocked)
+{
+	unsigned long ready;
+	long i;
+
+	switch (_NSIG_WORDS) {
+	default:
+		for (i = _NSIG_WORDS, ready = 0; --i >= 0 ;)
+			ready |= signal->sig[i] &~ blocked->sig[i];
+		break;
+
+	case 4: ready  = signal->sig[3] &~ blocked->sig[3];
+		ready |= signal->sig[2] &~ blocked->sig[2];
+		ready |= signal->sig[1] &~ blocked->sig[1];
+		ready |= signal->sig[0] &~ blocked->sig[0];
+		break;
+
+	case 2: ready  = signal->sig[1] &~ blocked->sig[1];
+		ready |= signal->sig[0] &~ blocked->sig[0];
+		break;
+
+	case 1: ready  = signal->sig[0] &~ blocked->sig[0];
+	}
+	return ready !=	0;
+}
+
 #define PENDING(p,b) has_pending_signals(&(p)->signal, (b))
 
 void recalc_sigpending_tsk(struct task_struct *t)

===================================================================


This BitKeeper patch contains the following changesets:
1.927
## Wrapped with gzip_uu ##


begin 664 bkpatch27713
M'XL(`%-`W#T``]5766_;1A!^YOZ**0($DBM1>_`092AP$Q=I$",Q;!A]2`.!
MQTHD1)$"N;*CENEO[Y"B;-JB?-4%&DD`Q=DYOIG9;Y9\!1>YS$;:51R15_!;
MFJN1%J9QNDBS9;C6_72!XK,T1?$@3!=R\/;C($K\>!7(O,]UD^#RJ:O\$"YE
MEH\TIHMKB5HOY4@[^_7]Q<DO9X2,Q_`N=).9/)<*QF.BTNS2C8/\R%5AG":Z
MRMPD7TCEEE&+:]6"4\KQ:S);4-,JF$4-N_!9P)AK,!E0;@PM@[C^0A[Y:2)]
M%5U6+G0ON^.%,<XH8T-S6'!A"H<<`],=;@/E`\8&G`(7(\%&S.E3/J(4L"I'
MMZL!/POH4_(67A;].^)#[H<R&,$R0_PJ^E/FH$()>>3%43*#*,%+*4LWBKK?
MVZRGL03?C6.903HM10N=?`3.A&F0TYN*D_X3/X10EY(W#R0ZEUDBXT$-J9FM
M(YS"L+G@A>EY7#";^Q8-A'1$2UG;_&RZ)1BS\!8OC\82S1(W;@'C.*9=6%,1
M,-^?VM@-CSK&?6":CAIHJ&T;SH-H:I8,L&VK;W5BX5U,S+`8*PS+F=J.&P3#
M`"LEIVV8]KMKUHD[#JV8UJK^,.O^!6AR%<7Q^BB07N0F>IK-OFQ#?;T7/+/8
MD)N&67#TSRM*,CK<H:1U#R4I]'&S__\Y677G,_2SJ^J''#MM;]0SR'ILXAP3
ME!Q;!@-N5)O@-JD>[OYSR$S<^7)Q%$0SF98^&DUOI31CZ!$W:R$X'8I-MPWC
M2=UFPQ]C`E<SZTZW;]?D&6W^P(;"`38DN4*(?@T*<I6M?`7*S>>3^O^!C/&,
M5A,_C.*@TZ:P[)*_B!9-H1-'J"@72[7NO%[VWU0FF4RZ7<BD6F4)?+HX.3DD
M6GVW44]4MNXTM/5$?E.]W4"]NH#=0_*=_/$(X"D"SR:UU0/(,7ZMJ"\S>3D>
ME_B7+L)1C3P>DT;3S4MDL4Y7N`&?D4=9QA?(XW'=:(Z)^KA[_)QXTD%[W_G0
M?N!2&\\&Y&Q13@U6S0J3/VE4"/I#C(KJ>6+/I*A+\JQ18?'R1!@<$#B`,]G'
MP/XJ=I6$I4R"$F>YBR5,,ZQ5!0\?S!%6G)80UUNMTGH#(^_!+$Z]YN+-BIL$
MX*'I7`9;H8ZF@SM4B1(%H9M/:OM)K=K!*X:?("DVDA[<2&JW%5E62;F.,;"/
M,^2#&ZR1"=5-=(@;6LNOHO+EHS/Y=/[A_>3WSV?'YUU`PT!.W56L1D33IFD&
MG0C&T-#I;7RAD!Y"OQ_!&_P'AUU4US8KQ;C.J^38[$OT%5[_O<UX*T(HFH?J
M\PJ*[^82C%'M&6[;BUU[4=FW1N.[VGR_-MO59ONUZ:XV;<N$[\GDOXG&]D3;
G9__]>AYNS'X::[2><=L74J2B/\]7B[&@EN?XWI3\`\RNWLO_#@``
`
end
