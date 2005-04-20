Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261285AbVDTCUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbVDTCUh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 22:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbVDTCTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 22:19:30 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:54290 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261285AbVDTCSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 22:18:23 -0400
Date: Wed, 20 Apr 2005 04:18:20 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux@syskonnect.de
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: [2.6 patch] remove drivers/net/skfp/lnkstat.c
Message-ID: <20050420021820.GE5489@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes a file that seems to be used only on AIX (sic).

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/skfp/Makefile  |    2 
 drivers/net/skfp/lnkstat.c |  204 -------------------------------------
 2 files changed, 1 insertion(+), 205 deletions(-)

--- linux-2.6.12-rc2-mm3-full/drivers/net/skfp/Makefile.old	2005-04-20 01:39:14.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/net/skfp/Makefile	2005-04-20 01:39:33.000000000 +0200
@@ -6,7 +6,7 @@
 
 skfp-objs :=  skfddi.o    hwmtm.o    fplustm.o  smt.o      cfm.o     \
               ecm.o       pcmplc.o   pmf.o      queue.o    rmt.o     \
-	      smtdef.o    smtinit.o  smttimer.o srf.o      lnkstat.o \
+	      smtdef.o    smtinit.o  smttimer.o srf.o \
               hwt.o      drvfbi.o   ess.o
 
 # NOTE:
--- linux-2.6.12-rc2-mm3-full/drivers/net/skfp/lnkstat.c	2005-04-20 01:35:22.000000000 +0200
+++ /dev/null	2005-03-19 22:42:59.000000000 +0100
@@ -1,204 +0,0 @@
-/******************************************************************************
- *
- *	(C)Copyright 1998,1999 SysKonnect,
- *	a business unit of Schneider & Koch & Co. Datensysteme GmbH.
- *
- *	See the file "skfddi.c" for further information.
- *
- *	This program is free software; you can redistribute it and/or modify
- *	it under the terms of the GNU General Public License as published by
- *	the Free Software Foundation; either version 2 of the License, or
- *	(at your option) any later version.
- *
- *	The information in this file is provided "AS IS" without warranty.
- *
- ******************************************************************************/
-
-/*
-	IBM FDDI read error log function
-*/
-
-#include "h/types.h"
-#include "h/fddi.h"
-#include "h/smc.h"
-#include "h/lnkstat.h"
-
-#ifndef	lint
-static const char ID_sccs[] = "@(#)lnkstat.c	1.8 97/04/11 (C) SK " ;
-#endif
-
-#ifdef	sun
-#define _far
-#endif
-
-#define EL_IS_OK(x,l)	((((int)&(((struct s_error_log *)0)->x)) + \
-			sizeof(er->x)) <= l)
-
-/*
-	BEGIN_MANUAL_ENTRY(if,func;others;11)
-
-	u_long smt_get_error_word(smc)
-	struct s_smc *smc ;
-
-Function	DOWNCALL	(SMT, lnkstat.c)
-		This functions returns the SMT error work for AIX events.
-
-Return	smt_error_word	These bits are supported:
-
-		SMT_ERL_ALC	== 	[PS/PA].fddiPORTLerFlag
-		SMT_ERL_BLC	==	[PB].fddiPORTLerFlag
-		SMT_ERL_NCC	==	fddiMACNotCopiedFlag
-		SMT_ERL_FEC	==	fddiMACFrameErrorFlag
-
-	END_MANUAL_ENTRY()
- */
-u_long smt_get_error_word(struct s_smc *smc)
-{
-	u_long	st;
-
-	/*
-	 * smt error word low
-	 */
-	st = 0 ;
-	if (smc->s.sas == SMT_SAS) {
-		if (smc->mib.p[PS].fddiPORTLerFlag)
-			st |= SMT_ERL_ALC ;
-	}
-	else {
-		if (smc->mib.p[PA].fddiPORTLerFlag)
-			st |= SMT_ERL_ALC ;
-		if (smc->mib.p[PB].fddiPORTLerFlag)
-			st |= SMT_ERL_BLC ;
-	}
-	if (smc->mib.m[MAC0].fddiMACNotCopiedFlag)
-		st |= SMT_ERL_NCC ;		/* not copied condition */
-	if (smc->mib.m[MAC0].fddiMACFrameErrorFlag)
-		st |= SMT_ERL_FEC ;		/* frame error condition */
-
-	return st;
-}
-
-/*
-	BEGIN_MANUAL_ENTRY(if,func;others;11)
-
-	u_long smt_get_event_word(smc)
-	struct s_smc *smc ;
-
-Function	DOWNCALL	(SMT, lnkstat.c)
-		This functions returns the SMT event work for AIX events.
-
-Return	smt_event_word	always 0
-
-	END_MANUAL_ENTRY()
- */
-u_long smt_get_event_word(struct s_smc *smc)
-{
-	return (u_long) 0;
-}
-
-/*
-	BEGIN_MANUAL_ENTRY(if,func;others;11)
-
-	u_long smt_get_port_event_word(smc)
-	struct s_smc *smc ;
-
-Function	DOWNCALL	(SMT, lnkstat.c)
-		This functions returns the SMT port event work for AIX events.
-
-Return	smt_port_event_word	always 0
-
-	END_MANUAL_ENTRY()
- */
-u_long smt_get_port_event_word(struct s_smc *smc)
-{
-	return (u_long) 0;
-}
-
-/*
-	BEGIN_MANUAL_ENTRY(if,func;others;11)
-
-	u_long smt_read_errorlog(smc,p,len)
-	struct s_smc *smc ;
-	char _far *p ;
-	int len ;
-
-Function	DOWNCALL	(SMT, lnkstat.c)
-		This functions returns the SMT error log field for AIX events.
-
-Para	p	pointer to the error log field
-	len	len of the error log field
-
-Return	len	used len of the error log field
-
-	END_MANUAL_ENTRY()
- */
-int smt_read_errorlog(struct s_smc *smc, char _far *p, int len)
-{
-	int			i ;
-	int			st ;
-	struct s_error_log _far	*er ;
-
-	er = (struct s_error_log _far *) p ;
-	if (len > sizeof(struct s_error_log))
-		len = sizeof(struct s_error_log) ;
-	for (i = 0 ; i < len ; i++)
-		*p++ = 0 ;
-	/*
-	 * set count
-	 */
-	if (EL_IS_OK(set_count_high,len)) {
-		er->set_count_low = (u_short)smc->mib.fddiSMTSetCount.count ;
-		er->set_count_high =
-			(u_short)(smc->mib.fddiSMTSetCount.count >> 16L) ;
-	}
-	/*
-	 * aci
-	 */
-	if (EL_IS_OK(aci_id_code,len)) {
-		er->aci_id_code = 0 ;
-	}
-	/*
-	 * purge counter is missed frames; 16 bits only
-	 */
-	if (EL_IS_OK(purge_frame_counter,len)) {
-		if (smc->mib.m[MAC0].fddiMACCopied_Ct > 0xffff)
-			er->purge_frame_counter = 0xffff ;
-		else
-			er->purge_frame_counter =
-				(u_short)smc->mib.m[MAC0].fddiMACCopied_Ct ;
-	}
-	/*
-	 * CMT and RMT state machines
-	 */
-	if (EL_IS_OK(ecm_state,len))
-		er->ecm_state = smc->mib.fddiSMTECMState ;
-
-	if (EL_IS_OK(pcm_b_state,len)) {
-		if (smc->s.sas == SMT_SAS) {
-			er->pcm_a_state = smc->y[PS].mib->fddiPORTPCMState ;
-			er->pcm_b_state = 0 ;
-		}
-		else {
-			er->pcm_a_state = smc->y[PA].mib->fddiPORTPCMState ;
-			er->pcm_b_state = smc->y[PB].mib->fddiPORTPCMState ;
-		}
-	}
-	if (EL_IS_OK(cfm_state,len))
-		er->cfm_state = smc->mib.fddiSMTCF_State ;
-	if (EL_IS_OK(rmt_state,len))
-		er->rmt_state = smc->mib.m[MAC0].fddiMACRMTState ;
-
-	/*
-	 * smt error word low (we only need the low order 16 bits.)
-	 */
-
-	st = smt_get_error_word(smc) & 0xffff ;
-
-	if (EL_IS_OK(smt_error_low,len))
-		er->smt_error_low = st ;
-
-	if (EL_IS_OK(ucode_version_level,len))
-		er->ucode_version_level = 0x0101 ;
-	return(len) ;
-}
-

