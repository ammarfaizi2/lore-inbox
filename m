Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750948AbVJQRB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbVJQRB7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 13:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750947AbVJQRB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 13:01:59 -0400
Received: from petasus.ims.intel.com ([62.118.80.130]:56961 "EHLO
	petasus.ims.intel.com") by vger.kernel.org with ESMTP
	id S1750781AbVJQRB6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 13:01:58 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: Re:[PATCH 1/1] indirect function calls elimination in IO scheduler
Date: Mon, 17 Oct 2005 21:01:54 +0400
Message-ID: <6694B22B6436BC43B429958787E454988F5B44@mssmsx402nb>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re:[PATCH 1/1] indirect function calls elimination in IO scheduler
thread-index: AcXTPHnhTQh9NWC3RUO5gbdQ5nTqZg==
From: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
To: "Jens Axboe" <axboe@suse.de>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 17 Oct 2005 17:01:55.0399 (UTC) FILETIME=[7A57A570:01C5D33C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe writes

> I don't really see the patch doing what you describe - the indirect
> function calls are the same.

For example on Pentium4 in the function elv_next_request() the line
            struct request *rq =
q->elevator->ops->elevator_next_req_fn(q);
before patch had required 11% of function running time as oprofile
reports
           %
    26  0.0457 :c0270ecb:       mov    0xc(%edi),%eax
  3455  6.0670 :c0270ece:       mov    (%eax),%eax
  2848  5.0011 :c0270ed0:       mov    %edi,(%esp)
  1538  2.7008 :c0270ed3:       call   *0xc(%eax)

	A patch which would delete all indirect calls was tryed
        struct request *rq = q->elevator_cp.ops.elevator_next_req_fn(q);
     9  0.0224 :c0270eea:       mov    %edi,(%esp)
  3814  9.4793 :c0270eed:       call   *0x18(%edi)

But additional memory would be needed for 'ops' in each queue. The
intermediate (proposed) patch has the same timing effect but saves some
memory:
	struct request *rq =
q->elevator_cp.ops->elevator_next_req_fn(q);
drivers/block/elevator.c:351
ffffffff802a8b97:       49 8b 44 24 18          mov    0x18(%r12),%rax
ffffffff802a8b9c:       4c 89 e7                mov    %r12,%rdi
ffffffff802a8b9f:       ff 50 18                callq  *0x18(%rax)

For Itanium the difference is huge:
	Before patch:
drivers/block/elevator.c:351
a0000001002cbb60:       0d f0 00 4c 18 10       [MFI]   ld8 r30=[r38]
a0000001002cbb66:       00 00 00 02 00 c0               nop.f 0x0
a0000001002cbb6c:       05 00 01 84                     mov r46=r32;;
a0000001002cbb70:       0b e8 00 3c 18 10       [MMI]   ld8 r29=[r30];;
a0000001002cbb76:       c0 c1 74 00 42 00               adds r28=24,r29
a0000001002cbb7c:       00 00 04 00                     nop.i 0x0;;
a0000001002cbb80:       0b d0 00 38 18 10       [MMI]   ld8 r26=[r28];;
a0000001002cbb86:       b0 41 68 30 28 00               ld8 r27=[r26],8
a0000001002cbb8c:       00 00 04 00                     nop.i 0x0;;
a0000001002cbb90:       11 08 00 34 18 10       [MIB]   ld8 r1=[r26]
a0000001002cbb96:       70 d8 04 80 03 00               mov b7=r27
a0000001002cbb9c:       78 00 80 10
br.call.sptk.many

	After patching there is no object code for considered line. It
is scattered mixed with other source code lines.

Leonid
