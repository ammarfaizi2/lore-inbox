Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030305AbWALMFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030305AbWALMFG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 07:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030315AbWALMFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 07:05:06 -0500
Received: from tornado.reub.net ([202.89.145.182]:17046 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1030305AbWALMFF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 07:05:05 -0500
Message-ID: <43C645ED.40905@reub.net>
Date: Fri, 13 Jan 2006 01:05:01 +1300
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.6a1 (Windows/20060111)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>, neilb@suse.de,
       mingo@elte.hu, linux-kernel@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.6.15-mm2
References: <20060111115616.GE3389@suse.de> <43C518BC.5090903@reub.net> <20060111145201.GS3389@suse.de> <20060111145504.GT3389@suse.de> <43C55B31.5000201@reub.net> <20060111194517.GE5373@suse.de> <20060111195349.GF5373@suse.de> <43C5D1CA.7000400@reub.net> <20060112080051.GA22783@htj.dyndns.org> <43C61598.7050004@reub.net> <20060112111846.GA19976@htj.dyndns.org>
In-Reply-To: <20060112111846.GA19976@htj.dyndns.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/01/2006 12:18 a.m., Tejun Heo wrote:
> On Thu, Jan 12, 2006 at 09:38:48PM +1300, Reuben Farrelly wrote:
> [--snip--]
>> [start_ordered       ] f7e8a708 -> c1b028fc,c1b029a4,c1b02a4c infl=1
>> [start_ordered       ] f74b0e00 0 48869571 8 8 1 1 c1ba9000
>> [start_ordered       ] BIO f74b0e00 48869571 4096
>> [start_ordered       ] ordered=31 in_flight=1
>> [blk_do_ordered      ] start_ordered f7e8a708->00000000
>> [blk_do_ordered      ] seq=02 f74ccd98->f74ccd98
>> [blk_do_ordered      ] seq=02 f74ccd98->f74ccd98
>> [blk_do_ordered      ] seq=02 c1b028fc->00000000
>> [blk_do_ordered      ] seq=02 c1b028fc->00000000
>> [blk_do_ordered      ] seq=02 c1b028fc->00000000
> 
> Yeap, this one is the offending one.  0xf74ccd98 got requeued in front
> of pre-flush while draining and when it finished it didn't complete
> draining thus hanging the queue.  It seems like it's some kind of
> special request which probably fails and got retried.  Are you using
> SMART or something which issues special commands to drives?

No SMART, although I should be (rebuilt the system a few months ago..and must
have missed it).

Are there any other things which could be contributing to this?  <scratches head>

> Can you please try the following debug patch.  I've added a few more
> debug messages to make things clearer.
> 
> diff --git a/block/elevator.c b/block/elevator.c
> index 1b5b5d9..a0075aa 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -37,6 +37,9 @@
>  
>  #include <asm/uaccess.h>
>  
> +#define pd(fmt, args...) printk("[%02d %-24s] "fmt, q->id, __FUNCTION__ , ##args)
> +#define pd0(fmt, args...) printk("[na %-24s] "fmt, __FUNCTION__ , ##args)
> +
>  static DEFINE_SPINLOCK(elv_list_lock);
>  static LIST_HEAD(elv_list);

I'm applying to -mm3 - applies with some fuzz.

Here's the last few lines:

[01 elv_completed_request   ] seq=03 unacc c1b351c4 (flags=0x2002318) infl=0
[01 blk_ordered_complete_seq] ordseq=03 seq=04 orderr=0 error=0
[01 blk_do_ordered          ] seq=08 c1b3526c->c1b3526c (flags=0xd9)
[01 elv_next_request        ] c1b3526c (bar)
[01 blk_do_ordered          ] seq=08 c1b35314->00000000 (flags=0x0)
[01 ordered_bio_endio       ] q->orderr=0 error=0
[na flush_dry_bio_endio     ] BIO f7eb95c0 48869571 4096
[na end_that_request_last   ] !ELVPRIV c1b3526c 000003d9
[01 elv_completed_request   ] seq=07 rq=c1b3526c (flags=0x3d9) infl=0
[01 blk_ordered_complete_seq] ordseq=07 seq=08 orderr=0 error=0
[01 blk_do_ordered          ] seq=10 c1b35314->c1b35314 (flags=0x2002018)
[01 elv_next_request        ] c1b35314 (post)
[na end_that_request_last   ] !ELVPRIV c1b35314 02002318
[01 elv_completed_request   ] seq=0f unacc c1b35314 (flags=0x2002318) infl=0
[01 blk_ordered_complete_seq] ordseq=0f seq=10 orderr=0 error=0
[01 blk_ordered_complete_seq] sequence complete
[02 blk_do_ordered          ] seq=02 c1b35904->00000000 (flags=0x0)
[01 start_ordered           ] f7dd93c0 -> c1b351c4,c1b3526c,c1b35314 ordcolor=1 
infl=0
[01 start_ordered           ] f7e93d80 0 69641528 8 8 1 1 c1ba7000
[01 start_ordered           ] BIO f7e93d80 69641528 4096
[01 start_ordered           ] ordered=31 in_flight=0
[01 blk_do_ordered          ] start_ordered f7dd93c0->c1b351c4
[01 elv_next_request        ] c1b351c4 (pre)
[01 blk_do_ordered          ] seq=04 c1b3526c->00000000 (flags=0x0)
[na end_that_request_last   ] !ELVPRIV c1b351c4 02002318
[01 elv_completed_request   ] seq=03 unacc c1b351c4 (flags=0x2002318) infl=0
[01 blk_ordered_complete_seq] ordseq=03 seq=04 orderr=0 error=0
[01 blk_do_ordered          ] seq=08 c1b3526c->c1b3526c (flags=0xd9)
[01 elv_next_request        ] c1b3526c (bar)
[01 blk_do_ordered          ] seq=08 c1b35314->00000000 (flags=0x0)
[01 ordered_bio_endio       ] q->orderr=0 error=0
[na flush_dry_bio_endio     ] BIO f7e93d80 69641528 4096
[na end_that_request_last   ] !ELVPRIV c1b3526c 000003d9
[01 elv_completed_request   ] seq=07 rq=c1b3526c (flags=0x3d9) infl=0
[01 blk_ordered_complete_seq] ordseq=07 seq=08 orderr=0 error=0
[01 blk_do_ordered          ] seq=10 c1b35314->c1b35314 (flags=0x2002018)
[01 elv_next_request        ] c1b35314 (post)
[na end_that_request_last   ] !ELVPRIV c1b35314 02002318
[01 elv_completed_request   ] seq=0f unacc c1b35314 (flags=0x2002318) infl=0
[01 blk_ordered_complete_seq] ordseq=0f seq=10 orderr=0 error=0
[01 blk_ordered_complete_seq] sequence complete
[02 blk_do_ordered          ] seq=02 c1b35904->00000000 (flags=0x0)
[01 start_ordered           ] f7dd93c0 -> c1b351c4,c1b3526c,c1b35314 ordcolor=1 
infl=0
[01 start_ordered           ] f7e938c0 0 69641536 8 8 1 1 f7dae000
[01 start_ordered           ] BIO f7e938c0 69641536 4096
[01 start_ordered           ] ordered=31 in_flight=0
[01 blk_do_ordered          ] start_ordered f7dd93c0->c1b351c4
[01 elv_next_request        ] c1b351c4 (pre)
[01 blk_do_ordered          ] seq=04 c1b3526c->00000000 (flags=0x0)
[na end_that_request_last   ] !ELVPRIV c1b351c4 02002318
[01 elv_completed_request   ] seq=03 unacc c1b351c4 (flags=0x2002318) infl=0
[01 blk_ordered_complete_seq] ordseq=03 seq=04 orderr=0 error=0
[01 blk_do_ordered          ] seq=08 c1b3526c->c1b3526c (flags=0xd9)
[01 elv_next_request        ] c1b3526c (bar)
[01 blk_do_ordered          ] seq=08 c1b35314->00000000 (flags=0x0)
[01 ordered_bio_endio       ] q->orderr=0 error=0
[na flush_dry_bio_endio     ] BIO f7e938c0 69641536 4096
[na end_that_request_last   ] !ELVPRIV c1b3526c 000003d9
[01 elv_completed_request   ] seq=07 rq=c1b3526c (flags=0x3d9) infl=0
[01 blk_ordered_complete_seq] ordseq=07 seq=08 orderr=0 error=0
[01 blk_do_ordered          ] seq=10 c1b35314->c1b35314 (flags=0x2002018)
[01 elv_next_request        ] c1b35314 (post)
[na end_that_request_last   ] !ELVPRIV c1b35314 02002318
[01 elv_completed_request   ] seq=0f unacc c1b35314 (flags=0x2002318) infl=0
[01 blk_ordered_complete_seq] ordseq=0f seq=10 orderr=0 error=0
[01 blk_ordered_complete_seq] sequence complete

The full 300k file is up on http://www.reub.net/files/kernel/  It's too big to 
be sending to everyone..

reuben




