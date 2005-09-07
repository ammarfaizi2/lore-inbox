Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751008AbVIGENj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbVIGENj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 00:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751017AbVIGENj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 00:13:39 -0400
Received: from smtp.istop.com ([66.11.167.126]:38291 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S1751005AbVIGENi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 00:13:38 -0400
From: Daniel Phillips <phillips@istop.com>
To: Mark Lord <lkml@rtr.ca>
Subject: Re: RFC: i386: kill !4KSTACKS
Date: Wed, 7 Sep 2005 00:16:41 -0400
User-Agent: KMail/1.8
Cc: Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>
References: <20050904145129.53730.qmail@web50202.mail.yahoo.com> <200509061819.45567.phillips@istop.com> <431E497A.4080303@rtr.ca>
In-Reply-To: <431E497A.4080303@rtr.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509070016.42121.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 September 2005 21:59, Mark Lord wrote:
> Daniel Phillips wrote:
> > There are only two stacks involved, the normal kernel stack and your new
> > ndis stack.  You save ESP of the kernel stack at the base of the ndis
> > stack.  When the Windows code calls your api, you get the ndis ESP, load
> > the kernel ESP from the base of the ndis stack, push the ndis ESP so you
> > can get back to the ndis code later, and continue on your merry way.

I must have been smoking something when I convinced myself that the driver 
can't call into the kernel without switching back to the kernel stack.  But 
this is wrong, as long as ->task and ->previous_esp are initialized, staying 
on the bigger stack looks fine (previous_esp is apparently used only for 
backtrace).

> With CONFIG_PREEMPT, this will still cause trouble due to lack
> of "current" task info on the NDIS stack.
>
> One option is to copy (duplicate) the bottom-of-stack info when
> switching to the NDIS stack.

Yes, just like do_IRQ.

> Another option is to stick a Mutex around any use of the NDIS stack
> when calling into the foreign driver (might be done like this already??),

There is no mutex now, but this is the easy way to get by with just one ndis 
stack.

> which will prevent PREEMPTion during the call.

We have preempt_enable/disable for that.  But I am not sure preemption needs 
to be disabled.

Regards,

Daniel
