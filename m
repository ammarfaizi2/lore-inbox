Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964903AbWIKGDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964903AbWIKGDm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 02:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964904AbWIKGDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 02:03:42 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:32456 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S964903AbWIKGDl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 02:03:41 -0400
Date: Mon, 11 Sep 2006 08:03:18 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Edward Falk <efalk@google.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Proper /proc/pid/cmdline behavior when command line is corrupt?
In-Reply-To: <4501DEF5.8010300@google.com>
Message-ID: <Pine.LNX.4.61.0609090954420.30551@yvahk01.tjqt.qr>
References: <mailman.3.1157626801.14788.linux-kernel-daily-digest@lists.us.dell.com>
 <4500D1E6.7020805@google.com> <Pine.LNX.4.61.0609080919130.22545@yvahk01.tjqt.qr>
 <4501A583.2050500@google.com> <Pine.LNX.4.61.0609082124350.30707@yvahk01.tjqt.qr>
 <4501DEF5.8010300@google.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Edward,


> Thank you for sending me that document.  It seems that the bottom
> line is that the environment-follows-the-commandline assumption is
> *not* valid for future kernels, and may well not be valid for other
> architectures either.

Yes, one cannot rely on that across architectures either. But, in
practice, binfmt_elf.c is used by all architectures that support ELF,
so it is likely that the env-follows-arg is consistent across ELF
programs at least. And that is a Good Thing(tm), since otherwise
proc_pid_cmdline() would need to consider every possible layout.

On the other side, binfmt_aout.c for example might do something
completely different. Luckily it does the same compact placing as
binfmt_elf.c, so proc_pid_cmdline() should also work with AOUT
programs.

> I would suggest that for an application to overwrite the end of its
> own commandline buffer is undefined behavior.*

On Linux, yes. Since the setproctitle(3) call has originated from BSD,
things might be a little different there.

> I'd also further suggest that the current implementation of
> proc_pid_cmdline() is essentially _guessing_ that the user has
> overwritten the end of the buffer and also guessing that the extra
> data can be found in the environment buffer.

Well, the environment string is the only place where extra data can go
at the moment. If you place you arguments somewhere else, then they are
not part of the argument string, and would not show up in `ps`.

> Further, if a terminating nul still can't be found in the leading
> part of the environment buffer, proc_pid_cmdline() arbitrarily
> truncates the return value at the one-page mark with no attempt to
> insert a terminating nul.  It seems to me that if we accept that it's
> ok to arbitrarily truncate the return value, then a better choice of
> truncation point would be the end of the commandline buffer.
>
> In addition, since the code is looking for missing data in the
> environment buffer, we can reasonably assume that the user has
> inadvertantly and hopelessly corrupted their own environment.

setproctitle(), as provided by sendmail, copies the environment to the
heap before attempting to overwrite the argument and (possibly) the
environment string. Other implementations might not be so careful,
though.

> I submit that in this case, all bets are off and it doesn't really
> matter *what* we do at this point -- the results are undefined and
> can't possibly be correct.
>
>
>> What that means for your future patch:
>> 
>> The way how the arg and env strings are laid out are, as far as I can
>> tell, defined in fs/binfmt_elf.c:create_elf_tables(). And
>> proc_pid_cmdline() depends on this layout, yes. However, since the layout
>> is not used anywhere outside the kernel (so says the PDF), there should
>> not be a problem. If you modify the layout, make sure it is consistent
>> within the kernel. It is unspecified for userspace, and a user program
>> accessing this area nonetheless is doing so at its own risk.
>
> Thank you for pointing this out.  I'm not planning to change the layout, but
> perhaps a comment should be added to create_elf_tables() warning that
> proc_pid_cmdline() will need to be modified if the layout is ever modified.
>
> Anyway; does anybody know why the original code was done this way, or of any
> applications that depend on that behavior?

Nothing should break if you make the PAGE_SIZE restriction go away,
since it is only procfs that limits the output to PAGE_SIZE. A program
can still access its full argv -- configure scripts sometimes check for
the maximum length of the argument string, and show that it can be up
to 128KB, a lot more than just one page.



Jan Engelhardt
-- 
