Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265891AbRGPTdK>; Mon, 16 Jul 2001 15:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267686AbRGPTcv>; Mon, 16 Jul 2001 15:32:51 -0400
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:13414
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S265891AbRGPTcl>; Mon, 16 Jul 2001 15:32:41 -0400
Date: Mon, 16 Jul 2001 21:32:37 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux@syskonnect.de
Cc: linux-kernel@vger.kernel.org, kernel-janitor-discuss@jaquet.dk
Subject: [PATCH] check sm_to_para return code in drivers/net/skfp/ess.c (246ac5)
Message-ID: <20010716213237.D896@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The following patch makes drivers//net/skfp/ess.c check the
return code of sm_to_para. It also gratitiously fixes a
spelling error. Patch against 246ac5.

--- linux-246-ac5-clean/drivers/net/skfp/ess.c	Mon Jul 16 20:40:03 2001
+++ linux-246-ac5/drivers/net/skfp/ess.c	Mon Jul 16 21:21:44 2001
@@ -186,7 +186,8 @@
 			if (!local || smc->mib.fddiESSPayload)
 				return(fs) ;
 			
-			p = (void *) sm_to_para(smc,sm,SMT_P0019)  ;
+			if (!(p = (void *) sm_to_para(smc,sm,SMT_P0019)))
+				return(fs) ;
 			for (i = 0; i < 5; i++) {
 				if (((struct smt_p_0019 *)p)->alloc_addr.a[i]) {
 					return(fs) ;
@@ -199,10 +200,12 @@
 			 */
 			smc->ess.alloc_trans_id = sm->smt_tid ;
 			DB_ESS("ESS: save Alloc Req Trans ID %lx\n",sm->smt_tid,0);
-			p = (void *) sm_to_para(smc,sm,SMT_P320F) ;
+			if (!(p = (void *) sm_to_para(smc,sm,SMT_P320F)))
+				return (fs) ;
 			((struct smt_p_320f *)p)->mib_payload =
 				smc->mib.a[PATH0].fddiPATHSbaPayload ;
-			p = (void *) sm_to_para(smc,sm,SMT_P3210) ;
+			if (!(p = (void *) sm_to_para(smc,sm,SMT_P3210)))
+				return (fs) ;
 			((struct smt_p_3210 *)p)->mib_overhead =
 				smc->mib.a[PATH0].fddiPATHSbaOverhead ;
 			sm->smt_dest = smt_sba_da ;
@@ -243,14 +246,19 @@
 		 *
 		 * If any are violated, discard the RAF frame
 		 */
-		if ((((struct smt_p_320b *)sm_to_para(smc,sm,SMT_P320B))->path_index
-			!= PRIMARY_RING) ||
-			(msg_res_type != SYNC_BW) ||
-		(((struct smt_p_reason *)sm_to_para(smc,sm,SMT_P0012))->rdf_reason
-			!= SMT_RDF_SUCCESS) ||
-			(sm->smt_tid != smc->ess.alloc_trans_id)) {
+		if (!(p = (void*) sm_to_para(smc,sm,SMT_P320B)))
+			return (fs) ;
+		if ((((struct smt_p_320b *)p)->path_index != PRIMARY_RING) ||
+		    (msg_res_type != SYNC_BW)) {
+			DB_ESS("ESS: Allocation Response not accepted\n",0,0) ;
+			return(fs) ;
+		}
 
-			DB_ESS("ESS: Allocation Responce not accepted\n",0,0) ;
+		if (!(p = (void*) sm_to_para(smc,sm,SMT_P0012)))
+			return (fs) ;
+		if ((((struct smt_p_reason *)p)->rdf_reason != SMT_RDF_SUCCESS)
+		    || (sm->smt_tid != smc->ess.alloc_trans_id)) {
+			DB_ESS("ESS: Allocation Response not accepted\n",0,0) ;
 			return(fs) ;
 		}
 
@@ -306,8 +314,10 @@
 		 * these are false, don't process this
 		 * change request frame.
 		 */
-		if ((((struct smt_p_320b *)sm_to_para(smc,sm,SMT_P320B))->path_index
-			!= PRIMARY_RING) || (msg_res_type != SYNC_BW)) {
+		if (!(p = sm_to_para(smc,sm,SMT_P320B)))
+			return (fs) ;
+		if ((((struct smt_p_320b *)p)->path_index != PRIMARY_RING) || 
+		    (msg_res_type != SYNC_BW)) {
 			DB_ESS("ESS: RAF frame with para problem, ignoring\n",0,0) ;
 			return(fs) ;
 		}
@@ -315,9 +325,11 @@
 		/*
 		 * Extract message queue parameters
 		 */
-		p = (void *) sm_to_para(smc,sm,SMT_P320F) ;
+		if (!(p = (void *) sm_to_para(smc,sm,SMT_P320F)))
+			return (fs) ;
 		payload = ((struct smt_p_320f *)p)->mib_payload ;
-		p = (void *) sm_to_para(smc,sm,SMT_P3210) ;
+		if (!(p = (void *) sm_to_para(smc,sm,SMT_P3210))) 
+			return (fs) ;
 		overhead = ((struct smt_p_3210 *)p)->mib_overhead ;
 
 		DB_ESSN(2,"ESS: Change Request from %s\n",
@@ -493,7 +505,7 @@
 	void			*p ;
 
 	/*
-	 * get and initialize the responce frame
+	 * get and initialize the response frame
 	 */
 	if (sba_cmd == CHANGE_ALLOCATION) {
 		if (!(mb=smt_build_frame(smc,SMT_RAF,SMT_REPLY,
@@ -543,7 +555,8 @@
 		/* set P1A */
 		chg->cat.para.p_type = SMT_P001A ;
 		chg->cat.para.p_len = sizeof(struct smt_p_001a) - PARA_LEN ;
-		p = (void *) sm_to_para(smc,sm,SMT_P001A) ;
+		if (!(p = (void *) sm_to_para(smc,sm,SMT_P001A)))
+			return (fs) ;
 		chg->cat.category = ((struct smt_p_001a *)p)->category ;
 	}
 	dump_smt(smc,(struct smt_header *)chg,"RAF") ;
@@ -595,7 +608,7 @@
 	}
 	
 	/*
-	 * get and initialize the responce frame
+	 * get and initialize the response frame
 	 */
 	if (!(mb=smt_build_frame(smc,SMT_RAF,SMT_REQUEST,
 			sizeof(struct smt_sba_alc_req))))

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

With Microsoft products, failure is not an option - it's a standard component. 
  -- Anonymous
