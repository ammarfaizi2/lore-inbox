Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751183AbWIHUF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbWIHUF4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 16:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbWIHUF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 16:05:56 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:2973 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751183AbWIHUFy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 16:05:54 -0400
Date: Fri, 8 Sep 2006 22:05:35 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Edward Falk <efalk@google.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Proper /proc/pid/cmdline behavior when command line is corrupt?
In-Reply-To: <4501A583.2050500@google.com>
Message-ID: <Pine.LNX.4.61.0609082124350.30707@yvahk01.tjqt.qr>
References: <mailman.3.1157626801.14788.linux-kernel-daily-digest@lists.us.dell.com>
 <4500D1E6.7020805@google.com> <Pine.LNX.4.61.0609080919130.22545@yvahk01.tjqt.qr>
 <4501A583.2050500@google.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Edward,


>>> that the environment buffer is assumed to immediately follow the
>>> command line buffer.
>> 
>> The environment buffer is not assumed to be there, it is _known_ to
>> come right after the argument string, because that is how the kernel
>> sets it up on execve (for x86 at least).
>
> Is that in a spec somewhere?

http://www.x86-64.org/documentation/abi.pdf#search=%22argv%20envp%20x86%20ABI%22
page 29 figure 3.9 lists the data block in question as "Information
block, including argument strings, environment strings, auxiliary
information", but does not specify it further, like how it is laid out.

What it does mention is "argument pointers" (aka argv[N]) and their
exact position. In fact, right below the figure is the explanation:
"Argument strings, environment strings, and the auxiliary information
appear in no specific order within the information block and they need
not be compactly allocated."

What this means: we are guaranteed that argv[N] is valid, but that not
that the memory range [&argv[0][0] .. &argv[X][Y]] is contiguous. In
fact, if the argument string was not contiguous, but, let's say, have a
map hole, using setproctitle() will inevidently lead to a SIGSEGV.
Probably that is the reason why Linux/glibc do not come with a
setproctitle(3) function. I have taken a look at sendmail, which ships
its own setproctitle (for this very reason), and a source code comment
says it will only use contiguous argv pointers, but I have not looked
at it more closely.

> Otherwise, I would argue that it isn't _known_ to come right after
> the argument string, it just _happens_ to come right after the
> argument string.  This could change in future kernels.

Yes you are right. It may happen that the argument strings come _after_
the environment. Or something even different. In practice that would 
mean that writing over the end of the argument string will write into 
other vital structures, possibly crashing the userspace program. Or if 
not that, it will display garbage in the command line.

What that means for your future patch:

The way how the arg and env strings are laid out are, as far as I can 
tell, defined in fs/binfmt_elf.c:create_elf_tables(). And 
proc_pid_cmdline() depends on this layout, yes. However, since the 
layout is not used anywhere outside the kernel (so says the PDF), there 
should not be a problem. If you modify the layout, make sure it is 
consistent within the kernel. It is unspecified for userspace, and a 
user program accessing this area nonetheless is doing so at its own risk.

Hope this helps.


Regards,
Jan Engelhardt
-- 
