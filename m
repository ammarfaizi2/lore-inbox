Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267900AbTBRROp>; Tue, 18 Feb 2003 12:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267927AbTBRROp>; Tue, 18 Feb 2003 12:14:45 -0500
Received: from almesberger.net ([63.105.73.239]:42249 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S267900AbTBRRNT>; Tue, 18 Feb 2003 12:13:19 -0500
Date: Tue, 18 Feb 2003 14:22:57 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, kuznet@ms2.inr.ac.ru,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Is an alternative module interface needed/possible?
Message-ID: <20030218142257.A10210@almesberger.net>
References: <20030217221837.Q2092@almesberger.net> <20030218050349.44B092C04E@lists.samba.org> <20030218042042.R2092@almesberger.net> <Pine.LNX.4.44.0302181252570.1336-100000@serv> <20030218111215.T2092@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030218111215.T2092@almesberger.net>; from wa@almesberger.net on Tue, Feb 18, 2003 at 11:12:15AM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Next round: possible remedies and their side-effects. As
usual, if you disagree with something, please holler.

If yes, let's look at possible (and not overly insane) solutions,
using remove_proc_entry as a case study:

1) still don't kfree, and leave it to the user to somehow
   minimize the damage. (Good luck :-)

2) add a callback that is invoked when the proc entry gets
   deleted. (This callback may be called before remove_proc_entry
   completes.) Problem: unload/return race for modules.

3) change remove_proc_entry or add remove_proc_entry_wait that
   works like remove_proc_entry, but blocks until the entry is
   deleted. Problem: may sleep "forever".

4) make remove_proc_entry return an indication of whether the
   entry was successfully removed or not. Problem: if it
   wasn't, what can we do then ?

5) like above, but don't remove the entry if we can't do it
   immediately. Problem: there's no notification for when we
   should try again, so we'd have to poll.

6) export the lookup mechanism, and let the caller poll for
   removal. Problem: races with creation of a new entry with
   the same name.

7) transfer ownership of de->data to procfs, and set some
   (possibly configurable) destruction policy (e.g. always
   kfree, or such). Similar to 2), but less flexible.

Any more ?

I think that most programmers would intuitively expect an
interface of type 3). In cases where we can't sleep, either
type 2) or type 5) would be common choices.

Does that sound reasonable so far ?

I'll wait a little until I continue with ways for dealing
with the side-effects.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
