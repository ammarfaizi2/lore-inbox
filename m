Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751267AbWIHVWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbWIHVWK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 17:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbWIHVWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 17:22:10 -0400
Received: from smtp-out.google.com ([216.239.45.12]:45399 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751264AbWIHVWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 17:22:07 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=lvbApR1deq4/DDHZ/khpT30fESn2A2TsnSZtVop/CIKjNAVWpQTbsMMTjNGOjn6La
	eG5EhfbR8KOZXLCygxhTA==
Message-ID: <4501DEF5.8010300@google.com>
Date: Fri, 08 Sep 2006 14:21:57 -0700
From: Edward Falk <efalk@google.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Proper /proc/pid/cmdline behavior when command line is corrupt?
References: <mailman.3.1157626801.14788.linux-kernel-daily-digest@lists.us.dell.com> <4500D1E6.7020805@google.com> <Pine.LNX.4.61.0609080919130.22545@yvahk01.tjqt.qr> <4501A583.2050500@google.com> <Pine.LNX.4.61.0609082124350.30707@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0609082124350.30707@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
> 
> http://www.x86-64.org/documentation/abi.pdf#search=%22argv%20envp%20x86%20ABI%22
> page 29 figure 3.9 lists the data block in question as "Information
> block, including argument strings, environment strings, auxiliary
> information", but does not specify it further, like how it is laid out.
> 
> What it does mention is "argument pointers" (aka argv[N]) and their
> exact position. In fact, right below the figure is the explanation:
> "Argument strings, environment strings, and the auxiliary information
> appear in no specific order within the information block and they need
> not be compactly allocated."

...

Thank you for sending me that document.  It seems that the bottom line 
is that the environment-follows-the-commandline assumption is *not* 
valid for future kernels, and may well not be valid for other 
architectures either.

I would suggest that for an application to overwrite the end of its own 
commandline buffer is undefined behavior.*

I'd also further suggest that the current implementation of 
proc_pid_cmdline() is essentially _guessing_ that the user has 
overwritten the end of the buffer and also guessing that the extra data 
can be found in the environment buffer.

Further, if a terminating nul still can't be found in the leading part 
of the environment buffer, proc_pid_cmdline() arbitrarily truncates the 
return value at the one-page mark with no attempt to insert a 
terminating nul.  It seems to me that if we accept that it's ok to 
arbitrarily truncate the return value, then a better choice of 
truncation point would be the end of the commandline buffer.

In addition, since the code is looking for missing data in the 
environment buffer, we can reasonably assume that the user has 
inadvertantly and hopelessly corrupted their own environment.  I submit 
that in this case, all bets are off and it doesn't really matter *what* 
we do at this point -- the results are undefined and can't possibly be 
correct.


> What that means for your future patch:
> 
> The way how the arg and env strings are laid out are, as far as I can 
> tell, defined in fs/binfmt_elf.c:create_elf_tables(). And 
> proc_pid_cmdline() depends on this layout, yes. However, since the 
> layout is not used anywhere outside the kernel (so says the PDF), there 
> should not be a problem. If you modify the layout, make sure it is 
> consistent within the kernel. It is unspecified for userspace, and a 
> user program accessing this area nonetheless is doing so at its own risk.

Thank you for pointing this out.  I'm not planning to change the layout, 
but perhaps a comment should be added to create_elf_tables() warning 
that proc_pid_cmdline() will need to be modified if the layout is ever 
modified.

Anyway; does anybody know why the original code was done this way, or of 
any applications that depend on that behavior?


> Hope this helps.

Immensely.  Thank you.

	-ed falk


*Actually, by the looks of things, for a process to write to its own 
commandline buffer *at all* is undefined behavior, since the spec makes 
no guarantees of the layout of the information block.
