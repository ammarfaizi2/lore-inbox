Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751445AbWEDJBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbWEDJBY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 05:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbWEDJBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 05:01:24 -0400
Received: from dougal.buttersideup.com ([195.200.137.69]:45017 "EHLO
	dougal.buttersideup.com") by vger.kernel.org with ESMTP
	id S1751445AbWEDJBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 05:01:23 -0400
Message-ID: <4459C31F.2020601@buttersideup.com>
Date: Thu, 04 May 2006 10:02:23 +0100
From: Tim Small <tim@buttersideup.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Ong, Soo Keong" <soo.keong.ong@intel.com>,
       "Gross, Mark" <mark.gross@intel.com>,
       bluesmoke-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>,
       "Carbonari, Steven" <steven.carbonari@intel.com>,
       "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>
Subject: Re: Problems with EDAC coexisting with BIOS
References: <C1989F6360C8E94B9645F0E4CF687C08C1E9FB@pgsmsx412.gar.corp.intel.com>	 <1145888979.29648.56.camel@localhost.localdomain>	 <4459119D.10905@buttersideup.com> <1146692646.14636.12.camel@localhost.localdomain>
In-Reply-To: <1146692646.14636.12.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Mer, 2006-05-03 at 21:25 +0100, Tim Small wrote:
>  
>
>>something with NMI-signalled errors, I was wondering what the problems 
>>with using NMI-signalled ECC errors were?
>>    
>>
>
>The big problem with NMI is that it can occur *during* a PCI
>configuration sequence (ie during pci_config_* functions). That means we
>can't safely do some I/O, especially configuration space I/O in an NMI
>handler. At best we could set a flag and catch it afterwards.
>  
>
I was assuming this was the case - but I don't think that deferring the 
work until after the NMI handler has returned is necessarily a big 
disadvantage - at least as far as ECC register-status checking is 
concerned - since none of the hardware that I've looked at makes any 
sort of guarantee about the timeliness of ECC-error-triggered NMI 
delivery anyway - so any of the really smart (and urgent) stuff that you 
could potentially do as part of the ECC error handling (e.g. terminating 
a process if one of their physical pages was mangled) is not possible to 
do in a reliable manner anyway.

About the best thing it is possible to do is to try and arrange to take 
the page(s) in which an uncorrectable error occurred out of further use 
(maybe do the same for correctable errors, if the same physical page 
sees repeated correctable errors), plus maybe give the option of 
panicing if an uncorrectable page was in use by the kernel?

My first thought was to schedule a tasklet as part of the ECC-specific 
NMI handling, or are there any gotchas with doing this from within an 
NMI handler?

Cheers,

Tim.
