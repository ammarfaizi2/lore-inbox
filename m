Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbUBZXy5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 18:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbUBZXy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 18:54:57 -0500
Received: from bristol.phunnypharm.org ([65.207.35.130]:5076 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S261289AbUBZXyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 18:54:50 -0500
Date: Thu, 26 Feb 2004 18:54:12 -0500
From: Ben Collins <bcollins@debian.org>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [BK PATCH] SCSI host num allocation improvement
Message-ID: <20040226235412.GA819@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After doing a large round of debugging and fixups for ieee1394, I
started getting really aggrivated with the way that the scsi layer
allocates host numbers by forever incrementing from the last one.

Before too long, I was getting scsi137, etc. Not only did it look bad,
it was bad. Cdrecord only scans bus 0-15, which means after a few
hotplugs with your USB or Firewire CD/DVD recorder, you wont be able to
burn to it. Yes, I know cdrecord needs to be fixed aswell, but I've had
my fill of trying to convince the author of anything, so I wont be
sending him a patch.

Anyway, this patch enables a race free (I hope) allocation of host
numbers. And it will pick the lowest available number first. I've only
tested it with ieee1394 sbp2, so real scsi users should give it a go.


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.1589, 2004-02-26 18:40:58-05:00, bcollins@debian.org
  [SCSI]: Add a scsi_alloc_host_num function for race free, and non-incremental host ids


 hosts.c |   44 ++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 40 insertions(+), 4 deletions(-)


diff -Nru a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
--- a/drivers/scsi/hosts.c	Thu Feb 26 18:52:00 2004
+++ b/drivers/scsi/hosts.c	Thu Feb 26 18:52:00 2004
@@ -38,9 +38,6 @@
 #include "scsi_logging.h"
 
 
-static int scsi_host_next_hn;		/* host_no for next new host */
-
-
 static void scsi_host_cls_release(struct class_device *class_dev)
 {
 	put_device(&class_to_shost(class_dev)->shost_gendev);
@@ -166,6 +163,38 @@
 	kfree(shost);
 }
 
+static DECLARE_MUTEX(host_num_lock);
+/**
+ * scsi_host_num_alloc - allocate a unique host number for a scsi host.
+ *
+ * Note:
+ *      Must hold host_num_lock when calling this, and continue holding it
+ *      till after the host is added to the shost_class.
+ *
+ * Return value:
+ *      A unique host number.
+ **/
+static int scsi_host_num_alloc(void)
+{
+	int host_num = 0;
+	struct class *class = &shost_class;
+	struct class_device *cdev;
+	struct Scsi_Host *shost;
+
+	down_read(&class->subsys.rwsem);
+next_host_num_try:
+	list_for_each_entry(cdev, &class->children, node) {
+		shost = class_to_shost(cdev);
+		if (shost->host_no == host_num) {
+			host_num++;
+			goto next_host_num_try;
+		}
+	}
+	up_read(&class->subsys.rwsem);
+
+	return host_num;
+}
+
 /**
  * scsi_host_alloc - register a scsi host adapter instance.
  * @sht:	pointer to scsi host template
@@ -214,7 +243,6 @@
 
 	init_MUTEX(&shost->scan_mutex);
 
-	shost->host_no = scsi_host_next_hn++; /* XXX(hch): still racy */
 	shost->dma_channel = 0xff;
 
 	/* These three are default values which can be overridden */
@@ -263,6 +291,12 @@
 	if (rval)
 		goto fail_kfree;
 
+	/* Hold this lock until after we've added this to the scsi_host
+	 * class, to avoid race condititons with the host number
+	 * allocation scheme. */
+	down(&host_num_lock);
+	shost->host_no = scsi_host_num_alloc();
+
 	device_initialize(&shost->shost_gendev);
 	snprintf(shost->shost_gendev.bus_id, BUS_ID_SIZE, "host%d",
 		shost->host_no);
@@ -273,6 +307,8 @@
 	shost->shost_classdev.class = &shost_class;
 	snprintf(shost->shost_classdev.class_id, BUS_ID_SIZE, "host%d",
 		  shost->host_no);
+
+	up(&host_num_lock);
 
 	shost->eh_notify = &complete;
 	rval = kernel_thread(scsi_error_handler, shost, 0);

===================================================================


This BitKeeper patch contains the following changesets:
1.1589
## Wrapped with gzip_uu ##


M'XL( *"&/D   [56:V_;-A3]+/Z*"Q3('">6J*<=!0[2)<$6;-V"9 $&=(5!
MDTQ$1*8RDK(;S/WO(ZG*>=1ML:*3!4BZO(]S[SF4_ JN-5=E,*=-70NIT2OX
MN=&F#!B?"R+#1MU:TV736%/4:A5I1:,[KB2O(^O?OA\E88&LRP4QM((E5[H,
MXC#=6,S#/2^#R[.?KG]]?8G0= HG%9&W_(H;F$Z1:=22U$P?$U/5C0R-(E(O
MN"$A;1;KC>LZP3BQOSP>IS@OUG&!L_&:QBR.219SAI-L4F2(D25?''?PPOG=
M7!@=2AO]+$^&DR3&*4[B\3K/\GB"3B$.XWQR #B+<!(E!<23,L-E/AGAO,08
M^ND</TX%]F(88?0C?-\.3A"%MU<G5^?O2GC-&!#05(L9J>N&SBK+S$RV"[AI
M)36BD7#3*%"$<KA1G.\#D0QD(T="4L477!I2@PL"P33Z!?(,CS&Z>&0 C?[C
M@1 F&!U]I6FFA!-"Y*!'KKX.Z9/^,XSMY).DR-9S/)GS<4YRRT:6L*V3_FPZ
M1V21I.E!DJ]3'"=C+Z]MWE]7VK=#1N3N?G'<:%8[L&_[,N\^FS*-DQ3C/,^L
M_I(TCC.OOX/Q,_6E!V62?TE]&891]K_([[O+KN/F=QBIE3^MC"ZVTO0-<CS-
M8DC1>5Q,($V0-L0("J=G)_9E<S9[<_W'V9^#'O[,]G*W>XBBX1#!L&MPL^8[
MA1'X*S'<3J"5XN^6=XU8ESE7ON]N--X<VCPNU6^-X:6[\<>;U@943<W@6658
M55P")8[*6S"5T-W@:".-?9%R'^*6A-FD,J*N@=P86]I4'Z$(#80QSBSSWJA]
M%5H3K7L\E]RT2H+51?L$U^LM';F(8=3/34BS;2R#92/8+OH'!<YAHX8IX$,4
M:*-::L#7AV%WF<+.$U0OG&:,+X65SI#:F\>U*U?7?7I@Z&,/T5\H8,U*SA0G
M;+#C8T='NIWK!QVJE>8+RZ7D[\TC6J,>2A34PCY:IF:<T&IFU:@>!J[6/O1)
M:"5JIKC<MZIE?!=L9X$O:I%W&$TS\P8?:.L$@;B!@3>-CKIZC7VI;(;1Y0CZ
MQ[T]%Q+<-I:C3R"ZI0_(G>W]%YNS U =DWWX(?I@K:?VRP4Q.D^*' H41$/[
MR;9J<Y("K[36*JK7S8K_L.2]8IQ'+YN>9Q18@7@ ^VZ-.+*[S6V5R801II$:
M5L)4CQKLQ.,C/VX8]U;0M+*[/P0K*,_<8.?EU@M>3G"KW'SKY\DXA\3-H+W_
<--'F[X4M2>]TNYBFN#@@\W&!_@4R$Z&RT@@     
 

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
