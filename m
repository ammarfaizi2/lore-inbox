Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261721AbSKUBPs>; Wed, 20 Nov 2002 20:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261859AbSKUBPs>; Wed, 20 Nov 2002 20:15:48 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:37647 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S261721AbSKUBPj>; Wed, 20 Nov 2002 20:15:39 -0500
Date: Wed, 20 Nov 2002 23:22:37 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] tcic: fix up header cleanups: add include <linux/interrupt.h>
Message-ID: <20021121012237.GH28717@conectiva.com.br>
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

	Now there are four outstanding changesets.

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.925, 2002-11-20 23:17:26-02:00, acme@conectiva.com.br
  tcic: fix up header cleanups: add include <linux/interrupt.h>
  
  also convert some struct initializations to C99 style and change
  irq_count to tcic_irq_count, as irq_count now is a macro...


 tcic.c |   64 +++++++++++++++++++++++++++++++---------------------------------
 1 files changed, 31 insertions(+), 33 deletions(-)


diff -Nru a/drivers/pcmcia/tcic.c b/drivers/pcmcia/tcic.c
--- a/drivers/pcmcia/tcic.c	Wed Nov 20 23:19:58 2002
+++ b/drivers/pcmcia/tcic.c	Wed Nov 20 23:19:58 2002
@@ -36,14 +36,8 @@
 #include <linux/types.h>
 #include <linux/fcntl.h>
 #include <linux/string.h>
-
-#include <asm/io.h>
-#include <asm/bitops.h>
-#include <asm/system.h>
-
-#include <linux/kernel.h>
 #include <linux/errno.h>
-#include <linux/sched.h>
+#include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/timer.h>
 #include <linux/ioport.h>
@@ -51,6 +45,10 @@
 #include <linux/proc_fs.h>
 #include <linux/workqueue.h>
 
+#include <asm/io.h>
+#include <asm/bitops.h>
+#include <asm/system.h>
+
 #include <pcmcia/version.h>
 #include <pcmcia/cs_types.h>
 #include <pcmcia/cs.h>
@@ -89,10 +87,10 @@
 static int irq_list[16] = { -1 };
 
 /* The card status change interrupt -- 0 means autoselect */
-static int cs_irq = 0;
+static int cs_irq;
 
 /* Poll status interval -- 0 means default to interrupt */
-static int poll_interval = 0;
+static int poll_interval;
 
 /* Delay for card status double-checking */
 static int poll_quick = HZ/20;
@@ -125,17 +123,17 @@
 } socket_info_t;
 
 static struct timer_list poll_timer;
-static int tcic_timer_pending = 0;
+static int tcic_timer_pending;
 
 static int sockets;
 static socket_info_t socket_table[2];
 
 static socket_cap_t tcic_cap = {
-    /* only 16-bit cards, memory windows must be size-aligned */
-    SS_CAP_PCCARD | SS_CAP_MEM_ALIGN,
-    0x4cf8,		/* irq 14, 11, 10, 7, 6, 5, 4, 3 */
-    0x1000,		/* 4K minimum window size */
-    0, 0		/* No PCI or CardBus support */
+	/* only 16-bit cards, memory windows must be size-aligned */
+	.features = SS_CAP_PCCARD | SS_CAP_MEM_ALIGN,
+	.irq_mask = 0x4cf8,		/* irq 14, 11, 10, 7, 6, 5, 4, 3 */
+	.map_size = 0x1000,		/* 4K minimum window size */
+	/* No PCI or CardBus support */
 };
 
 /*====================================================================*/
@@ -235,7 +233,7 @@
 
 static volatile u_int irq_hits;
 
-static void __init irq_count(int irq, void *dev, struct pt_regs *regs)
+static void __init tcic_irq_count(int irq, void *dev, struct pt_regs *regs)
 {
     irq_hits++;
 }
@@ -245,11 +243,11 @@
     u_short cfg;
 
     irq_hits = 0;
-    if (request_irq(irq, irq_count, 0, "irq scan", irq_count) != 0)
+    if (request_irq(irq, tcic_irq_count, 0, "irq scan", tcic_irq_count) != 0)
 	return -1;
     mdelay(10);
     if (irq_hits) {
-	free_irq(irq, irq_count);
+	free_irq(irq, tcic_irq_count);
 	return -1;
     }
 
@@ -260,7 +258,7 @@
     tcic_setb(TCIC_ICSR, TCIC_ICSR_ERR | TCIC_ICSR_JAM);
 
     udelay(1000);
-    free_irq(irq, irq_count);
+    free_irq(irq, tcic_irq_count);
 
     /* Turn off interrupts */
     tcic_setb(TCIC_IENA, TCIC_IENA_CFG_OFF);
@@ -301,9 +299,9 @@
 	/* Fallback: just find interrupts that aren't in use */
 	for (i = 0; i < 16; i++)
 	    if ((mask0 & (1 << i)) &&
-		(request_irq(i, irq_count, 0, "x", irq_count) == 0)) {
+		(request_irq(i, tcic_irq_count, 0, "x", tcic_irq_count) == 0)) {
 		mask1 |= (1 << i);
-		free_irq(i, irq_count);
+		free_irq(i, tcic_irq_count);
 	    }
 	printk("default");
     }
@@ -983,18 +981,18 @@
 }
 
 static struct pccard_operations tcic_operations = {
-	tcic_init,
-	tcic_suspend,
-	tcic_register_callback,
-	tcic_inquire_socket,
-	tcic_get_status,
-	tcic_get_socket,
-	tcic_set_socket,
-	tcic_get_io_map,
-	tcic_set_io_map,
-	tcic_get_mem_map,
-	tcic_set_mem_map,
-	tcic_proc_setup
+	.init		   = tcic_init,
+	.suspend	   = tcic_suspend,
+	.register_callback = tcic_register_callback,
+	.inquire_socket	   = tcic_inquire_socket,
+	.get_status	   = tcic_get_status,
+	.get_socket	   = tcic_get_socket,
+	.set_socket	   = tcic_set_socket,
+	.get_io_map	   = tcic_get_io_map,
+	.set_io_map	   = tcic_set_io_map,
+	.get_mem_map	   = tcic_get_mem_map,
+	.set_mem_map	   = tcic_set_mem_map,
+	.proc_setup	   = tcic_proc_setup,
 };
 
 /*====================================================================*/

===================================================================


This BitKeeper patch contains the following changesets:
1.925
## Wrapped with gzip_uu ##


begin 664 bkpatch4208
M'XL(`+XTW#T``^U6VW+;-A!])K]B&[_$+D4!X$675IG8<B;U.$DU]N2I[7`@
M$+8X)@F:`'U)]?%=4))UL6)/+X_5A1CNGCTXW#W0Z`"^:ED/'2X*Z1[`+TJ;
MH2-4*87)[K@O5.%/:TQ<*(6)[DP5LGMRWLU*D3>IU!WF1RZF)]R(&=S)6@\=
MZ@=/$?-8R:%S\>'CUT_'%ZX[&L%XQLMK>2D-C$:N4?4=SU/]GIM9KDK?U+S4
MA33MQO,GZ)P1PO`=T5Y`HGA.8Q+VYH*FE/*0RI2PL!^'KGV&][O:=U@H9910
M&@7AG+$>B]U3H/Z`14!8E](N(\""(>T-6=PA;$@(["6%'RETB'L"_^T#C%T!
M1F1B"%?9`S05S"1/90TBE[QL*CT$GJ:P[#W\G&=E\X"C,+*NF\KXLW=8CQ^>
M:P4H&<=A0./$0)NZ$08K,Y/Q//O&3:9*C>IA/!A@]C&7P,L41"L8*;+Z-A&J
M*8W%6$G)4\0#KC?RI;J'3`.'@HM:^;[OG@-CI!^[D_6LW<[??+DNX<1]]TI_
MTSJSENM6HA`9[UJ=OMCH=4AH?QX%/>SUE(;],.JE&,1`W-\_UQ<8E\;IL6`>
M]`/&6C/OA;]N['^AVTUG68F\6I585$KSVVJK/UX43]!Q9("NIWT:#5K74_K,
M],'+I@_0]4'PO^V_8_N%+WZ%3GW??M#&D_T6^0?GX308`/Y:A3%0]ZR]'KS4
MD;,H@'`#PG71S93-;,>FF5&5?A[7C]K(PL9_=T\'S&[:7K7!)F*CL`5"V^[\
MA.FH34?;Z4KE>=)J0JL@BK*^A2V6#5S;9I,5LDXJ6:99>6W!00@1@H,^+D[W
M"%29/P*-.Z@7!*]3[4$A"U4_PCV>!W6OH6BT@2D./?LF.SCMZU*F<-1U'?]*
M<M/44L,(+B^3\?$DF8S'QQ>G,%_=?_[P.3G^=/;QBX=P.^2"ZQN$DX=07/4]
MQRK`,-#0`TKQ2SSH>1![$'F`L6"Q4<&KQ&[?5E)"R*(R/(<"/5@TQ5)LJ[$M
MP>P7!9/Q&:@:QOA<)XT&W5250@\CX)0%;=<6R[)K=RI+(4FLK7=,^M8V%.^\
M!>8HE7?>ZA14)JGEM88C>SU$YG#!W"Z`K^P*WM;RMI':6,:W+<_N(<`'?V,[
MH04OW^RF#^$'?'++';6.62S.52WE]Q@/<=@L#EITNU@EKQ4$)+0%B\5QME7O
MU_RP1^S(BCV$/RUAO"",6\+U_OMV'_01Q=#P@YY=T3`X",=!W:,E&N^MD72C
MK:,W,LN(3>(4,CQB=2)XGD^YN%EAGB5:3Y:W35;+1"MQ(\W67IL)"[V6)K%&
M:?0&;!U\@NPRK8.M]GT0O06Q!9G"HU+ML"R"*Y9G$+T%L05XDO?0+*,KGN<@
EO0VJ:M7&FDW,.NBM_Z>*F10WNBE&8IH&(7[=OP#^9T$R!PL`````
`
end
