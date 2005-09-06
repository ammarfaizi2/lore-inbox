Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751037AbVIFWQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbVIFWQv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 18:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbVIFWQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 18:16:51 -0400
Received: from smtp.istop.com ([66.11.167.126]:42124 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S1750775AbVIFWQv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 18:16:51 -0400
From: Daniel Phillips <phillips@istop.com>
To: Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>
Subject: Re: RFC: i386: kill !4KSTACKS
Date: Tue, 6 Sep 2005 18:19:45 -0400
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
References: <20050904145129.53730.qmail@web50202.mail.yahoo.com> <58d0dbf10509061005358dce91@mail.gmail.com> <dfkjav$lmd$1@sea.gmane.org>
In-Reply-To: <dfkjav$lmd$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509061819.45567.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 September 2005 13:23, Giridhar Pemmasani wrote:
> Jan Kiszka wrote:
> > The only way I see is to switch stacks back on ndiswrapper API entry.
> > But managing all those stacks correctly is challenging,

There are only two stacks involved, the normal kernel stack and your new ndis 
stack.  You save ESP of the kernel stack at the base of the ndis stack.  When 
the Windows code calls your api, you get the ndis ESP, load the kernel ESP 
from the base of the ndis stack, push the ndis ESP so you can get back to the 
ndis code later, and continue on your merry way.

> > as you will likely not want to create a new stack on each switching
> > point... 

You will allocate your own stack once on driver initialization.

> This is what I had in mind before I saw this thread here. I, in fact, did
> some work along those lines, but it is even more complicated than you
> mentioned here: Windows uses different calling conventions (STDCALL,
> FASTCALL, CDECL) so switching stacks by copying arguments/results gets
> complicated.

I missed something there.  You would switch stacks before calling the Windows 
code and after the Windows code calls you (and respective returns) so you are 
always in your own code when you switch, hence you know how to copy the 
parameters.

> I am still hoping that Andi's approach is possible (I don't understand how
> we can make kernel see current info from private stack).

He suggested you use your own private variant of current which would 
presumeably read a copy of current you stored at the bottom of your own 
stack.  But I don't see why your code would ever need current while you are 
on the private ndis stack.

Andi, their stack will have to have a valid thread_info->task because 
interrupts will use it.  Out of interest, could you please explain what for?

Code like u32 stack[THREAD_SIZE/sizeof(u32)] is violated by a different sized 
stack, but apparently not in any way that matters.

By the way, I use ndis_wrapper, thanks a lot you guys!

Regards,

Daniel
