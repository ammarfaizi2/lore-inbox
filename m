Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751229AbWDKEsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbWDKEsq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 00:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWDKEsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 00:48:46 -0400
Received: from web33008.mail.mud.yahoo.com ([68.142.206.72]:6819 "HELO
	web33008.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751229AbWDKEsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 00:48:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=uYD5u/q+rKFYkm3MKU0k0NEZJtD30QyV61tTXZTvuKFv2RciZF4KnS1e2FIkF3CCg3CQei/u7M9IXglARphbZWPcrzAZGgfM7DJn536jyW5ySsmTexAyVkzeqIeql1qKJg1mwnSAnaRUaH5iOBV6iWo2MQJFXMzhj3lAJB4BlWE=  ;
Message-ID: <20060411044845.87232.qmail@web33008.mail.mud.yahoo.com>
Date: Mon, 10 Apr 2006 21:48:45 -0700 (PDT)
From: Stephen Cameron <smcameron@yahoo.com>
Subject: Re: cciss: bug fix for crash when running hpacucli
To: linux-kernel@vger.kernel.org, mike.miller@hp.com, akpm@osdl.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> "Mike Miller (OS Dev)" <m...@beardog.cca.cpqcorp.net> wrote:
>
>> This patch fixes a crash when running hpacucli with multiple logical volumes
>>  on a cciss controller. We were not properly initializing the disk->queue
>>  and causing a fault.
>
>Please confirm that this is safe&appropriate for backporting into 2.6.16.x? 

I think it should be ok, so long as those kernels contain 
Jens's softirq changes, and I think they do, iirc.

The problem was an ioctl that the hpacucli program uses to
tell the driver to re-query the controller about what logical drives are
configured (after it say, adds or deletes logical drives) didn't bother to set up
the queue in this ioctl with the softirq function as it does in 
cciss_init_one (the latter being called at init time).  

The business end of the patch is this hunk, 
which mimics code in cciss.c:cciss_init_one():

 @@ -1249,6 +1296,8 @@ static void cciss_update_drive_info(int

                blk_queue_max_sectors(disk->queue, 512);

+               blk_queue_softirq_done(disk->queue, cciss_softirq_done);
+
                disk->queue->queuedata = hba[ctlr];

                blk_queue_hardsect_size(disk->queue, 

The rest of it is just moving functions around to satisfy the compiler
about function prototypes.

Well, maybe that doesn't answer your question if you were wanting
stronger verification, such as actual testing with those kernels.
If the function cciss_init_one contains a call to blk_queue_softirq_done, 
but cciss_update_drive_info does not contain such a call, then
it's a safe bet this patch or something very like it is needed.  
cciss_update_drive_info needs to do the same thing per new drive as
cciss_init_one does.

-- steve


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
