Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269009AbTBWXYX>; Sun, 23 Feb 2003 18:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269012AbTBWXYX>; Sun, 23 Feb 2003 18:24:23 -0500
Received: from pool-129-44-54-71.ny325.east.verizon.net ([129.44.54.71]:49158
	"EHLO arizona.koconnor.net") by vger.kernel.org with ESMTP
	id <S269009AbTBWXYV>; Sun, 23 Feb 2003 18:24:21 -0500
Date: Sun, 23 Feb 2003 18:34:33 -0500
From: "Kevin O'Connor" <kevin@koconnor.net>
To: Werner Almesberger <wa@almesberger.net>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Is an alternative module interface needed/possible?
Message-ID: <20030223183433.A16972@arizona.localdomain>
References: <20030217221837.Q2092@almesberger.net> <20030218050349.44B092C04E@lists.samba.org> <20030218042042.R2092@almesberger.net> <Pine.LNX.4.44.0302181252570.1336-100000@serv> <20030218111215.T2092@almesberger.net> <20030218142257.A10210@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030218142257.A10210@almesberger.net>; from wa@almesberger.net on Tue, Feb 18, 2003 at 02:22:57PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2003 at 02:22:57PM -0300, Werner Almesberger wrote:
> Next round: possible remedies and their side-effects. As
> usual, if you disagree with something, please holler.
> 
> If yes, let's look at possible (and not overly insane) solutions,
> using remove_proc_entry as a case study:

Hi Werner,

Thanks for putting together this list; I've been following this thread for
a while and it seems that the discussion always deteriorates into
semantics.  Anyway, I think there is an eighth possible solution to the
list you proposed.

Just to be specific, the requirements for the proc entry stuff are:

a) a mechanism needs to be defined to indicate that the entry is no longer
needed (something that starts the delete process -- ie, remove_proc_entry),

b) the code must conform to a system that ensures de->data will not be used
after the "release" code is executed, and

c) the "release" code must be eventually executed.

Assuming these requirements are really requirements (your options 1 and 4
don't seem to meet these) then an "eighth" solution is:

8) Have the unregister code (remove_proc_entry) set an external flag (eg,
   de->data_is_there), and update all users of de->data to check the flag
   before following the pointer.

Option 8 may not qualify as "sane", but I think it is important to add it
because it is what the module code is currently using.  Thus, one need not
look at the module stuff as a "special case", but as a general (if
complicated) resource management solution.

Finally, one could probably apply any of the "options" for any dynamically
allocated memory.  It is interesting that Linus seems to prefer option 2/7
(from the recent kobject work and CodingStyle).

If I've missed something, please let me know.
-Kevin

> 1) still don't kfree, and leave it to the user to somehow
>    minimize the damage. (Good luck :-)
> 
> 2) add a callback that is invoked when the proc entry gets
>    deleted. (This callback may be called before remove_proc_entry
>    completes.) Problem: unload/return race for modules.
> 
> 3) change remove_proc_entry or add remove_proc_entry_wait that
>    works like remove_proc_entry, but blocks until the entry is
>    deleted. Problem: may sleep "forever".
> 
> 4) make remove_proc_entry return an indication of whether the
>    entry was successfully removed or not. Problem: if it
>    wasn't, what can we do then ?
> 
> 5) like above, but don't remove the entry if we can't do it
>    immediately. Problem: there's no notification for when we
>    should try again, so we'd have to poll.
> 
> 6) export the lookup mechanism, and let the caller poll for
>    removal. Problem: races with creation of a new entry with
>    the same name.
> 
> 7) transfer ownership of de->data to procfs, and set some
>    (possibly configurable) destruction policy (e.g. always
>    kfree, or such). Similar to 2), but less flexible.

-- 
 ------------------------------------------------------------------------
 | Kevin O'Connor                     "BTW, IMHO we need a FAQ for      |
 | kevin@koconnor.net                  'IMHO', 'FAQ', 'BTW', etc. !"    |
 ------------------------------------------------------------------------
