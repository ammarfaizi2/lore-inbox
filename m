Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274838AbRIUVI3>; Fri, 21 Sep 2001 17:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274839AbRIUVIT>; Fri, 21 Sep 2001 17:08:19 -0400
Received: from mueller.uncooperative.org ([216.254.102.19]:2062 "EHLO
	mueller.datastacks.com") by vger.kernel.org with ESMTP
	id <S274838AbRIUVID>; Fri, 21 Sep 2001 17:08:03 -0400
Date: Fri, 21 Sep 2001 17:08:28 -0400
From: Crutcher Dunnavant <crutcher@datastacks.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Magic SysRq +# in 2.4.9-ac/2.4.10-pre12
Message-ID: <20010921170828.J8188@mueller.datastacks.com>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3BA8C01D.79FBD7C3@osdlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BA8C01D.79FBD7C3@osdlab.org>; from rddunlap@osdlab.org on Wed, Sep 19, 2001 at 08:56:13AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

++ 19/09/01 08:56 -0700 - Randy.Dunlap:
> (and maybe earlier...)
> 
> Simple problems grow...
> 
> Keith Owens has already noted one problem in sysrq.c (2.4.10-pre12).
> 
> Beginning:
> 
> I have an IBM model KB-9910 keyboard.  When I use
> Alt+SysRQ+number (number: 0...9) on it to change the
> console loglevel, only keys 5 and 6 have the desired
> effect.  I used showkey -s to view the scancodes from
> the other <number> keys, but showkey didn't display
> anything for them.  Any other suggestions?
> 
> 
> For now, I'm just using different (non-number) keys
> to modify the loglevel.
> 
> Anyway, in looking at SysRq loglevel handling in
> 2.4.9-ac (and 2.4.10-pre12), I see that it has been modified
> quite a bit.  Looks extensible, which can be good.
> However, looking over it gave me several nagging questions
> and problems.
> 
> 1.  Was this stuff tested?  How ???
> 
> It always sets console_loglevel and then restores
> console_loglevel from orig_log_level, so Alt+SysRq+#
> handling is severely broken.
> 
> If someone (Crutcher ?) wants to patch it, that's fine.
> If I patched it, I would just add a
>   next_loglevel = -1;
> at the beginning of __handle_sysrq_nolock() and then
> let the loglevel handler(s) set next_loglevel.
> If next_loglevel != -1 at the end of __handle_sysrq_nolock(),
> set console_loglevel to next_loglevel.

I'm looking real close at this right now, and there are a couple of
problems, and a simple, but ugly solution.

The entire reason that console_loglevel is touched _after_ the call to
the second level handler is actually for the loglevel handler's
printout. I was trying to minimize change in the display, but horked it.

Here is the problem.

SysRq events use action messages which get printed by the top level
handler before calling the second level handler, the call line is:

        orig_log_level = console_loglevel;
        console_loglevel = 7;
        printk(KERN_INFO "SysRq : ");

        op_p = __sysrq_get_key_op(key);
	...
        printk ("%s", op_p->action_msg);
        op_p->handler(key, pt_regs, kbd, tty);
	...
        console_loglevel = orig_log_level;


The killer here is the fact that the action message format string does
not carry a newline, allowing people to register strings which leave the
printk state open. The loglevel handler then fills in the loglevel, and
closes the printk state.

There was a time when I thought that was a good idea.

Go ahead, laugh.

Anyway, that sort of unresolved state is bad, and is the source of all
of this song and dance. I think the right answer is to force handlers to
open their own calls to printk, and to keep whats going on with the
console_loglevel and printk buffer nice and clean.

The cost is that messages like this:

SysRq : Loglevel switched to X

will have to become more like this:

SysRq : Loglevel
Loglevel switched to X


Again, appologies, and a patch is forthcoming.

-- 
Crutcher        <crutcher@datastacks.com>
GCS d--- s+:>+:- a-- C++++$ UL++++$ L+++$>++++ !E PS+++ PE Y+ PGP+>++++
    R-(+++) !tv(+++) b+(++++) G+ e>++++ h+>++ r* y+>*$
