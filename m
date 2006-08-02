Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbWHBSaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbWHBSaQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 14:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbWHBSaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 14:30:16 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:42661 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932133AbWHBSaO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 14:30:14 -0400
Message-ID: <44D0EF30.7030701@vmware.com>
Date: Wed, 02 Aug 2006 11:30:08 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Stas Sergeev <stsp@aknet.ru>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: + espfix-code-cleanup.patch added to -mm tree
References: <200607300016.k6U0GYu4023664@shell0.pdx.osdl.net> <44CE766D.6000705@vmware.com> <44CF474C.9070800@aknet.ru> <44CFC139.4030801@vmware.com> <44D0DCF5.8050906@aknet.ru>
In-Reply-To: <44D0DCF5.8050906@aknet.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stas Sergeev wrote:
> Hi,
>
> Zachary Amsden wrote:
>> You need to get a #GP or #NP on the faulting iret.  Several ways to 
>> do that -
> I do that much simpler - I provoke a SIGSEGV and in a signal handler
> I put the wrong value to scp->cs or scp->ss, and that makes iret to 
> fault.

Ok, that's a new trick ;)

>
>> iret faults, but doesn't pop the user return frame.
> But does it push the kernel frame after it or not?
> If not - I don't understand how we go to a fixup.
> If yes - I don't understand how the user's frame gets
> accessed later, as it is above the kernel's frame.

Yes.  The iret faults, the fault pushes a new kernel frame - and the 
fault handler's iret returns, removing the kernel frame.  So the kernel 
frame is gone by the time the fixup runs.

>
>>> safe limit is regs->esp + THREAD_SIZE*2... Well, may just I not do 
>>> that please? :)
>>> For what, btw? There are no such a things for __KERNEL_DS or 
>>> anything, so
>>> I just don't see the necessity.
>> It helps track down any bugs that could leak through otherwise and 
>> corrupt random memory.
> I think regs->esp + THREAD_SIZE*2 is already very permissive,
> and I'd like to avoid messing with granularity. So unless you
> really insist, I'll better not do that. :)

It's really hard to catch bugs that could otherwise happen when a 
non-zero based stack gets used (for example, C code which uses %ebp with 
-fomit-frame-pointer).  Setting the limit to THREAD_SIZE should 
guarantee that the non-zero based stack never is used to access anything 
but the stack and current thread.

Zach

