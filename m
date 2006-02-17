Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751047AbWBQOqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbWBQOqG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 09:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbWBQOqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 09:46:06 -0500
Received: from [195.23.16.24] ([195.23.16.24]:30171 "EHLO
	linuxbipbip.grupopie.com") by vger.kernel.org with ESMTP
	id S1751047AbWBQOqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 09:46:05 -0500
Message-ID: <43F5E1A4.7060502@grupopie.com>
Date: Fri, 17 Feb 2006 14:45:56 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [SOLVED] Trap flag handling change in 2.6.10-bk5 broke Kylix
 debugger
References: <43F23BB4.8070703@grupopie.com> <Pine.LNX.4.64.0602141243020.3691@g5.osdl.org> <43F36833.9060100@grupopie.com> <43F46B1C.3070208@grupopie.com> <Pine.LNX.4.64.0602161127040.916@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602161127040.916@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Thu, 16 Feb 2006, Paulo Marques wrote:
> [...]
>>I did a workaround in the interposer (remembering that a single step was
>>requested so that it sets the trap flag on the next call to ptrace) and the
>>debugger actually works, but I would prefer to do it better.
> 
> Ok. It does seem like the debugger is using the TF bit in the debuggee to 
> "remember" whether it was single-stepping or not.
> 
> Which is pretty insane.

It sure is :P

>>BTW, is there a good way to do the "test_tsk_thread_flag(child,
>>TIF_SINGLESTEP)" from user space?
> 
> Not really. Except you should just remember that you asked for 
> single-stepping. That, together with the status return on the wait (which 
> tells you why the process stopped - the single-step could have been 
> aborted because of a real fault), should be plenty good enough, and sounds 
> like the natural way to do this.

I think I can do a better interposer, then. I can interpose both the 
ptrace and the wait functions so that I can keep an internal "is being 
single stepped" state for each process being ptrace'd.

> Relying on the TF bit, which is under the control of the debugged 
> application itself, is kind of hokey.

If I understand this correctly, if the kernel had some other way of 
producing a single step (a new flag on newer processors, a timer 
interrupt going on after one cycle, whatever) it might not even set the 
trap flag at all, and still execute perfectly well the ptrace syscalls, 
with all the expected signals being generated, etc.

So this is very much implementation dependent, and the application 
should not rely on internal kernel mechanisms like that...

> So your patch isn't too intrusive, which is nice. The thing that _isn't_ 
> nice about it is that it means that the debugger cannot actually set the 
> TF bit "for real" on the process it is debugging, and it cannot really ask 
> for what the state of the TF bit is (because it will be overshadowed by 
> the debugger single-stepping).

The patch wasn't meant to be used like that. It was just to show what 
was needed to make the debugger happy.

At the very least, the patch needs a lot more comments and a quarantine 
on -mm before it can be used on mainline.

> So I like your patch because it re-instates old (admittedly broken) 
> behaviour without breaking the _internal_ kernel logic (just the "external 
> interface"). And while the old behaviour _was_ broken, being backwards 
> compatible is damn important.
>
> That said, I'd be a lot happier if we could just fix Kylix instead ;(

The interposer is the closest thing we have to "fixing kylix". I think 
most kylix users will be perfectly happy with the interposer and we 
really don't need to change the kernel. They are already used to work 
around problems that arise from the total staleness of the project.

I'll try to send a few posts to Kylix forums with the interposer thing 
and see how well it is accepted.

 From what I've heard, Borland is selling its languages, including 
Delphi and Kylix, so maybe the company that buys it will be more willing 
to properly maintain kylix in the future :)

-- 
Paulo Marques - www.grupopie.com

Pointy-Haired Boss: I don't see anything that could stand in our way.
            Dilbert: Sanity? Reality? The laws of physics?
