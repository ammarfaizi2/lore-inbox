Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131246AbRCRSCT>; Sun, 18 Mar 2001 13:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131248AbRCRSCB>; Sun, 18 Mar 2001 13:02:01 -0500
Received: from d-dialin-2394.addcom.de ([62.96.168.242]:23283 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S131246AbRCRSBx>; Sun, 18 Mar 2001 13:01:53 -0500
Date: Sun, 18 Mar 2001 19:03:24 +0100 (CET)
From: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>
To: Andrew Morton <andrewm@uow.edu.au>
cc: Junfeng Yang <yjf@stanford.edu>, <linux-kernel@vger.kernel.org>,
        <mc@cs.stanford.edu>, <i4ldeveloper@listserv.isdn4linux.de>
Subject: Re: [CHECKER] 28 potential interrupt errors
In-Reply-To: <3AB3FB5A.BAA50BEA@uow.edu.au>
Message-ID: <Pine.LNX.4.30.0103181857140.1131-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Mar 2001, Andrew Morton wrote:

> I'm planning on poking through everything which has been
> identified as a posible problem.  But I won't start for
> several weeks - give the maintainers (if any) time to
> address these things.

I took a look at the ISDN issues, here's a patch which should fix most of 
it (sleeping in IRQ, and unchecked user access still missing).

I'ld appreciate it if somebody felt like looking through it. The patch is
against current CVS, but applies against current 2.4.3-pre.

--Kai

diff -ur isdn-HEAD/drivers/isdn/avmb1/capi.c isdn-h/drivers/isdn/avmb1/capi.c
--- isdn-HEAD/drivers/isdn/avmb1/capi.c	Thu Mar 15 22:19:21 2001
+++ isdn-h/drivers/isdn/avmb1/capi.c	Sat Mar 17 18:21:23 2001
@@ -1082,6 +1082,8 @@
 		return -ENODEV;
 
 	skb = alloc_skb(count, GFP_USER);
+	if (!skb)
+		return -ENOMEM;
 
 	if ((retval = copy_from_user(skb_put(skb, count), buf, count))) {
 		kfree_skb(skb);
@@ -1501,6 +1503,8 @@
 		return -EINVAL;
 
 	skb = alloc_skb(CAPI_DATA_B3_REQ_LEN+count, GFP_USER);
+	if (!skb)
+		return -ENOMEM;
 
 	skb_reserve(skb, CAPI_DATA_B3_REQ_LEN);
 	if ((retval = copy_from_user(skb_put(skb, count), buf, count))) {
Only in isdn-h/drivers/isdn/avmb1: capi.c%
diff -ur isdn-HEAD/drivers/isdn/avmb1/capidrv.c isdn-h/drivers/isdn/avmb1/capidrv.c
--- isdn-HEAD/drivers/isdn/avmb1/capidrv.c	Thu Mar 15 17:05:56 2001
+++ isdn-h/drivers/isdn/avmb1/capidrv.c	Sat Mar 17 18:23:33 2001
@@ -2065,8 +2065,8 @@
 	__u16 datahandle;
 
 	if (!card) {
-		printk(KERN_ERR "capidrv-%d: if_sendbuf called with invalid driverId %d!\n",
-		       card->contrnr, id);
+		printk(KERN_ERR "capidrv: if_sendbuf called with invalid driverId %d!\n",
+		       id);
 		return 0;
 	}
 	if (debugmode > 1)
@@ -2137,8 +2137,8 @@
 	__u8 *p;
 
 	if (!card) {
-		printk(KERN_ERR "capidrv-%d: if_readstat called with invalid driverId %d!\n",
-		       card->contrnr, id);
+		printk(KERN_ERR "capidrv: if_readstat called with invalid driverId %d!\n",
+		       id);
 		return -ENODEV;
 	}
 
Only in isdn-h/drivers/isdn/avmb1: capidrv.c%
diff -ur isdn-HEAD/drivers/isdn/hisax/config.c isdn-h/drivers/isdn/hisax/config.c
--- isdn-HEAD/drivers/isdn/hisax/config.c	Thu Mar 15 22:19:21 2001
+++ isdn-h/drivers/isdn/hisax/config.c	Sat Mar 17 18:07:41 2001
@@ -925,13 +925,12 @@
 
 	save_flags(flags);
 	cli();
-	if (!(cs = (struct IsdnCardState *)
-		kmalloc(sizeof(struct IsdnCardState), GFP_ATOMIC))) {
+	cs = kmalloc(sizeof(struct IsdnCardState), GFP_ATOMIC)
+	if (!cs) {
 		printk(KERN_WARNING
 		       "HiSax: No memory for IsdnCardState(card %d)\n",
 		       cardnr + 1);
-		restore_flags(flags);
-		return (0);
+		goto out;
 	}
 	memset(cs, 0, sizeof(struct IsdnCardState));
 	card->cs = cs;
@@ -950,241 +949,235 @@
 #endif
 	cs->protocol = card->protocol;
 
-	if ((card->typ > 0) && (card->typ <= ISDN_CTYPE_COUNT)) {
-		if (!(cs->dlog = kmalloc(MAX_DLOG_SPACE, GFP_ATOMIC))) {
-			printk(KERN_WARNING
-				"HiSax: No memory for dlog(card %d)\n",
-				cardnr + 1);
-			restore_flags(flags);
-			return (0);
-		}
-		if (!(cs->status_buf = kmalloc(HISAX_STATUS_BUFSIZE, GFP_ATOMIC))) {
-			printk(KERN_WARNING
-				"HiSax: No memory for status_buf(card %d)\n",
-				cardnr + 1);
-			kfree(cs->dlog);
-			restore_flags(flags);
-			return (0);
-		}
-		cs->stlist = NULL;
-		cs->status_read = cs->status_buf;
-		cs->status_write = cs->status_buf;
-		cs->status_end = cs->status_buf + HISAX_STATUS_BUFSIZE - 1;
-		cs->typ = card->typ;
-		strcpy(cs->iif.id, id);
-		cs->iif.channels = 2;
-		cs->iif.maxbufsize = MAX_DATA_SIZE;
-		cs->iif.hl_hdrlen = MAX_HEADER_LEN;
-		cs->iif.features =
-			ISDN_FEATURE_L2_X75I |
-			ISDN_FEATURE_L2_HDLC |
-			ISDN_FEATURE_L2_HDLC_56K |
-			ISDN_FEATURE_L2_TRANS |
-			ISDN_FEATURE_L3_TRANS |
+	if (card->typ <= 0 || card->typ > ISDN_CTYPE_COUNT) {
+		printk(KERN_WARNING
+		       "HiSax: Card Type %d out of range\n",
+		       card->typ);
+		goto outf_cs;
+	}
+	if (!(cs->dlog = kmalloc(MAX_DLOG_SPACE, GFP_ATOMIC))) {
+		printk(KERN_WARNING
+		       "HiSax: No memory for dlog(card %d)\n",
+		       cardnr + 1);
+		goto outf_cs;
+	}
+	if (!(cs->status_buf = kmalloc(HISAX_STATUS_BUFSIZE, GFP_ATOMIC))) {
+		printk(KERN_WARNING
+		       "HiSax: No memory for status_buf(card %d)\n",
+		       cardnr + 1);
+		goto outf_dlog;
+	}
+	cs->stlist = NULL;
+	cs->status_read = cs->status_buf;
+	cs->status_write = cs->status_buf;
+	cs->status_end = cs->status_buf + HISAX_STATUS_BUFSIZE - 1;
+	cs->typ = card->typ;
+	strcpy(cs->iif.id, id);
+	cs->iif.channels = 2;
+	cs->iif.maxbufsize = MAX_DATA_SIZE;
+	cs->iif.hl_hdrlen = MAX_HEADER_LEN;
+	cs->iif.features =
+		ISDN_FEATURE_L2_X75I |
+		ISDN_FEATURE_L2_HDLC |
+		ISDN_FEATURE_L2_HDLC_56K |
+		ISDN_FEATURE_L2_TRANS |
+		ISDN_FEATURE_L3_TRANS |
 #ifdef	CONFIG_HISAX_1TR6
-			ISDN_FEATURE_P_1TR6 |
+		ISDN_FEATURE_P_1TR6 |
 #endif
 #ifdef	CONFIG_HISAX_EURO
-			ISDN_FEATURE_P_EURO |
+		ISDN_FEATURE_P_EURO |
 #endif
 #ifdef	CONFIG_HISAX_NI1
-			ISDN_FEATURE_P_NI1 |
+		ISDN_FEATURE_P_NI1 |
 #endif
-			0;
-
-		cs->iif.command = HiSax_command;
-		cs->iif.writecmd = NULL;
-		cs->iif.writebuf_skb = HiSax_writebuf_skb;
-		cs->iif.readstat = HiSax_readstatus;
-		register_isdn(&cs->iif);
-		cs->myid = cs->iif.channels;
-		printk(KERN_INFO
-			"HiSax: Card %d Protocol %s Id=%s (%d)\n", cardnr + 1,
-			(card->protocol == ISDN_PTYPE_1TR6) ? "1TR6" :
-			(card->protocol == ISDN_PTYPE_EURO) ? "EDSS1" :
-			(card->protocol == ISDN_PTYPE_LEASED) ? "LEASED" :
-			(card->protocol == ISDN_PTYPE_NI1) ? "NI1" :
-			"NONE", cs->iif.id, cs->myid);
-		switch (card->typ) {
+		0;
+	
+	cs->iif.command = HiSax_command;
+	cs->iif.writecmd = NULL;
+	cs->iif.writebuf_skb = HiSax_writebuf_skb;
+	cs->iif.readstat = HiSax_readstatus;
+	register_isdn(&cs->iif);
+	cs->myid = cs->iif.channels;
+	printk(KERN_INFO
+	       "HiSax: Card %d Protocol %s Id=%s (%d)\n", cardnr + 1,
+	       (card->protocol == ISDN_PTYPE_1TR6) ? "1TR6" :
+	       (card->protocol == ISDN_PTYPE_EURO) ? "EDSS1" :
+	       (card->protocol == ISDN_PTYPE_LEASED) ? "LEASED" :
+	       (card->protocol == ISDN_PTYPE_NI1) ? "NI1" :
+	       "NONE", cs->iif.id, cs->myid);
+	switch (card->typ) {
 #if CARD_TELES0
-			case ISDN_CTYPE_16_0:
-			case ISDN_CTYPE_8_0:
-				ret = setup_teles0(card);
-				break;
+	case ISDN_CTYPE_16_0:
+	case ISDN_CTYPE_8_0:
+		ret = setup_teles0(card);
+		break;
 #endif
 #if CARD_TELES3
-			case ISDN_CTYPE_16_3:
-			case ISDN_CTYPE_PNP:
-			case ISDN_CTYPE_TELESPCMCIA:
-			case ISDN_CTYPE_COMPAQ_ISA:
-				ret = setup_teles3(card);
-				break;
+	case ISDN_CTYPE_16_3:
+	case ISDN_CTYPE_PNP:
+	case ISDN_CTYPE_TELESPCMCIA:
+	case ISDN_CTYPE_COMPAQ_ISA:
+		ret = setup_teles3(card);
+		break;
 #endif
 #if CARD_S0BOX
-			case ISDN_CTYPE_S0BOX:
-				ret = setup_s0box(card);
-				break;
+	case ISDN_CTYPE_S0BOX:
+		ret = setup_s0box(card);
+		break;
 #endif
 #if CARD_TELESPCI
-			case ISDN_CTYPE_TELESPCI:
-				ret = setup_telespci(card);
-				break;
+	case ISDN_CTYPE_TELESPCI:
+		ret = setup_telespci(card);
+		break;
 #endif
 #if CARD_AVM_A1
-			case ISDN_CTYPE_A1:
-				ret = setup_avm_a1(card);
-				break;
+	case ISDN_CTYPE_A1:
+		ret = setup_avm_a1(card);
+		break;
 #endif
 #if CARD_AVM_A1_PCMCIA
-			case ISDN_CTYPE_A1_PCMCIA:
-				ret = setup_avm_a1_pcmcia(card);
-				break;
+	case ISDN_CTYPE_A1_PCMCIA:
+		ret = setup_avm_a1_pcmcia(card);
+		break;
 #endif
 #if CARD_FRITZPCI
-			case ISDN_CTYPE_FRITZPCI:
-				ret = setup_avm_pcipnp(card);
-				break;
+	case ISDN_CTYPE_FRITZPCI:
+		ret = setup_avm_pcipnp(card);
+		break;
 #endif
 #if CARD_ELSA
-			case ISDN_CTYPE_ELSA:
-			case ISDN_CTYPE_ELSA_PNP:
-			case ISDN_CTYPE_ELSA_PCMCIA:
-			case ISDN_CTYPE_ELSA_PCI:
-				ret = setup_elsa(card);
-				break;
+	case ISDN_CTYPE_ELSA:
+	case ISDN_CTYPE_ELSA_PNP:
+	case ISDN_CTYPE_ELSA_PCMCIA:
+	case ISDN_CTYPE_ELSA_PCI:
+		ret = setup_elsa(card);
+		break;
 #endif
 #if CARD_IX1MICROR2
-			case ISDN_CTYPE_IX1MICROR2:
-				ret = setup_ix1micro(card);
-				break;
+	case ISDN_CTYPE_IX1MICROR2:
+		ret = setup_ix1micro(card);
+		break;
 #endif
 #if CARD_DIEHLDIVA
-			case ISDN_CTYPE_DIEHLDIVA:
-				ret = setup_diva(card);
-				break;
+	case ISDN_CTYPE_DIEHLDIVA:
+		ret = setup_diva(card);
+		break;
 #endif
 #if CARD_ASUSCOM
-			case ISDN_CTYPE_ASUSCOM:
-				ret = setup_asuscom(card);
-				break;
+	case ISDN_CTYPE_ASUSCOM:
+		ret = setup_asuscom(card);
+		break;
 #endif
 #if CARD_TELEINT
-			case ISDN_CTYPE_TELEINT:
-				ret = setup_TeleInt(card);
-				break;
+	case ISDN_CTYPE_TELEINT:
+		ret = setup_TeleInt(card);
+		break;
 #endif
 #if CARD_SEDLBAUER
-			case ISDN_CTYPE_SEDLBAUER:
-			case ISDN_CTYPE_SEDLBAUER_PCMCIA:
-			case ISDN_CTYPE_SEDLBAUER_FAX:
-				ret = setup_sedlbauer(card);
-				break;
+	case ISDN_CTYPE_SEDLBAUER:
+	case ISDN_CTYPE_SEDLBAUER_PCMCIA:
+	case ISDN_CTYPE_SEDLBAUER_FAX:
+		ret = setup_sedlbauer(card);
+		break;
 #endif
 #if CARD_SPORTSTER
-			case ISDN_CTYPE_SPORTSTER:
-				ret = setup_sportster(card);
-				break;
+	case ISDN_CTYPE_SPORTSTER:
+		ret = setup_sportster(card);
+		break;
 #endif
 #if CARD_MIC
-			case ISDN_CTYPE_MIC:
-				ret = setup_mic(card);
-				break;
+	case ISDN_CTYPE_MIC:
+		ret = setup_mic(card);
+		break;
 #endif
 #if CARD_NETJET_S
-			case ISDN_CTYPE_NETJET_S:
-				ret = setup_netjet_s(card);
-				break;
+	case ISDN_CTYPE_NETJET_S:
+		ret = setup_netjet_s(card);
+		break;
 #endif
 #if CARD_HFCS
-			case ISDN_CTYPE_TELES3C:
-			case ISDN_CTYPE_ACERP10:
-				ret = setup_hfcs(card);
-				break;
+	case ISDN_CTYPE_TELES3C:
+	case ISDN_CTYPE_ACERP10:
+		ret = setup_hfcs(card);
+		break;
 #endif
 #if CARD_HFC_PCI
-		        case ISDN_CTYPE_HFC_PCI: 
-				ret = setup_hfcpci(card);
-				break;
+	case ISDN_CTYPE_HFC_PCI: 
+		ret = setup_hfcpci(card);
+		break;
 #endif
 #if CARD_HFC_SX
-		        case ISDN_CTYPE_HFC_SX: 
-				ret = setup_hfcsx(card);
-				break;
+	case ISDN_CTYPE_HFC_SX: 
+		ret = setup_hfcsx(card);
+		break;
 #endif
 #if CARD_NICCY
-			case ISDN_CTYPE_NICCY:
-				ret = setup_niccy(card);
-				break;
+	case ISDN_CTYPE_NICCY:
+		ret = setup_niccy(card);
+		break;
 #endif
 #if CARD_AMD7930
-			case ISDN_CTYPE_AMD7930:
-				ret = setup_amd7930(card);
-				break;
+	case ISDN_CTYPE_AMD7930:
+		ret = setup_amd7930(card);
+		break;
 #endif
 #if CARD_ISURF
-			case ISDN_CTYPE_ISURF:
-				ret = setup_isurf(card);
-				break;
+	case ISDN_CTYPE_ISURF:
+		ret = setup_isurf(card);
+		break;
 #endif
 #if CARD_HSTSAPHIR
-			case ISDN_CTYPE_HSTSAPHIR:
-				ret = setup_saphir(card);
-				break;
+	case ISDN_CTYPE_HSTSAPHIR:
+		ret = setup_saphir(card);
+		break;
 #endif
 #if CARD_TESTEMU
-			case ISDN_CTYPE_TESTEMU:
-				ret = setup_testemu(card);
-				break;
+	case ISDN_CTYPE_TESTEMU:
+		ret = setup_testemu(card);
+		break;
 #endif
 #if	CARD_BKM_A4T       
-           	case ISDN_CTYPE_BKM_A4T:
-	        	ret = setup_bkm_a4t(card);
-			break;
+	case ISDN_CTYPE_BKM_A4T:
+		ret = setup_bkm_a4t(card);
+		break;
 #endif
 #if	CARD_SCT_QUADRO
-	        case ISDN_CTYPE_SCT_QUADRO:
-    			ret = setup_sct_quadro(card);
-			break;
+	case ISDN_CTYPE_SCT_QUADRO:
+		ret = setup_sct_quadro(card);
+		break;
 #endif
 #if CARD_GAZEL
- 		case ISDN_CTYPE_GAZEL:
- 			ret = setup_gazel(card);
- 			break;
+	case ISDN_CTYPE_GAZEL:
+		ret = setup_gazel(card);
+		break;
 #endif
 #if CARD_W6692
-		case ISDN_CTYPE_W6692:
-			ret = setup_w6692(card);
-			break;
+	case ISDN_CTYPE_W6692:
+		ret = setup_w6692(card);
+		break;
 #endif
 #if CARD_NETJET_U
-			case ISDN_CTYPE_NETJET_U:
-				ret = setup_netjet_u(card);
-				break;
-#endif
-		default:
-			printk(KERN_WARNING
-				"HiSax: Support for %s Card not selected\n",
-				CardType[card->typ]);
-			ll_unload(cs);
-			restore_flags(flags);
-			return (0);
-		}
-	} else {
+	case ISDN_CTYPE_NETJET_U:
+		ret = setup_netjet_u(card);
+		break;
+#endif
+	default:
 		printk(KERN_WARNING
-		       "HiSax: Card Type %d out of range\n",
-		       card->typ);
-		restore_flags(flags);
-		return (0);
+		       "HiSax: Support for %s Card not selected\n",
+		       CardType[card->typ]);
+		ll_unload(cs);
+		goto outf_cs;
 	}
 	if (!ret) {
 		ll_unload(cs);
-		restore_flags(flags);
-		return (0);
+		goto outf_cs;
 	}
 	if (!(cs->rcvbuf = kmalloc(MAX_DFRAME_LEN_L1, GFP_ATOMIC))) {
 		printk(KERN_WARNING
 		       "HiSax: No memory for isac rcvbuf\n");
-		return (1);
+		ll_unload(cs);
+		goto outf_cs;
 	}
 	cs->rcvidx = 0;
 	cs->tx_skb = NULL;
@@ -1201,21 +1194,31 @@
 	ret = init_card(cs);
 	if (ret) {
 		closecard(cardnr);
-		restore_flags(flags);
-		return (0);
+		ret = 0;
+		goto outf_cs;
 	}
 	init_tei(cs, cs->protocol);
 	ret = CallcNewChan(cs);
 	if (ret) {
 		closecard(cardnr);
-		restore_flags(flags);
-		return 0;
+		ret = 0;
+		goto outf_cs;
 	}
 	/* ISAR needs firmware download first */
 	if (!test_bit(HW_ISAR, &cs->HW_Flags))
 		ll_run(cs, 0);
+
+	ret = 1;
+	goto out;
+
+ outf_dlog:
+	kfree(cs->dlog);
+ outf_cs:
+	kfree(cs);
+	card->cs = NULL;
+ out:
 	restore_flags(flags);
-	return (1);
+	return ret;
 }
 
 void __devinit
@@ -1264,9 +1267,6 @@
 		} else {
 			printk(KERN_WARNING "HiSax: Card %s not installed !\n",
 			       CardType[cards[i].typ]);
-			if (cards[i].cs)
-				kfree((void *) cards[i].cs);
-			cards[i].cs = NULL;
 			HiSax_shiftcards(i);
 			nrcards--;
 		}
Only in isdn-h/drivers/isdn/hisax: config.c%
diff -ur isdn-HEAD/drivers/isdn/hisax/isar.c isdn-h/drivers/isdn/hisax/isar.c
--- isdn-HEAD/drivers/isdn/hisax/isar.c	Thu Mar 15 10:08:37 2001
+++ isdn-h/drivers/isdn/hisax/isar.c	Sat Mar 17 18:10:54 2001
@@ -383,12 +383,12 @@
 	} else {
 		printk(KERN_DEBUG"isar selftest not OK %x/%x/%x\n",
 			ireg->cmsb, ireg->clsb, ireg->par[0]);
-		ret = 1;goto reterror;
+		ret = 1;goto reterrflg;
 	}
 	ireg->iis = 0;
 	if (!sendmsg(cs, ISAR_HIS_DIAG, ISAR_CTRL_SWVER, 0, NULL)) {
 		printk(KERN_ERR"isar RQST SVN failed\n");
-		ret = 1;goto reterror;
+		ret = 1;goto reterrflg;
 	}
 	cnt = 30000; /* max 300 ms */
 	while ((ireg->iis != ISAR_IIS_DIAG) && cnt) {
Only in isdn-h/drivers/isdn/hisax: isar.c%
diff -ur isdn-HEAD/drivers/isdn/isdn_ppp.c isdn-h/drivers/isdn/isdn_ppp.c
--- isdn-HEAD/drivers/isdn/isdn_ppp.c	Wed Jan 24 00:22:46 2001
+++ isdn-h/drivers/isdn/isdn_ppp.c	Sat Mar 17 18:13:59 2001
@@ -176,6 +176,7 @@
 	int unit = 0;
 	long flags;
 	struct ippp_struct *is;
+	int retval;
 
 	save_flags(flags);
 	cli();
@@ -208,12 +209,14 @@
 	if (i >= ISDN_MAX_CHANNELS) {
 		restore_flags(flags);
 		printk(KERN_WARNING "isdn_ppp_bind: Can't find a (free) connection to the ipppd daemon.\n");
-		return -1;
+		retval = -1;
+		goto out;
 	}
 	unit = isdn_ppp_if_get_unit(lp->name);	/* get unit number from interface name .. ugly! */
 	if (unit < 0) {
 		printk(KERN_ERR "isdn_ppp_bind: illegal interface name %s.\n", lp->name);
-		return -1;
+		retval = -1;
+		goto out;
 	}
 	
 	lp->ppp_slot = i;
@@ -222,13 +225,16 @@
 	is->unit = unit;
 	is->state = IPPP_OPEN | IPPP_ASSIGNED;	/* assigned to a netdevice but not connected */
 #ifdef CONFIG_ISDN_MPP
-	if (isdn_ppp_mp_init(lp, NULL) < 0)
-		return -ENOMEM;
+	retval = isdn_ppp_mp_init(lp, NULL);
+	if (retval < 0)
+		goto out;
 #endif /* CONFIG_ISDN_MPP */
 
-	restore_flags(flags);
+	retval = lp->ppp_slot;
 
-	return lp->ppp_slot;
+ out:
+	restore_flags(flags);
+	return retval;
 }
 
 /*
Only in isdn-h/drivers/isdn: isdn_ppp.c%
diff -ur isdn-HEAD/drivers/isdn/pcbit/drv.c isdn-h/drivers/isdn/pcbit/drv.c
--- isdn-HEAD/drivers/isdn/pcbit/drv.c	Thu Mar 15 10:08:38 2001
+++ isdn-h/drivers/isdn/pcbit/drv.c	Sat Mar 17 18:30:32 2001
@@ -430,7 +430,6 @@
 	return len;
 }
 
-
 int pcbit_writecmd(const u_char* buf, int len, int user, int driver, int channel)
 {
 	struct pcbit_dev * dev;
@@ -454,32 +453,36 @@
 		if (len > BANK4 + 1)
 		{
 			printk("pcbit_writecmd: invalid length %d\n", len);
-			return -EFAULT;
+			return -EINVAL;
 		}
 
 		if (user)
 		{
-			u_char cbuf[1024];
+			u_char *cbuf = kmalloc(len, GFP_KERNEL);
+			if (!cbuf)
+				return -ENOMEM;
 
-			copy_from_user(cbuf, buf, len);
-			for (i=0; i<len; i++)
-				writeb(cbuf[i], dev->sh_mem + i);
+			if (copy_from_user(cbuf, buf, len)) {
+				kfree(cbuf);
+				return -EFAULT;
+			}
+			memcpy_toio(dev->sh_mem, cbuf, len);
+			kfree(cbuf);
 		}
 		else
 			memcpy_toio(dev->sh_mem, buf, len);
 		return len;
-		break;
 	case L2_FWMODE:
 		/* this is the hard part */
 		/* dumb board */
-		if (len < 0)
-			return -EINVAL;
-
 		if (user) {		
 			/* get it into kernel space */
 			if ((ptr = kmalloc(len, GFP_KERNEL))==NULL)
 				return -ENOMEM;
-			copy_from_user(ptr, buf, len);
+			if (copy_from_user(ptr, buf, len)) {
+				kfree(ptr);
+				return -EFAULT;
+			}
 			loadbuf = ptr;
 		}
 		else
@@ -511,12 +514,9 @@
 			kfree(ptr);
 
 		return errstat ? errstat : len;
-
-		break;
 	default:
 		return -EBUSY;
 	}
-	return 0;
 }
 
 /*
Only in isdn-h/drivers/isdn/pcbit: drv.c%
diff -ur isdn-HEAD/drivers/isdn/sc/interrupt.c isdn-h/drivers/isdn/sc/interrupt.c
--- isdn-HEAD/drivers/isdn/sc/interrupt.c	Thu Mar 15 10:08:38 2001
+++ isdn-h/drivers/isdn/sc/interrupt.c	Sat Mar 17 17:35:12 2001
@@ -34,7 +34,6 @@
 
 extern int indicate_status(int, int, ulong, char *);
 extern void check_phystat(unsigned long);
-extern void dump_messages(int);
 extern int receivemessage(int, RspMessage *);
 extern int sendmessage(int, unsigned int, unsigned int, unsigned int,
         unsigned int, unsigned int, unsigned int, unsigned int *);
Only in isdn-h/drivers/isdn/sc: interrupt.c%
diff -ur isdn-HEAD/drivers/isdn/sc/message.c isdn-h/drivers/isdn/sc/message.c
--- isdn-HEAD/drivers/isdn/sc/message.c	Sat Sep  4 08:20:07 1999
+++ isdn-h/drivers/isdn/sc/message.c	Sat Mar 17 17:35:43 2001
@@ -38,55 +38,12 @@
 extern unsigned int cinst;
 
 /*
- * Obligitory function prototypes
+ * Obligatory function prototypes
  */
 extern int indicate_status(int,ulong,char*);
 extern int scm_command(isdn_ctrl *);
 extern void *memcpy_fromshmem(int, void *, const void *, size_t);
 
-/*
- * Dump message queue in shared memory to screen
- */
-void dump_messages(int card) 
-{
-	DualPortMemory dpm;
-	unsigned long flags;
-
-	int i =0;
-	
-	if (!IS_VALID_CARD(card)) {
-		pr_debug("Invalid param: %d is not a valid card id\n", card);
-	}
-
-	save_flags(flags);
-	cli();
-	outb(adapter[card]->ioport[adapter[card]->shmem_pgport], 
-		(adapter[card]->shmem_magic >> 14) | 0x80);
-	memcpy_fromshmem(card, &dpm, 0, sizeof(dpm));
-	restore_flags(flags);
-
-	pr_debug("%s: Dumping Request Queue\n", adapter[card]->devicename);
-	for (i = 0; i < dpm.req_head; i++) {
-		pr_debug("%s: Message #%d: (%d,%d,%d), link: %d\n",
-				adapter[card]->devicename, i,
-				dpm.req_queue[i].type,
-				dpm.req_queue[i].class,
-				dpm.req_queue[i].code,
-				dpm.req_queue[i].phy_link_no);
-	}
-
-	pr_debug("%s: Dumping Response Queue\n", adapter[card]->devicename);
-	for (i = 0; i < dpm.rsp_head; i++) {
-		pr_debug("%s: Message #%d: (%d,%d,%d), link: %d, status: %d\n",
-				adapter[card]->devicename, i,
-				dpm.rsp_queue[i].type,
-				dpm.rsp_queue[i].class,
-				dpm.rsp_queue[i].code,
-				dpm.rsp_queue[i].phy_link_no,
-				dpm.rsp_queue[i].rsp_status);
-	}
-
-}	
 
 /*
  * receive a message from the board
Only in isdn-h/drivers/isdn/sc: message.c%


