Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262693AbTDXMLU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 08:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263497AbTDXMLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 08:11:20 -0400
Received: from mta01.telering.at ([212.95.31.38]:63389 "EHLO smtp.telering.at")
	by vger.kernel.org with ESMTP id S262693AbTDXMLT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 08:11:19 -0400
Date: Thu, 24 Apr 2003 13:26:11 +0200
From: Bernhard Kaindl <kaindl@telering.at>
X-X-Sender: bkaindl@hase.a11.local
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Nuno Silva <nuno.silva@vgertech.com>,
       Yusuf Wilajati Purna <purna@sm.sony.co.jp>,
       Marcelo Tosatti <marcelo@conectiva.com.br>, rmk@arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.4+ptrace] fix side effects of the kmod/ptrace secfix
In-Reply-To: <20030424090051.D24363@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.53.0304241238200.2190@hase.a11.local>
References: <3E9E3FA9.6060509@sm.sony.co.jp> <Pine.LNX.4.53.0304190532520.1887@hase.a11.local>
 <3EA4CD3F.9040902@sm.sony.co.jp> <Pine.LNX.4.53.0304222236040.2341@hase.a11.local>
 <3EA778E7.5040903@vgertech.com> <20030424090051.D24363@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arjan!

On Thu, 24 Apr 2003, Arjan van de Ven wrote:
> On Thu, Apr 24, 2003 at 06:40:55AM +0100, Nuno Silva wrote:
> > Good morning! :)
> >
> > I'd like to ear an "official" word on this subject, please. :)
> > Is this patch still secure?
>
> The check is loosend too much.

Last month, you sounded different:

On 2003-03-22 17:28:54, Arjan van de Ven wrote:
>On Sat, Mar 22, 2003 at 05:13:12PM +0000, Russell King wrote:
>>
>> int ptrace_check_attach(struct task_struct *child, int kill)
>> {
>>    ...
>> +       if (!is_dumpable(child))
>> +               return -EPERM;
>> }
>>
>> So, we went from being able to ptrace daemons as root, to being able to
>> attach daemons and then being unable to do anything with them, even if
>> you're root (or have the CAP_SYS_PTRACE capability).  I think this
>> behaviour is getting on for being described as "insane" 8) and is
>> clearly wrong.
>
>ok it seems this check is too strong. It *has* to check
>child->task_dumpable and return -EPERM, but child->mm->dumpable is not
>needed.

Can you give me an explanation that changed with regard to the
kmod/ptrace fix?

Im private discussuion this possible scenario has been brought up:

> execed setuid
> opens RAW_SOCKET
> setuid back
>
> 	ptrace_attach()
> ...

AFAICS, ptrace_attach() will abort, because the "setuid back" does
not set mm->dumpable back to 1, it is left at 0 and ptrace_attach()
aborts then.

Of course you could do an exec() to get a new mm and then, you may
get an mm->dumpable is set != 0.

But especially in the case of an exec() I think the setuid program
should not go back to the original uid because the user may send
any signal it wants to the suid program then, read it's environment
and do all other sorts of bad stuff e.g. if the program is stupid
enough to not use a safe directory for temp files and such.

If we really need to protect such (IMHO insecure) progam to be
somewhat more secure, we could inherit task_dumpable over exec's,
but I'm not sure what kind of side effects whis would have when
using programs like su and login...

I think by adding such workarounds which are unrelated to kmod,
we would introduce more unwanted side effects insted of fixing
what we alread have because of too strong checks.

Best Regards,
Bernhard Kaindl
