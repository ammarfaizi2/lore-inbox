Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273345AbTHKU3u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 16:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273403AbTHKU3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 16:29:50 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:27273 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S273345AbTHKU3s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 16:29:48 -0400
Date: Mon, 11 Aug 2003 22:27:55 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, axboe@suse.de
Subject: Re: test3 oops on Compaq 8500R
Message-ID: <20030811222755.C1246@electric-eye.fr.zoreil.com>
References: <Pine.LNX.4.44.0308111552350.1734-100000@logos.cnet> <Pine.LNX.4.53.0308111509160.26153@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.53.0308111509160.26153@montezuma.mastecende.com>; from zwane@linuxpower.ca on Mon, Aug 11, 2003 at 03:13:11PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@linuxpower.ca> :
[...]
> NULL disk->queue->queuedata, what does the following (possibly 
> fundamentally flawed) patch do?

Hmmm...

DAC960_Probe()
-> DAC960_DetectController()
   ->   for (i = 0; i < DAC960_MaxLogicalDrives; i++) {
        	Controller->disks[i] = alloc_disk(1<<DAC960_MaxPartitionsBits);
	        if (!Controller->disks[i])
        	        goto Failure;
	        Controller->disks[i]->private_data = (void *)i;
	        Controller->disks[i]->queue = Controller->RequestQueue;
	}
-> DAC960_InitializeController()
   -> DAC960_RegisterBlockDevice()
      -> RequestQueue = blk_init_queue(DAC960_RequestFunction,...);
  	 if (!RequestQueue) {
                 unregister_blkdev(MajorNumber, "dac960");
                 return false;
         }
         Controller->RequestQueue = RequestQueue;

Controller->disks[i]->queue = ... should be done once Controller->RequestQueue
is set imho.

--
Ueimor
