Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262629AbSI0Txd>; Fri, 27 Sep 2002 15:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262626AbSI0Txa>; Fri, 27 Sep 2002 15:53:30 -0400
Received: from packet.digeo.com ([12.110.80.53]:14471 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262623AbSI0Twl>;
	Fri, 27 Sep 2002 15:52:41 -0400
Message-ID: <3D94B848.E2F6412E@digeo.com>
Date: Fri, 27 Sep 2002 12:58:00 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Justin T. Gibbs" <gibbs@scsiguy.com>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Jens Axboe <axboe@suse.de>, Matthew Jacob <mjacob@feral.com>,
       "Pedro M. Rodrigues" <pmanuel@myrealbox.com>,
       Mathieu Chouquet-Stringer <mathieu@newview.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Warning - running *really* short on DMA buffers while 
 doingfiletransfers
References: <3D94AC8B.4AB6EB09@digeo.com> <2561606224.1033154176@aslan.btc.adaptec.com> <3D94B33F.EB3B9D41@digeo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Sep 2002 19:57:53.0892 (UTC) FILETIME=[2AB0D240:01C26660]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> ...
> One sample trace is at
> http://www.zip.com.au/~akpm/linux/patches/trace.txt
> 

Another thing to note from that trace is that many writes
went through the entire submit_bio/elv_next_request/bio_endio
cycle between the submission and completion of the read.

So there was:

	submit_bio(the read)
	elv_next_request(the read)
	...
	submit_bio(a write)
	elv_next_request(that write)
	bio_endio(that write)
	...
	bio_endio(the read)

For many writes.  I'm fairly (but not 100%) sure that the same
behaviour was seen with four tags.
