Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262616AbVHDPu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262616AbVHDPu1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 11:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbVHDPsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 11:48:15 -0400
Received: from mx1.suse.de ([195.135.220.2]:38054 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262616AbVHDPqu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 11:46:50 -0400
Date: Thu, 4 Aug 2005 17:46:49 +0200
From: Andi Kleen <ak@suse.de>
To: Zachary Amsden <zach@vmware.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 3/5 explicit-iopl
Message-ID: <20050804154649.GA8266@wotan.suse.de>
References: <200508040043.j740hi0R004184@zach-dev.vmware.com.suse.lists.linux.kernel> <p73k6j1rj1i.fsf@bragg.suse.de> <42F2344D.1070209@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42F2344D.1070209@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well... maybe.  On Opteron and/or Intel EMT it may not be a win.  The 
> cost of the branch could overtake the cost of the POPF (that's the 
> expensive one).  Grrr.

Not on Opteron, but probably on Intel.

iirc popf will actually flush parts of the trace cache, while
a branch shouldn't do that. So I expect it to be a win.


> 
> >Can we perhaps get rid of the PUSHF/POPF in the SYSENTER syscall path too?
> >iirc they were only for single stepping. But SYSENTER doesn't disable
> >single stepping, so the debug handler could detect this and set
> >some magic flag that restores it on syscall exit.
> > 
> >
> 
> A context switch requires IRET, which requires the flags to be saved, so 
> you can't eliminate the pushf (*) IIRC, the popf is already omitted.  

If we have iopl and TF elsewhere then the flags could just be replaced
with a default value. 

Drawback would be that it would be slightly incompatible to before,
but then it's just a function call and function calls are not 
required to preserve flags.

> (*) Well, you could.  It's just that system calls would have to clobber 
> flags - hmm.. sysenter based calls already do. But I'm not 100% sure 

They do pushf. 

> there isn't some bogon case where kernel preemption could cause you a 
> problem.  Keeping around the fake IRET frame still appears to be a good 
> thing to do just for the benefit of ptrace / debug functionality.  PUSHF 
> is cheap on every core I have measured on.

Are you sure? I thought it was expensive on Northwood at least.
Haven't measured on a Prescott or newer.

-Andi
