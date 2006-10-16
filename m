Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbWJPXZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWJPXZh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 19:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWJPXZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 19:25:37 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:28597 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1750806AbWJPXZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 19:25:36 -0400
Message-ID: <453414F0.8020502@vmware.com>
Date: Mon, 16 Oct 2006 16:25:36 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: caglar@pardus.org.tr, Gerd Hoffmann <kraxel@suse.de>,
       john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Avoid PIT SMP lockups
References: <1160170736.6140.31.camel@localhost.localdomain> <200610121045.32846.caglar@pardus.org.tr> <453404F6.5040202@vmware.com> <200610170040.49502.ak@suse.de>
In-Reply-To: <200610170040.49502.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>> It might only happen with SMP because the difficulty of getting good 
>> enough TSC / timer IRQ synchronization during boot increases 
>> exponentially with SMP configurations. And it might pass 10% of the time 
>> because you were lucky enough not to fire off another timer interrupt yet.
>>     
>
> We have the same problem with NMI watchdog events unfortunately. 
> Need to call something in the nmi watchdog code to make sure it is 
> not renewed and then reenabled.
> Or maybe it's better to figure out a way that yields atomic patches.
>   

> I think the best way is to make sure all alternative() patches
> are always done before the code can be ever executed - this
> means doing it very early for the main kernel. The only exception
> would be the LOCK prefix patching, which should be atomic

Yes, this solves the problem in most cases.  Lock patching is fine no 
matter when you do it.  I think the problem with alternative patching in 
check_bugs() is that it happens way too late; the patching really has 
nothing at all to do with check_bugs(), and should be a separate step, 
probably part of setup_arch.


The paravirt-ops stuff also has some patching code.  Fortunately, there, 
we can probably skirt the NMI issue by simply disallowing NMIs, but the 
issue pops up again in stop_machine_run - what happens if you take NMIs 
during stop_machine_run?  Debug traps?  Module unload is fine, but code 
patching done using stop_machine_run is not safe.

Zach
