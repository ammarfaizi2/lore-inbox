Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751011AbWIMTiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbWIMTiZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 15:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbWIMTiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 15:38:25 -0400
Received: from sabe.cs.wisc.edu ([128.105.6.20]:21440 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S1750985AbWIMTiY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 15:38:24 -0400
Message-ID: <45085E20.7070003@cs.wisc.edu>
Date: Wed, 13 Sep 2006 14:38:08 -0500
From: Mike Christie <michaelc@cs.wisc.edu>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Jens Axboe <axboe@kernel.dk>
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/2] block: Modify blk_rq_map_user to support large requests
References: <1157835221.4543.10.camel@max> <20060913093009.GF23515@kernel.dk>
In-Reply-To: <20060913093009.GF23515@kernel.dk>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Sat, Sep 09 2006, Mike Christie wrote:
>> Currently, there is some duplication between bsg, scsi_ioctl.c
>> and scsi_lib.c/sg/st in its mapping code. This patch modifies
>> the block layer blk_rq_map_user code to support large requests so
>> that the scsi and block drivers can use this common code. The
>> changes also make it so the callers do not have to account for
>> the bio to be unmapped and bounce buffers.
>>
>> The next patch then coverts bsg.c, scsi_ioctl.c and cdrom.c
>> to use the updated functions. For scsi_ioctl.c and cdrom.c
>> the only thing that changes is that they no longer have
>> to do the bounce buffer management and pass in the len for
>> the unmapping. The bsg change is a little larger since that
>> code was duplicating a lot of code that is now common
>> in the block layer. The bsg conversions als should fix
>> a memory leak caused when unmapping a hdr with iovec_count=0.
>>
>> Patch was made over Jens's block tree and the bsg branch
> 
> Generally it looks good - two comments:
> 
> - I see some advantages to having biohead_orig to avoid keeping track of
>   it and passing it around, but there's also good reasons for _not_
>   adding more stuff to struct request. Any particular reason you chose
>   to do that?

I think I originally made a mistake with the bounce buffers and thinking
that others may do the same I felt that hiding a lot of the magic that
is going on in blk_rq_map_user was nice. By adding the field to the
request, the caller would only have to map the data and then unmap the
request. Since not even a handful of drivers would ever use the api, I
agree that adding the field for this limited use could be overkill.

> 
> - blk_get_bounced_bio() looks redundant. BIO_BOUNCED should only be set
>   on a bounced bio, and ->bi_private should always hold that bounced
>   bio.
>

Ok, I will remove that.

