Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753421AbWKCSGI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753421AbWKCSGI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 13:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753423AbWKCSGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 13:06:08 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:24967 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1753421AbWKCSGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 13:06:05 -0500
Message-ID: <454B850C.3050402@vmware.com>
Date: Fri, 03 Nov 2006 10:06:04 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>
Subject: Re: [patch] i386: remove IOPL check on task switch
References: <200611030130_MC3-1-D02A-DEB@compuserve.com>
In-Reply-To: <200611030130_MC3-1-D02A-DEB@compuserve.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:
> IOPL is implicitly saved and restored on task switch,
> so explicit check is no longer needed.
>
> Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
>
> --- 2.6.19-rc4-32smp.orig/arch/i386/kernel/process.c
> +++ 2.6.19-rc4-32smp/arch/i386/kernel/process.c
> @@ -681,12 +681,6 @@ struct task_struct fastcall * __switch_t
>  		loadsegment(gs, next->gs);
>  
>  	/*
> -	 * Restore IOPL if needed.
> -	 */
> -	if (unlikely(prev->iopl != next->iopl))
> -		set_iopl_mask(next->iopl);
> -
> -	/*
>  	 * Now maybe handle debug registers and/or IO bitmaps
>  	 */
>  	if (unlikely((task_thread_info(next_p)->flags & _TIF_WORK_CTXSW)
>   

Nack.  This is used for paravirt-ops kernels that use IOPL'd userspace.  
Fixing it would require a fairly heavy penalty on the iret path, since 
every single instruction there contributes to a critical region which 
must have custom fixup code, or some other technique to provide 
protection against interrupt re-entrancy.

At least, let's discuss other potential solutions first - for now it is 
harmless.

Zach
