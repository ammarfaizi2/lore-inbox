Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275269AbTHGKbD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 06:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275271AbTHGKbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 06:31:03 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:55952 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S275269AbTHGKbA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 06:31:00 -0400
Date: Thu, 7 Aug 2003 12:30:43 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [BROKEN PATCH] syscalls leak data via registers?
Message-ID: <20030807103043.GB211@elf.ucw.cz>
References: <1059815183.18860.55.camel@ixodes.goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059815183.18860.55.camel@ixodes.goop.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> It looks to me like the syscall calling convention, on x86 at least,
> leaks kernel data out via the registers.
[scary stuff]
> When sys_foo returns, the value of %ebx has been changed to 77 on the
> stack, so when it returns to user-mode, the whole world can see that
> arg1 was assigned 77 at some point.
> 
> It seems to me the bug is in restoring the register values on return to
> user-mode.  As I understand it, the x86 ABI says that the called
> function owns the stack memory which contains the function's arguments,
> so it is completely within gcc's right to reuse the memory as spill
> space (or anything else) when generating code for that function. 
> Therefore, the code in entry.S should not restore those values to
> registers - it should just trash all the registers (except %eax, of
> course) before returning.
> 
> I tried writing a patch which replaces the RESTORE_ALL with the
> equivalent which simply skips %esp over the other registers, pops %eax
> and then assigns it to %ebx-%ebp (it makes as good a trash value as
> any), but this crashes when calibrating the delay loop.  Hm, looks like
> the RESTORE_ALL on the syscall return path is also used by the interrupt
> return path - that probably shouldn't trash registers.

I believe userspace depends on registers to be preserved over system
call, except for eax. So what you found is not only security problem,
but also crasher bug.
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
