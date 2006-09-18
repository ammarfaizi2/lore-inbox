Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030193AbWIRVre@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030193AbWIRVre (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 17:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751942AbWIRVre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 17:47:34 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:7056 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751937AbWIRVrc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 17:47:32 -0400
Message-ID: <450F13EC.2020303@garzik.org>
Date: Mon, 18 Sep 2006 17:47:24 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>,
       "Darrick J. Wong" <djwong@us.ibm.com>, Andrew Morton <akpm@osdl.org>
CC: linux-ide <linux-ide@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexis Bruemmer <alexisb@us.ibm.com>,
       Mike Anderson <andmike@us.ibm.com>
Subject: Re: [PATCH v3] libsas: move ATA bits into a separate module
References: <4508A0A2.2080605@us.ibm.com> <450971D3.2040405@garzik.org> <4509DA77.7000508@us.ibm.com> <20060918190033.GD17670@infradead.org>
In-Reply-To: <20060918190033.GD17670@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Thu, Sep 14, 2006 at 03:40:55PM -0700, Darrick J. Wong wrote:
>> Jeff Garzik wrote:
>>
>>> I disagree completely with this approach.
>>>
>>> You don't need a table of hooks for the case where libata is disabled in
>>> .config.  Thus, it's only useful for the case where libsas is loaded as
>>> a module, but libata is not.
>> Indeed, I misunderstood what James Bottomley wanted, so I reworked the
>> patch.  It has the same functionality as before, but this module uses
>> the module loader/symbol resolver for all the functions in libata, and
>> allows libsas to (optionally) call into sas_ata with weak references by
>> pushing a table of the necessary function pointers into libsas at
>> sas_ata load time.  Thus, libsas doesn't need to load libata/sas_ata
>> unless it actually finds a SATA device.
> 
> NACK again.  Week references are bad.  Please change it back to normal
> hard references so that it works like everything else in the kernel.

I strongly agree.

The kernel code will bloat, and performance will suffer, if we did weak 
refs and jump tables everywhere.

I just don't see the overhead of loading libata, and not using it, as a 
huge penalty, when looking at the alternatives.

Consider the common use cases:  (a) normal distro usage, often servers 
where libata loading will be common anyway due to SATA presence on 
motherboard, and (b) embedded use, where ATA support can be .config'd 
out at compile time.

Thus, the use cases where end users really will care about libata being 
loaded, but not used, are slim to none.

	Jeff


