Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264931AbTK3QmN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 11:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264936AbTK3QmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 11:42:13 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18097 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264931AbTK3QmL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 11:42:11 -0500
Message-ID: <3FCA1DD3.70004@pobox.com>
Date: Sun, 30 Nov 2003 11:41:55 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Prakash K. Cheemplavam" <prakashkc@gmx.de>, marcush@onlinehome.de,
       linux-kernel@vger.kernel.org, eric_mudama@Maxtor.com
Subject: Re: Silicon Image 3112A SATA trouble
References: <3FC36057.40108@gmx.de> <200311301547.32347.bzolnier@elka.pw.edu.pl> <3FCA1220.2040508@gmx.de> <200311301721.41812.bzolnier@elka.pw.edu.pl> <20031130162523.GV10679@suse.de>
In-Reply-To: <20031130162523.GV10679@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Sun, Nov 30 2003, Bartlomiej Zolnierkiewicz wrote:
>>Hmm. actually I was under influence that we have generic ioctls in 2.6.x,
>>but I can find only BLKSECTGET, BLKSECTSET was somehow lost.  Jens?
> 
> 
> Probably because it's very dangerous to expose, echo something too big
> and watch your data disappear.


IMO, agreed.

Max KB per request really should be set by the driver, as it's a 
hardware-specific thing that (as we see :)) is often errata-dependent.

Tangent:  My non-pessimistic fix will involve submitting a single sector 
DMA r/w taskfile manually, then proceeding with the remaining sectors in 
another r/w taskfile.  This doubles the interrupts on the affected 
chipset/drive combos, but still allows large requests.  I'm not terribly 
fond of partial completions, as I feel they add complexity, particularly 
so in my case:  I can simply use the same error paths for both the 
single-sector taskfile and the "everything else" taskfile, regardless of 
which taskfile throws the error.

(thinking out loud)  Though best for simplicity, I am curious if a 
succession of "tiny/huge" transaction pairs are efficient?  I am hoping 
that the drive's cache, coupled with the fact that each pair of 
taskfiles is sequentially contiguous, will not hurt speed too much over 
a non-errata configuration...

	Jeff



