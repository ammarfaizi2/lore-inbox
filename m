Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030415AbWALOUf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030415AbWALOUf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 09:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030414AbWALOUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 09:20:35 -0500
Received: from zproxy.gmail.com ([64.233.162.193]:18621 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030416AbWALOUe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 09:20:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=EA7FHLr0cQiP++GGA3+mzBB91/dezkTxKve7Hl2+zZ5eseOemH4cuuwReFGRLlBbLfFngwiqdj4SEhT+a4/hmLTNYJS8s57ANMYcSZVkjGXsQHU3/Qj0+LkHTH/AIuWWKnD8H8isZmvvHKrvyGRJGhazvi+a/bM2WCfJ/H7DB8U=
Message-ID: <43C665A9.60301@gmail.com>
Date: Thu, 12 Jan 2006 23:20:25 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Reuben Farrelly <reuben-lkml@reub.net>, Ric Wheeler <ric@emc.com>,
       Andrew Morton <akpm@osdl.org>, neilb@suse.de, mingo@elte.hu,
       linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.6.15-mm2
References: <20060111194517.GE5373@suse.de> <20060111195349.GF5373@suse.de> <43C5D1CA.7000400@reub.net> <20060112080051.GA22783@htj.dyndns.org> <43C61598.7050004@reub.net> <20060112111846.GA19976@htj.dyndns.org> <43C645ED.40905@reub.net> <43C64C3B.5070704@emc.com> <43C64DF6.7060604@reub.net> <20060112135533.GA29675@htj.dyndns.org> <20060112141015.GL3945@suse.de>
In-Reply-To: <20060112141015.GL3945@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Thu, Jan 12 2006, Tejun Heo wrote:
> 
>>4. a REQ_SPECIAL | REQ_BLOCK_PC | REQ_QUIET request gets queued at
>>   the head of the queue.  (I have no idea where this comes from.  sd
>>   driver doesn't even handle PC requests.  It will be just failed.
>>   Some kind of hardware management stuff trying to probe MMC
>>   devices?)
> 
> 
> But it does, sd understands these just fine (see references to
> blk_pc_request()).
> 
> It could be coming from someone doing a blkdev_issue_flush, that will
> even cause sd to queue such a request internally. So it isn't
> necessarily from user space (it would have to be through SG_IO at that
> point), and Reubens boot log doesn't have any evidence of anything of
> that nature being started. So I'm guessing it's the flush, raid1
> propagates these flushes to the bottom devices when it sees one.
> 
> Your analysis looks correct though, Reuben looking forward to hearing
> whether this fixes your boot hang!
> 

Ah... you're right.  I was only staring at the !blk_fs_request() test in 
sd_init_command().  It has early exit for blk_pc_request() of course. 
It needs to handle SG_IO's & flushes.  :-p

-- 
tejun
