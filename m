Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274848AbRIUVoH>; Fri, 21 Sep 2001 17:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274847AbRIUVn4>; Fri, 21 Sep 2001 17:43:56 -0400
Received: from air-1.osdlab.org ([65.201.151.5]:2830 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S274846AbRIUVni>;
	Fri, 21 Sep 2001 17:43:38 -0400
Message-ID: <3BABB42A.6D17F44E@osdlab.org>
Date: Fri, 21 Sep 2001 14:42:02 -0700
From: "Randy.Dunlap" <rddunlap@osdlab.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Crutcher Dunnavant <crutcher@datastacks.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Magic SysRq +# in 2.4.9-ac/2.4.10-pre12
In-Reply-To: <3BA8C01D.79FBD7C3@osdlab.org> <20010921170828.J8188@mueller.datastacks.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Crutcher Dunnavant wrote:
> 
> I'm looking real close at this right now, and there are a couple of
> problems, and a simple, but ugly solution.
> 
> The entire reason that console_loglevel is touched _after_ the call to
> the second level handler is actually for the loglevel handler's
> printout. I was trying to minimize change in the display, but horked it.
> 
> Here is the problem.
> 
> SysRq events use action messages which get printed by the top level
> handler before calling the second level handler, the call line is:
> 
>         orig_log_level = console_loglevel;
>         console_loglevel = 7;
>         printk(KERN_INFO "SysRq : ");
> 
>         op_p = __sysrq_get_key_op(key);
>         ...
>         printk ("%s", op_p->action_msg);
>         op_p->handler(key, pt_regs, kbd, tty);
>         ...
>         console_loglevel = orig_log_level;
> 
> The killer here is the fact that the action message format string does
> not carry a newline, allowing people to register strings which leave the
> printk state open. The loglevel handler then fills in the loglevel, and
> closes the printk state.
> 
> There was a time when I thought that was a good idea.
> 
> Go ahead, laugh.
> 
> Anyway, that sort of unresolved state is bad, and is the source of all
> of this song and dance. I think the right answer is to force handlers to
> open their own calls to printk, and to keep whats going on with the
> console_loglevel and printk buffer nice and clean.
> 
> The cost is that messages like this:
> 
> SysRq : Loglevel switched to X
> 
> will have to become more like this:
> 
> SysRq : Loglevel
> Loglevel switched to X
> 
> Again, appologies, and a patch is forthcoming.

I've posted a patch (and copied you on it).
It's in 2.4.9-ac13.
You are welcome to post patches anyway, of course.

~Randy
