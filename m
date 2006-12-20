Return-Path: <linux-kernel-owner+w=401wt.eu-S964825AbWLTCoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbWLTCoX (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 21:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbWLTCoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 21:44:23 -0500
Received: from nz-out-0506.google.com ([64.233.162.235]:64663 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964825AbWLTCoW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 21:44:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=CbJHTm4NNvraA/YP/VA0xk5eAYrsK/crWYOZLOg/E5G6UcYh8Hhej+zPQnl8XUtFTarpHSrDbL1Bi5h+TelQmCG0bZp/EX6E3zLj6MY65qlayfy43T7sAcr8A0ZfNRhfSK6IhTc+UVlMvFXACyyXgjdJ5KfWlEW+1kzPNS2O7l0=
Message-ID: <4588A37F.9040102@gmail.com>
Date: Wed, 20 Dec 2006 11:44:15 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.8 (X11/20061129)
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Alan <alan@lxorguk.ukuu.org.uk>, David Shirley <tephra@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: SATA DMA problem (sata_uli)
References: <f0e65c090612122102o327ac693u2f24a74a9ba973ef@mail.gmail.com> <20061213112004.59cb186c@localhost.localdomain> <45841B20.9030402@pobox.com> <458884B2.9080802@gmail.com> <45888653.6080702@pobox.com>
In-Reply-To: <45888653.6080702@pobox.com>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Jeff Garzik wrote:
>>> Alan wrote:
>>>>> I tracked it down to one of the drives being forced into PIO4 mode
>>>>> rather than UDMA mode; dmesg bits:
>>>>> ata4.00: ATA-7, max UDMA/133, 586072368 sectors: LBA48 NCQ (depth
>>>>> 0/32)
>>>>> ata4.00: ata4: dev 0 multi count 16
>>>>> ata4.00: simplex DMA is claimed by other device, disabling DMA
>>>> Your ULi controller is reporting that it supports UDMA upon only one
>>>> channel at a time. The kernel is honouring this information. The older
>>>> ULi (was ALi) PATA devices report simplex but let you turn it off so
>>>> see if the following does the trick. Test carefully as always with
>>>> disk driver
>>>> changes.
>>>>
>>>> (Jeff probably best to check the docs before merging this but I believe
>>>> it is sane)
>>>>
>>>> Signed-off-by: Alan Cox <alan@redhat.com>
>>> My Uli SATA docs do not appear to cover the bmdma registers :(  Only the
>>> PCI config registers.
>>>
>>> But regardless, I think the better fix is to never set ATA_HOST_SIMPLEX
>>> if ATA_FLAG_NO_LEGACY is set.
>>>
>>> None of the SATA controllers I've ever encountered has been simplex.
>>
>> Just another data point.  The same problem is reported by bug #7590.
>>
>> http://bugzilla.kernel.org/show_bug.cgi?id=7590
>>
>> Is somebody brewing a patch?
> 
> Not to my knowledge.  Did you just volunteer?  ;-)
> 
> /me runs...

I'm just gonna ack Alan's patch.

* ATA_FLAG_NO_LEGACY is not really used widely (and thus LLDs don't set
it rigorously).  I think it should be removed once we get initialization
model right.

* I'm really reluctant to add more LLD-specific knowledge into libata
core.  We're already carrying too much due to the current init model
(libata should initialize host according to probe_ent, so many
weirdities should be represented in probe_ent in a form libata core
understands).

* The idea of clearing simplex for unknown controllers scares the hell
out of me.  where's mummy...

So, I'll ask bug reporter of #7590 to test it.

-- 
tejun
