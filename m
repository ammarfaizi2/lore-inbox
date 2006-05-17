Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbWEQFO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbWEQFO2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 01:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbWEQFO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 01:14:28 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:7850 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932108AbWEQFO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 01:14:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=gBjqQFzMNG4fB3RIPUzuy7QKoqcsdaRUTHCppLL/mrhbxX0SUC3lPzqZUgYcGlVbHpjAdobEp6ik07OhaY4QrZ1JbHxsprH/lZYET/WND4KbUabFepDS4l/gHk8DbzVCTxjkfVwNWuE8ci6Z7PXavKLAIo7Le5pCFiYZd8ywmH4=
Message-ID: <446AB12C.10001@gmail.com>
Date: Wed, 17 May 2006 14:14:20 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: jeff@garzik.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [RFT] major libata update
References: <20060515170006.GA29555@havoc.gtf.org>	<20060516190507.35c1260f.akpm@osdl.org>	<446AAB3C.6050303@gmail.com> <20060516215610.2b822c00.akpm@osdl.org>
In-Reply-To: <20060516215610.2b822c00.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Tejun Heo <htejun@gmail.com> wrote:
>> Hello, Andrew.
>>
>> Andrew Morton wrote:
>> [--snip--]
>>> [   44.719422] ata2.00: cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:101f
>>> [   44.719425] ata2.00: ATAPI, max UDMA/66
>>> [   44.765263] ata2.00: applying bridge limits
>>> [   74.928836] ata2.01: qc timeout (cmd 0xa1)
>>> [   74.977811] ata2.01: failed to IDENTIFY (I/O error, err_mask=0x4)
>>> [   75.468853] ata2.00: cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:101f
>>> [   75.468856] ata2.00: ATAPI, max UDMA/66
>>> [   75.514678] ata2.00: applying bridge limits
>>> [  105.674130] ata2.01: qc timeout (cmd 0xa1)
>> Did this device work with previous versions of kernel?
> 
> No.  In fact, it doesn't even work with the 2.6.17-rc4-mm1 lineup plus the
> latest git-libata-all.  It needs this tweak:
> 
> --- devel/drivers/scsi/ata_piix.c~2.6.17-rc4-mm1-ich8-fix	2006-05-16 18:36:12.000000000 -0700
> +++ devel-akpm/drivers/scsi/ata_piix.c	2006-05-16 18:36:12.000000000 -0700
> @@ -542,6 +542,14 @@ static unsigned int piix_sata_probe (str
>  		port = map[base + i];
>  		if (port < 0)
>  			continue;
> +		if (ap->flags & PIIX_FLAG_AHCI) {
> +			/* FIXME: Port status of AHCI controllers
> +			 * should be accessed in AHCI memory space.  */
> +			if (pcs & 1 << port)
> +				present_mask |= 1 << i;
> +			else
> +				pcs &= ~(1 << port);
> +		}
>  		if (ap->flags & PIIX_FLAG_IGNORE_PCS || pcs & 1 << (4 + port))
>  			present_mask |= 1 << i;
>  		else
> _

Ah.. I see.  This is the ata_piix ghosting problem where signature of 
the first device is duplicated in the second device causing libata to 
probe the second non-existent device.

>> libata used to give up on the first failure during probe, so the boot 
>> time would have been shorter in failure cases.
> 
> I don't recall anyone complaining?

One of sata_via + ATAPI probing problem might have been fixed by this. 
It still needs to be investigated further though.

>>  I think controlled 
>> retries during boot probe is a good thing, but the timeout of 30s for 
>> IDENTIFY commands can be shortened, I guess.
> 
> We should do something, please.  It'll hurt kernel developers the most.

I think the correct solution would be fixing the ghosting problem of the 
controller.  I'll look into it.

-- 
tejun
