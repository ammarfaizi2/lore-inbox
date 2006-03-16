Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752268AbWCPJT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752268AbWCPJT5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 04:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752272AbWCPJT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 04:19:57 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:65448 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1752262AbWCPJT4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 04:19:56 -0500
Date: Thu, 16 Mar 2006 10:19:43 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swsusp_suspend continues?
Message-ID: <20060316091943.GD1729@elf.ucw.cz>
References: <200603101704.AA00798@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <20060313113631.GA1736@elf.ucw.cz> <20060315103711.GA31317@suse.de> <200603161320.36051.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200603161320.36051.kernel@kolivas.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Čt 16-03-06 13:20:35, Con Kolivas wrote:
> Hi Pavel
> 
> I've been playing with hooking in the post resume swap prefetch code into 
> swsusp_suspend and just started noting this on 2.6.16-rc6-mm1:
> During the _suspend_ to disk cycle on this machine the swsusp_suspend function 
> appears to continue beyond swsusp_arch_suspend as I get the same messages 
> that I would normally get during a resume cycle such as this:
> 
> Suspending device platform
> swsusp: Need to copy 14852 pages
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0
> and...
> eth1: Coming out of suspend...
> and so on
> 
> but then it manages to write to disk and power down anyway. Is this correct? 

Yes. We need our hardware enabled for image write (disk would be
enough), so we resume it (and we resume all of it, because that was
easier to code).

> If I put post_resume_swap_prefetch at the end of swsusp_suspend it hits that 
> function on both resume _and_ suspend cycles. Am I missing something?

No. That's just the way it is. See

        /* Restore control flow magically appears here */

and 

        /* Code below is only ever reached in case of failure. Otherwise
         * execution continues at place where swsusp_arch_suspend was called
         */
        BUG_ON(!error);

Yes, I agree it is confusing, and feel free to suggest comment cleanups.

I'd suggest you hook at disk.c:pm_suspend_disk.

Or just include that /sys interface, and trigger it from userspace
just after resume. Actually I like that best. It is optional, it can
be triggered from userspace, and you will not have to deal with
suspend internals.

(And it will be useful to uswsusp, too, that avoids big chunks of
in-kernel suspend code).

								Pavel
-- 
133:
