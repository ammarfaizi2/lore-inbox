Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965235AbWIVWYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965235AbWIVWYt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 18:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965212AbWIVWYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 18:24:48 -0400
Received: from gw.goop.org ([64.81.55.164]:40899 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S965235AbWIVWYs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 18:24:48 -0400
Message-ID: <451462B0.8000709@goop.org>
Date: Fri, 22 Sep 2006 15:24:48 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Andi Kleen <ak@muc.de>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       virtualization <virtualization@lists.osdl.org>
Subject: Re: [PATCH 2/7]
References: <1158925861.26261.3.camel@localhost.localdomain>	 <1158925997.26261.6.camel@localhost.localdomain> <1158926106.26261.8.camel@localhost.localdomain>
In-Reply-To: <1158926106.26261.8.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> This patch implements save/restore of %gs in the kernel, so it can be
> used for per-cpu data.  This is not cheap, and we do it for UP as well
> as SMP, which is stupid.  Benchmarks, anyone?
>   
I measured the cost as adding 9 cycles to a null syscall on my Core Duo 
machine.  I have not explicitly measured it on other machines, but I run 
a number of other segment save/load tests on a wide range of machines, 
and didn't find much variability.

I think saving/restoring %gs will still be necessary. There are a number 
of places in the kernel which expect to find the usermode %gs on the 
kernel stack frame, including context switch, ptrace, vm86, signal 
context, and maybe something else.  If you don't save it on the stack, 
then you need to have UP variations of %gs handling in all those other 
places, which is pretty messy.  Also, unless you want to have two 
definitions of struct_pt regs (which would add even more mess into 
ptrace), you'd still need to sub/add %esp in entry.S to skip over the 
%gs hole.  I don't think this UP microoptimisation would be worth enough 
to justify the mess it would cause elsewhere.

How does this version of the patch differ from mine?  Is it just my 
patch+Ingo's fix, or are there other changes?  I couldn't see anything 
from a quick read-over.

    J
