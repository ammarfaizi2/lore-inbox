Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261588AbVBSAXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbVBSAXj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 19:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261600AbVBSAXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 19:23:33 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:46340 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261575AbVBSAQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 19:16:23 -0500
Date: Sat, 19 Feb 2005 01:16:21 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@pobox.com, linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/skfp/: cleanups
Message-ID: <20050219001621.GL4337@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- make needlessly global code static
- remove the completely unused smtparse.c
- remove the following unused global functions:
  - drvfbi.c: init_dma
  - drvfbi.c: dis_dma
  - drvfbi.c: get_rom_byte
  - drvfbi.c: mac_drv_vpd_read
  - drvfbi.c: mac_drv_pci_fix
  - fplustm.c: mac_set_func_addr
  - fplustm.c: mac_del_multicast
  - hwmtm.c: mac_drv_rx_frag
  - pcmplc.c: pcm_set_lct_short
  - smt.c: smt_please_reconnect
  - smt.c: smt_change_t_neg
  - smtdef.c: smt_set_defaults

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/skfp/Makefile   |    2 
 drivers/net/skfp/drvfbi.c   |  222 -----------------
 drivers/net/skfp/ess.c      |    4 
 drivers/net/skfp/fplustm.c  |   70 -----
 drivers/net/skfp/h/cmtdef.h |    7 
 drivers/net/skfp/h/hwmtm.h  |   25 -
 drivers/net/skfp/hwmtm.c    |   34 --
 drivers/net/skfp/pcmplc.c   |    7 
 drivers/net/skfp/pmf.c      |   11 
 drivers/net/skfp/skfddi.c   |    1 
 drivers/net/skfp/smt.c      |   46 ---
 drivers/net/skfp/smtdef.c   |    5 
 drivers/net/skfp/smtparse.c |  467 ------------------------------------
 13 files changed, 19 insertions(+), 882 deletions(-)

--- linux-2.6.11-rc3-mm2-full/drivers/net/skfp/smtparse.c	2005-02-17 02:17:05.000000000 +0100
+++ /dev/null	2004-11-25 03:16:25.000000000 +0100
@@ -1,467 +0,0 @@
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
-
-/*
-	parser for SMT parameters
-*/
-
-#include "h/types.h"
-#include "h/fddi.h"
-#include "h/smc.h"
-#include "h/smt_p.h"
-
-#define KERNEL
-#include "h/smtstate.h"
-
-#ifndef	lint
-static const char ID_sccs[] = "@(#)smtparse.c	1.12 98/10/06 (C) SK " ;
-#endif
-
-#ifdef	sun
-#define _far
-#endif
-
-/*
- * convert to BCLK units
- */
-#define MS2BCLK(x)      ((x)*12500L)
-#define US2BCLK(x)      ((x/10)*125L)
-
-/*
- * parameter table
- */
-static struct s_ptab {
-	char	*pt_name ;
-	u_short	pt_num ;
-	u_short	pt_type ;
-	u_long	pt_min ;
-	u_long	pt_max ;
-} ptab[] = {
-	{ "PMFPASSWD",0,	0 } ,
-	{ "USERDATA",1,		0 } ,
-	{ "LERCUTOFFA",2,	1,	4,	15	} ,
-	{ "LERCUTOFFB",3,	1,	4,	15	} ,
-	{ "LERALARMA",4,	1,	4,	15	} ,
-	{ "LERALARMB",5,	1,	4,	15	} ,
-	{ "TMAX",6,		1,	5,	165	} ,
-	{ "TMIN",7,		1,	5,	165	} ,
-	{ "TREQ",8,		1,	5,	165	} ,
-	{ "TVX",9,		1,	2500,	10000	} ,
-#ifdef ESS
-	{ "SBAPAYLOAD",10,	1,	0,	1562	} ,
-	{ "SBAOVERHEAD",11,	1,	50,	5000	} ,
-	{ "MAXTNEG",12,		1,	5,	165	} ,
-	{ "MINSEGMENTSIZE",13,	1,	0,	4478	} ,
-	{ "SBACATEGORY",14,	1,	0,	0xffff	} ,
-	{ "SYNCHTXMODE",15,	0 } ,
-#endif
-#ifdef SBA
-	{ "SBACOMMAND",16,	0 } ,
-	{ "SBAAVAILABLE",17,	1,	0,	100	} ,
-#endif
-	{ NULL }
-} ;
-
-/* Define maximum string size for values and keybuffer */
-#define MAX_VAL	40
-
-/*
- * local function declarations
- */
-static u_long parse_num(int type, char _far *value, char *v, u_long mn,
-			u_long mx, int scale);
-static int parse_word(char *buf, char _far *text);
-
-#ifdef SIM
-#define DB_MAIN(a,b,c)	printf(a,b,c)
-#else
-#define DB_MAIN(a,b,c)
-#endif
-
-/*
- * BEGIN_MANUAL_ENTRY()
- *
- *	int smt_parse_arg(struct s_smc *,char _far *keyword,int type,
-		char _far *value)
- *
- *	parse SMT parameter
- *	*keyword
- *		pointer to keyword, must be \0, \n or \r terminated
- *	*value	pointer to value, either char * or u_long *
- *		if char *
- *			pointer to value, must be \0, \n or \r terminated
- *		if u_long *
- *			contains binary value
- *
- *	type	0: integer
- *		1: string
- *	return
- *		0	parameter parsed ok
- *		!= 0	error
- *	NOTE:
- *		function can be called with DS != SS
- *
- *
- * END_MANUAL_ENTRY()
- */
-int smt_parse_arg(struct s_smc *smc, char _far *keyword, int type,
-		  char _far *value)
-{
-	char		keybuf[MAX_VAL+1];
-	char		valbuf[MAX_VAL+1];
-	char		c ;
-	char 		*p ;
-	char		*v ;
-	char		*d ;
-	u_long		val = 0 ;
-	struct s_ptab	*pt ;
-	int		st ;
-	int		i ;
-
-	/*
-	 * parse keyword
-	 */
-	if ((st = parse_word(keybuf,keyword)))
-		return(st) ;
-	/*
-	 * parse value if given as string
-	 */
-	if (type == 1) {
-		if ((st = parse_word(valbuf,value)))
-			return(st) ;
-	}
-	/*
-	 * search in table
-	 */
-	st = 0 ;
-	for (pt = ptab ; (v = pt->pt_name) ; pt++) {
-		for (p = keybuf ; (c = *p) ; p++,v++) {
-			if (c != *v)
-				break ;
-		}
-		if (!c && !*v)
-			break ;
-	}
-	if (!v)
-		return(-1) ;
-#if	0
-	printf("=>%s<==>%s<=\n",pt->pt_name,valbuf) ;
-#endif
-	/*
-	 * set value in MIB
-	 */
-	if (pt->pt_type)
-		val = parse_num(type,value,valbuf,pt->pt_min,pt->pt_max,1) ;
-	switch (pt->pt_num) {
-	case 0 :
-		v = valbuf ;
-		d = (char *) smc->mib.fddiPRPMFPasswd ;
-		for (i = 0 ; i < (signed)sizeof(smc->mib.fddiPRPMFPasswd) ; i++)
-			*d++ = *v++ ;
-		DB_MAIN("SET %s = %s\n",pt->pt_name,smc->mib.fddiPRPMFPasswd) ;
-		break ;
-	case 1 :
-		v = valbuf ;
-		d = (char *) smc->mib.fddiSMTUserData ;
-		for (i = 0 ; i < (signed)sizeof(smc->mib.fddiSMTUserData) ; i++)
-			*d++ = *v++ ;
-		DB_MAIN("SET %s = %s\n",pt->pt_name,smc->mib.fddiSMTUserData) ;
-		break ;
-	case 2 :
-		smc->mib.p[PA].fddiPORTLer_Cutoff = (u_char) val ;
-		DB_MAIN("SET %s = %d\n",
-			pt->pt_name,smc->mib.p[PA].fddiPORTLer_Cutoff) ;
-		break ;
-	case 3 :
-		smc->mib.p[PB].fddiPORTLer_Cutoff = (u_char) val ;
-		DB_MAIN("SET %s = %d\n",
-			pt->pt_name,smc->mib.p[PB].fddiPORTLer_Cutoff) ;
-		break ;
-	case 4 :
-		smc->mib.p[PA].fddiPORTLer_Alarm = (u_char) val ;
-		DB_MAIN("SET %s = %d\n",
-			pt->pt_name,smc->mib.p[PA].fddiPORTLer_Alarm) ;
-		break ;
-	case 5 :
-		smc->mib.p[PB].fddiPORTLer_Alarm = (u_char) val ;
-		DB_MAIN("SET %s = %d\n",
-			pt->pt_name,smc->mib.p[PB].fddiPORTLer_Alarm) ;
-		break ;
-	case 6 :			/* TMAX */
-		DB_MAIN("SET %s = %d\n",pt->pt_name,val) ;
-		smc->mib.a[PATH0].fddiPATHT_MaxLowerBound =
-			(u_long) -MS2BCLK((long)val) ;
-		break ;
-	case 7 :			/* TMIN */
-		DB_MAIN("SET %s = %d\n",pt->pt_name,val) ;
-		smc->mib.m[MAC0].fddiMACT_Min =
-			(u_long) -MS2BCLK((long)val) ;
-		break ;
-	case 8 :			/* TREQ */
-		DB_MAIN("SET %s = %d\n",pt->pt_name,val) ;
-		smc->mib.a[PATH0].fddiPATHMaxT_Req =
-			(u_long) -MS2BCLK((long)val) ;
-		break ;
-	case 9 :			/* TVX */
-		DB_MAIN("SET %s = %d \n",pt->pt_name,val) ;
-		smc->mib.a[PATH0].fddiPATHTVXLowerBound =
-			(u_long) -US2BCLK((long)val) ;
-		break ;
-#ifdef	ESS
-	case 10 :			/* SBAPAYLOAD */
-		DB_MAIN("SET %s = %d\n",pt->pt_name,val) ;
-		if (smc->mib.fddiESSPayload != val) {
-			smc->ess.raf_act_timer_poll = TRUE ;
-			smc->mib.fddiESSPayload = val ;
-		}
-		break ;
-	case 11 :			/* SBAOVERHEAD */
-		DB_MAIN("SET %s = %d\n",pt->pt_name,val) ;
-		smc->mib.fddiESSOverhead = val ;
-		break ;
-	case 12 :			/* MAXTNEG */
-		DB_MAIN("SET %s = %d\n",pt->pt_name,val) ;
-		smc->mib.fddiESSMaxTNeg = (u_long) -MS2BCLK((long)val) ;
-		break ;
-	case 13 :			/* MINSEGMENTSIZE */
-		DB_MAIN("SET %s = %d\n",pt->pt_name,val) ;
-		smc->mib.fddiESSMinSegmentSize = val ;
-		break ;
-	case 14 :			/* SBACATEGORY */
-		DB_MAIN("SET %s = %d\n",pt->pt_name,val) ;
-		smc->mib.fddiESSCategory =
-			(smc->mib.fddiESSCategory & 0xffff) |
-			((u_long)(val << 16)) ;
-		break ;
-	case 15 :			/* SYNCHTXMODE */
-		/* do not use memcmp(valbuf,"ALL",3) because DS != SS */
-		if (valbuf[0] == 'A' && valbuf[1] == 'L' && valbuf[2] == 'L') {
-			smc->mib.fddiESSSynchTxMode = TRUE ;
-			DB_MAIN("SET %s = %s\n",pt->pt_name,valbuf) ;
-		}
-		/* if (!memcmp(valbuf,"SPLIT",5)) { */
-		if (valbuf[0] == 'S' && valbuf[1] == 'P' && valbuf[2] == 'L' &&
-			valbuf[3] == 'I' && valbuf[4] == 'T') {
-			DB_MAIN("SET %s = %s\n",pt->pt_name,valbuf) ;
-			smc->mib.fddiESSSynchTxMode = FALSE ;
-		}
-		break ;
-#endif
-#ifdef	SBA
-	case 16 :			/* SBACOMMAND */
-		/* if (!memcmp(valbuf,"START",5)) { */
-		if (valbuf[0] == 'S' && valbuf[1] == 'T' && valbuf[2] == 'A' &&
-			valbuf[3] == 'R' && valbuf[4] == 'T') {
-			DB_MAIN("SET %s = %s\n",pt->pt_name,valbuf) ;
-			smc->mib.fddiSBACommand = SB_START ;
-		}
-		/* if (!memcmp(valbuf,"STOP",4)) { */
-		if (valbuf[0] == 'S' && valbuf[1] == 'T' && valbuf[2] == 'O' &&
-			valbuf[3] == 'P') {
-			DB_MAIN("SET %s = %s\n",pt->pt_name,valbuf) ;
-			smc->mib.fddiSBACommand = SB_STOP ;
-		}
-		break ;
-	case 17 :			/* SBAAVAILABLE */
-		DB_MAIN("SET %s = %d\n",pt->pt_name,val) ;
-		smc->mib.fddiSBAAvailable = (u_char) val ;
-		break ;
-#endif
-	}
-	return(0) ;
-}
-
-static int parse_word(char *buf, char _far *text)
-{
-	char		c ;
-	char 		*p ;
-	int		p_len ;
-	int		quote ;
-	int		i ;
-	int		ok ;
-
-	/*
-	 * skip leading white space
-	 */
-	p = buf ;
-	for (i = 0 ; i < MAX_VAL ; i++)
-		*p++ = 0 ;
-	p = buf ;
-	p_len = 0 ;
-	ok = 0 ;
-	while ( (c = *text++) && (c != '\n') && (c != '\r')) {
-		if ((c != ' ') && (c != '\t')) {
-			ok = 1 ;
-			break ;
-		}
-	}
-	if (!ok)
-		return(-1) ;
-	if (c == '"') {
-		quote = 1 ;
-	}
-	else {
-		quote = 0 ;
-		text-- ;
-	}
-	/*
-	 * parse valbuf
-	 */
-	ok = 0 ;
-	while (!ok && p_len < MAX_VAL-1 && (c = *text++) && (c != '\n')
-		&& (c != '\r')) {
-		switch (quote) {
-		case 0 :
-			if ((c == ' ') || (c == '\t') || (c == '=')) {
-				ok = 1 ;
-				break ;
-			}
-			*p++ = c ;
-			p_len++ ;
-			break ;
-		case 2 :
-			*p++ = c ;
-			p_len++ ;
-			quote = 1 ;
-			break ;
-		case 1 :
-			switch (c) {
-			case '"' :
-				ok = 1 ;
-				break ;
-			case '\\' :
-				quote = 2 ;
-				break ;
-			default :
-				*p++ = c ;
-				p_len++ ;
-			}
-		}
-	}
-	*p++ = 0 ;
-	for (p = buf ; (c = *p) ; p++) {
-		if (c >= 'a' && c <= 'z')
-			*p = c + 'A' - 'a' ;
-	}
-	return(0) ;
-}
-
-static u_long parse_num(int type, char _far *value, char *v, u_long mn,
-			u_long mx, int scale)
-{
-	u_long	x = 0 ;
-	char	c ;
-
-	if (type == 0) {		/* integer */
-		u_long _far	*l ;
-		u_long		u1 ;
-
-		l = (u_long _far *) value ;
-		u1 = *l ;
-		/*
-		 * if the value is negative take the lower limit
-		 */
-		if ((long)u1 < 0) {
-			if (- ((long)u1) > (long) mx) {
-				u1 = 0 ;
-			}
-			else {
-				u1 = (u_long) - ((long)u1) ;
-			}
-		}
-		x = u1 ;
-	}
-	else {				/* string */
-		int	sign = 0 ;
-
-		if (*v == '-') {
-			sign = 1 ;
-		}
-		while ((c = *v++) && (c >= '0') && (c <= '9')) {
-			x = x * 10 + c - '0' ;
-		}
-		if (scale == 10) {
-			x *= 10 ;
-			if (c == '.') {
-				if ((c = *v++) && (c >= '0') && (c <= '9')) {
-					x += c - '0' ;
-				}
-			}
-		}
-		if (sign)
-			x = (u_long) - ((long)x) ;
-	}
-	/*
-	 * if the value is negative
-	 *	and the absolute value is outside the limits
-	 *		take the lower limit
-	 *	else
-	 *		take the absoute value
-	 */
-	if ((long)x < 0) {
-		if (- ((long)x) > (long) mx) {
-			x = 0 ;
-		}
-		else {
-			x = (u_long) - ((long)x) ;
-		}
-	}
-	if (x < mn)
-		return(mn) ;
-	else if (x > mx)
-		return(mx) ;
-	return(x) ;
-}
-
-#if 0
-struct	s_smc	SMC ;
-main()
-{
-	char	*p ;
-	char	*v ;
-	char	buf[100] ;
-	int	toggle = 0 ;
-
-	while (gets(buf)) {
-		p = buf ;
-		while (*p && ((*p == ' ') || (*p == '\t')))
-			p++ ;
-
-		while (*p && ((*p != ' ') && (*p != '\t')))
-			p++ ;
-
-		v = p ;
-		while (*v && ((*v == ' ') || (*v == '\t')))
-			v++ ;
-		if ((*v >= '0') && (*v <= '9')) {
-			toggle = !toggle ;
-			if (toggle) {
-				u_long	l ;
-				l = atol(v) ;
-				smt_parse_arg(&SMC,buf,0,(char _far *)&l) ;
-			}
-			else
-				smt_parse_arg(&SMC,buf,1,(char _far *)p) ;
-		}
-		else {
-			smt_parse_arg(&SMC,buf,1,(char _far *)p) ;
-		}
-	}
-	exit(0) ;
-}
-#endif
-
--- linux-2.6.11-rc3-mm2-full/drivers/net/skfp/h/cmtdef.h.old	2005-02-16 18:25:59.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/skfp/h/cmtdef.h	2005-02-16 19:05:50.000000000 +0100
@@ -507,7 +507,6 @@
 		      int *remote, int *mac);
 void plc_config_mux(struct s_smc *smc, int mux);
 void sm_lem_evaluate(struct s_smc *smc);
-void smt_clear_una_dna(struct s_smc *smc);
 void mac_update_counter(struct s_smc *smc);
 void sm_pm_ls_latch(struct s_smc *smc, int phy, int on_off);
 void sm_ma_control(struct s_smc *smc, int mode);
@@ -541,11 +540,9 @@
 u_long smt_get_time(void);
 u_long smt_get_tid(struct s_smc *smc);
 void smt_timer_done(struct s_smc *smc);
-void smt_set_defaults(struct s_smc *smc);
 void smt_fixup_mib(struct s_smc *smc);
 void smt_reset_defaults(struct s_smc *smc, int level);
 void smt_agent_task(struct s_smc *smc);
-void smt_please_reconnect(struct s_smc *smc, int reconn_time);
 int smt_check_para(struct s_smc *smc, struct smt_header *sm,
 		   const u_short list[]);
 void driver_get_bia(struct s_smc *smc, struct fddi_addr *bia_addr);
@@ -568,7 +565,6 @@
 int pcm_rooted_station(struct s_smc *smc);
 int cfm_get_mac_input(struct s_smc *smc);
 int cfm_get_mac_output(struct s_smc *smc);
-int port_to_mib(struct s_smc *smc, int p);
 int cem_build_path(struct s_smc *smc, char *to, int path_index);
 int sm_mac_get_tx_state(struct s_smc *smc);
 char *get_pcmstate(struct s_smc *smc, int np);
@@ -580,8 +576,6 @@
 void smt_set_timestamp(struct s_smc *smc, u_char *p);
 void mac_set_rx_mode(struct s_smc *smc,	int mode);
 int mac_add_multicast(struct s_smc *smc, struct fddi_addr *addr, int can);
-int mac_set_func_addr(struct s_smc *smc, u_long f_addr);
-void mac_del_multicast(struct s_smc *smc, struct fddi_addr *addr, int can);
 void mac_update_multicast(struct s_smc *smc);
 void mac_clear_multicast(struct s_smc *smc);
 void set_formac_tsync(struct s_smc *smc, long sync_bw);
@@ -599,7 +593,6 @@
 int smt_set_mac_opvalues(struct s_smc *smc);
 
 #ifdef TAG_MODE
-void mac_drv_pci_fix(struct s_smc *smc, u_long fix_value);
 void mac_do_pci_fix(struct s_smc *smc);
 void mac_drv_clear_tx_queue(struct s_smc *smc);
 void mac_drv_repair_descr(struct s_smc *smc);
--- linux-2.6.11-rc3-mm2-full/drivers/net/skfp/drvfbi.c.old	2005-02-16 18:23:36.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/skfp/drvfbi.c	2005-02-16 19:07:09.000000000 +0100
@@ -105,8 +105,8 @@
 #endif
 
 
-/* Prototypes of local functions. */
-void smt_stop_watchdog(struct s_smc *smc);
+/* Prototype of a local function. */
+static void smt_stop_watchdog(struct s_smc *smc);
 
 #ifdef MCA
 static int read_card_id() ;
@@ -631,7 +631,7 @@
  *	LED_Y_OFF	just switch yellow LED off
  *	LED_Y_ON	just switch yello LED on
  */
-void led_indication(struct s_smc *smc, int led_event)
+static void led_indication(struct s_smc *smc, int led_event)
 {
 	/* use smc->hw.mac_ring_is_up == TRUE 
 	 * as indication for Ring Operational
@@ -764,122 +764,6 @@
 #endif
 }
 
-/*--------------------------- DMA init ----------------------------*/
-#ifdef	ISA
-
-/*
- * init DMA
- */
-void init_dma(struct s_smc *smc, int dma)
-{
-	SK_UNUSED(smc) ;
-
-	/*
-	 * set cascade mode,
-	 * clear mask bit (enable DMA cannal)
-	 */
-	if (dma > 3) {
-		outp(0xd6,(dma & 0x03) | 0xc0) ;
-		outp(0xd4, dma & 0x03) ;
-	}
-	else {
-		outp(0x0b,(dma & 0x03) | 0xc0) ;
-		outp(0x0a,dma & 0x03) ;
-	}
-}
-
-/*
- * disable DMA
- */
-void dis_dma(struct s_smc *smc, int dma)
-{
-	SK_UNUSED(smc) ;
-
-	/*
-	 * set mask bit (disable DMA cannal)
-	 */
-	if (dma > 3) {
-		outp(0xd4,(dma & 0x03) | 0x04) ;
-	}
-	else {
-		outp(0x0a,(dma & 0x03) | 0x04) ;
-	}
-}
-
-#endif	/* ISA */
-
-#ifdef	EISA
-
-/*arrays with io addresses of dma controller length and address registers*/
-static const int cntr[8] = { 0x001,0x003,0x005,0x007,0,0x0c6,0x0ca,0x0ce } ;
-static const int base[8] = { 0x000,0x002,0x004,0x006,0,0x0c4,0x0c8,0x0cc } ;
-static const int page[8] = { 0x087,0x083,0x081,0x082,0,0x08b,0x089,0x08a } ;
-
-void init_dma(struct s_smc *smc, int dma)
-{
-	/*
-	 * extended mode register
-	 * 32 bit IO
-	 * type c
-	 * TC output
-	 * disable stop
-	 */
-
-	/* mode read (write) demand */
-	smc->hw.dma_rmode = (dma & 3) | 0x08 | 0x0 ;
-	smc->hw.dma_wmode = (dma & 3) | 0x04 | 0x0 ;
-
-	/* 32 bit IO's, burst DMA mode (type "C") */
-	smc->hw.dma_emode = (dma & 3) | 0x08 | 0x30 ;
-
-	outp((dma < 4) ? 0x40b : 0x4d6,smc->hw.dma_emode) ;
-
-	/* disable chaining */
-	outp((dma < 4) ? 0x40a : 0x4d4,(dma&3)) ;
-
-	/*load dma controller addresses for fast access during set dma*/
-	smc->hw.dma_base_word_count = cntr[smc->hw.dma];
-	smc->hw.dma_base_address = base[smc->hw.dma];
-	smc->hw.dma_base_address_page = page[smc->hw.dma];
-
-}
-
-void dis_dma(struct s_smc *smc, int dma)
-{
-	SK_UNUSED(smc) ;
-
-	outp((dma < 4) ? 0x0a : 0xd4,(dma&3)|4) ;/* mask bit */
-}
-#endif	/* EISA */
-
-#ifdef	MCA
-void init_dma(struct s_smc *smc, int dma)
-{
-	SK_UNUSED(smc) ;
-	SK_UNUSED(dma) ;
-}
-
-void dis_dma(struct s_smc *smc, int dma)
-{
-	SK_UNUSED(smc) ;
-	SK_UNUSED(dma) ;
-}
-#endif
-
-#ifdef	PCI
-void init_dma(struct s_smc *smc, int dma)
-{
-	SK_UNUSED(smc) ;
-	SK_UNUSED(dma) ;
-}
-
-void dis_dma(struct s_smc *smc, int dma)
-{
-	SK_UNUSED(smc) ;
-	SK_UNUSED(dma) ;
-}
-#endif
-
 #ifdef MULT_OEM
 static int is_equal_num(char comp1[], char comp2[], int num)
 {
@@ -1407,7 +1291,7 @@
 #endif	/* DEBUG */
 }
 
-void smt_stop_watchdog(struct s_smc *smc)
+static void smt_stop_watchdog(struct s_smc *smc)
 {
 	SK_UNUSED(smc) ;	/* Make LINT happy. */
 #ifndef	DEBUG
@@ -1422,104 +1306,6 @@
 }
 
 #ifdef	PCI
-static char get_rom_byte(struct s_smc *smc, u_short addr)
-{
-	GET_PAGE(addr) ;
-	return (READ_PROM(ADDR(B2_FDP))) ;
-}
-
-/*
- * ROM image defines
- */
-#define	ROM_SIG_1	0
-#define ROM_SIG_2	1
-#define PCI_DATA_1	0x18
-#define PCI_DATA_2	0x19
-
-/*
- * PCI data structure defines
- */
-#define	VPD_DATA_1	0x08
-#define	VPD_DATA_2	0x09
-#define IMAGE_LEN_1	0x10
-#define IMAGE_LEN_2	0x11
-#define	CODE_TYPE	0x14
-#define	INDICATOR	0x15
-
-/*
- *	BEGIN_MANUAL_ENTRY(mac_drv_vpd_read)
- *	mac_drv_vpd_read(smc,buf,size,image)
- *
- * function	DOWNCALL	(FDDIWARE)
- *		reads the VPD data of the FPROM and writes it into the
- *		buffer
- *
- * para	buf	points to the buffer for the VPD data
- *	size	size of the VPD data buffer
- *	image	boot image; code type of the boot image
- *		image = 0	Intel x86, PC-AT compatible
- *			1	OPENBOOT standard for PCI
- *			2-FF	reserved
- *
- * returns	len	number of VPD data bytes read form the FPROM
- *		<0	number of read bytes
- *		>0	error: data invalid
- *
- *	END_MANUAL_ENTRY
- */
-int mac_drv_vpd_read(struct s_smc *smc, char *buf, int size, char image)
-{
-	u_short	ibase ;
-	u_short pci_base ;
-	u_short vpd ;
-	int	len ;
-
-	len = 0 ;
-	ibase = 0 ;
-	/*
-	 * as long images defined
-	 */
-	while (get_rom_byte(smc,ibase+ROM_SIG_1) == 0x55 &&
-		(u_char) get_rom_byte(smc,ibase+ROM_SIG_2) == 0xaa) {
-		/*
-		 * get the pointer to the PCI data structure
-		 */
-		pci_base = ibase + get_rom_byte(smc,ibase+PCI_DATA_1) +
-				(get_rom_byte(smc,ibase+PCI_DATA_2) << 8) ;
-
-		if (image == get_rom_byte(smc,pci_base+CODE_TYPE)) {
-			/*
-			 * we have the right image, read the VPD data
-			 */
-			vpd = ibase + get_rom_byte(smc,pci_base+VPD_DATA_1) +
-				(get_rom_byte(smc,pci_base+VPD_DATA_2) << 8) ;
-			if (vpd == ibase) {
-				break ;		/* no VPD data */
-			}
-			for (len = 0; len < size; len++,buf++,vpd++) {
-				*buf = get_rom_byte(smc,vpd) ;
-			}
-			break ;
-		}
-		else {
-			/*
-			 * try the next image
-			 */
-			if (get_rom_byte(smc,pci_base+INDICATOR) & 0x80) {
-				break ;		/* this was the last image */
-			}
-			ibase = ibase + get_rom_byte(smc,ibase+IMAGE_LEN_1) +
-				(get_rom_byte(smc,ibase+IMAGE_LEN_2) << 8) ;
-		}
-	}
-
-	return(len) ;
-}
-
-void mac_drv_pci_fix(struct s_smc *smc, u_long fix_value)
-{
-	smc->hw.pci_fix_value = fix_value ;
-}
 
 void mac_do_pci_fix(struct s_smc *smc)
 {
--- linux-2.6.11-rc3-mm2-full/drivers/net/skfp/ess.c.old	2005-02-16 18:27:37.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/skfp/ess.c	2005-02-16 18:27:50.000000000 +0100
@@ -102,7 +102,7 @@
 void ess_para_change(struct s_smc *smc);
 int ess_raf_received_pack(struct s_smc *smc, SMbuf *mb, struct smt_header *sm,
 			  int fs);
-int process_bw_alloc(struct s_smc *smc, long int payload, long int overhead);
+static int process_bw_alloc(struct s_smc *smc, long int payload, long int overhead);
 
 
 /*
@@ -375,7 +375,7 @@
  * determines the synchronous bandwidth, set the TSYNC register and the
  * mib variables SBAPayload, SBAOverhead and fddiMACT-NEG.
  */
-int process_bw_alloc(struct s_smc *smc, long int payload, long int overhead)
+static int process_bw_alloc(struct s_smc *smc, long int payload, long int overhead)
 {
 	/*
 	 * determine the synchronous bandwidth (sync_bw) in bytes per T-NEG,
--- linux-2.6.11-rc3-mm2-full/drivers/net/skfp/fplustm.c.old	2005-02-16 18:28:20.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/skfp/fplustm.c	2005-02-16 18:29:05.000000000 +0100
@@ -1117,30 +1117,6 @@
 /*
 	BEGIN_MANUAL_ENTRY(if,func;others;2)
 
-	int mac_set_func_addr(smc,f_addr)
-	struct s_smc *smc ;
-	u_long f_addr ;
-
-Function	DOWNCALL	(SMT, fplustm.c)
-		Set a Token-Ring functional address, the address will
-		be activated after calling mac_update_multicast()
-
-Para	f_addr	functional bits in non-canonical format
-
-Returns	0: always success
-
-	END_MANUAL_ENTRY()
- */
-int mac_set_func_addr(struct s_smc *smc, u_long f_addr)
-{
-	smc->hw.fp.func_addr = f_addr ;
-	return(0) ;
-}
-
-
-/*
-	BEGIN_MANUAL_ENTRY(if,func;others;2)
-
 	int mac_add_multicast(smc,addr,can)
 	struct s_smc *smc ;
 	struct fddi_addr *addr ;
@@ -1203,52 +1179,6 @@
 }
 
 /*
-	BEGIN_MANUAL_ENTRY(if,func;others;2)
-
-	void mac_del_multicast(smc,addr,can)
-	struct s_smc *smc ;
-	struct fddi_addr *addr ;
-	int can ;
-
-Function	DOWNCALL	(SMT, fplustm.c)
-		Delete an entry from the multicast table
-
-Para	addr	pointer to a multicast address
-	can	= 0:	the multicast address has the physical format
-		= 1:	the multicast address has the canonical format
-		| 0x80	permanent
-
-	END_MANUAL_ENTRY()
- */
-void mac_del_multicast(struct s_smc *smc, struct fddi_addr *addr, int can)
-{
-	SK_LOC_DECL(struct fddi_addr,own) ;
-	struct s_fpmc	*tb ;
-
-	if (!(tb = mac_get_mc_table(smc,addr,&own,1,can & ~0x80)))
-		return ;
-	/*
-	 * permanent addresses must be deleted with perm bit
-	 * and vice versa
-	 */
-	if (( tb->perm &&  (can & 0x80)) ||
-	    (!tb->perm && !(can & 0x80))) {
-		/*
-		 * delete it
-		 */
-		if (tb->n) {
-			tb->n-- ;
-			if (tb->perm) {
-				smc->hw.fp.smt_slots_used-- ;
-			}
-			else {
-				smc->hw.fp.os_slots_used-- ;
-			}
-		}
-	}
-}
-
-/*
  * mode
  */
 
--- linux-2.6.11-rc3-mm2-full/drivers/net/skfp/skfddi.c.old	2005-02-16 18:29:34.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/skfp/skfddi.c	2005-02-16 18:29:40.000000000 +0100
@@ -149,7 +149,6 @@
 extern void mac_drv_rx_mode(struct s_smc *smc, int mode);
 extern void mac_drv_clear_rx_queue(struct s_smc *smc);
 extern void enable_tx_irq(struct s_smc *smc, u_short queue);
-extern void mac_drv_clear_txd(struct s_smc *smc);
 
 static struct pci_device_id skfddi_pci_tbl[] = {
 	{ PCI_VENDOR_ID_SK, PCI_DEVICE_ID_SK_FP, PCI_ANY_ID, PCI_ANY_ID, },
--- linux-2.6.11-rc3-mm2-full/drivers/net/skfp/h/hwmtm.h.old	2005-02-16 18:30:10.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/skfp/h/hwmtm.h	2005-02-16 18:30:37.000000000 +0100
@@ -262,31 +262,6 @@
 					(smc)->hw.fp.tx_q[queue].tx_curr_put
 
 /*
- *	BEGIN_MANUAL_ENTRY(HWM_TX_CHECK)
- *	void HWM_TX_CHECK(smc,frame_status,low_water)
- *
- * function	MACRO		(hardware module, hwmtm.h)
- *		This macro is invoked by the OS-specific before it left it's
- *		driver_send function. This macro calls mac_drv_clear_txd
- *		if the free TxDs of the current transmit queue is equal or
- *		lower than the given low water mark.
- *
- * para	frame_status	status of the frame, see design description
- *	low_water	low water mark of free TxD's
- *
- *	END_MANUAL_ENTRY
- */
-#ifndef HWM_NO_FLOW_CTL
-#define	HWM_TX_CHECK(smc,frame_status,low_water) {\
-	if ((low_water)>=(smc)->hw.fp.tx_q[(frame_status)&QUEUE_A0].tx_free) {\
-		mac_drv_clear_txd(smc) ;\
-	}\
-}
-#else
-#define	HWM_TX_CHECK(smc,frame_status,low_water)	mac_drv_clear_txd(smc)
-#endif
-
-/*
  *	BEGIN_MANUAL_ENTRY(HWM_GET_RX_FRAG_LEN)
  *	int HWM_GET_RX_FRAG_LEN(rxd)
  *
--- linux-2.6.11-rc3-mm2-full/drivers/net/skfp/hwmtm.c.old	2005-02-16 18:30:46.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/skfp/hwmtm.c	2005-02-16 18:32:10.000000000 +0100
@@ -86,6 +86,7 @@
 static u_long repair_rxd_ring(struct s_smc *smc, struct s_smt_rx_queue *queue);
 static SMbuf* get_llc_rx(struct s_smc *smc);
 static SMbuf* get_txd_mb(struct s_smc *smc);
+static void mac_drv_clear_txd(struct s_smc *smc);
 
 /*
 	-------------------------------------------------------------
@@ -146,7 +147,6 @@
 */
 void process_receive(struct s_smc *smc);
 void fddi_isr(struct s_smc *smc);
-void mac_drv_clear_txd(struct s_smc *smc);
 void smt_free_mbuf(struct s_smc *smc, SMbuf *mb);
 void init_driver_fplus(struct s_smc *smc);
 void mac_drv_rx_mode(struct s_smc *smc, int mode);
@@ -158,7 +158,6 @@
 void hwm_rx_frag(struct s_smc *smc, char far *virt, u_long phys, int len,
 		 int frame_status);
 
-int mac_drv_rx_frag(struct s_smc *smc, void far *virt, int len);
 int mac_drv_init(struct s_smc *smc);
 int hwm_tx_init(struct s_smc *smc, u_char fc, int frag_count, int frame_len,
 		int frame_status);
@@ -1448,35 +1447,6 @@
 	NDD_TRACE("RHfE",r,AIX_REVERSE(r->rxd_rbadr),0) ;
 }
 
-#ifndef	NDIS_OS2
-/*
- *	BEGIN_MANUAL_ENTRY(mac_drv_rx_frag)
- *	int mac_drv_rx_frag(smc,virt,len)
- *
- * function	DOWNCALL	(hwmtm.c)
- *		mac_drv_rx_frag fills the fragment with a part of the frame.
- *
- * para	virt	the virtual address of the fragment
- *	len	the length in bytes of the fragment
- *
- * return 0:	success code, no errors possible
- *
- *	END_MANUAL_ENTRY
- */
-int mac_drv_rx_frag(struct s_smc *smc, void far *virt, int len)
-{
-	NDD_TRACE("RHSB",virt,len,smc->os.hwm.r.mb_pos) ;
-
-	DB_RX("receive from queue: len/virt: = %d/%x",len,virt,4) ;
-	memcpy((char far *)virt,smc->os.hwm.r.mb_pos,len) ;
-	smc->os.hwm.r.mb_pos += len ;
-
-	NDD_TRACE("RHSE",smc->os.hwm.r.mb_pos,0,0) ;
-	return(0) ;
-}
-#endif
-
-
 /*
  *	BEGINN_MANUAL_ENTRY(mac_drv_clear_rx_queue)
  *
@@ -1978,7 +1948,7 @@
  *
  *	END_MANUAL_ENTRY
  */
-void mac_drv_clear_txd(struct s_smc *smc)
+static void mac_drv_clear_txd(struct s_smc *smc)
 {
 	struct s_smt_tx_queue *queue ;
 	struct s_smt_fp_txd volatile *t1 ;
--- linux-2.6.11-rc3-mm2-full/drivers/net/skfp/pcmplc.c.old	2005-02-16 18:35:03.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/skfp/pcmplc.c	2005-02-16 18:35:18.000000000 +0100
@@ -1861,13 +1861,6 @@
 #endif
 }
 
-void pcm_set_lct_short(struct s_smc *smc, int n)
-{
-	if (n <= 0 || n > 1000)
-		return ;
-	smc->s.lct_short = n ;
-}
-
 #ifdef	DEBUG
 /*
  * fill state struct
--- linux-2.6.11-rc3-mm2-full/drivers/net/skfp/pmf.c.old	2005-02-16 18:35:46.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/skfp/pmf.c	2005-02-16 18:37:03.000000000 +0100
@@ -36,12 +36,13 @@
 static int smt_check_set_count(struct s_smc *smc, struct smt_header *sm);
 static const struct s_p_tab* smt_get_ptab(u_short para);
 static int smt_mib_phys(struct s_smc *smc);
-int smt_set_para(struct s_smc *smc, struct smt_para *pa, int index, int local,
-		 int set);
+static int smt_set_para(struct s_smc *smc, struct smt_para *pa, int index,
+			int local, int set);
 void smt_add_para(struct s_smc *smc, struct s_pcon *pcon, u_short para,
 		  int index, int local);
 static SMbuf *smt_build_pmf_response(struct s_smc *smc, struct smt_header *req,
 				     int set, int local);
+static int port_to_mib(struct s_smc *smc, int p);
 
 #define MOFFSS(e)	((int)&(((struct fddi_mib *)0)->e))
 #define MOFFSA(e)	((int) (((struct fddi_mib *)0)->e))
@@ -1078,8 +1079,8 @@
 /*
  * set parameter
  */
-int smt_set_para(struct s_smc *smc, struct smt_para *pa, int index, int local,
-		 int set)
+static int smt_set_para(struct s_smc *smc, struct smt_para *pa, int index,
+			int local, int set)
 {
 #define IFSET(x)	if (set) (x)
 
@@ -1549,7 +1550,7 @@
 #endif
 }
 
-int port_to_mib(struct s_smc *smc, int p)
+static int port_to_mib(struct s_smc *smc, int p)
 {
 #ifdef	CONCENTRATOR
 	SK_UNUSED(smc) ;
--- linux-2.6.11-rc3-mm2-full/drivers/net/skfp/smt.c.old	2005-02-16 18:37:20.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/skfp/smt.c	2005-02-16 18:38:33.000000000 +0100
@@ -110,7 +110,7 @@
 static void smt_fill_echo(struct s_smc *smc, struct smt_p_echo *echo, u_long seed,
 			  int len);
 
-void smt_clear_una_dna(struct s_smc *smc);
+static void smt_clear_una_dna(struct s_smc *smc);
 static void smt_clear_old_una_dna(struct s_smc *smc);
 #ifdef	CONCENTRATOR
 static int entity_to_index(void);
@@ -118,7 +118,7 @@
 static void update_dac(struct s_smc *smc, int report);
 static int div_ratio(u_long upper, u_long lower);
 #ifdef  USE_CAN_ADDR
-void	hwm_conv_can(struct s_smc *smc, char *data, int len);
+static void	hwm_conv_can(struct s_smc *smc, char *data, int len);
 #else
 #define		hwm_conv_can(smc,data,len)
 #endif
@@ -216,24 +216,6 @@
 	DB_SMT("SMT agent task\n",0,0) ;
 }
 
-void smt_please_reconnect(struct s_smc *smc, int reconn_time)
-/* struct s_smc	*smc;  Pointer to SMT context */
-/* int reconn_time;    Wait for reconnect time in seconds */
-{
-	/*
-	 * The please reconnect variable is used as a timer.
-	 * It is decremented each time smt_event is called.
-	 * This happens every second or when smt_force_irq is called.
-	 * Note: smt_force_irq () is called on some packet receives and
-	 *       when a multicast address is changed. Since nothing
-	 *       is received during the disconnect and the multicast
-	 *       address changes can be viewed as not very often and
-	 *       the timer runs out close to its given value
-	 *       (reconn_time).
-	 */
-	smc->sm.please_reconnect = reconn_time ;
-}
-
 #ifndef SMT_REAL_TOKEN_CT
 void smt_emulate_token_ct(struct s_smc *smc, int mac_index)
 {
@@ -1574,7 +1556,7 @@
  * clear DNA and UNA
  * called from CFM if configuration changes
  */
-void smt_clear_una_dna(struct s_smc *smc)
+static void smt_clear_una_dna(struct s_smc *smc)
 {
 	smc->mib.m[MAC0].fddiMACUpstreamNbr = SMT_Unknown ;
 	smc->mib.m[MAC0].fddiMACDownstreamNbr = SMT_Unknown ;
@@ -2058,30 +2040,10 @@
 }
 
 /*
- * change tneg
- *	set T_Req in MIB (Path Attribute)
- *	calculate new values for MAC
- *	if change required
- *		disconnect
- *		set reconnect
- *	end
- */
-void smt_change_t_neg(struct s_smc *smc, u_long tneg)
-{
-	smc->mib.a[PATH0].fddiPATHMaxT_Req = tneg ;
-
-	if (smt_set_mac_opvalues(smc)) {
-		RS_SET(smc,RS_EVENT) ;
-		smc->sm.please_reconnect = 1 ;
-		queue_event(smc,EVENT_ECM,EC_DISCONNECT) ;
-	}
-}
-
-/*
  * canonical conversion of <len> bytes beginning form *data
  */
 #ifdef  USE_CAN_ADDR
-void hwm_conv_can(struct s_smc *smc, char *data, int len)
+static void hwm_conv_can(struct s_smc *smc, char *data, int len)
 {
 	int i ;
 
--- linux-2.6.11-rc3-mm2-full/drivers/net/skfp/smtdef.c.old	2005-02-16 18:39:05.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/skfp/smtdef.c	2005-02-16 18:39:16.000000000 +0100
@@ -76,11 +76,6 @@
 static void smt_init_mib(struct s_smc *smc, int level);
 static int set_min_max(int maxflag, u_long mib, u_long limit, u_long *oper);
 
-void smt_set_defaults(struct s_smc *smc)
-{
-	smt_reset_defaults(smc,0) ;
-}
-
 #define MS2BCLK(x)	((x)*12500L)
 #define US2BCLK(x)	((x)*1250L)
 
--- linux-2.6.11-rc3-mm2-full/drivers/net/skfp/Makefile.old	2005-02-16 19:09:41.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/skfp/Makefile	2005-02-16 19:09:49.000000000 +0100
@@ -7,7 +7,7 @@
 skfp-objs :=  skfddi.o    hwmtm.o    fplustm.o  smt.o      cfm.o     \
               ecm.o       pcmplc.o   pmf.o      queue.o    rmt.o     \
 	      smtdef.o    smtinit.o  smttimer.o srf.o      lnkstat.o \
-              smtparse.o  hwt.o      drvfbi.o   ess.o
+              hwt.o      drvfbi.o   ess.o
 
 # NOTE:
 #   Compiling this driver produces some warnings (and some more are 

