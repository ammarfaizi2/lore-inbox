Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbWGaQAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbWGaQAG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 12:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbWGaQAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 12:00:06 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:12791 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751195AbWGaQAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 12:00:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=qVElvfdUKFJUYh6KFTSMUHog8qw3INLclq/WgQ7UeMN2o9GFv/GtLRDhHOi1oG8IwiIieWNlb7jYjKfp/yxPgci2b8jVkgnLdFK2L9Fh3f97I9BCcld926QwHHwxUVaKqCdbo6lYCc6F3CdwL0GWMcKpdphr8Aqjdz/Fsn9Pa5s=
Message-ID: <44CE2908.8080502@gmail.com>
Date: Tue, 01 Aug 2006 01:00:08 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: =?UTF-8?B?IkouQS4gTWFnYWxsw7NuIg==?= <jamagallon@ono.com>
CC: "Linux-Kernel, " <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6.18-rc2-mm1] libata ate one PATA channel
References: <20060728134550.030a0eb8@werewolf.auna.net>	<44CD0E55.4020206@gmail.com> <20060731172452.76a1b6bd@werewolf.auna.net>
In-Reply-To: <20060731172452.76a1b6bd@werewolf.auna.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallón wrote:
> werewolf:~> lspci
> 00:1f.1 IDE interface: Intel Corporation 82801EB/ER (ICH5/ICH5R) IDE Controller (rev 02)
> 00:1f.2 IDE interface: Intel Corporation 82801EB (ICH5) SATA Controller (rev 02)
> werewolf:~> lspci -n
> 00:1f.1 0101: 8086:24db (rev 02)
> 00:1f.2 0101: 8086:24d1 (rev 02)

You compiled w/ ATA_ENABLE_PATA, right?

>> Also, can you report what the kernel says with the 
>> attached patch applied?
>>
> 
> I reworked it to look like this:
> 
>     if (legacy_mode) {
>         probe_ent = ata_pci_init_legacy_port(pdev, port, legacy_mode);
>         dev_printk(KERN_INFO, &pdev->dev,
>            "XXX: legacy_mode probe_ent=%p\n", probe_ent);

This is where the problem is.  Ah.. I see.  Alan's 
rework-legacy-handling patch got into mm.

=====
rework-legacy-handling-to-remove-much-of-the-cruft.patch

From: Alan Cox <alan@lxorguk.ukuu.org.uk>

Kill host_set->next
Fix simplex support
Allow per platform setting of IDE legacy bases
Turn per device tuning on so that PATA timings are fully enabled

Some of this can be tidied further later on, in particular all the
legacy port gunge belongs as a PCI quirk/PCI header decode to understand
the special legacy IDE rules in the PCI spec.

Longer term Jeff also wants to move the request_irq/free_irq out of core
which will make this even cleaner.
=====

These are patches #110-112.  Andrew, can you drop those patches for the 
time being?  I'm working on integrating those into libata #upstream now. 
  Also, please drop #113 libata_resume_fix.patch.  This shouldn't be 
necessary anymore.

Thanks.

-- 
tejun
