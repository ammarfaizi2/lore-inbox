Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317171AbSFKQkC>; Tue, 11 Jun 2002 12:40:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317169AbSFKQkB>; Tue, 11 Jun 2002 12:40:01 -0400
Received: from host194.steeleye.com ([216.33.1.194]:60933 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S317171AbSFKQjs>; Tue, 11 Jun 2002 12:39:48 -0400
Message-Id: <200206111639.g5BGdh509698@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Jens Axboe <axboe@suse.de>
cc: James Bottomley <James.Bottomley@SteelEye.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Proposed changes to generic blk tag for use in SCSI (1/3) 
In-Reply-To: Message from Jens Axboe <axboe@suse.de> 
   of "Tue, 11 Jun 2002 16:45:06 +0200." <20020611144506.GI1117@suse.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 11 Jun 2002 12:39:43 -0400
From: James Bottomley <James.Bottomley@SteelEye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, this is the new patch with all the changes.  I didn't alter the IDE 
blk_queue_start_tag() to check for a REQ_CMD, since you said you would do that.

James

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.490, 2002-06-11 12:33:05-04:00, jejb@mulgrave.(none)
  [BLK TCQ]
  
  remove blk_queue_tag_request() in favour of blk_queue_find_tag()
  Allow any request type into blk_queue_start_tag()

ChangeSet@1.489, 2002-06-11 10:34:17-04:00, jejb@mulgrave.(none)
  [BLK LAYER]
  
  add find tag function, adjust criteria for tagging commands.


 drivers/block/ll_rw_blk.c |   40 ++++++++++++++++++++++++++++++++++------
 drivers/ide/tcq.c         |    2 +-
 include/linux/blkdev.h    |    2 +-
 3 files changed, 36 insertions(+), 8 deletions(-)


diff -Nru a/drivers/block/ll_rw_blk.c b/drivers/block/ll_rw_blk.c
--- a/drivers/block/ll_rw_blk.c	Tue Jun 11 12:38:12 2002
+++ b/drivers/block/ll_rw_blk.c	Tue Jun 11 12:38:12 2002
@@ -297,6 +297,27 @@
 }
 
 /**
+ * blk_queue_find_tag - find a request by its tag and queue
+ *
+ * @q:	 The request queue for the device
+ * @tag: The tag of the request
+ *
+ * Notes:
+ *    Should be used when a device returns a tag and you want to match
+ *    it with a request.
+ *
+ *    no locks need be held.
+ **/
+struct request *blk_queue_find_tag(request_queue_t *q, int tag)
+{
+	struct blk_queue_tag *bqt = q->queue_tags;
+
+	if(unlikely(bqt == NULL || bqt->max_depth < tag))
+		return NULL;
+
+	return bqt->tag_index[tag];
+}
+/**
  * blk_queue_free_tags - release tag maintenance info
  * @q:  the request queue for the device
  *
@@ -429,10 +450,12 @@
  *  Description:
  *    This can either be used as a stand-alone helper, or possibly be
  *    assigned as the queue &prep_rq_fn (in which case &struct request
- *    automagically gets a tag assigned). Note that this function assumes
- *    that only REQ_CMD requests can be queued! The request will also be
- *    removed from the request queue, so it's the drivers responsibility to
- *    readd it if it should need to be restarted for some reason.
+ *    automagically gets a tag assigned). Note that this function
+ *    assumes that any type of request can be queued! if this is not
+ *    true for your device, you must check the request type before
+ *    calling this function.  The request will also be removed from
+ *    the request queue, so it's the drivers responsibility to readd
+ *    it if it should need to be restarted for some reason.
  *
  *  Notes:
  *   queue lock must be held.
@@ -443,8 +466,12 @@
 	unsigned long *map = bqt->tag_map;
 	int tag = 0;
 
-	if (unlikely(!(rq->flags & REQ_CMD)))
-		return 1;
+	if (unlikely((rq->flags & REQ_QUEUED))) {
+		printk(KERN_ERR 
+		       "request %p for device [02%x:02%x] already tagged %d",
+		       rq, major(rq->rq_dev), minor(rq->rq_dev), rq->tag);
+		BUG();
+	}
 
 	for (map = bqt->tag_map; *map == -1UL; map++) {
 		tag += BLK_TAGS_PER_LONG;
@@ -2027,6 +2054,7 @@
 
 EXPORT_SYMBOL(blk_queue_prep_rq);
 
+EXPORT_SYMBOL(blk_queue_find_tag);
 EXPORT_SYMBOL(blk_queue_init_tags);
 EXPORT_SYMBOL(blk_queue_free_tags);
 EXPORT_SYMBOL(blk_queue_start_tag);
diff -Nru a/drivers/ide/tcq.c b/drivers/ide/tcq.c
--- a/drivers/ide/tcq.c	Tue Jun 11 12:38:12 2002
+++ b/drivers/ide/tcq.c	Tue Jun 11 12:38:12 2002
@@ -282,7 +282,7 @@
 
 	TCQ_PRINTK("%s: stat %x, feat %x\n", __FUNCTION__, stat, feat);
 
-	rq = blk_queue_tag_request(&drive->queue, tag);
+	rq = blk_queue_find_tag(&drive->queue, tag);
 	if (!rq) {
 		printk(KERN_ERR"%s: missing request for tag %d\n", __FUNCTION__, tag);
 		return ide_stopped;
diff -Nru a/include/linux/blkdev.h b/include/linux/blkdev.h
--- a/include/linux/blkdev.h	Tue Jun 11 12:38:12 2002
+++ b/include/linux/blkdev.h	Tue Jun 11 12:38:12 2002
@@ -328,11 +328,11 @@
 /*
  * tag stuff
  */
-#define blk_queue_tag_request(q, tag)	((q)->queue_tags->tag_index[(tag)])
 #define blk_queue_tag_depth(q)		((q)->queue_tags->busy)
 #define blk_queue_tag_queue(q)		((q)->queue_tags->busy < (q)->queue_tags->
max_depth)
 #define blk_rq_tagged(rq)		((rq)->flags & REQ_QUEUED)
 extern int blk_queue_start_tag(request_queue_t *, struct request *);
+extern struct request *blk_queue_find_tag(request_queue_t *, int);
 extern void blk_queue_end_tag(request_queue_t *, struct request *);
 extern int blk_queue_init_tags(request_queue_t *, int);
 extern void blk_queue_free_tags(request_queue_t *);

===================================================================


This BitKeeper patch contains the following changesets:
1.489..1.490
## Wrapped with gzip_uu ##


begin 664 bkpatch9679
M'XL(`'0G!CT``\U8^W/:.!#^&?\5>^VT![D`\I-'+YF\F%XF:9J29N8ZO0ZC
MV`*<^`&6@#!'__=;R>892IJT=,YA@BVO5OOX]M.*EW#-65+/W;+;&^TE_!5S
M4<^%@Z"3T"$KY:,X8@4<;\8QCI>[<<C*4K1\=%:^">Z*$1L5!>T4C9*MH=@E
M%6X7ABSA]9Q>,F<C8MQC]5RS\?;Z_+"I:7M[<-RE48==,0%[>YJ(DR$-/'Y`
M13>(HY)(:,1#)FC)C</)3'1B$&+@GZU73&([$]TA5F7BZIZN4TMG'C&LJF/-
MM4EK-^MR2(W84M_$L&NFK9V`7K*J-2!&F3AE70>=U$VKKE>*Q*H3`M+U@Y7H
MP!\&%(EV!#_7BV/-A<]'YV=P?OBIT?R"3_BAG@=M/_(`8P[M0>0*/XYV<?AV
MP`6XB2]8XE-HQXF4Z/A1!W#MD$8>+VEG8%B$U+3+>?"UXA,O32.4:/N/^.HE
MOL0`(B1V[\I!T$I&+41+R5WP'4VQT'>G6IM43=UT+.+JAN>XMNFL#?-C2AU=
MURW3THT)L:VJ_:B-?N0&`X^5`S\:W$LL>VQ8ZBXFIV:1B648IC6YH<RUJ5,Q
M:J1BMF^,]09NTKA@7968AJ:MU;"*SFP2HE,E3J&S1A;0:=1-LT[LC>@TMXK.
MC\<?,FPF+(R'#-#O5G_`!JR%"&PE#.^YR!?`CZ!-A_$@@;B]("31+"7S!51Q
M&`3Q"&@TAFR>(@Z<*N*%*5S01&1S$--HIOX+,/WK\>*8ADTF1+<P]?O@T8"Y
M=_X!&_H<B[XX9)$8)(PO%9R/ZH3;G]:$34R]HB.U371\PC16VI6*P=KM"G&K
MK&9M+K0597.33)LXQO^6!%(;#=NIZ&JG>>".W'&V$<UG*74P#(Y9Q4HS;02/
MJG'=62YQHVZ3C26N0U'?2HE?T)"!JR8NE^UR;2^5YT)%GT$*E?=03$;J@]5V
M^3`CSRC9$Z-J@ZZ=IE^YI`][ZVQXK=8J[JOA7;DI%MXLH>(!D![O1WX0V-\'
MDV\!?`87P['-%"Y5\T&_8FSN5\QMX47V)P^S,.M4)%!4^T)G!-]!=W&\RT#-
MD3K2]B;=5`[3SF8-^4,4"ZDO8>T!9_).#OIM-=YL?&@=OSLI*77C5(8&4R&7
MX@RN%KTZOCJ%GM]C2,)*">H/`MDKJ2;B&\!]D)QG`/C4J-7`T#7861>QXFJ<
M;L;@"Z[,EP%*@P4[<OI!OYZ#C^C,5%:]3)M`',5=Q7>9$L39=24IU6`]B_FD
M3-=%+!BORSN\KKKQ(,"$,L!X>3#J8J9HI@_G(6@CC@-3F\;Q`$8T4ED)9=N?
MJ?$%C'S1G3M3RA;#*XI!QI)#Q)A:J<L"3[[?*6M<)`-7S+S:65/>V;LI*<%.
M?U=V"ZK.M7^U7*9BB;=041]/'=#/6$&.\3?:/UK.;^<'4>#?L6"<5S)[<'%]
M?@Z3">!C<3^D]RV/]="5/]4*!2V72\.@Y)2.[%G)2Y)$2]G]9[S[\D;[JI5W
M=K03RW(D<Z5?N"C,5\TG:%4[0(/@M0+QA^O&=>.D@$N=8@G6<$+C[\OWS8^M
MJT_OCMZ?YQ_&1/+;S^B?%;-83]V(\"CD;(590GK'UM(`=5U,B2ISU2PBK*>(
MR;-[]0XK01)!D##JC=7!"+&&!G/5/ZI&88N%?F+9)EB8;]L!)X,]'8@XI!W?
M1;(90X>)61UQ[G<BYA5*JA2Q0BFBN>OS&8=.-7`^"!6)T?7.NS22]:3"Y?TF
MB5&IP0\29*8$JR/EB;'LR]/"WE5U'*KS9!?WJ4622!>Y83B%92JD!_*8N61C
M"9;X:.0'`8:?Q]*@])B`Q]@D#J=FK'+7+J"L+WY/.3I+!HKP7AQQ_\8/?#%.
MN1\WG#G+H(_XGZ>LI0A%9$LJN,A%T5<>AW*(<K03D^-4P,#D.%5,SO<6(R"U
MY'H),LU=_JS1O&@UFDW`(4BO%U-G7O74BAEC?B;&J_NZ_/=E%8ROO!>[\_D)
MLEA(;^-$69#TD72&!1SRH]4A^9#6?"YW=/TV+V^^JOYF_>'B\>;F1XXYFSN;
MC<>=65M#\#LE'UM_8ENC;^N@^XVNII?$(I85@2RB#O4K)++>X>>T"J8IFUQV
M+QAN+<_9%M6N^,V=X2D_7*C,&$_<%LBV^LU-OSE`7C9,">L%U&4A(E%RW[IC
FBMP%U"%[6_D[,4T,U/SW4<6K2-][)JVZ58>VM?\`!I#L'H85````
`
end


