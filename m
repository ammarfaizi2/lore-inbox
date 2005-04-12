Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262044AbVDLIE4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262044AbVDLIE4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 04:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262047AbVDLIEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 04:04:55 -0400
Received: from fmr24.intel.com ([143.183.121.16]:10727 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S262044AbVDLIEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 04:04:12 -0400
Message-Id: <200504120803.j3C83tg06634@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Jens Axboe'" <axboe@suse.de>, "Nick Piggin" <nickpiggin@yahoo.com.au>
Cc: "Claudio Martins" <ctpm@rnl.ist.utl.pt>, "Andrew Morton" <akpm@osdl.org>,
       "lkml" <linux-kernel@vger.kernel.org>,
       "Neil Brown" <neilb@cse.unsw.edu.au>
Subject: RE: Processes stuck on D state on Dual Opteron
Date: Tue, 12 Apr 2005 01:03:50 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcU/MGq93qDMgoQYTPSuLx3hVto5BQAAhrcw
In-Reply-To: <20050412070744.GB7161@suse.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12 2005, Nick Piggin wrote:
> Actually the patches I have sent you do fix real bugs, but they also
> make the block layer less likely to recurse into page reclaim, so it
> may be eg. hiding the problem that Neil's patch fixes.

Jens Axboe wrote on Tuesday, April 12, 2005 12:08 AM
> Can you push those to Andrew? I'm quite happy with the way they turned
> out. It would be nice if Ken would bench 2.6.12-rc2 with and without
> those patches.


I like the patch a lot and already did bench it on our db setup.  However,
I'm seeing a negative regression compare to a very very crappy patch (see
attached, you can laugh at me for doing things like that :-).

My first reaction is that the overhead is in wait queue setup and tear down
in get_request_wait function. Throwing the following patch on top does improve
things a bit, but we are still in the negative territory.  I can't explain why.
Everything suppose to be faster.  So I'm staring at the execution profile at
the moment.


diff -Nru a/drivers/block/ll_rw_blk.c b/drivers/block/ll_rw_blk.c
--- a/drivers/block/ll_rw_blk.c	2005-04-12 00:48:12 -07:00
+++ b/drivers/block/ll_rw_blk.c	2005-04-12 00:48:12 -07:00
@@ -1740,10 +1740,35 @@
  */
 static struct request *get_request_wait(request_queue_t *q, int rw)
 {
-	DEFINE_WAIT(wait);
 	struct request *rq;
+	struct request_list *rl = &q->rq;
+	int gfp_flag = GFP_ATOMIC;
+
+	if (rl->count[rw] < queue_congestion_off_threshold(q)) {
+		rq = kmem_cache_alloc(request_cachep, gfp_flag);
+		if (rq) {
+			if (!elv_set_request(q, rq, gfp_flag)) {
+
+				rl->count[rw]++;
+				INIT_LIST_HEAD(&rq->queuelist);
+				rq->flags = rw;
+				rq->rq_status = RQ_ACTIVE;
+				rq->ref_count = 1;
+				rq->q = q;
+				rq->rl = rl;
+				rq->special = NULL;
+				rq->data_len = 0;
+				rq->data = NULL;
+				rq->sense = NULL;
+
+				return rq;
+			}
+			kmem_cache_free(request_cachep, rq);
+		}
+	}

 	do {
+		DEFINE_WAIT(wait);
 		struct request_list *rl = &q->rq;

 		prepare_to_wait_exclusive(&rl->wait[rw], &wait,



begin 666 old_freereq.patch
M9&EF9B M3G)U(&$O9')I=F5R<R]B;&]C:R]L;%]R=U]B;&LN8R!B+V1R:79E
M<G,O8FQO8VLO;&Q?<G=?8FQK+F,*+2TM(&$O9')I=F5R<R]B;&]C:R]L;%]R
M=U]B;&LN8PDR,# U+3 T+3 T(# P.C4X.C4U("TP-SHP, HK*RL@8B]D<FEV
M97)S+V)L;V-K+VQL7W)W7V)L:RYC"3(P,#4M,#0M,#0@,# Z-3@Z-34@+3 W
M.C P"D! ("TQ.3DV+#$U("LQ.3DV+#$T($! "B *( ER82 ](&)I;RT^8FE?
M<G<@)B H,2 \/"!"24]?4E=?04A%040I.PH@"BL)+RH@1W)A8B!A(&9R964@
M<F5Q=65S="!F<F]M('1H92!F<F5E;&ES=" J+PHK"69R965R97$@/2!G971?
M<F5Q=65S="AQ+"!R=RP@1T907T%43TU)0RD["BL*(&%G86EN.@H@"7-P:6Y?
M;&]C:U]I<G$H<2T^<75E=65?;&]C:RD["B *+0EI9B H96QV7W%U975E7V5M
M<'1Y*'$I*2!["BL):68@*&5L=E]Q=65U95]E;7!T>2AQ*2D*( D)8FQK7W!L
M=6=?9&5V:6-E*'$I.PHM"0EG;W1O(&=E=%]R<3L*+0E]"BT):68@*&)A<G)I
M97(I"BT)"6=O=&\@9V5T7W)Q.PH@"B )96Q?<F5T(#T@96QV7VUE<F=E*'$L
A("9R97$L(&)I;RD["B )<W=I=&-H("AE;%]R970I('L*
`
end

