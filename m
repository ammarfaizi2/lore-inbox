Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268789AbUHLUyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268789AbUHLUyL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 16:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268777AbUHLUyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 16:54:11 -0400
Received: from odin.allegientsystems.com ([208.251.178.227]:23303 "EHLO
	pegasus.lawaudit.com") by vger.kernel.org with ESMTP
	id S268784AbUHLUwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 16:52:35 -0400
Message-ID: <411BD892.8050000@optonline.net>
Date: Thu, 12 Aug 2004 16:52:34 -0400
From: Nathan Bryant <nbryant@optonline.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040806
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: Pavel Machek <pavel@suse.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux SCSI Reflector <linux-scsi@vger.kernel.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] SCSI midlayer power management
References: <411A1B72.1010302@optonline.net> <1092231462.2087.3.camel@mulgrave> <1092267400.2136.24.camel@gaston> <1092314892.1755.5.camel@mulgrave> <20040812131457.GB1086@elf.ucw.cz> <1092328173.2184.15.camel@mulgrave> <20040812191120.GA14903@elf.ucw.cz> <1092339247.1755.36.camel@mulgrave> <20040812202622.GD14556@elf.ucw.cz> <1092342716.2184.56.camel@mulgrave> <20040812203729.GE14556@elf.ucw.cz> <1092343376.1755.61.camel@mulgrave>
In-Reply-To: <1092343376.1755.61.camel@mulgrave>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> On Thu, 2004-08-12 at 16:37, Pavel Machek wrote:
> 
>>Can't you simply reuse bootup code? It will no longer be __init,
>>but it should make suspend/resume functions quite simple.
> 
> 
> Unfortunately, no that simply.
> 
> Bootup is all about allocating these areas and initialising the card. 
> Resume will be about initialising the card knowing the existing areas
> (and the data about the existing areas will have to be part of our
> persistent data on suspend).
> 
> So, modifying the bootup to do something like
> 
> if (in_resume)
> 	addr = read from suspend image

Maybe not that complex. The "suspend image" has become the running 
kernel by the time we receive the resume request, right? So we maybe 
just look at the dma base address that we already have in our 
card-private data structure. If that's all that's needed the S3-resume 
is more likely to just work for disk suspend.

But in general yes you are right you need to separate the bootup code 
into "allocate structures" and "program the card for those locations" 
sections. Personally I think this approach can ultimately be more 
maintainable than saving and restoring registers.

> else
> 	addr = dma_alloc_coherent(...)
> 
> may work.
> 
> 
>>>to pick three drivers to do this for, that would be aic7xxx, aic79xx and
>>>sym_2?
>>
>>No idea, only SCSI host I owned was some 8-bit isa thing....
> 
> 
> Well, someone who's interested needs to pick a driver.  It's usually
> easier to persuade everyone to add the feature if there's an example to
> copy...

Look at my aic7xxx patch. Maybe a little messy but it works. Eh it kind 
of uses a mix of a save/restore registers technique (inherited from 
Justin Gibbs' code) and my own "reuse-the-boot-code" approach that I 
needed to fill in the gaps in his resume code, which was untested

> 
> James
> 
> 
> 

