Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264392AbUAZIfm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 03:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264954AbUAZIfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 03:35:42 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:32778 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S264392AbUAZIfj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 03:35:39 -0500
Message-ID: <4014D440.8060308@aitel.hist.no>
Date: Mon, 26 Jan 2004 09:48:00 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: no, en
MIME-Version: 1.0
To: Steve Youngs <sryoungs@bigpond.net.au>
CC: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: (as177) Add class_device_unregister_wait() and platform_device_unregister_wait()
 to the driver model core
References: <Pine.LNX.4.44L0.0401251224530.947-100000@ida.rowland.org>	<Pine.LNX.4.58.0401251054340.18932@home.osdl.org>	<microsoft-free.877jzfoc5h.fsf@eicq.dnsalias.org>	<20040125222242.A24443@mail.kroptech.com>	<microsoft-free.87hdyjs3h3.fsf@eicq.dnsalias.org>	<200401260521.i0Q5LRha021370@turing-police.cc.vt.edu> <microsoft-free.87d697s18l.fsf@eicq.dnsalias.org>
In-Reply-To: <microsoft-free.87d697s18l.fsf@eicq.dnsalias.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Youngs wrote:
> * Valdis Kletnieks <Valdis.Kletnieks@vt.edu> writes:
> 
>   > On Mon, 26 Jan 2004 15:06:48 +1000, Steve Youngs <sryoungs@bigpond.net.au>  said:
>   >> > A boolean is just a one-bit reference count. If the maximum number of
>   >> > simultaneous 'users' for a given module is one, then a boolean will work.
>   >> > If there is potential for more than one simultaneous user then you need
>   >> > more bits.
>   >> 
>   >> Why?  A module is either being used or it isn't, the number of uses
>   >> shouldn't even come into it.
> 
>   > OK. There's 2 users of the module.  The first one exits.  How does
>   > it (or anything else) know that it's NOT safe to just clear the
>   > in-use bit and clean it up?
> 
> Because the 2nd user is still using the module so its in-use bit
> should still be set.  Remember that when the module was first loaded
> it registered a function with the kernel for testing whether the
> module is in use.

Are you talking about an in-use bit _per module_ or an in-use bit _per user_ ???
Either way has some problems:

In-use bit per module:
This is what everybody thought yopu were talking about up until now.
The problem above is real: There are 2 (or more) users.  One exits.
How does the code know that it can't clear the module's in-use bit?
This one user doesn't know about the other users - how could it?
And there is no "number of users" anywhere because you said you
didn't want that. (The number would be the refcount you tries to get rid of)
Problems, and you haven't provided a solution yet.

Possible solution: Let each user know about all the others so it
can check wether it is ok to clear the in-use bit.  This is unworkable!

In-use bit per user:
Your comment about the second users in-use bit being set seems to imply
that you want an in-use bit per module user.  (instead of per module).
The rule now becomes "no unloading as long as there is at least one
in-use bit set for this module." There may be several such bits.
This seems straightforward enough until you try to manage such
a set of bits.  I might try to unload a module: The unload code checks
the first user bit - it is not set. So that user isn't using the module
now.  Fine.  Check the next bit - not in use there either. And so on.
It is a lengthy procedure, which is dangerous. Think SMP or preempt:
The unload function are checking the last in-use bits (after first checking the first ones
and finding them all zeroed), and then the first
module user sets his bit because he starts using the module again.
This is what we call a "race".  The module unloader comes to the wrong
conclusion - that the module isn't in use - because a user came in and
used it _while_ the bits were being counted.


Solutions:
1. Use locks for manipulating the multiple in-use bits.  Too slow.
2. Use refcounting instead.  Better, because the count can be changed and tested
   atomically, avoiding the above mentioned race _and_ the slow locking.
   There are some cases where even this is too slow, but such a module could
   be made "not unloadable".  To take Linus' example of a packet filter
   module:  It cannot be unloaded on its own because an interrupt can
   make use of it anytime, making refcounting too expensive. 
   Unloading it is possible however, as part
   of unloading the entire TCP/IP module as a whole.  You may then
   reload tcp/ip without packet filtering if you so wish...

> 
> I must be overlooking something 
Sure.

> because I see the answer so clearly.
> Maybe if someone could give me a real world example of a situation
> where it'd be hard/impossible/unsafe to unload a module and I'll see
> if my ideas can be applied.

Try the above.  Or look at actual code people have problems with.  Run tests
(on SMP) and get some surprises.  Basically, the surprises revolve
around several things happening simultaneously.

Note that many modules (but not all of the existing ones) _can_ be made safely unloadable.
Those that can do it simply don't bother - because they have more important
and/or interesting work to do.  Feel free to volunteer for fixing things . . .


Helge Hafting

