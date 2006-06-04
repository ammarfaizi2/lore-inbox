Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932222AbWFDJKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbWFDJKR (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 05:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbWFDJKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 05:10:16 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:40812 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932218AbWFDJKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 05:10:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ChqOdz0Cd1DEj1gbrE6h0rzOmbb9mk8MNuRiECyeaCLeSeiQKdXQ4JzrJQ/ASSlFJakUPjcLIYutMbBCEADhbWG/w+siTBX9/dgRYT1oVeVKtDOHd9Bm5TvGdSbIfOanPxdOoZ39U0vvpTLHI1q9H+d+z6z78pq7EHQU8AHW7qs=
Message-ID: <4482A364.1050006@gmail.com>
Date: Sun, 04 Jun 2006 18:09:56 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>, Tejun Heo <htejun@gmail.com>,
        Jens Axboe <axboe@suse.de>,
        James Bottomley <James.Bottomley@SteelEye.com>,
        Dave Miller <davem@redhat.com>, bzolnier@gmail.com,
        james.steward@dynamicratings.com, jgarzik@pobox.com,
        mattjreimer@gmail.com, Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        rmk@arm.linux.org.uk, lkml <linux-kernel@vger.kernel.org>,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 2/5] ide: add cpu cache flushes after kmapping and modifying
 a page
References: <1149392479501-git-send-email-htejun@gmail.com> <1149392480987-git-send-email-htejun@gmail.com> <20060604081734.GA29696@infradead.org>
In-Reply-To: <20060604081734.GA29696@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Sun, Jun 04, 2006 at 12:41:20PM +0900, Tejun Heo wrote:
>>  			data = bvec_kmap_irq(bvec, &flags);
>>  			drive->hwif->atapi_input_bytes(drive, data, count);
>> +			flush_kernel_dcache_page(kmap_atomic_to_page(data));
>>  			bvec_kunmap_irq(data, &flags);
> 
> shouldn't bvec_kunmap_irq do the flush_kernel_dcache_page call?
> 

Eventually, yes.  At the moment, not all archs implement 
flush_kernel_dcache_page(), so converting

	kmap();
	modify buffer;
	flush_dcache_page();
	kunmap();

to

	kmap_wrapper();
	modify buffer;
	kunmap_wrapper_which_calls_flush_kernel_dcache_page()

breaks cache coherency on those archs.  The current patches simply add 
calls to flush_kernel_dcache_page() where missing such that it doesn't 
break anything while fixing cache coherency for arm and parisc.  In the 
long term...

1. implement flush_kernel_dcache_page() for all needed archs
2. update kmap interface such that the caller is mandated to specify 
whether the buffer has been modified or not when unmapping (maybe 
addition of simple boolean argument?)
3. update bvec_kmap_*() similarly
4. update all calls to kunmap & friends.

Thanks.

-- 
tejun
