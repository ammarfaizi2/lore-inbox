Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261796AbULOB2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbULOB2p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 20:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261822AbULOB1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 20:27:32 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:526 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261796AbULOBMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 20:12:15 -0500
Date: Wed, 15 Dec 2004 02:12:11 +0100
From: Adrian Bunk <bunk@stusta.de>
To: acme@conectiva.com.br
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/llc/: misc possible cleanups
Message-ID: <20041215011211.GC12937@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below contains the following possible cleanups:
- make some needlessly global code static
- remove the following unused global functions:
  - lc_c_ac.c: llc_conn_ac_report_status
  - lc_c_ac.c: llc_conn_ac_send_dm_rsp_f_set_f_flag
  - lc_c_ac.c: llc_conn_ac_resend_i_cmd_p_set_1
  - lc_c_ac.c: llc_conn_ac_resend_i_cmd_p_set_1_or_send_rr
  - lc_c_ac.c: llc_conn_ac_send_ack_cmd_p_set_1
  - lc_c_ac.c: llc_conn_ac_send_ua_rsp_f_set_f_flag
  - lc_c_ac.c: llc_conn_ac_set_f_flag_p
  - llc_c_ev.c: llc_conn_ev_conn_resp
  - llc_c_ev.c: llc_conn_ev_rst_resp
  - llc_c_ev.c: llc_conn_ev_rx_xxx_cmd_pbit_set_0
  - llc_c_ev.c: llc_conn_ev_rx_xxx_yyy
  - llc_c_ev.c: llc_conn_ev_any_tmr_exp
  - llc_c_ev.c: llc_conn_ev_qlfy_init_p_f_cycle
  - llc_c_ev.c: llc_conn_ev_qlfy_set_status_impossible
  - llc_c_ev.c: llc_conn_ev_qlfy_set_status_received
  - llc_if.c: llc_build_and_send_reset_pkt
  - llc_pdu.c: llc_pdu_decode_cr_bit
- remove the following unneeded EXPORT_SYMBOL:
  - llc_core.c: llc_sap_list_lock

Please comment on which of these changes are correct and which conflict
with pending patches.


diffstat output:
 include/net/llc_c_ac.h |   19 ------
 include/net/llc_c_ev.h |   12 ---
 include/net/llc_conn.h |    3 
 include/net/llc_pdu.h  |    1 
 include/net/llc_sap.h  |    1 
 net/llc/llc_c_ac.c     |  127 ++++-------------------------------------
 net/llc/llc_c_ev.c     |   88 ----------------------------
 net/llc/llc_conn.c     |    7 +-
 net/llc/llc_core.c     |    7 --
 net/llc/llc_if.c       |   24 -------
 net/llc/llc_pdu.c      |   13 ----
 net/llc/llc_proc.c     |    4 -
 net/llc/llc_sap.c      |    5 -
 net/llc/llc_station.c  |    2 
 14 files changed, 27 insertions(+), 286 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc3-mm1-full/include/net/llc_c_ac.h.old	2004-12-14 21:20:52.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/include/net/llc_c_ac.h	2004-12-14 21:25:39.000000000 +0100
@@ -96,7 +96,6 @@
 extern int llc_conn_ac_disc_ind(struct sock* sk, struct sk_buff *skb);
 extern int llc_conn_ac_rst_ind(struct sock* sk, struct sk_buff *skb);
 extern int llc_conn_ac_rst_confirm(struct sock* sk, struct sk_buff *skb);
-extern int llc_conn_ac_report_status(struct sock* sk, struct sk_buff *skb);
 extern int llc_conn_ac_clear_remote_busy_if_f_eq_1(struct sock* sk,
 						   struct sk_buff *skb);
 extern int llc_conn_ac_stop_rej_tmr_if_data_flag_eq_2(struct sock* sk,
@@ -107,8 +106,6 @@
 					   struct sk_buff *skb);
 extern int llc_conn_ac_send_dm_rsp_f_set_1(struct sock* sk,
 					   struct sk_buff *skb);
-extern int llc_conn_ac_send_dm_rsp_f_set_f_flag(struct sock* sk,
-						struct sk_buff *skb);
 extern int llc_conn_ac_send_frmr_rsp_f_set_x(struct sock* sk,
 					     struct sk_buff *skb);
 extern int llc_conn_ac_resend_frmr_rsp_f_set_0(struct sock* sk,
@@ -116,11 +113,6 @@
 extern int llc_conn_ac_resend_frmr_rsp_f_set_p(struct sock* sk,
 					       struct sk_buff *skb);
 extern int llc_conn_ac_send_i_cmd_p_set_1(struct sock* sk, struct sk_buff *skb);
-extern int llc_conn_ac_send_i_cmd_p_set_0(struct sock* sk, struct sk_buff *skb);
-extern int llc_conn_ac_resend_i_cmd_p_set_1(struct sock* sk,
-					    struct sk_buff *skb);
-extern int llc_conn_ac_resend_i_cmd_p_set_1_or_send_rr(struct sock* sk,
-						  struct sk_buff *skb);
 extern int llc_conn_ac_send_i_xxx_x_set_0(struct sock* sk, struct sk_buff *skb);
 extern int llc_conn_ac_resend_i_xxx_x_set_0(struct sock* sk,
 					    struct sk_buff *skb);
@@ -145,8 +137,6 @@
 						struct sk_buff *skb);
 extern int llc_conn_ac_send_rr_cmd_p_set_1(struct sock* sk,
 					   struct sk_buff *skb);
-extern int llc_conn_ac_send_ack_cmd_p_set_1(struct sock* sk,
-					    struct sk_buff *skb);
 extern int llc_conn_ac_send_rr_rsp_f_set_1(struct sock* sk,
 					   struct sk_buff *skb);
 extern int llc_conn_ac_send_ack_rsp_f_set_1(struct sock* sk,
@@ -157,8 +147,6 @@
 					    struct sk_buff *skb);
 extern int llc_conn_ac_send_sabme_cmd_p_set_x(struct sock* sk,
 					      struct sk_buff *skb);
-extern int llc_conn_ac_send_ua_rsp_f_set_f_flag(struct sock* sk,
-						struct sk_buff *skb);
 extern int llc_conn_ac_send_ua_rsp_f_set_p(struct sock* sk,
 					   struct sk_buff *skb);
 extern int llc_conn_ac_set_s_flag_0(struct sock* sk, struct sk_buff *skb);
@@ -183,7 +171,6 @@
 extern int llc_conn_ac_set_data_flag_1_if_data_flag_eq_0(struct sock* sk,
 							 struct sk_buff *skb);
 extern int llc_conn_ac_set_p_flag_0(struct sock* sk, struct sk_buff *skb);
-extern int llc_conn_ac_set_p_flag_1(struct sock* sk, struct sk_buff *skb);
 extern int llc_conn_ac_set_remote_busy_0(struct sock* sk, struct sk_buff *skb);
 extern int llc_conn_ac_set_retry_cnt_0(struct sock* sk, struct sk_buff *skb);
 extern int llc_conn_ac_set_cause_flag_0(struct sock* sk, struct sk_buff *skb);
@@ -195,20 +182,14 @@
 extern int llc_conn_ac_set_vs_nr(struct sock* sk, struct sk_buff *skb);
 extern int llc_conn_ac_rst_vs(struct sock* sk, struct sk_buff *skb);
 extern int llc_conn_ac_upd_vs(struct sock* sk, struct sk_buff *skb);
-extern int llc_conn_ac_set_f_flag_p(struct sock* sk, struct sk_buff *skb);
 extern int llc_conn_disc(struct sock* sk, struct sk_buff *skb);
 extern int llc_conn_reset(struct sock* sk, struct sk_buff *skb);
 extern int llc_conn_ac_disc_confirm(struct sock* sk, struct sk_buff *skb);
 extern u8 llc_circular_between(u8 a, u8 b, u8 c);
 extern int llc_conn_ac_send_ack_if_needed(struct sock* sk, struct sk_buff *skb);
-extern int llc_conn_ac_inc_npta_value(struct sock* sk, struct sk_buff *skb);
 extern int llc_conn_ac_adjust_npta_by_rr(struct sock* sk, struct sk_buff *skb);
 extern int llc_conn_ac_adjust_npta_by_rnr(struct sock* sk, struct sk_buff *skb);
 extern int llc_conn_ac_rst_sendack_flag(struct sock* sk, struct sk_buff *skb);
-extern int llc_conn_ac_send_rr_rsp_f_set_ackpf(struct sock* sk,
-					       struct sk_buff *skb);
-extern int llc_conn_ac_send_i_rsp_f_set_ackpf(struct sock* sk,
-					      struct sk_buff *skb);
 extern int llc_conn_ac_send_i_rsp_as_ack(struct sock* sk, struct sk_buff *skb);
 extern int llc_conn_ac_send_i_as_ack(struct sock* sk, struct sk_buff *skb);
 
--- linux-2.6.10-rc3-mm1-full/net/llc/llc_c_ac.c.old	2004-12-14 21:21:07.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/llc/llc_c_ac.c	2004-12-14 21:26:07.000000000 +0100
@@ -33,6 +33,13 @@
 static void llc_process_tmr_ev(struct sock *sk, struct sk_buff *skb);
 static int llc_conn_ac_data_confirm(struct sock *sk, struct sk_buff *ev);
 
+static int llc_conn_ac_inc_npta_value(struct sock *sk, struct sk_buff *skb);
+
+static int llc_conn_ac_send_rr_rsp_f_set_ackpf(struct sock *sk,
+					       struct sk_buff *skb);
+
+static int llc_conn_ac_set_p_flag_1(struct sock *sk, struct sk_buff *skb);
+
 #define INCORRECT 0
 
 int llc_conn_ac_clear_remote_busy(struct sock *sk, struct sk_buff *skb)
@@ -185,11 +192,6 @@
 	return 0;
 }
 
-int llc_conn_ac_report_status(struct sock *sk, struct sk_buff *skb)
-{
-	return 0;
-}
-
 int llc_conn_ac_clear_remote_busy_if_f_eq_1(struct sock *sk,
 					    struct sk_buff *skb)
 {
@@ -291,32 +293,6 @@
 	goto out;
 }
 
-int llc_conn_ac_send_dm_rsp_f_set_f_flag(struct sock *sk, struct sk_buff *skb)
-{
-	int rc = -ENOBUFS;
-	struct sk_buff *nskb = llc_alloc_frame();
-
-	if (nskb) {
-		struct llc_opt *llc = llc_sk(sk);
-		struct llc_sap *sap = llc->sap;
-		u8 f_bit = llc->f_flag;
-
-		nskb->dev = llc->dev;
-		llc_pdu_header_init(nskb, LLC_PDU_TYPE_U, sap->laddr.lsap,
-				    llc->daddr.lsap, LLC_PDU_RSP);
-		llc_pdu_init_as_dm_rsp(nskb, f_bit);
-		rc = llc_mac_hdr_init(nskb, llc->dev->dev_addr, llc->daddr.mac);
-		if (rc)
-			goto free;
-		llc_conn_send_pdu(sk, nskb);
-	}
-out:
-	return rc;
-free:
-	kfree_skb(nskb);
-	goto out;
-}
-
 int llc_conn_ac_send_frmr_rsp_f_set_x(struct sock *sk, struct sk_buff *skb)
 {
 	u8 f_bit;
@@ -426,7 +402,7 @@
 	return rc;
 }
 
-int llc_conn_ac_send_i_cmd_p_set_0(struct sock *sk, struct sk_buff *skb)
+static int llc_conn_ac_send_i_cmd_p_set_0(struct sock *sk, struct sk_buff *skb)
 {
 	int rc;
 	struct llc_opt *llc = llc_sk(sk);
@@ -443,27 +419,6 @@
 	return rc;
 }
 
-int llc_conn_ac_resend_i_cmd_p_set_1(struct sock *sk, struct sk_buff *skb)
-{
-	struct llc_pdu_sn *pdu = llc_pdu_sn_hdr(skb);
-	u8 nr = LLC_I_GET_NR(pdu);
-
-	llc_conn_resend_i_pdu_as_cmd(sk, nr, 1);
-	return 0;
-}
-
-int llc_conn_ac_resend_i_cmd_p_set_1_or_send_rr(struct sock *sk,
-						struct sk_buff *skb)
-{
-	struct llc_pdu_sn *pdu = llc_pdu_sn_hdr(skb);
-	u8 nr = LLC_I_GET_NR(pdu);
-	int rc = llc_conn_ac_send_rr_cmd_p_set_1(sk, skb);
-
-	if (!rc)
-		llc_conn_resend_i_pdu_as_cmd(sk, nr, 0);
-	return rc;
-}
-
 int llc_conn_ac_send_i_xxx_x_set_0(struct sock *sk, struct sk_buff *skb)
 {
 	int rc;
@@ -745,31 +700,6 @@
 	goto out;
 }
 
-int llc_conn_ac_send_ack_cmd_p_set_1(struct sock *sk, struct sk_buff *skb)
-{
-	int rc = -ENOBUFS;
-	struct sk_buff *nskb = llc_alloc_frame();
-
-	if (nskb) {
-		struct llc_opt *llc = llc_sk(sk);
-		struct llc_sap *sap = llc->sap;
-
-		nskb->dev = llc->dev;
-		llc_pdu_header_init(nskb, LLC_PDU_TYPE_S, sap->laddr.lsap,
-				    llc->daddr.lsap, LLC_PDU_CMD);
-		llc_pdu_init_as_rr_cmd(nskb, 1, llc->vR);
-		rc = llc_mac_hdr_init(nskb, llc->dev->dev_addr, llc->daddr.mac);
-		if (rc)
-			goto free;
-		llc_conn_send_pdu(sk, nskb);
-	}
-out:
-	return rc;
-free:
-	kfree_skb(nskb);
-	goto out;
-}
-
 int llc_conn_ac_send_rr_rsp_f_set_1(struct sock *sk, struct sk_buff *skb)
 {
 	int rc = -ENOBUFS;
@@ -911,31 +841,6 @@
 	goto out;
 }
 
-int llc_conn_ac_send_ua_rsp_f_set_f_flag(struct sock *sk, struct sk_buff *skb)
-{
-	int rc = -ENOBUFS;
-	struct sk_buff *nskb = llc_alloc_frame();
-
-	if (nskb) {
-		struct llc_opt *llc = llc_sk(sk);
-		struct llc_sap *sap = llc->sap;
-
-		nskb->dev = llc->dev;
-		llc_pdu_header_init(nskb, LLC_PDU_TYPE_U, sap->laddr.lsap,
-				    llc->daddr.lsap, LLC_PDU_RSP);
-		llc_pdu_init_as_ua_rsp(nskb, llc->f_flag);
-		rc = llc_mac_hdr_init(nskb, llc->dev->dev_addr, llc->daddr.mac);
-		if (rc)
-			goto free;
-		llc_conn_send_pdu(sk, nskb);
-	}
-out:
-	return rc;
-free:
-	kfree_skb(nskb);
-	goto out;
-}
-
 int llc_conn_ac_send_ua_rsp_f_set_p(struct sock *sk, struct sk_buff *skb)
 {
 	u8 f_bit;
@@ -1041,7 +946,8 @@
  *	set to one if one PDU with p-bit set to one is received.  Returns 0 for
  *	success, 1 otherwise.
  */
-int llc_conn_ac_send_i_rsp_f_set_ackpf(struct sock *sk, struct sk_buff *skb)
+static int llc_conn_ac_send_i_rsp_f_set_ackpf(struct sock *sk,
+					      struct sk_buff *skb)
 {
 	int rc;
 	struct llc_opt *llc = llc_sk(sk);
@@ -1091,7 +997,8 @@
  *	if there is any. ack_pf flag indicates if a PDU has been received with
  *	p-bit set to one. Returns 0 for success, 1 otherwise.
  */
-int llc_conn_ac_send_rr_rsp_f_set_ackpf(struct sock *sk, struct sk_buff *skb)
+static int llc_conn_ac_send_rr_rsp_f_set_ackpf(struct sock *sk,
+					       struct sk_buff *skb)
 {
 	int rc = -ENOBUFS;
 	struct sk_buff *nskb = llc_alloc_frame();
@@ -1126,7 +1033,7 @@
  *	acknowledgements decreases by increasing of "npta". Returns 0 for
  *	success, 1 otherwise.
  */
-int llc_conn_ac_inc_npta_value(struct sock *sk, struct sk_buff *skb)
+static int llc_conn_ac_inc_npta_value(struct sock *sk, struct sk_buff *skb)
 {
 	struct llc_opt *llc = llc_sk(sk);
 
@@ -1387,7 +1294,7 @@
 	return 0;
 }
 
-int llc_conn_ac_set_p_flag_1(struct sock *sk, struct sk_buff *skb)
+static int llc_conn_ac_set_p_flag_1(struct sock *sk, struct sk_buff *skb)
 {
 	llc_conn_set_p_flag(sk, 1);
 	return 0;
@@ -1453,12 +1360,6 @@
 	return 0;
 }
 
-int llc_conn_ac_set_f_flag_p(struct sock *sk, struct sk_buff *skb)
-{
-	llc_pdu_decode_pf_bit(skb, &llc_sk(sk)->f_flag);
-	return 0;
-}
-
 void llc_conn_pf_cycle_tmr_cb(unsigned long timeout_data)
 {
 	struct sock *sk = (struct sock *)timeout_data;
--- linux-2.6.10-rc3-mm1-full/include/net/llc_c_ev.h.old	2004-12-14 21:26:24.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/include/net/llc_c_ev.h	2004-12-14 21:40:58.000000000 +0100
@@ -129,11 +129,9 @@
 typedef int (*llc_conn_ev_qfyr_t)(struct sock *sk, struct sk_buff *skb);
 
 extern int llc_conn_ev_conn_req(struct sock *sk, struct sk_buff *skb);
-extern int llc_conn_ev_conn_resp(struct sock *sk, struct sk_buff *skb);
 extern int llc_conn_ev_data_req(struct sock *sk, struct sk_buff *skb);
 extern int llc_conn_ev_disc_req(struct sock *sk, struct sk_buff *skb);
 extern int llc_conn_ev_rst_req(struct sock *sk, struct sk_buff *skb);
-extern int llc_conn_ev_rst_resp(struct sock *sk, struct sk_buff *skb);
 extern int llc_conn_ev_local_busy_detected(struct sock *sk,
 					   struct sk_buff *skb);
 extern int llc_conn_ev_local_busy_cleared(struct sock *sk, struct sk_buff *skb);
@@ -162,7 +160,6 @@
 					     struct sk_buff *skb);
 extern int llc_conn_ev_rx_xxx_rsp_fbit_set_x(struct sock *sk,
 					     struct sk_buff *skb);
-extern int llc_conn_ev_rx_xxx_yyy(struct sock *sk, struct sk_buff *skb);
 extern int llc_conn_ev_rx_zzz_cmd_pbit_set_x_inval_nr(struct sock *sk,
 						      struct sk_buff *skb);
 extern int llc_conn_ev_rx_zzz_rsp_fbit_set_x_inval_nr(struct sock *sk,
@@ -171,13 +168,10 @@
 extern int llc_conn_ev_ack_tmr_exp(struct sock *sk, struct sk_buff *skb);
 extern int llc_conn_ev_rej_tmr_exp(struct sock *sk, struct sk_buff *skb);
 extern int llc_conn_ev_busy_tmr_exp(struct sock *sk, struct sk_buff *skb);
-extern int llc_conn_ev_any_tmr_exp(struct sock *sk, struct sk_buff *skb);
 extern int llc_conn_ev_sendack_tmr_exp(struct sock *sk, struct sk_buff *skb);
 /* NOT_USED functions and their variations */
 extern int llc_conn_ev_rx_xxx_cmd_pbit_set_1(struct sock *sk,
 					     struct sk_buff *skb);
-extern int llc_conn_ev_rx_xxx_cmd_pbit_set_0(struct sock *sk,
-					     struct sk_buff *skb);
 extern int llc_conn_ev_rx_xxx_rsp_fbit_set_1(struct sock *sk,
 					     struct sk_buff *skb);
 extern int llc_conn_ev_rx_i_cmd_pbit_set_0_unexpd_ns(struct sock *sk,
@@ -252,20 +246,14 @@
 					    struct sk_buff *skb);
 extern int llc_conn_ev_qlfy_cause_flag_eq_0(struct sock *sk,
 					    struct sk_buff *skb);
-extern int llc_conn_ev_qlfy_init_p_f_cycle(struct sock *sk,
-					   struct sk_buff *skb);
 extern int llc_conn_ev_qlfy_set_status_conn(struct sock *sk,
 					    struct sk_buff *skb);
 extern int llc_conn_ev_qlfy_set_status_disc(struct sock *sk,
 					    struct sk_buff *skb);
 extern int llc_conn_ev_qlfy_set_status_failed(struct sock *sk,
 					      struct sk_buff *skb);
-extern int llc_conn_ev_qlfy_set_status_impossible(struct sock *sk,
-						  struct sk_buff *skb);
 extern int llc_conn_ev_qlfy_set_status_remote_busy(struct sock *sk,
 						  struct sk_buff *skb);
-extern int llc_conn_ev_qlfy_set_status_received(struct sock *sk,
-						struct sk_buff *skb);
 extern int llc_conn_ev_qlfy_set_status_refuse(struct sock *sk,
 					      struct sk_buff *skb);
 extern int llc_conn_ev_qlfy_set_status_conflict(struct sock *sk,
--- linux-2.6.10-rc3-mm1-full/net/llc/llc_c_ev.c.old	2004-12-14 21:26:38.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/llc/llc_c_ev.c	2004-12-14 21:39:03.000000000 +0100
@@ -105,14 +105,6 @@
 	       ev->prim_type == LLC_PRIM_TYPE_REQ ? 0 : 1;
 }
 
-int llc_conn_ev_conn_resp(struct sock *sk, struct sk_buff *skb)
-{
-	struct llc_conn_state_ev *ev = llc_conn_ev(skb);
-
-	return ev->prim == LLC_CONN_PRIM &&
-	       ev->prim_type == LLC_PRIM_TYPE_RESP ? 0 : 1;
-}
-
 int llc_conn_ev_data_req(struct sock *sk, struct sk_buff *skb)
 {
 	struct llc_conn_state_ev *ev = llc_conn_ev(skb);
@@ -137,14 +129,6 @@
 	       ev->prim_type == LLC_PRIM_TYPE_REQ ? 0 : 1;
 }
 
-int llc_conn_ev_rst_resp(struct sock *sk, struct sk_buff *skb)
-{
-	struct llc_conn_state_ev *ev = llc_conn_ev(skb);
-
-	return ev->prim == LLC_RESET_PRIM &&
-	       ev->prim_type == LLC_PRIM_TYPE_RESP ? 0 : 1;
-}
-
 int llc_conn_ev_local_busy_detected(struct sock *sk, struct sk_buff *skb)
 {
 	struct llc_conn_state_ev *ev = llc_conn_ev(skb);
@@ -474,27 +458,6 @@
 	return rc;
 }
 
-int llc_conn_ev_rx_xxx_cmd_pbit_set_0(struct sock *sk, struct sk_buff *skb)
-{
-	u16 rc = 1;
-	struct llc_pdu_sn *pdu = llc_pdu_sn_hdr(skb);
-
-	if (LLC_PDU_IS_CMD(pdu)) {
-		if (LLC_PDU_TYPE_IS_I(pdu) || LLC_PDU_TYPE_IS_S(pdu)) {
-			if (LLC_I_PF_IS_0(pdu))
-				rc = 0;
-		} else if (LLC_PDU_TYPE_IS_U(pdu))
-			switch (LLC_U_PDU_CMD(pdu)) {
-			case LLC_2_PDU_CMD_SABME:
-			case LLC_2_PDU_CMD_DISC:
-				if (LLC_U_PF_IS_0(pdu))
-					rc = 0;
-				break;
-			}
-	}
-	return rc;
-}
-
 int llc_conn_ev_rx_xxx_cmd_pbit_set_x(struct sock *sk, struct sk_buff *skb)
 {
 	u16 rc = 1;
@@ -557,26 +520,6 @@
 	return rc;
 }
 
-int llc_conn_ev_rx_xxx_yyy(struct sock *sk, struct sk_buff *skb)
-{
-	u16 rc = 1;
-	struct llc_pdu_un *pdu = llc_pdu_un_hdr(skb);
-
-	if (LLC_PDU_TYPE_IS_I(pdu) || LLC_PDU_TYPE_IS_S(pdu))
-		rc = 0;
-	else if (LLC_PDU_TYPE_IS_U(pdu))
-		switch (LLC_U_PDU_CMD(pdu)) {
-		case LLC_2_PDU_CMD_SABME:
-		case LLC_2_PDU_CMD_DISC:
-		case LLC_2_PDU_RSP_UA:
-		case LLC_2_PDU_RSP_DM:
-		case LLC_2_PDU_RSP_FRMR:
-			rc = 0;
-			break;
-		}
-	return rc;
-}
-
 int llc_conn_ev_rx_zzz_cmd_pbit_set_x_inval_nr(struct sock *sk,
 					       struct sk_buff *skb)
 {
@@ -646,16 +589,6 @@
 	return ev->type != LLC_CONN_EV_TYPE_BUSY_TMR;
 }
 
-int llc_conn_ev_any_tmr_exp(struct sock *sk, struct sk_buff *skb)
-{
-	struct llc_conn_state_ev *ev = llc_conn_ev(skb);
-
-	return ev->type == LLC_CONN_EV_TYPE_P_TMR ||
-	       ev->type == LLC_CONN_EV_TYPE_ACK_TMR ||
-	       ev->type == LLC_CONN_EV_TYPE_REJ_TMR ||
-	       ev->type == LLC_CONN_EV_TYPE_BUSY_TMR ? 0 : 1;
-}
-
 int llc_conn_ev_init_p_f_cycle(struct sock *sk, struct sk_buff *skb)
 {
 	return 1;
@@ -778,11 +711,6 @@
 	return llc_sk(sk)->cause_flag;
 }
 
-int llc_conn_ev_qlfy_init_p_f_cycle(struct sock *sk, struct sk_buff *skb)
-{
-	return 0;
-}
-
 int llc_conn_ev_qlfy_set_status_conn(struct sock *sk, struct sk_buff *skb)
 {
 	struct llc_conn_state_ev *ev = llc_conn_ev(skb);
@@ -799,14 +727,6 @@
 	return 0;
 }
 
-int llc_conn_ev_qlfy_set_status_impossible(struct sock *sk, struct sk_buff *skb)
-{
-	struct llc_conn_state_ev *ev = llc_conn_ev(skb);
-
-	ev->status = LLC_STATUS_IMPOSSIBLE;
-	return 0;
-}
-
 int llc_conn_ev_qlfy_set_status_failed(struct sock *sk, struct sk_buff *skb)
 {
 	struct llc_conn_state_ev *ev = llc_conn_ev(skb);
@@ -824,14 +744,6 @@
 	return 0;
 }
 
-int llc_conn_ev_qlfy_set_status_received(struct sock *sk, struct sk_buff *skb)
-{
-	struct llc_conn_state_ev *ev = llc_conn_ev(skb);
-
-	ev->status = LLC_STATUS_RECEIVED;
-	return 0;
-}
-
 int llc_conn_ev_qlfy_set_status_refuse(struct sock *sk, struct sk_buff *skb)
 {
 	struct llc_conn_state_ev *ev = llc_conn_ev(skb);
--- linux-2.6.10-rc3-mm1-full/include/net/llc_conn.h.old	2004-12-14 21:29:57.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/include/net/llc_conn.h	2004-12-14 21:30:20.000000000 +0100
@@ -91,7 +91,6 @@
 extern void llc_sk_free(struct sock *sk);
 
 extern void llc_sk_reset(struct sock *sk);
-extern int llc_sk_init(struct sock *sk);
 
 /* Access to a connection */
 extern int llc_conn_state_process(struct sock *sk, struct sk_buff *skb);
@@ -106,8 +105,6 @@
 extern struct sock *llc_lookup_established(struct llc_sap *sap,
 					   struct llc_addr *daddr,
 					   struct llc_addr *laddr);
-extern struct sock *llc_lookup_listener(struct llc_sap *sap,
-					struct llc_addr *laddr);
 extern void llc_sap_add_socket(struct llc_sap *sap, struct sock *sk);
 extern void llc_sap_remove_socket(struct llc_sap *sap, struct sock *sk);
 
--- linux-2.6.10-rc3-mm1-full/net/llc/llc_conn.c.old	2004-12-14 21:29:09.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/llc/llc_conn.c	2004-12-14 21:30:31.000000000 +0100
@@ -503,7 +503,8 @@
  *	local mac, and local sap. Returns pointer for parent socket found,
  *	%NULL otherwise.
  */
-struct sock *llc_lookup_listener(struct llc_sap *sap, struct llc_addr *laddr)
+static struct sock *llc_lookup_listener(struct llc_sap *sap,
+					struct llc_addr *laddr)
 {
 	struct sock *rc;
 	struct hlist_node *node;
@@ -546,7 +547,7 @@
  *	Finds offset of next category of transitions in transition table.
  *	Returns the start index of next category.
  */
-u16 find_next_offset(struct llc_conn_state *state, u16 offset)
+static u16 find_next_offset(struct llc_conn_state *state, u16 offset)
 {
 	u16 cnt = 0;
 	struct llc_conn_state_trans **next_trans;
@@ -785,7 +786,7 @@
  *
  *     Initializes a socket with default llc values.
  */
-int llc_sk_init(struct sock* sk)
+static int llc_sk_init(struct sock* sk)
 {
 	struct llc_opt *llc = kmalloc(sizeof(*llc), GFP_ATOMIC);
 	int rc = -ENOMEM;
--- linux-2.6.10-rc3-mm1-full/net/llc/llc_core.c.old	2004-12-14 21:30:45.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/llc/llc_core.c	2004-12-14 21:31:57.000000000 +0100
@@ -31,7 +31,7 @@
  *
  *	Allocates and initializes sap.
  */
-struct llc_sap *llc_sap_alloc(void)
+static struct llc_sap *llc_sap_alloc(void)
 {
 	struct llc_sap *sap = kmalloc(sizeof(*sap), GFP_ATOMIC);
 
@@ -50,7 +50,7 @@
  *
  *	Adds a sap to the LLC's station sap list.
  */
-void llc_add_sap(struct llc_sap *sap)
+static void llc_add_sap(struct llc_sap *sap)
 {
 	write_lock_bh(&llc_sap_list_lock);
 	list_add_tail(&sap->node, &llc_sap_list);
@@ -63,7 +63,7 @@
  *
  *	Removes a sap to the LLC's station sap list.
  */
-void llc_del_sap(struct llc_sap *sap)
+static void llc_del_sap(struct llc_sap *sap)
 {
 	write_lock_bh(&llc_sap_list_lock);
 	list_del(&sap->node);
@@ -169,7 +169,6 @@
 
 EXPORT_SYMBOL(llc_station_mac_sa);
 EXPORT_SYMBOL(llc_sap_list);
-EXPORT_SYMBOL(llc_sap_list_lock);
 EXPORT_SYMBOL(llc_sap_find);
 EXPORT_SYMBOL(llc_sap_open);
 EXPORT_SYMBOL(llc_sap_close);
--- linux-2.6.10-rc3-mm1-full/net/llc/llc_if.c.old	2004-12-14 21:32:12.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/llc/llc_if.c	2004-12-14 21:32:20.000000000 +0100
@@ -155,27 +155,3 @@
 	return rc;
 }
 
-/**
- *	llc_build_and_send_reset_pkt - Resets an established LLC connection
- *	@prim: pointer to structure that contains service parameters.
- *
- *	Called when upper layer wants to reset an established LLC connection
- *	with a remote machine. This function packages a proper event and sends
- *	it to connection component state machine. Returns 0 for success, 1
- *	otherwise.
- */
-int llc_build_and_send_reset_pkt(struct sock *sk)
-{
-	int rc = 1;
-	struct sk_buff *skb = alloc_skb(0, GFP_ATOMIC);
-
-	if (skb) {
-		struct llc_conn_state_ev *ev = llc_conn_ev(skb);
-
-		ev->type      = LLC_CONN_EV_TYPE_PRIM;
-		ev->prim      = LLC_RESET_PRIM;
-		ev->prim_type = LLC_PRIM_TYPE_REQ;
-		rc = llc_conn_state_process(sk, skb);
-	}
-	return rc;
-}
--- linux-2.6.10-rc3-mm1-full/include/net/llc_pdu.h.old	2004-12-14 21:32:38.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/include/net/llc_pdu.h	2004-12-14 21:32:43.000000000 +0100
@@ -419,7 +419,6 @@
 extern void llc_pdu_set_cmd_rsp(struct sk_buff *skb, u8 type);
 extern void llc_pdu_set_pf_bit(struct sk_buff *skb, u8 bit_value);
 extern void llc_pdu_decode_pf_bit(struct sk_buff *skb, u8 *pf_bit);
-extern void llc_pdu_decode_cr_bit(struct sk_buff *skb, u8 *cr_bit);
 extern void llc_pdu_init_as_disc_cmd(struct sk_buff *skb, u8 p_bit);
 extern void llc_pdu_init_as_i_cmd(struct sk_buff *skb, u8 p_bit, u8 ns, u8 nr);
 extern void llc_pdu_init_as_rej_cmd(struct sk_buff *skb, u8 p_bit, u8 nr);
--- linux-2.6.10-rc3-mm1-full/net/llc/llc_pdu.c.old	2004-12-14 21:32:53.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/llc/llc_pdu.c	2004-12-14 21:33:00.000000000 +0100
@@ -80,19 +80,6 @@
 }
 
 /**
- *	llc_pdu_decode_cr_bit - extracts command response bit from LLC header
- *	@skb: input skb that c/r bit must be extracted from it.
- *	@cr_bit: command/response bit (0 or 1).
- *
- *	This function extracts command/response bit from LLC header. this bit
- *	is right bit of source SAP.
- */
-void llc_pdu_decode_cr_bit(struct sk_buff *skb, u8 *cr_bit)
-{
-	*cr_bit = llc_pdu_un_hdr(skb)->ssap & LLC_PDU_CMD_RSP_MASK;
-}
-
-/**
  *	llc_pdu_init_as_disc_cmd - Builds DISC PDU
  *	@skb: Address of the skb to build
  *	@p_bit: The P bit to set in the PDU
--- linux-2.6.10-rc3-mm1-full/net/llc/llc_proc.c.old	2004-12-14 21:33:18.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/llc/llc_proc.c	2004-12-14 21:33:44.000000000 +0100
@@ -185,14 +185,14 @@
 	return 0;
 }
 
-struct seq_operations llc_seq_socket_ops = {
+static struct seq_operations llc_seq_socket_ops = {
 	.start  = llc_seq_start,
 	.next   = llc_seq_next,
 	.stop   = llc_seq_stop,
 	.show   = llc_seq_socket_show,
 };
 
-struct seq_operations llc_seq_core_ops = {
+static struct seq_operations llc_seq_core_ops = {
 	.start  = llc_seq_start,
 	.next   = llc_seq_next,
 	.stop   = llc_seq_stop,
--- linux-2.6.10-rc3-mm1-full/include/net/llc_sap.h.old	2004-12-14 21:34:59.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/include/net/llc_sap.h	2004-12-14 21:35:05.000000000 +0100
@@ -14,7 +14,6 @@
 struct llc_sap;
 struct sk_buff;
 
-extern void llc_sap_state_process(struct llc_sap *sap, struct sk_buff *skb);
 extern void llc_sap_rtn_pdu(struct llc_sap *sap, struct sk_buff *skb);
 extern void llc_save_primitive(struct sk_buff* skb, unsigned char prim);
 extern struct sk_buff *llc_alloc_frame(void);
--- linux-2.6.10-rc3-mm1-full/net/llc/llc_sap.c.old	2004-12-14 21:34:03.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/llc/llc_sap.c	2004-12-14 21:34:48.000000000 +0100
@@ -173,7 +173,7 @@
  *	if needed(on receiving an UI frame). sk can be null for the
  *	datalink_proto case.
  */
-void llc_sap_state_process(struct llc_sap *sap, struct sk_buff *skb)
+static void llc_sap_state_process(struct llc_sap *sap, struct sk_buff *skb)
 {
 	struct llc_sap_state_ev *ev = llc_sap_ev(skb);
 
@@ -275,7 +275,8 @@
  *	Search socket list of the SAP and finds connection using the local
  *	mac, and local sap. Returns pointer for socket found, %NULL otherwise.
  */
-struct sock *llc_lookup_dgram(struct llc_sap *sap, struct llc_addr *laddr)
+static struct sock *llc_lookup_dgram(struct llc_sap *sap,
+				     struct llc_addr *laddr)
 {
 	struct sock *rc;
 	struct hlist_node *node;
--- linux-2.6.10-rc3-mm1-full/net/llc/llc_station.c.old	2004-12-14 21:35:20.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/llc/llc_station.c	2004-12-14 21:35:29.000000000 +0100
@@ -642,7 +642,7 @@
  *	Queues an event (on the station event queue) for handling by the
  *	station state machine and attempts to process any queued-up events.
  */
-void llc_station_state_process(struct sk_buff *skb)
+static void llc_station_state_process(struct sk_buff *skb)
 {
 	spin_lock_bh(&llc_main_station.ev_q.lock);
 	skb_queue_tail(&llc_main_station.ev_q.list, skb);

