Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316540AbSFJXee>; Mon, 10 Jun 2002 19:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316541AbSFJXee>; Mon, 10 Jun 2002 19:34:34 -0400
Received: from host194.steeleye.com ([216.33.1.194]:49421 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S316540AbSFJXea>; Mon, 10 Jun 2002 19:34:30 -0400
Message-Id: <200206102334.g5ANYNk05623@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [BKPATCH] Update 53c700 driver to version 2.8
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 10 Jun 2002 19:34:23 -0400
From: James Bottomley <James.Bottomley@HansenPartnership.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached fixes two fatal (but fortunately rarely tripped) bugs in the 
53c700 driver.  One caused an endless loop when we got a request sense with a 
10 byte command and was caused by having an incorrect cmd_len (actually 
inherited from the request length).  The fix is to copy back the saved command 
length after the request sense completes.  The other fix adjusts the depth 
correctly in the tag starvation case (otherwise the depth is spuriously 
incremented and eventually the device will accept no more commands).

James Bottomley

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.540, 2002-06-09 15:17:35-04:00, jejb@mulgrave.(none)
  [SCSI 53c700] update version to 2.8

ChangeSet@1.539, 2002-06-09 12:33:45-04:00, jejb@mulgrave.(none)
  [SCSI 53c700] bux fix in tag starvation, cosmetic cleanup of set_depth

ChangeSet@1.538, 2002-03-21 14:43:41-08:00, jejb@mulgrave.(none)
  53c700
  
  Correct request sense processing to avoid command retry length
  mismatch.


 53c700.c |   38 +++++++++++++++++++++++++++++++-------
 1 files changed, 31 insertions(+), 7 deletions(-)


diff -Nru a/drivers/scsi/53c700.c b/drivers/scsi/53c700.c
--- a/drivers/scsi/53c700.c	Mon Jun 10 19:33:08 2002
+++ b/drivers/scsi/53c700.c	Mon Jun 10 19:33:08 2002
@@ -51,6 +51,14 @@
 
 /* CHANGELOG
  *
+ * Version 2.8
+ *
+ * Fixed bad bug affecting tag starvation processing (previously the
+ * driver would hang the system if too many tags starved.  Also fixed
+ * bad bug having to do with 10 byte command processing and REQUEST
+ * SENSE (the command would loop forever getting a transfer length
+ * mismatch in the CMD phase).
+ *
  * Version 2.7
  *
  * Fixed scripts problem which caused certain devices (notably CDRWs)
@@ -104,7 +112,7 @@
  * Initial modularisation from the D700.  See NCR_D700.c for the rest of
  * the changelog.
  * */
-#define NCR_700_VERSION "2.7"
+#define NCR_700_VERSION "2.8"
 
 #include <linux/config.h>
 #include <linux/version.h>
@@ -674,21 +682,34 @@
 			print_sense("53c700", SCp);
 
 #endif
-			SCp->use_sg = SCp->cmnd[8];
+			/* restore the old result if the request sense was
+			 * successful */
 			if(result == 0)
 				result = SCp->cmnd[7];
+			/* now restore the original command */
+			memcpy((void *) SCp->cmnd, (void *) SCp->data_cmnd,
+			       sizeof(SCp->data_cmnd));
+			SCp->request_buffer = SCp->buffer;
+			SCp->request_bufflen = SCp->bufflen;
+			SCp->use_sg = SCp->old_use_sg;
+			SCp->cmd_len = SCp->old_cmd_len;
+			SCp->sc_data_direction = SCp->sc_old_data_direction;
+			SCp->underflow = SCp->old_underflow;
+			
 		}
 
 		free_slot(slot, hostdata);
-
-		SCp->host_scribble = NULL;
-		SCp->result = result;
-		SCp->scsi_done(SCp);
+#ifdef NCR_700_DEBUG
 		if(NCR_700_get_depth(SCp->device) == 0 ||
 		   NCR_700_get_depth(SCp->device) > NCR_700_MAX_TAGS)
 			printk(KERN_ERR "Invalid depth in NCR_700_scsi_done(): %d\n",
 			       NCR_700_get_depth(SCp->device));
+#endif /* NCR_700_DEBUG */
 		NCR_700_set_depth(SCp->device, NCR_700_get_depth(SCp->device) - 1);
+
+		SCp->host_scribble = NULL;
+		SCp->result = result;
+		SCp->scsi_done(SCp);
 	} else {
 		printk(KERN_ERR "53c700: SCSI DONE HAS NULL SCp\n");
 	}
@@ -1048,7 +1069,6 @@
 				 * of the command */
 				SCp->cmnd[6] = NCR_700_INTERNAL_SENSE_MAGIC;
 				SCp->cmnd[7] = hostdata->status[0];
-				SCp->cmnd[8] = SCp->use_sg;
 				SCp->use_sg = 0;
 				SCp->sc_data_direction = SCSI_DATA_READ;
 				pci_dma_sync_single(hostdata->pci_dev,
@@ -1885,6 +1905,10 @@
 				printk(KERN_WARNING "scsi%d (%d:%d) Target is suffering from tag 
starvation.\n", SCp->host->host_no, SCp->target, SCp->lun);
 				NCR_700_set_flag(SCp->device, NCR_700_DEV_TAG_STARVATION_WARNED);
 			}
+			/* Release the slot and ajust the depth before refusing
+			 * the command */
+			free_slot(slot, hostdata);
+			NCR_700_set_depth(SCp->device, NCR_700_get_depth(SCp->device) - 1);
 			return 1;
 		}
 		slot->tag = SCp->device->current_tag++;

===================================================================


This BitKeeper patch contains the following changesets:
1.538..1.540
## Wrapped with gzip_uu ##


begin 664 bkpatch5608
M'XL(`#0W!3T``]U847/:1A!^MG[%3OQ0<`W<20(),F228)IZDC@IU'EI.\PA
MG4")T%'="8<./[Z[DL#@4*;IU--.,(/@;F]O;[_=_?9\#K=:9KVSC_+CU#J'
M'Y4VO;-%GLPRL9+-6JI26<?QD5(XWIJKA6R1:.OEZU;;"3S&&G:S;:'$>V&"
M.:QDIGMGO.GL1LQZ*7MGH^&KVS<O1I;5[\-@+M*9'$L#_;YE5+822:B?"S-/
M5-HTF4CU0AK1#-1BLQ/=V(S9^-?FGL/:G0WO,-?;!#SD7+A<ALQV_8Y[KXT,
M/:W+X3[ONKANXW9\V[.N@#?;C@_,;C&G97/@;L]U>BYO,+_'&-"IGS]P#'S/
MH<&LE_#OGF)@!5`Z%[_@>Z"R3`8&,OE[+K4!+5,M89FI0&H=IS/<'L1*Q2'@
M;@N1ABAILC4D,IV9.2I8Q'I!8#2MUX"G=7WK_3T*5N,K7Y;%!+.>P9)4'C]Q
MF,44"2T=Z+B*DV:P.[W-N,?]#;-YFV\\Z?J.'X2!L.VNX-Y11Y]2Z-C<MEW.
MNINVZ[N>91U5\!#]8I'C\DWICQ+];H%^I\6ZP.V>@^BW&\S]#]#_93P87U<Q
M\!M,\\\0Q9\A3L&(&6@C<#\3J_02`:>-X@""1(HT7X**,#S,))1+1+Y$V_N6
MT.ZP+N\XCNMLF,=\_O?0WBYJ;TI_%&B[;`_M=H][/>=_@7:^#(61125%B"FW
M[:9?0=G]UJ#LDG<V3MMVW((;CHH33SR.S<>CYY1"CI^VP]R-C03B%)'D'7(&
M[['N:<ZPH6$_2B"]2(S,3M)$AA,JDZ"R>!:G(MDR!B[&;\M$&IFLF["E'`T"
MJ\\,[N82%YFY1"H)(1%KW$8%@:`(%4FR+@E'HY9G'9BN,7PKO1KN8C.'8!%.
MD(WZ'1#1%R82*Y6E^QTTLKOBC<'Z_G@P_(.HO^IX'G#KFAZV=79VUKK8.8+.
MI!)B3)TG!N*H&#ETX9W0M`HN0.<!.3/*$[AHD4(L':S2F*J[0ZT/7$PK4'(A
M%\%R7:L5?'U1A_%@V7@6+-+P$@['L`J(23%1;%Z^=/R'5%'M4*!>?THBQ6!E
M^62:1Q$ZNE_J*G\=ET)<]L7PY[U<KN5$S[;3Z*=).7(O42&[+U(-W<OH8%+8
M&L844U34*FF<H`6'DWN[IZ',H@3]NF_`=K"0LZXX)@;\%0]\1=M`F>Q_P?_.
M:49@T'`?)9,IZ8CR#_D>M(+80*BD3K\S0'J+4--K;>0":M,U1)F4F.NHHIA(
ME(&R(0SS(*[$0[F*`WI@CP!3&5'$8@+G64H2O%YVG6_5:BLCPH^Y-@N9&NI!
MR)F3$#V`38?"RP/5%=IV4NQ6V[8DJ`)/4*?L+ICZT9*[ZX*+N=BE'#^/HU!&
M<#,835#AY&KX\O:5=>TQ"I%SF8:8WYBJ!]-%)GO,1B6_6E7DS?$:--%!%D^G
MB<3HN[E]\^:IM4N>HE3TJYJQ&]_YA=(34_*:^VB36Y6'D<0.3<M#6`3YM<+D
M`(PHIXI=51V:/RPB.W?7Z.,2R%[*HK(0;(^W:P2K>E'`?KD[_>S8=!T:&`%/
MOSZ?'C9FE$_=+SHL=C*?NM#@CY).1WNJ$H$0;TV%1BSNZ.)LC?%:]B./%+#7
M;0=\"V']4%E#[1U<T,@/\6<9PE2$1?X+K-E8$2EI#ZO`'J77EAG"IG*-'(QA
M0DI*.^%.Y4AK#TL$\9M2@*&T)JVZ5"M#I/P7"5:7B"P@+5LCYF)5M0ZA*KD<
MB]X^P^];0S]'PY]NA^.?2<=X>#,>0FT_?$NK$J660)%.AF(8%H<44.!,K%5=
M7%'%]N9:W'U0S^#M%2SGF$=85]!G6/T+9B\?YYCZ,9:E;8!_&([&U^]NX`EZ
<^,G]_RB"N0P^(=A]X;-NU&G;UI^G:50R!1$`````
`
end


