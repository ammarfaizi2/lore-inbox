Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271972AbTHMXQy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 19:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272000AbTHMXQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 19:16:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:38564 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271972AbTHMXQv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 19:16:51 -0400
Message-Id: <200308132316.h7DNGao27969@mail.osdl.org>
Date: Wed, 13 Aug 2003 16:16:33 -0700 (PDT)
From: markw@osdl.org
Subject: bounce buffers and i/o schedulers with aacraid
To: piggin@cyberone.com.au, axboe@suse.de
cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We're still trying to avoid bounce buffers with the aacraid driver and
noticed something interesting in some profiles (which I'll copy farther
down) with the deadline scheduler and AS.  Using our DBT-2 workload, we
see with the deadline scheduler our patch to avoid bounce buffers
doesn't change the profile much.  But with AS, we don't see
bounce_copy_vec or __blk_queue_bounce near the top of the profile.  Any
ideas why?

This is with 2.6.0-test3 on a system with 4GB of memory.  The first pair
of tables compares the deadline scheduler with our patch applied to the
profile in the right side.  The second pair of tables compare AS with
our patch applied to the profile on the right side.

You can see our patch here: 
	http://www.osdl.org/cgi-bin/getpatch?id=2052
or in color!
	http://www.osdl.org/cgi-bin/getpatch?id=2052.html



METRICS OVER LAST 20 MINUTES:
--------------- -------- ----- ---- -------- -----------------------------------
Kernel          Elevator NOTPM CPU% Blocks/s URL                                
--------------- -------- ----- ---- -------- -----------------------------------
2.6.0-test3     deadline  1313 94.5   9582.1 http://khack.osdl.org/stp/277489/  
2.6.0-test3     deadline  1304 94.1   9685.0 http://khack.osdl.org/stp/277494/  

FUNCTIONS SORTED BY LOAD:
-- ------------------------- ------- ------------------------- -------
 # deadline 2.6.0-test3      ticks   deadline 2.6.0-test3      ticks  
-- ------------------------- ------- ------------------------- -------
 1 default_idle              5470223 default_idle              5447766
 2 bounce_copy_vec             77961 bounce_copy_vec             85122
 3 schedule                    65916 schedule                    62840
 4 __blk_queue_bounce          30048 __blk_queue_bounce          24983
 5 do_softirq                  23265 scsi_request_fn             23950
 6 scsi_request_fn             22748 do_softirq                  23573
 7 __make_request              18727 __make_request              19055
 8 scsi_end_request            12207 scsi_end_request            12358
 9 sysenter_past_esp           10296 try_to_wake_up              10007
10 try_to_wake_up              10132 sysenter_past_esp            9959



METRICS OVER LAST 20 MINUTES:
--------------- -------- ----- ---- -------- -----------------------------------
Kernel          Elevator NOTPM CPU% Blocks/s URL                                
--------------- -------- ----- ---- -------- -----------------------------------
2.6.0-test3     as        1143 92.6   8848.5 http://khack.osdl.org/stp/277490/  
2.6.0-test3     as        1175 91.4   8883.1 http://khack.osdl.org/stp/277493/  

FUNCTIONS SORTED BY LOAD:
-- ------------------------- ------- ------------------------- -------
 # as 2.6.0-test3            ticks   as 2.6.0-test3            ticks  
-- ------------------------- ------- ------------------------- -------
 1 default_idle              6089608 default_idle              6307410
 2 bounce_copy_vec             69264 schedule                    44346
 3 schedule                    63544 scsi_request_fn             25109
 4 scsi_request_fn             25617 __make_request              23740
 5 __make_request              23137 do_softirq                  20522
 6 __blk_queue_bounce          20156 scsi_end_request            15665
 7 do_softirq                  20012 try_to_wake_up               7979
 8 scsi_end_request            15821 dio_bio_end_io               7867
 9 sysenter_past_esp           10313 do_anonymous_page            7440
10 try_to_wake_up               9227 ipc_lock                     6387


-- 
Mark Wong - - markw@osdl.org
Open Source Development Lab Inc - A non-profit corporation
12725 SW Millikan Way - Suite 400 - Beaverton, OR 97005
(503) 626-2455 x 32 (office)
(503) 626-2436      (fax)
http://www.osdl.org/archive/markw/
