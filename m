Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbUCIL1u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 06:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbUCIL1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 06:27:50 -0500
Received: from ns.bitdefender.com ([217.156.83.1]:14536 "EHLO avxfw.softwin.ro")
	by vger.kernel.org with ESMTP id S261880AbUCIL1s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 06:27:48 -0500
X-BitDefender-Spam: No (0)
X-BitDefender-Scanner: Clean, Agent: Qmail 1.5.6 (mail.dsd.ro)
Date: Tue, 9 Mar 2004 13:27:41 +0200
From: "Viorel Canja, Softwin" <vcanja@bitdefender.com>
X-Mailer: The Bat! (v2.00)
Reply-To: "Viorel Canja, Softwin" <vcanja@bitdefender.com>
Organization: Softwin
X-Priority: 3 (Normal)
Message-ID: <684501482.20040309132741@bitdefender.com>
To: linux-kernel@vger.kernel.org
Subject: problem in tcp_v4_synq_add ?
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I was looking through the networking code in 2.6.1 kernel and it seems
to me there could be a problem in tcp_ipv4.c in function tcp_v4_synq_add :

904 static void tcp_v4_synq_add(struct sock *sk, struct open_request *req)
905 {
906         struct tcp_opt *tp = tcp_sk(sk);
907         struct tcp_listen_opt *lopt = tp->listen_opt;
908         u32 h = tcp_v4_synq_hash(req->af.v4_req.rmt_addr, req->rmt_port, lopt->hash_rnd);
909 
910         req->expires = jiffies + TCP_TIMEOUT_INIT;
911         req->retrans = 0;
912         req->sk = NULL;
913         req->dl_next = lopt->syn_table[h];
914 
915         write_lock(&tp->syn_wait_lock);
916         lopt->syn_table[h] = req;
917         write_unlock(&tp->syn_wait_lock);
918 
919         tcp_synq_added(sk);
920 }

Shouldn't  "write_lock(&tp->syn_wait_lock);" be moved before
"req->dl_next = lopt->syn_table[h];" to avoid a race condition ?

I am new to the linux kernel so it is likely that I am missing
something. What am I missing ?

Thanks in advance,
Viorel

