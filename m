Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132552AbQKKVKg>; Sat, 11 Nov 2000 16:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132527AbQKKVK0>; Sat, 11 Nov 2000 16:10:26 -0500
Received: from tepid.osl.fast.no ([213.188.9.130]:36361 "EHLO
	tepid.osl.fast.no") by vger.kernel.org with ESMTP
	id <S132552AbQKKVKN>; Sat, 11 Nov 2000 16:10:13 -0500
Date: Sat, 11 Nov 2000 21:11:10 GMT
Message-Id: <200011112111.VAA31999@tepid.osl.fast.no>
Subject: [patch] patch-2.4.0-test10-irda10 (was: Re: The IrDA patches)
X-Mailer: Pygmy (v0.4.4pre)
Subject: [patch] patch-2.4.0-test10-irda10 (was: Re: The IrDA patches)
Cc: linux-kernel@vger.kernel.org
From: Dag Brattli <dagb@fast.no>
To: torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Here are the new IrDA patches for Linux-2.4.0-test10. Please apply them to
your latest 2.4 code. If you decide to apply them, then I suggest you start
with the first one (irda1.diff) and work your way to the last one 
(irda24.diff) since most of them are not commutative. 

The name of this patch is irda10.diff. 

(Many thanks to Jean Tourrilhes for splitting up the big patch)

[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash
[OUPS   ] : Error that will be fixed in a later patch

irda10.diff :
-----------------
	o [CRITICA] Update skb handling (Add skb_get() and kfree_skb())

diff -urpN old-linux/net/irda/irlap.c linux/net/irda/irlap.c
--- old-linux/net/irda/irlap.c	Thu Nov  9 14:47:22 2000
+++ linux/net/irda/irlap.c	Thu Nov  9 14:47:40 2000
@@ -232,7 +232,8 @@ void irlap_connect_indication(struct irl
 	ASSERT(self->magic == LAP_MAGIC, return;);
 
 	irlap_init_qos_capabilities(self, NULL); /* No user QoS! */
-	
+
+	skb_get(skb); /*LEVEL4*/
 	irlmp_link_connect_indication(self->notify.instance, self->saddr, 
 				      self->daddr, &self->qos_tx, skb);
 }
@@ -248,6 +249,7 @@ void irlap_connect_response(struct irlap
 	IRDA_DEBUG(4, __FUNCTION__ "()\n");
 	
 	irlap_do_event(self, CONNECT_RESPONSE, skb, NULL);
+	kfree_skb(skb);
 }
 
 /*
@@ -292,6 +294,7 @@ void irlap_connect_confirm(struct irlap_
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == LAP_MAGIC, return;);
 
+	skb_get(skb); /*LEVEL4*/
 	irlmp_link_connect_confirm(self->notify.instance, &self->qos_tx, skb);
 }
 
@@ -310,6 +313,7 @@ void irlap_data_indication(struct irlap_
 
 #ifdef CONFIG_IRDA_COMPRESSION
 	if (self->qos_tx.compression.value) {
+		skb_get(skb); /*LEVEL4*/
 		skb = irlap_decompress_frame(self, skb);
 		if (!skb) {
 			IRDA_DEBUG(1, __FUNCTION__ "(), Decompress error!\n");
@@ -317,6 +321,7 @@ void irlap_data_indication(struct irlap_
 		}
 	}
 #endif
+	skb_get(skb); /*LEVEL4*/
 	irlmp_link_data_indication(self->notify.instance, skb, unreliable);
 }
 
@@ -373,6 +378,7 @@ void irlap_data_request(struct irlap_cb 
 			ASSERT(skb != NULL, return;);
 		}
 		irlap_do_event(self, SEND_I_CMD, skb, NULL);
+		kfree_skb(skb);
 	} else
 		skb_queue_tail(&self->txq, skb);
 }
@@ -422,6 +428,7 @@ void irlap_unitdata_indication(struct ir
 	/* Hide LAP header from IrLMP layer */
 	skb_pull(skb, LAP_ADDR_HEADER+LAP_CTRL_HEADER);
 
+	skb_get(skb); /*LEVEL4*/
 	irlmp_link_unitdata_indication(self->notify.instance, skb);
 }
 #endif /* CONFIG_IRDA_ULTRA */
diff -urpN old-linux/net/irda/irlap_event.c linux/net/irda/irlap_event.c
--- old-linux/net/irda/irlap_event.c	Thu Nov  9 14:47:22 2000
+++ linux/net/irda/irlap_event.c	Thu Nov  9 14:47:40 2000
@@ -230,7 +230,7 @@ void irlap_do_event(struct irlap_cb *sel
 	
 	if (!self || self->magic != LAP_MAGIC)
 		return;
-	
+
   	IRDA_DEBUG(3, __FUNCTION__ "(), event = %s, state = %s\n", 
 		   irlap_event[event], irlap_state[self->state]); 
 	
@@ -252,6 +252,7 @@ void irlap_do_event(struct irlap_cb *sel
 			while ((skb = skb_dequeue(&self->txq)) != NULL) {
 				ret = (*state[self->state])(self, SEND_I_CMD,
 							    skb, NULL);
+				kfree_skb(skb);
 				if (ret == -EPROTO)
 					break; /* Try again later! */
 			}
@@ -351,12 +352,11 @@ static int irlap_state_ndm(struct irlap_
 			self->caddr = info->caddr;
 			
 			irlap_next_state(self, LAP_CONN);
-			
+
 			irlap_connect_indication(self, skb);
 		} else {
 			IRDA_DEBUG(0, __FUNCTION__ "(), SNRM frame does not "
 				   "contain an I field!\n");
-			dev_kfree_skb(skb);
 		}
 		break;
 	case DISCOVERY_REQUEST:		
@@ -410,14 +410,13 @@ static int irlap_state_ndm(struct irlap_
 			irlap_start_query_timer(self, QUERY_TIMEOUT*info->S);
 			irlap_next_state(self, LAP_REPLY);
 		}
-		dev_kfree_skb(skb);
 		break;
 #ifdef CONFIG_IRDA_ULTRA
 	case SEND_UI_FRAME:
 		/* Only allowed to repeat an operation twice */
 		for (i=0; ((i<2) && (self->media_busy == FALSE)); i++) {
 			skb = skb_dequeue(&self->txq_ultra);
-			if (skb)			
+			if (skb)
 				irlap_send_ui_frame(self, skb, CBROADCAST, 
 						    CMD_FRAME);
 			else
@@ -433,7 +432,6 @@ static int irlap_state_ndm(struct irlap_
 		if (info->caddr != CBROADCAST) {
 			IRDA_DEBUG(0, __FUNCTION__ 
 				   "(), not a broadcast frame!\n");
-			dev_kfree_skb(skb);
 		} else
 			irlap_unitdata_indication(self, skb);
 		break;
@@ -447,19 +445,14 @@ static int irlap_state_ndm(struct irlap_
 		 * will only be used to send out the same info as the cmd
 		 */
 		irlap_send_test_frame(self, CBROADCAST, info->daddr, skb);
-		dev_kfree_skb(skb);
 		break;
 	case RECV_TEST_RSP:
 		IRDA_DEBUG(0, __FUNCTION__ "() not implemented!\n");
-		dev_kfree_skb(skb);
 		break;
 	default:
 		IRDA_DEBUG(2, __FUNCTION__ "(), Unknown event %s\n", 
 			   irlap_event[event]);
 		
-		if (skb)
-			dev_kfree_skb(skb);
-
 		ret = -1;
 		break;
 	}	
@@ -492,7 +485,6 @@ static int irlap_state_query(struct irla
 			WARNING(__FUNCTION__ "(), discovery log is gone! "
 				"maybe the discovery timeout has been set to "
 				"short?\n");
-			dev_kfree_skb(skb);
 			break;
 		}
 		hashbin_insert(self->discovery_log, 
@@ -502,7 +494,6 @@ static int irlap_state_query(struct irla
 		/* Keep state */
 		/* irlap_next_state(self, LAP_QUERY);  */
 
-		dev_kfree_skb(skb);
 		break;
 	case SLOT_TIMER_EXPIRED:
 		if (self->s < self->S) {
@@ -537,9 +528,6 @@ static int irlap_state_query(struct irla
 		IRDA_DEBUG(2, __FUNCTION__ "(), Unknown event %s\n", 
 			   irlap_event[event]);
 
-		if (skb)
-			dev_kfree_skb(skb);
-
 		ret = -1;
 		break;
 	}
@@ -595,15 +583,11 @@ static int irlap_state_reply(struct irla
 			self->frame_sent = TRUE;
 			irlap_next_state(self, LAP_REPLY);
 		}
-		dev_kfree_skb(skb);
 		break;
 	default:
 		IRDA_DEBUG(1, __FUNCTION__ "(), Unknown event %d, %s\n", event,
 			   irlap_event[event]);
 
-		if (skb)
-			dev_kfree_skb(skb);
-		
 		ret = -1;
 		break;
 	}
@@ -665,14 +649,12 @@ static int irlap_state_conn(struct irlap
 		irlap_start_wd_timer(self, self->wd_timeout);
 		irlap_next_state(self, LAP_NRM_S);
 
-		dev_kfree_skb(skb);
 		break;
 	case RECV_DISCOVERY_XID_CMD:
 		IRDA_DEBUG(3, __FUNCTION__ 
 			   "(), event RECV_DISCOVER_XID_CMD!\n");
 		irlap_next_state(self, LAP_NDM);
 
-		dev_kfree_skb(skb);
 		break;		
 	case DISCONNECT_REQUEST:
 		irlap_send_dm_frame(self);
@@ -682,9 +664,6 @@ static int irlap_state_conn(struct irlap
 		IRDA_DEBUG(1, __FUNCTION__ "(), Unknown event %d, %s\n", event,
 			   irlap_event[event]);
 		
-		if (skb)
-			dev_kfree_skb(skb);
-
 		ret = -1;
 		break;
 	}
@@ -766,7 +745,6 @@ static int irlap_state_setup(struct irla
 			irlap_start_wd_timer(self, self->wd_timeout);
 		} else {
 			/* We just ignore the other device! */
-			dev_kfree_skb(skb);
 			irlap_next_state(self, LAP_SETUP);
 		}
 		break;
@@ -803,14 +781,11 @@ static int irlap_state_setup(struct irla
 		irlap_next_state(self, LAP_NDM);
 
 		irlap_disconnect_indication(self, LAP_DISC_INDICATION);
-		dev_kfree_skb(skb);
 		break;
 	default:
 		IRDA_DEBUG(1, __FUNCTION__ "(), Unknown event %d, %s\n", event,
 			   irlap_event[event]);		
-		if (skb)
-			dev_kfree_skb(skb);
-		
+
 		ret = -1;
 		break;
 	}	
@@ -860,8 +835,7 @@ static int irlap_state_xmit_p(struct irl
 				IRDA_DEBUG(4, __FUNCTION__ 
 					   "(), Not allowed to transmit more "
 					   "bytes!\n");
-				skb_queue_head(&self->txq, skb);
-
+				skb_queue_head(&self->txq, skb_get(skb));
 				/*
 				 *  We should switch state to LAP_NRM_P, but
 				 *  that is not possible since we must be sure
@@ -900,7 +874,7 @@ static int irlap_state_xmit_p(struct irl
 		} else {
 			IRDA_DEBUG(4, __FUNCTION__ 
 				   "(), Unable to send! remote busy?\n");
-			skb_queue_head(&self->txq, skb);
+			skb_queue_head(&self->txq, skb_get(skb));
 
 			/*
 			 *  The next ret is important, because it tells 
@@ -929,9 +903,6 @@ static int irlap_state_xmit_p(struct irl
 		IRDA_DEBUG(0, __FUNCTION__ "(), Unknown event %s\n", 
 			   irlap_event[event]);
 
-		if (skb)
-			dev_kfree_skb(skb);
-
 		ret = -EINVAL;
 		break;
 	}
@@ -964,7 +935,6 @@ static int irlap_state_pclose(struct irl
 		irlap_next_state(self, LAP_NDM);
 		
 		irlap_disconnect_indication(self, LAP_DISC_INDICATION);
-		dev_kfree_skb(skb);
 		break;
 	case FINAL_TIMER_EXPIRED:
 		if (self->retry_count < self->N3) {
@@ -985,9 +955,6 @@ static int irlap_state_pclose(struct irl
 	default:
 		IRDA_DEBUG(1, __FUNCTION__ "(), Unknown event %d\n", event);
 
-		if (skb)
-			dev_kfree_skb(skb);
-
 		ret = -1;
 		break;	
 	}
@@ -1041,7 +1008,7 @@ static int irlap_state_nrm_p(struct irla
 				
 				/* Keep state, do not move this line */
 				irlap_next_state(self, LAP_NRM_P);
-				
+
 				irlap_data_indication(self, skb, FALSE);
 			} else {
 				del_timer(&self->final_timer);
@@ -1065,7 +1032,7 @@ static int irlap_state_nrm_p(struct irla
 				 * upper layers
 				 */
 				irlap_next_state(self, LAP_XMIT_P);
-			
+
 				irlap_data_indication(self, skb, FALSE);
 
 				/* This is the last frame */
@@ -1102,7 +1069,6 @@ static int irlap_state_nrm_p(struct irla
 				irlap_start_final_timer(self, self->final_timeout);
 				irlap_next_state(self, LAP_NRM_P);
 			}
-			dev_kfree_skb(skb);
 			break;
 		}
 		/* 
@@ -1124,7 +1090,7 @@ static int irlap_state_nrm_p(struct irla
 				
 				/* Keep state, do not move this line */
 				irlap_next_state(self, LAP_NRM_P);
-				
+
 				irlap_data_indication(self, skb, FALSE);
 			} else {
 				/* 
@@ -1142,7 +1108,7 @@ static int irlap_state_nrm_p(struct irla
 
 				/* Keep state, do not move this line!*/
 				irlap_next_state(self, LAP_NRM_P); 
-				
+
 				irlap_data_indication(self, skb, FALSE);
 			}
 			break;
@@ -1171,7 +1137,6 @@ static int irlap_state_nrm_p(struct irla
 				
 				self->ack_required = FALSE;
 			}
-			dev_kfree_skb(skb);
 			break;
 		}
 
@@ -1193,7 +1158,6 @@ static int irlap_state_nrm_p(struct irla
 				
 				self->xmitflag = FALSE;
 			}
-			dev_kfree_skb(skb);
 			break;
 		}
 		IRDA_DEBUG(1, __FUNCTION__ "(), Not implemented!\n");
@@ -1209,6 +1173,7 @@ static int irlap_state_nrm_p(struct irla
 		} else {
 			del_timer(&self->final_timer);
 			irlap_data_indication(self, skb, TRUE);
+			printk(__FUNCTION__ "(): RECV_UI_FRAME: next state %s\n", irlap_state[self->state]);
 			irlap_start_poll_timer(self, self->poll_timeout);
 		}
 		break;
@@ -1270,7 +1235,6 @@ static int irlap_state_nrm_p(struct irla
 			irlap_disconnect_indication(self, LAP_RESET_INDICATION);
 			self->xmitflag = TRUE;
 		}
-		dev_kfree_skb(skb);
 		break;
 	case RECV_RNR_RSP:
 		ASSERT(info != NULL, return -1;);
@@ -1285,14 +1249,12 @@ static int irlap_state_nrm_p(struct irla
 			
 		/* Start poll timer */
 		irlap_start_poll_timer(self, self->poll_timeout);
-		dev_kfree_skb(skb);
 		break;
 	case RECV_FRMR_RSP:
 		del_timer(&self->final_timer);
 		self->xmitflag = TRUE;
 		irlap_next_state(self, LAP_RESET_WAIT);
 		irlap_reset_indication(self);
-		dev_kfree_skb(skb);
 		break;
 	case FINAL_TIMER_EXPIRED:
 		/* 
@@ -1357,7 +1319,6 @@ static int irlap_state_nrm_p(struct irla
 		} else
 			irlap_resend_rejected_frames(self, CMD_FRAME);
 		irlap_start_final_timer(self, self->final_timeout);
-		dev_kfree_skb(skb);
 		break;
 	case RECV_SREJ_RSP:
 		irlap_update_nr_received(self, info->nr);
@@ -1367,7 +1328,6 @@ static int irlap_state_nrm_p(struct irla
 		} else
 			irlap_resend_rejected_frame(self, CMD_FRAME);
 		irlap_start_final_timer(self, self->final_timeout);
-		dev_kfree_skb(skb);
 		break;
 	case RECV_RD_RSP:
 		IRDA_DEBUG(0, __FUNCTION__ "(), RECV_RD_RSP\n");
@@ -1381,8 +1341,6 @@ static int irlap_state_nrm_p(struct irla
 	default:
 		IRDA_DEBUG(1, __FUNCTION__ "(), Unknown event %s\n", 
 			   irlap_event[event]);
-		if (skb)
-			dev_kfree_skb(skb);
 
 		ret = -1;
 		break;
@@ -1430,8 +1388,6 @@ static int irlap_state_reset_wait(struct
 	default:
 		IRDA_DEBUG(1, __FUNCTION__ "(), Unknown event %s\n", 
 			   irlap_event[event]);
-		if (skb)
-			dev_kfree_skb(skb);
 
 		ret = -1;
 		break;	
@@ -1467,7 +1423,6 @@ static int irlap_state_reset(struct irla
 
 		irlap_disconnect_indication(self, LAP_NO_RESPONSE);
 
-		dev_kfree_skb(skb);
 		break;
 	case RECV_UA_RSP:
 		del_timer(&self->final_timer);
@@ -1483,7 +1438,6 @@ static int irlap_state_reset(struct irla
 
 		irlap_start_poll_timer(self, self->poll_timeout);
 
-		dev_kfree_skb(skb);
 		break;
 	case FINAL_TIMER_EXPIRED:
 		if (self->retry_count < 3) {
@@ -1522,13 +1476,10 @@ static int irlap_state_reset(struct irla
 			IRDA_DEBUG(0, __FUNCTION__ 
 				   "(), SNRM frame contained an I field!\n");
 		}
-		dev_kfree_skb(skb);
 		break;
 	default:
 		IRDA_DEBUG(1, __FUNCTION__ "(), Unknown event %s\n", 
 			   irlap_event[event]);	
-		if (skb)
-			dev_kfree_skb(skb);
 
 		ret = -1;
 		break;	
@@ -1566,7 +1517,7 @@ static int irlap_state_xmit_s(struct irl
 			 *  speed and turn-around-time.
 			 */
 			if (skb->len > self->bytes_left) {
-				skb_queue_head(&self->txq, skb);
+				skb_queue_head(&self->txq, skb_get(skb));
 				/*
 				 *  Switch to NRM_S, this is only possible
 				 *  when we are in secondary mode, since we 
@@ -1600,7 +1551,7 @@ static int irlap_state_xmit_s(struct irl
 			}
 		} else {
 			IRDA_DEBUG(2, __FUNCTION__ "(), Unable to send!\n");
-			skb_queue_head(&self->txq, skb);
+			skb_queue_head(&self->txq, skb_get(skb));
 			ret = -EPROTO;
 		}
 		break;
@@ -1613,8 +1564,6 @@ static int irlap_state_xmit_s(struct irl
 	default:
 		IRDA_DEBUG(2, __FUNCTION__ "(), Unknown event %s\n", 
 			   irlap_event[event]);
-		if (skb)
-			dev_kfree_skb(skb);
 
 		ret = -EINVAL;
 		break;
@@ -1676,7 +1625,7 @@ static int irlap_state_nrm_s(struct irla
 #endif
 				/* Keep state, do not move this line */
 				irlap_next_state(self, LAP_NRM_S);
-				
+
 				irlap_data_indication(self, skb, FALSE);
 				break;
 			} else {
@@ -1739,7 +1688,6 @@ static int irlap_state_nrm_s(struct irla
 			
 				irlap_start_wd_timer(self, self->wd_timeout);
 			}
-			dev_kfree_skb(skb);
 			break;
 		}
 
@@ -1778,7 +1726,7 @@ static int irlap_state_nrm_s(struct irla
 				
 				/* Keep state, do not move this line */
 				irlap_next_state(self, LAP_NRM_S);
-				
+
 				irlap_data_indication(self, skb, FALSE);
 				irlap_start_wd_timer(self, self->wd_timeout);
 			}
@@ -1787,11 +1735,9 @@ static int irlap_state_nrm_s(struct irla
 		
 		if (ret == NR_INVALID) {
 			IRDA_DEBUG(0, "NRM_S, NR_INVALID not implemented!\n");
-			dev_kfree_skb(skb);
 		}
 		if (ret == NS_INVALID) {
 			IRDA_DEBUG(0, "NRM_S, NS_INVALID not implemented!\n");
-			dev_kfree_skb(skb);
 		}
 		break;
 	case RECV_UI_FRAME:
@@ -1870,7 +1816,6 @@ static int irlap_state_nrm_s(struct irla
 			IRDA_DEBUG(1, __FUNCTION__ 
 				   "(), invalid nr not implemented!\n");
 		} 
-		dev_kfree_skb(skb);
 		break;
 	case RECV_SNRM_CMD:
 		/* SNRM frame is not allowed to contain an I-field */
@@ -1885,7 +1830,6 @@ static int irlap_state_nrm_s(struct irla
 				   "(), SNRM frame contained an I-field!\n");
 			
 		}
-		dev_kfree_skb(skb);
 		break;
 	case RECV_REJ_CMD:
 		irlap_update_nr_received(self, info->nr);
@@ -1895,7 +1839,6 @@ static int irlap_state_nrm_s(struct irla
 		} else
 			irlap_resend_rejected_frames(self, CMD_FRAME);
 		irlap_start_wd_timer(self, self->wd_timeout);
-		dev_kfree_skb(skb);
 		break;
 	case RECV_SREJ_CMD:
 		irlap_update_nr_received(self, info->nr);
@@ -1905,7 +1848,6 @@ static int irlap_state_nrm_s(struct irla
 		} else
 			irlap_resend_rejected_frame(self, CMD_FRAME);
 		irlap_start_wd_timer(self, self->wd_timeout);
-		dev_kfree_skb(skb);
 		break;
 	case WD_TIMER_EXPIRED:
 		/*
@@ -1944,7 +1886,6 @@ static int irlap_state_nrm_s(struct irla
 		irlap_apply_default_connection_parameters(self);
 
 		irlap_disconnect_indication(self, LAP_DISC_INDICATION);
-		dev_kfree_skb(skb);		
 		break;
 	case RECV_DISCOVERY_XID_CMD:
 		irlap_wait_min_turn_around(self, &self->qos_tx);
@@ -1953,7 +1894,6 @@ static int irlap_state_nrm_s(struct irla
 		irlap_start_wd_timer(self, self->wd_timeout);
 		irlap_next_state(self, LAP_NRM_S);
 
-		dev_kfree_skb(skb);
 		break;
 	case RECV_TEST_CMD:
 		/* Remove test frame header */
@@ -1964,13 +1904,10 @@ static int irlap_state_nrm_s(struct irla
 
 		/* Send response (info will be copied) */
 		irlap_send_test_frame(self, self->caddr, info->daddr, skb);
-		dev_kfree_skb(skb);
 		break;
 	default:
 		IRDA_DEBUG(1, __FUNCTION__ "(), Unknown event %d, (%s)\n", 
 			   event, irlap_event[event]);
-		if (skb)
-			dev_kfree_skb(skb);
 
 		ret = -EINVAL;
 		break;
@@ -2005,7 +1942,6 @@ static int irlap_state_sclose(struct irl
 		irlap_apply_default_connection_parameters(self);
 
 		irlap_disconnect_indication(self, LAP_DISC_INDICATION);
-		dev_kfree_skb(skb);
 		break;
 	case RECV_DM_RSP:
 		/* Always switch state before calling upper layers */
@@ -2015,7 +1951,6 @@ static int irlap_state_sclose(struct irl
 		irlap_apply_default_connection_parameters(self);
 		
 		irlap_disconnect_indication(self, LAP_DISC_INDICATION);
-		dev_kfree_skb(skb);
 		break;
 	case WD_TIMER_EXPIRED:
 		irlap_apply_default_connection_parameters(self);
@@ -2025,9 +1960,7 @@ static int irlap_state_sclose(struct irl
 	default:
 		IRDA_DEBUG(1, __FUNCTION__ "(), Unknown event %d, (%s)\n", 
 			   event, irlap_event[event]);
-		if (skb)
-			dev_kfree_skb(skb);
-		
+
 		ret = -EINVAL;
 		break;
 	}
@@ -2064,8 +1997,6 @@ static int irlap_state_reset_check( stru
 	default:
 		IRDA_DEBUG(1, __FUNCTION__ "(), Unknown event %d, (%s)\n", 
 			   event, irlap_event[event]);
-		if (skb)
-			dev_kfree_skb(skb);
 
 		ret = -EINVAL;
 		break;
diff -urpN old-linux/net/irda/irlap_frame.c linux/net/irda/irlap_frame.c
--- old-linux/net/irda/irlap_frame.c	Thu Jan  6 14:46:18 2000
+++ linux/net/irda/irlap_frame.c	Thu Nov  9 14:47:40 2000
@@ -164,7 +164,6 @@ static void irlap_recv_snrm_cmd(struct i
 		if ((info->caddr == 0x00) || (info->caddr == 0xfe)) {
 			IRDA_DEBUG(3, __FUNCTION__ 
 			      "(), invalid connection address!\n");
-			dev_kfree_skb(skb);
 			return;
 		}
 		
@@ -175,13 +174,13 @@ static void irlap_recv_snrm_cmd(struct i
 		/* Only accept if addressed directly to us */
 		if (info->saddr != self->saddr) {
 			IRDA_DEBUG(2, __FUNCTION__ "(), not addressed to us!\n");
-			dev_kfree_skb(skb);
 			return;
 		}
 		irlap_do_event(self, RECV_SNRM_CMD, skb, info);
-	} else
+	} else {
 		/* Signal that this SNRM frame does not contain and I-field */
 		irlap_do_event(self, RECV_SNRM_CMD, skb, NULL);
+	}
 }
 
 /*
@@ -408,13 +407,11 @@ static void irlap_recv_discovery_xid_rsp
 	if ((info->saddr != self->saddr) && (info->saddr != BROADCAST)) {
 		IRDA_DEBUG(0, __FUNCTION__ 
 			   "(), frame is not addressed to us!\n");
-		dev_kfree_skb(skb);
 		return;
 	}
 
 	if ((discovery = kmalloc(sizeof(discovery_t), GFP_ATOMIC)) == NULL) {
 		WARNING(__FUNCTION__ "(), kmalloc failed!\n");
-		dev_kfree_skb(skb);
 		return;
 	}
 	memset(discovery, 0, sizeof(discovery_t));
@@ -476,7 +473,6 @@ static void irlap_recv_discovery_xid_cmd
 	if ((info->saddr != self->saddr) && (info->saddr != BROADCAST)) {
 		IRDA_DEBUG(0, __FUNCTION__ 
 			   "(), frame is not addressed to us!\n");
-		dev_kfree_skb(skb);
 		return;
 	}
 
@@ -512,7 +508,6 @@ static void irlap_recv_discovery_xid_cmd
 		discovery = kmalloc(sizeof(discovery_t), GFP_ATOMIC);
 		if (!discovery) {
 			WARNING(__FUNCTION__ "(), unable to malloc!\n");
-			dev_kfree_skb(skb);
 			return;
 		}
 	      
@@ -541,7 +536,7 @@ static void irlap_recv_discovery_xid_cmd
 		info->discovery = discovery;
 	} else
 		info->discovery = NULL;
-	
+
 	irlap_do_event(self, RECV_DISCOVERY_XID_CMD, skb, info);
 }
 
@@ -734,7 +729,6 @@ void irlap_send_data_primary(struct irla
 		/* Copy buffer */
 		tx_skb = skb_clone(skb, GFP_ATOMIC);
 		if (tx_skb == NULL) {
-			dev_kfree_skb(skb);
 			return;
 		}
 		
@@ -747,7 +741,7 @@ void irlap_send_data_primary(struct irla
 		/* 
 		 *  Insert frame in store, in case of retransmissions 
 		 */
-		skb_queue_tail(&self->wx_list, skb);
+		skb_queue_tail(&self->wx_list, skb_get(skb));
 		
 		self->vs = (self->vs + 1) % 8;
 		self->ack_required = FALSE;		
@@ -756,7 +750,7 @@ void irlap_send_data_primary(struct irla
 		irlap_send_i_frame( self, tx_skb, CMD_FRAME);
 	} else {
 		IRDA_DEBUG(4, __FUNCTION__ "(), sending unreliable frame\n");
-		irlap_send_ui_frame(self, skb, self->caddr, CMD_FRAME);
+		irlap_send_ui_frame(self, skb_get(skb), self->caddr, CMD_FRAME);
 		self->window -= 1;
 	}
 }
@@ -781,7 +775,6 @@ void irlap_send_data_primary_poll(struct
 		/* Copy buffer */
 		tx_skb = skb_clone(skb, GFP_ATOMIC);
 		if (tx_skb == NULL) {
-			dev_kfree_skb(skb);
 			return;
 		}
 		
@@ -794,7 +787,7 @@ void irlap_send_data_primary_poll(struct
 		/* 
 		 *  Insert frame in store, in case of retransmissions 
 		 */
-		skb_queue_tail(&self->wx_list, skb);
+		skb_queue_tail(&self->wx_list, skb_get(skb));
 		
 		/*  
 		 *  Set poll bit if necessary. We do this to the copied
@@ -819,12 +812,12 @@ void irlap_send_data_primary_poll(struct
 		del_timer(&self->poll_timer);
 
 		if (self->ack_required) {
-			irlap_send_ui_frame(self, skb, self->caddr, CMD_FRAME);
+			irlap_send_ui_frame(self, skb_get(skb), self->caddr, CMD_FRAME);
 			irlap_send_rr_frame(self, CMD_FRAME);
 			self->ack_required = FALSE;
 		} else {
 			skb->data[1] |= PF_BIT;
-			irlap_send_ui_frame(self, skb, self->caddr, CMD_FRAME);
+			irlap_send_ui_frame(self, skb_get(skb), self->caddr, CMD_FRAME);
 		}
 		self->window = self->window_size;
 		irlap_start_final_timer(self, self->final_timeout);
@@ -857,7 +850,6 @@ void irlap_send_data_secondary_final(str
 		
 		tx_skb = skb_clone(skb, GFP_ATOMIC);
 		if (tx_skb == NULL) {
-			dev_kfree_skb(skb);
 			return;
 		}		
 
@@ -865,7 +857,7 @@ void irlap_send_data_secondary_final(str
 			skb_set_owner_w(tx_skb, skb->sk);
 		
 		/* Insert frame in store */
-		skb_queue_tail(&self->wx_list, skb);
+		skb_queue_tail(&self->wx_list, skb_get(skb));
 		
 		tx_skb->data[1] |= PF_BIT;
 		
@@ -878,12 +870,12 @@ void irlap_send_data_secondary_final(str
 		irlap_send_i_frame(self, tx_skb, RSP_FRAME); 
 	} else {
 		if (self->ack_required) {
-			irlap_send_ui_frame(self, skb, self->caddr, RSP_FRAME);
+			irlap_send_ui_frame(self, skb_get(skb), self->caddr, RSP_FRAME);
 			irlap_send_rr_frame(self, RSP_FRAME);
 			self->ack_required = FALSE;
 		} else {
 			skb->data[1] |= PF_BIT;
-			irlap_send_ui_frame(self, skb, self->caddr, RSP_FRAME);
+			irlap_send_ui_frame(self, skb_get(skb), self->caddr, RSP_FRAME);
 		}
 		self->window = self->window_size;
 
@@ -912,7 +904,6 @@ void irlap_send_data_secondary(struct ir
 		
 		tx_skb = skb_clone(skb, GFP_ATOMIC);
 		if (tx_skb == NULL) {
-			dev_kfree_skb(skb);
 			return;
 		}		
 		
@@ -920,7 +911,7 @@ void irlap_send_data_secondary(struct ir
 			skb_set_owner_w(tx_skb, skb->sk);
 		
 		/* Insert frame in store */
-		skb_queue_tail(&self->wx_list, skb);
+		skb_queue_tail(&self->wx_list, skb_get(skb));
 		
 		self->vs = (self->vs + 1) % 8;
 		self->ack_required = FALSE;		
@@ -928,7 +919,7 @@ void irlap_send_data_secondary(struct ir
 
 		irlap_send_i_frame(self, tx_skb, RSP_FRAME); 
 	} else {
-		irlap_send_ui_frame(self, skb, self->caddr, RSP_FRAME);
+		irlap_send_ui_frame(self, skb_get(skb), self->caddr, RSP_FRAME);
 		self->window -= 1;
 	}
 }
@@ -1023,6 +1014,7 @@ void irlap_resend_rejected_frames(struct
 			} else {
 				irlap_send_data_primary_poll(self, skb);
 			}
+			kfree_skb(skb);
 		}
 	}
 #endif
@@ -1259,7 +1251,6 @@ static void irlap_recv_test_frame(struct
 		if (skb->len < sizeof(struct test_frame)) {
 			IRDA_DEBUG(0, __FUNCTION__ 
 				   "() test frame to short!\n");
-			dev_kfree_skb(skb);
 			return;
 		}
 		
@@ -1270,7 +1261,6 @@ static void irlap_recv_test_frame(struct
 		/* Make sure frame is addressed to us */
 		if ((info->saddr != self->saddr) && 
 		    (info->saddr != BROADCAST)) {
-			dev_kfree_skb(skb);
 			return;
 		}
 	}
@@ -1323,8 +1313,7 @@ int irlap_driver_rcv(struct sk_buff *skb
 	/*  First we check if this frame has a valid connection address */
 	if ((info.caddr != self->caddr) && (info.caddr != CBROADCAST)) {
 		IRDA_DEBUG(0, __FUNCTION__ "(), wrong connection address!\n");
-		dev_kfree_skb(skb);
-		return 0;
+		goto out;
 	}
 	/*  
 	 *  Optimize for the common case and check if the frame is an
@@ -1332,7 +1321,7 @@ int irlap_driver_rcv(struct sk_buff *skb
 	 */
 	if (~control & 0x01) {
 		irlap_recv_i_frame(self, skb, &info, command);
-		return 0;
+		goto out;
 	}
 	/*
 	 *  We now check is the frame is an S(upervisory) frame. Only 
@@ -1360,10 +1349,9 @@ int irlap_driver_rcv(struct sk_buff *skb
 			WARNING(__FUNCTION__ 
 				"() Unknown S-frame %02x received!\n",
 				info.control);
-			dev_kfree_skb(skb);
 			break;
 		}
-		return 0;
+		goto out;
 	}
 	/* 
 	 *  This must be a C(ontrol) frame 
@@ -1399,8 +1387,9 @@ int irlap_driver_rcv(struct sk_buff *skb
 	default:
 		WARNING(__FUNCTION__ "(), Unknown frame %02x received!\n", 
 			info.control);
-		dev_kfree_skb(skb); 
 		break;
 	}
+out:
+	dev_kfree_skb(skb); 
 	return 0;
 }


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
