Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261980AbSIPNov>; Mon, 16 Sep 2002 09:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261994AbSIPNov>; Mon, 16 Sep 2002 09:44:51 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:23057 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S261980AbSIPNou>;
	Mon, 16 Sep 2002 09:44:50 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200209161349.g8GDngd06901@oboe.it.uc3m.es>
Subject: end_request error procedure in 2.5?
To: linux kernel <linux-kernel@vger.kernel.org>
Date: Mon, 16 Sep 2002 15:49:42 +0200 (MET DST)
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can someone tell me why this block end_request routine works fine with a
request that isn't errored, but locks the machine a milisecond or two
later if the request is marked for erroring?

call as 

 end_request( req, (req->errors == 0) ? 1 : 0 );
 ..

 static void end_request(struct request *req, int uptodate) {
 struct bio *bio;
 while ((bio = req->bio) != NULL) {
             blk_finished_io(bio_sectors(bio));
             req->bio = bio->bi_next;
             bio->bi_next = NULL;
             bio_endio(bio, uptodate);
     }
     blk_put_request(req);
 }


It works fine except on error.  Kernel 2.5.31.  I understand that
put_request adds the request back to a free list (if gotten from there
via get_request).  The request is ordinary, except out of range ...
it's produced by an e2fsck of the device when the device itself is
unformatted, and the out of range request gets passed to the driver and
is errored there, and "kapow" ..

Peter
