Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbTI1OpN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 10:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262576AbTI1OpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 10:45:13 -0400
Received: from havoc.gtf.org ([63.247.75.124]:39071 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261183AbTI1OpB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 10:45:01 -0400
Date: Sun, 28 Sep 2003 10:44:05 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [bk patches] 2.6.x bcopy janitorial stuff
Message-ID: <20030928144405.GA16412@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please do a

	bk pull bk://kernel.bkbits.net/jgarzik/bcopy-2.5

This will update the following files:

 arch/ia64/sn/io/sn2/module.c        |    7 +++----
 arch/ia64/sn/io/sn2/pic.c           |    4 +---
 drivers/scsi/ncr53c8xx.c            |    2 +-
 drivers/scsi/sym53c8xx_2/sym_glue.h |    4 ----
 drivers/scsi/sym53c8xx_2/sym_hipd.c |    6 +++---
 drivers/scsi/sym53c8xx_2/sym_misc.c |    2 +-
 drivers/scsi/sym53c8xx_comm.h       |    4 ----
 fs/jfs/jfs_imap.c                   |    2 +-
 8 files changed, 10 insertions(+), 21 deletions(-)

through these ChangeSets:

<jgarzik@redhat.com> (03/09/28 1.1376)
   [janitor] Replace bcopy() uses with memcpy(), where possible.
   
   Affects: JFS, scsi/{sym,sym2}, arch/ia64/sn/io/sn2/{module,pic}.c



diff -Nru a/arch/ia64/sn/io/sn2/module.c b/arch/ia64/sn/io/sn2/module.c
--- a/arch/ia64/sn/io/sn2/module.c	Sun Sep 28 10:35:52 2003
+++ b/arch/ia64/sn/io/sn2/module.c	Sun Sep 28 10:35:52 2003
@@ -166,7 +166,6 @@
 {
     lboard_t	       *board;
     klmod_serial_num_t *comp;
-    char * bcopy(const char * src, char * dest, int count);
     char serial_number[16];
 
     /*
@@ -215,9 +214,9 @@
 #endif
 
 	    if (comp->snum.snum_str[0] != '\0') {
-		bcopy(comp->snum.snum_str,
-		      m->sys_snum,
-		      MAX_SERIAL_NUM_SIZE);
+		memcpy(m->sys_snum,
+		       comp->snum.snum_str,
+		       MAX_SERIAL_NUM_SIZE);
 		m->sys_snum_valid = 1;
 	    }
     }
diff -Nru a/arch/ia64/sn/io/sn2/pic.c b/arch/ia64/sn/io/sn2/pic.c
--- a/arch/ia64/sn/io/sn2/pic.c	Sun Sep 28 10:35:52 2003
+++ b/arch/ia64/sn/io/sn2/pic.c	Sun Sep 28 10:35:52 2003
@@ -29,8 +29,6 @@
 #include <asm/sn/io.h>
 #include <asm/sn/sn_private.h>
 
-extern char *bcopy(const char * src, char * dest, int count);
-
 
 #define PCI_BUS_NO_1 1
 
@@ -51,7 +49,7 @@
 				(arbitrary_info_t *)&pinv) == GRAPH_SUCCESS)
  {
 		NEW(peer_pinv);
-		bcopy((const char *)pinv, (char *)peer_pinv, sizeof(inventory_t));
+		memcpy(peer_pinv, pinv, sizeof(inventory_t));
 		if (hwgraph_info_add_LBL(peer_conn_v, INFO_LBL_INVENT,
 			    (arbitrary_info_t)peer_pinv) != GRAPH_SUCCESS) {
 			DEL(peer_pinv);
diff -Nru a/drivers/scsi/ncr53c8xx.c b/drivers/scsi/ncr53c8xx.c
--- a/drivers/scsi/ncr53c8xx.c	Sun Sep 28 10:35:52 2003
+++ b/drivers/scsi/ncr53c8xx.c	Sun Sep 28 10:35:52 2003
@@ -7757,7 +7757,7 @@
 	cp->start.schedule.l_cmd = cpu_to_scr(SCR_JUMP);
 	cp->start.p_phys	 = cpu_to_scr(CCB_PHYS(cp, phys));
 
-	bcopy(&cp->start, &cp->restart, sizeof(cp->restart));
+	memcpy(&cp->restart, &cp->start, sizeof(cp->restart));
 
 	cp->start.schedule.l_paddr   = cpu_to_scr(NCB_SCRIPT_PHYS (np, idle));
 	cp->restart.schedule.l_paddr = cpu_to_scr(NCB_SCRIPTH_PHYS (np, abort));
diff -Nru a/drivers/scsi/sym53c8xx_2/sym_glue.h b/drivers/scsi/sym53c8xx_2/sym_glue.h
--- a/drivers/scsi/sym53c8xx_2/sym_glue.h	Sun Sep 28 10:35:52 2003
+++ b/drivers/scsi/sym53c8xx_2/sym_glue.h	Sun Sep 28 10:35:52 2003
@@ -70,10 +70,6 @@
 #include <scsi/scsi_host.h>
 #include "../scsi.h"		/* XXX: DID_* */
 
-#ifndef bcopy
-#define bcopy(s, d, n)	memcpy((d), (s), (n))
-#endif
-
 #ifndef bzero
 #define bzero(d, n)	memset((d), 0, (n))
 #endif
diff -Nru a/drivers/scsi/sym53c8xx_2/sym_hipd.c b/drivers/scsi/sym53c8xx_2/sym_hipd.c
--- a/drivers/scsi/sym53c8xx_2/sym_hipd.c	Sun Sep 28 10:35:52 2003
+++ b/drivers/scsi/sym53c8xx_2/sym_hipd.c	Sun Sep 28 10:35:52 2003
@@ -5889,9 +5889,9 @@
 	/*
 	 *  Copy scripts to controller instance.
 	 */
-	bcopy(fw->a_base, np->scripta0, np->scripta_sz);
-	bcopy(fw->b_base, np->scriptb0, np->scriptb_sz);
-	bcopy(fw->z_base, np->scriptz0, np->scriptz_sz);
+	memcpy(np->scripta0, fw->a_base, np->scripta_sz);
+	memcpy(np->scriptb0, fw->b_base, np->scriptb_sz);
+	memcpy(np->scriptz0, fw->z_base, np->scriptz_sz);
 
 	/*
 	 *  Setup variable parts in scripts and compute
diff -Nru a/drivers/scsi/sym53c8xx_2/sym_misc.c b/drivers/scsi/sym53c8xx_2/sym_misc.c
--- a/drivers/scsi/sym53c8xx_2/sym_misc.c	Sun Sep 28 10:35:52 2003
+++ b/drivers/scsi/sym53c8xx_2/sym_misc.c	Sun Sep 28 10:35:52 2003
@@ -225,7 +225,7 @@
  */
 void sym_update_trans_settings(hcb_p np, tcb_p tp)
 {
-	bcopy(&tp->tinfo.user, &tp->tinfo.goal, sizeof(tp->tinfo.goal));
+	memcpy(&tp->tinfo.goal, &tp->tinfo.user, sizeof(tp->tinfo.goal));
 
 	if (tp->inq_version >= 4) {
 		switch(tp->inq_byte56 & INQ56_CLOCKING) {
diff -Nru a/drivers/scsi/sym53c8xx_comm.h b/drivers/scsi/sym53c8xx_comm.h
--- a/drivers/scsi/sym53c8xx_comm.h	Sun Sep 28 10:35:52 2003
+++ b/drivers/scsi/sym53c8xx_comm.h	Sun Sep 28 10:35:52 2003
@@ -88,10 +88,6 @@
 #define u_int		unsigned int
 #define u_long		unsigned long
 
-#ifndef bcopy
-#define bcopy(s, d, n)	memcpy((d), (s), (n))
-#endif
-
 #ifndef bcmp
 #define bcmp(s, d, n)	memcmp((d), (s), (n))
 #endif
diff -Nru a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
--- a/fs/jfs/jfs_imap.c	Sun Sep 28 10:35:52 2003
+++ b/fs/jfs/jfs_imap.c	Sun Sep 28 10:35:52 2003
@@ -838,7 +838,7 @@
 	 */
 	if (S_ISDIR(ip->i_mode)
 	    && (ip->i_ipmnt->i_mntflag & JFS_DASD_ENABLED))
-		bcopy(&ip->i_DASD, &dp->di_DASD, sizeof(struct dasd));
+		memcpy(&dp->di_DASD, &ip->i_DASD, sizeof(struct dasd));
 #endif				/*  _JFS_FASTDASD */
 
 	/* release the buffer holding the updated on-disk inode. 
