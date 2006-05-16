Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751696AbWEPIh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbWEPIh4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 04:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751697AbWEPIh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 04:37:56 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:45186 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751694AbWEPIhz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 04:37:55 -0400
Date: Tue, 16 May 2006 01:40:47 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Zachary Amsden <zach@vmware.com>
Cc: Ingo Molnar <mingo@elte.hu>, Rusty Russell <rusty@rustcorp.com.au>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>,
       virtualization <virtualization@lists.osdl.org>,
       Gerd Hoffmann <kraxel@suse.de>
Subject: Re: [PATCH] Gerd Hoffman's move-vsyscall-into-user-address-range patch
Message-ID: <20060516084047.GH2697@moss.sous-sol.org>
References: <1147759423.5492.102.camel@localhost.localdomain> <20060516064723.GA14121@elte.hu> <44698A74.3090400@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44698A74.3090400@vmware.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zachary Amsden (zach@vmware.com) wrote:
> Let's dive into it.  How do you get the randomization without 
> sacrificing syscall performance?  Do you randomize on boot, dynamically, 
> or on a per-process level?

The latter, on exec.

> Because I can see some issues with 
> per-process randomization that will certainly cost some amount of cycles 
> on the system call path.  Marginal perhaps, but that is exactly where 
> you don't want to shed cycles unnecessarily, and the complexity of the 
> whole thing will go up quite a bit I think.

The crux is here:

+       OFFSET(TI_sysenter_return, thread_info, sysenter_return);
...

-       pushl $SYSENTER_RETURN
-
+       /*
+        * Push current_thread_info()->sysenter_return to the stack.
+        * A tiny bit of offset fixup is necessary - 4*4 means the 4 words
+        * pushed above; +8 corresponds to copy_thread's esp0 setting.
+        */
+       pushl (TI_sysenter_return-THREAD_SIZE+8+4*4)(%esp)

...

and in binfmt_elf during exec thread_info->sysenter_return is setup
based on the randomized mapping it does for vdso

+               ti->sysenter_return = &SYSENTER_RETURN_OFFSET + addr;


I think it's not so bad, but I can't say I've benchmarked the cost.

thanks,
-chris
