Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262843AbTIES2O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 14:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262857AbTIES2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 14:28:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:17379 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262843AbTIES2K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 14:28:10 -0400
Message-Id: <200309051828.h85IRxo16644@mail.osdl.org>
Date: Fri, 5 Sep 2003 11:27:56 -0700 (PDT)
From: markw@osdl.org
Subject: OSDL DBT-2 AS vs. Deadline 2.6.0-test4-mm3
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With recent firmware upgrades to our controller cards in our STP system,
I was finally able to make use of Mark Haverkamp's aacraid patch to
avoid bounce buffers.  I've broken out the data by host, since we see
varying results between our system:

AS Scheduler:
host      avg. notpm  stddev  samples
--------  ----------  ------  -------
stp4-000     1273.13   66.91        6  
stp4-001     1210.33   27.81        6
stp4-002     1217.33   10.03        6
stp4-003     1338.67   12.88        5

Deadline Scheduler:
host      avg. notpm  stddev  samples
--------  ----------  ------  -------
stp4-000     1268.50   61.81        3
stp4-001     1232.67   11.15        3
stp4-002     1214.00       -        1
stp4-003     1348.00   30.04        3


Here's a profile comparison:

METRICS OVER LAST 20 MINUTES:
--------------- -------- ----- ---- -------- -----------------------------------
Kernel          Elevator NOTPM CPU% Blocks/s URL                                
--------------- -------- ----- ---- -------- -----------------------------------
2.6.0-test4-mm3 as        1315 90.8   9983.1 http://khack.osdl.org/stp/278809/  
2.6.0-test4-mm3 deadline  1314 90.3  10036.0 http://khack.osdl.org/stp/278903/  

FUNCTIONS SORTED BY LOAD:
-- ------------------------- ------- ------------------------- -------
 # as 2.6.0-test4-mm3        ticks   deadline 2.6.0-test4-mm3  ticks  
-- ------------------------- ------- ------------------------- -------
 1 default_idle              5746007 default_idle              5764451
 2 schedule                    53609 schedule                    52174
 3 scsi_request_fn             29340 do_softirq                  25905
 4 __make_request              25949 scsi_request_fn             23549
 5 do_softirq                  25560 __make_request              20325
 6 scsi_end_request            16524 try_to_wake_up              11723
 7 try_to_wake_up              11939 scsi_end_request            11340
 8 dio_bio_end_io              11253 dio_bio_end_io              10950
 9 do_anonymous_page            8234 do_anonymous_page            8110
10 ipc_lock                     7366 ipc_lock                     6706
11 sys_semtimedop               5493 sys_semtimedop               5152
12 sysenter_past_esp            5080 sysenter_past_esp            5064
13 direct_io_worker             5065 direct_io_worker             4732
14 dio_await_one                4084 dio_await_one                3779
15 __copy_to_user_ll            3643 __mod_timer                  3571
16 __mod_timer                  3582 blk_run_queue                3521
17 blk_run_queue                3411 __copy_to_user_ll            3495
18 __might_sleep                3316 __might_sleep                3277
19 kmem_cache_alloc             3225 kmem_cache_alloc             3054
20 semctl_main                  3072 semctl_main                  3016

-- 
Mark Wong - - markw@osdl.org
Open Source Development Lab Inc - A non-profit corporation
12725 SW Millikan Way - Suite 400 - Beaverton, OR 97005
(503) 626-2455 x 32 (office)
(503) 626-2436      (fax)
