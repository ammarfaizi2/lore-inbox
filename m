Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266448AbUFQKjI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266448AbUFQKjI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 06:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266450AbUFQKjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 06:39:08 -0400
Received: from colin2.muc.de ([193.149.48.15]:41234 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S266448AbUFQKjC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 06:39:02 -0400
Date: 17 Jun 2004 12:39:01 +0200
Date: Thu, 17 Jun 2004 12:39:01 +0200
From: Andi Kleen <ak@muc.de>
To: eliot@cincom.com
Cc: ak@muc.de, linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: PROBLEM: 2.6 kernels on x86 do not preserve FPU flags across context switches
Message-ID: <20040617103901.GB73341@colin2.muc.de>
References: <200406162227.PAA01216@central.parcplace.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406162227.PAA01216@central.parcplace.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2004 at 03:26:55PM -0700, eliot@cincom.com wrote:
> Hi Andi,
> 
> 
> | Funny, Linux just added fnclex to a critical path on popular request.
> | But I guess it will need to be removed again, we already discussed
> | that.
> 
> Yes, this is a right royal pain.  We have problems around fnclex.  Because people can call arbitrary code from within Smalltalk we have to do an fnclex prior to an fp operation if we're to trap NaN/Inf results.  But doing so prior to each fp oiperation is becomming increasingly slower on more "modern" x86 implementations.  So we've now moved the fnclex to the return from an external language call as this tends to have lower dynamic frequency.  So from where I sit (a mushroom-like position) the issue feels like a design flaw in the x87 fpu...


You can use fwait and handle the exception in a signal handler if it occurs. 
fwait is much faster.

> 
> | > I don't know whether any action on your part is appropriate.  The
> | > use of the FPU status flags is presumably rare on linux (I believe
> | > that neither gcc nor glibc make use of them).  But "exotic"
> | > execution machinery such as runtimes for dynamic or functional
> | > languages (language implementations that may not use IEEE arithmetic
> | > and instead flag Infs and NaNs as an error) may fall foul of this
> | > issue.  Since previous versions of the kernel on x86 apparently do
> | > preserve the FPU status flags perhaps its simple to preserve the old
> | > behaviour.  At the very least let me suggest you document the
> | > limitation.
> 
> | This sounds like a serious kernel bug that should be fixed if
> | true. Can you perhaps create a simple demo program that shows the
> | problem and post it?
> 
> OK, I'm working on it.  I have to get one of our customers to run the test because I don't have a 2.6 kernel handy.  As Im in release crunch mode right now there may be a couple of weeks delay.  But I should have a test program to you soon.

Thanks.

> 
> | On what CPUs does the failure occur? Linux uses different paths
> | depending on if the CPU supports SSE or not.
> 
> This answer should be more prompt.  Say tomorrow.
> 
> | Does your program receive signals? Could it be related to them?
> 
> Could be. Yes we do have to handle signals.  But I'm pretty confident the issue is with the FPU flags because as far as fp goes the only significant change between the version that shows the problem and that that doesn't is the use of the FPU flags (via fxam, fstsw).  The version that uses fxam & fstsw doesn;t show the problem on kernels prior to 2.6.  In any case if I'm right the test proram should show it pretty clearly.

I'm asking because signals save/restore FPU context. 

-Andi
