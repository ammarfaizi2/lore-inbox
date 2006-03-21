Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030284AbWCULTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030284AbWCULTz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 06:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030295AbWCULTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 06:19:54 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:52867 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030284AbWCULTx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 06:19:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=r2nRjqkusKFA60D2okutfXR3tul1hmcXLMu4tnLhQK/4k7/3Xk2uoRq85mVWq9t+Wq3PTvIOmtJE+ZCRz8gCBq9LT9tbvGhmMQR8EeUsBw4odmCQw3CqeiTOx85dKIBsot70Oy7i0KJ289nr96fA4HYYt8vVRU1x+jqviUPVjS8=
Message-ID: <441FE146.3050406@gmail.com>
Date: Tue, 21 Mar 2006 20:19:34 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Mail/News 1.5 (X11/20060228)
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Sergey Vlasov <vsu@altlinux.ru>, Geoff Rivell <grivell@comcast.net>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] AHCI SATA vendor update from VIA
References: <439CF812.8010107@pobox.com> <20060315191736.231a2894.vsu@altlinux.ru> <441F5C7D.2050600@pobox.com>
In-Reply-To: <441F5C7D.2050600@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Jeff Garzik wrote:
> Sergey Vlasov wrote:
>> What is needed to get the VT8251 support into the kernel tree?
> 
> 1) Doing what you are doing:  asking questions like this.  :)
> 
> 2) Watching Tejun Heo's reset work.  He already has an AHCI soft reset 
> patch, and the VIA AHCI work really depends on this.
> 

BTW, what happened to AHCI softreset patch. It got acked[1], but it has 
not made into the tree yet. Do you want me to regenerate it against the 
current tree? Or is there anything holding it from going into the tree?

> 
>> I have looked at the patch, and it basically does three things:
>>
>> 1) Apparently the VT8251 hardware does not like the standard reset
>>    sequence performed by __sata_phy_reset() - the phy seems to become
>>    ready, but the ATA_BUSY bit never goes off.  So the patch authors
>>    just duplicated ahci_phy_reset(), inserted the whole code of
>>    __sata_phy_reset() in there, and added this part before the
>>    ata_busy_sleep() call:
>>
>> +    /*Fix the VIA busy bug by a software reset*/
>> +    for (i = 0; i < 100; i++) {
>> +        tmp_status = ap->ops->check_status(ap);
>> +        if ((tmp_status & ATA_BUSY) == 0) break;
>> +        msleep(10);
>> +    }
>> +
>> +    if ((tmp_status & ATA_BUSY)) {
>> +        DPRINTK("Busy after CommReset, do softreset...\n"); +        
>> /*set the PxCMD.CLO bit to clear BUSY and DRQ, to make the reset 
>> command sent out*/
>> +        tmp = readl(port_mmio + PORT_CMD);
>> +        tmp |= PORT_CMD_CLO;
>> +        writel(tmp, port_mmio + PORT_CMD);
>> +        readl(port_mmio + PORT_CMD); /* flush */
>> +
>> +        if (via_ahci_softreset(ap)) {
>> +            printk(KERN_WARNING "softreset failed\n");
>> +            return;
>> +        }
>> +    }
>>
>>    Now, if this is really a chip bug, we don't have any choice except
>>    adding this workaround, but obviously not in this way.  What do you
>>    think about splitting __sata_phy_reset() in two parts -
>>    __sata_phy_reset_start() (everything up to the point where
>>    ata_busy_sleep() is called) and __sata_phy_reset_end()
>>    (ata_busy_sleep() and the rest), so that the low-level driver could
>>    insert its own code between these parts?  Or should a hook for this
>>    be added to ->ops instead?
> 
> Tejun's stuff broke up this sequence, so it should be much easier to 
> utilize his new reset code (in libata-dev.git#upstream, queued for 2.6.17).
> 

If hardreset never works on via ahci, simply omitting hardreset in 
ahci_probe_reset() routine for that controller should do the job (with 
the AHCI softreset patch applied of course).

-- 
tejun

[1] http://thread.gmane.org/gmane.linux.ide/7952
