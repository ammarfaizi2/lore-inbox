Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264934AbUFLWIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264934AbUFLWIQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 18:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264936AbUFLWIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 18:08:16 -0400
Received: from zero.aec.at ([193.170.194.10]:21253 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S264934AbUFLWIP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 18:08:15 -0400
To: Sergey Vlasov <vsu@altlinux.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: timer + fpu stuff locks up computer
References: <26h3z-t3-15@gated-at.bofh.it> <26hGq-Zr-29@gated-at.bofh.it>
	<26isF-1Im-11@gated-at.bofh.it> <26lJU-4lC-23@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Sun, 13 Jun 2004 00:08:10 +0200
In-Reply-To: <26lJU-4lC-23@gated-at.bofh.it> (Sergey Vlasov's message of
 "Sat, 12 Jun 2004 20:50:10 +0200")
Message-ID: <m3isdwo2et.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergey Vlasov <vsu@altlinux.ru> writes:

> On Sat, Jun 12, 2004 at 07:14:22PM +0400, Sergey Vlasov wrote:
>> If the FPU state belong to the userspace process, kernel_fpu_begin()
>> is safe even if some exceptions are pending.  However, after
>> __clear_fpu() the FPU is "orphaned", and kernel_fpu_begin() does
>> nothing with it.
>> 
>> Replacing fwait with fnclex instead of removing it completely should
>> avoid the fault later.
>
> Yes, it seems to be enough.  Another case where it looks like FPU
> might be "orphaned" is exit(); however, it is handled as a normal task
> switch, __switch_to() calls __unlazy_fpu(), which clears pending
> exceptions.

One problem on 486s/P5s would be the race that is described in D.2.1.3
of Volume 1 of the Intel architecture manual when the FPU is in MSDOS
compatibility. When that happens we can still get the exception later
(e.g. on a following fwait which the kernel can still execute). The
only way to handle that would be to check in the exception handler,
like my patch did. However my patch was also not complete, since it
didn't handle it for all fwaits in the kernel.

Also BTW x86-64 must be fixed too.

-Andi

