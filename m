Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965115AbWJCAcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965115AbWJCAcZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 20:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965542AbWJCAcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 20:32:25 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:3019 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965115AbWJCAcY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 20:32:24 -0400
Message-ID: <4521AF8D.4050209@garzik.org>
Date: Mon, 02 Oct 2006 20:32:13 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "Moore, Eric" <Eric.Moore@lsil.com>, Martin Bligh <mbligh@google.com>,
       LKML <linux-kernel@vger.kernel.org>, Andy Whitcroft <apw@shadowen.org>,
       linux-scsi@vger.kernel.org
Subject: Re: Panic from mptspi_dv_renegotiate_work in 2.6.18-mm2
References: <664A4EBB07F29743873A87CF62C26D703507DA@NAMAIL4.ad.lsil.com> <20061002163733.610a3c1f.akpm@osdl.org>
In-Reply-To: <20061002163733.610a3c1f.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Mon, 2 Oct 2006 17:21:08 -0600
> "Moore, Eric" <Eric.Moore@lsil.com> wrote:
> 
>> On Monday, October 02, 2006 2:40 PM, Andrew Morton wrote: 
>>
>>> Yeah, Bryce@osdl is hitting this.  Apparently it can be worked around
>>> by compiling the driver as a module.
>>>
>> What I saw in Bryces trace was the driver was not receiving interrupts
>> for
>> the first command sent after interrutps were enabled.  This was a config
>> page
>> for spi port pages.  Since this command timed out, an internal timeout
>> handler was called,
>> and we issued an internal host reset.  The host reset called each
>> driver,
>> such as mptspi, mptfc, mptsas,  callback handers.  That ended with
>> as pacin in mptspi, due to we assume ioc->hd to be a valid pointer.  
>> We don't allocate ioc->hd to well after mpt_attach, which is where the
>> config
>> page that timed out.    We could prevent the panic in mptspi, but that 
>> doesn't fix the problem why we are not getting interrupts.   
>>
>> I have a 2.6.18 gold kernel, and that works fine with modules.  
>> There are no changes in mpt stack since 2.6.18 that would effect
>> interrupts.  
>> Do you know of any changes in kernel effecting interrupts?   I suspect
>> that
>> modules versus linked drivers into kernel would matter, or would it?
> 
> There are lots and lots of interrupt changes, some now in mainline, some
> not.
> 
> There's a known-problematic PCI resource allocation bug now in mainline
> too.  It appears that this can cause devices to not get assigned an
> interrupt.
> 
> So yes, this is probably the trigger.  But as a secondary thing, it appears
> that the driver will crash if something goes wrong with the interrupt
> setup?

FWIW, I am seeing precisely this problem, in the latest -git.

	Jeff



