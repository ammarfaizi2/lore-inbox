Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262409AbTFKAEN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 20:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbTFKAEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 20:04:12 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:58588
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262451AbTFKAC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 20:02:56 -0400
Date: Wed, 11 Jun 2003 02:16:19 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Chris Mason <mason@suse.com>
Cc: Nick Piggin <piggin@cyberone.com.au>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Georg Nikodym <georgn@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>
Subject: Re: [PATCH] io stalls (was: -rc7   Re: Linux 2.4.21-rc6)
Message-ID: <20030611001619.GL26270@dualathlon.random>
References: <Pine.LNX.4.55L.0305282019160.321@freak.distro.conectiva> <200306041235.07832.m.c.p@wolk-project.de> <20030604104215.GN4853@suse.de> <200306041246.21636.m.c.p@wolk-project.de> <20030604104825.GR3412@x30.school.suse.de> <3EDDDEBB.4080209@cyberone.com.au> <1055194762.23130.370.camel@tiny.suse.com> <20030609221950.GF26270@dualathlon.random> <1055286825.24111.155.camel@tiny.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1055286825.24111.155.camel@tiny.suse.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 10, 2003 at 07:13:45PM -0400, Chris Mason wrote:
> On Mon, 2003-06-09 at 18:19, Andrea Arcangeli wrote:
> The avg throughput per process with vanilla rc7 is 3MB/s, the best I've
> been able to do was with nr_requests at higher levels was 1.3MB/s.  With
> smaller of iozone threads (10 and lower so far) I can match rc7 speeds,
> but not with 20 procs.

at least with my patches, I also made this change:

-#define ELV_LINUS_SEEK_COST    16
+#define ELV_LINUS_SEEK_COST    1

 #define ELEVATOR_NOOP                                                  \
 ((elevator_t) {                                                                \
@@ -93,8 +93,8 @@ static inline int elevator_request_laten

 #define ELEVATOR_LINUS                                                 \
 ((elevator_t) {                                                                \
-       2048,                           /* read passovers */            \
-       8192,                           /* write passovers */           \
+       128,                            /* read passovers */            \
+       512,                            /* write passovers */           \
                                                                        \

you didn't change the I/O scheduler at all compared to mainline, so
there can be quite a lot of difference in the bandwidth average per
process between my patches and mainline and your patches (unless you run
elvtune or unless you backed out the above).

Anyways the 130671 < 100, 0 < 200, 0 < 300, 0 < 400, 0 < 500 from your
patch sounds perfectly fair and that's unrelated to I/O scheduler and
size of runqueue. I believe the most interesting difference is the
blocking of tasks until the waitqueue is empty (i.e. clearing the
waitqueue-full bit only when nobody is waiting). That is the right thing
to do of course, that was a bug in my patch I merged by mistake from
Nick's original patch, and that I'm going to fix immediatly of course.

Andrea
