Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267646AbSKTHT6>; Wed, 20 Nov 2002 02:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267643AbSKTHTz>; Wed, 20 Nov 2002 02:19:55 -0500
Received: from dp.samba.org ([66.70.73.150]:49107 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264712AbSKTHTs>;
	Wed, 20 Nov 2002 02:19:48 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alexander Viro <viro@math.psu.edu>, Doug Ledford <dledford@redhat.com>,
       Linux Scsi Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why /dev/sdc1 doesn't show up... 
In-reply-to: Your message of "Mon, 18 Nov 2002 16:08:49 -0800."
             <Pine.LNX.4.44.0211181607120.13381-100000@home.transmeta.com> 
Date: Wed, 20 Nov 2002 07:54:07 +1100
Message-Id: <20021120072653.BC52C2C055@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0211181607120.13381-100000@home.transmeta.com> you write:
> On Tue, 19 Nov 2002, Rusty Russell wrote:
> > 
> > See other posting.  This is a fundamental design decision, and it's
> > not changing.  Sorry.
> 
> Rusty, you take that approach, and the module code flies out of the 
> kernel. 

Linus,

	Sorry, you're right of course.  I should at least have done
something like the "unsafe" wedge which was used for the other
interfaces.  Under the circumstances, I agree with your fix.

> you seem to say that drivers should be broken een if they are perfectly 
> fine and do not have any races as is.

	Linus, I would like an answer: how does one register two /proc
entries?  The following has a race when modular:

	if (!create_proc_entry("foo"...))
		goto fail;
	if (!create_proc_entry("bar"...))
		goto fail_free_foo;
	return 0;

	I sympathize with Al's "we have worse problems, just BUG()
when it happens" approach, but I don't agree with Doug's "that's
clearly broken code!" assertion.  Al wants to split such code into:

	if (!reserve_proc_entry("foo"...))
		goto fail;
	if (!reserve_proc_entry("bar"...))
		goto fail_free_foo;

	/* Now we're safe! */
	activate_proc_entry("foo");
	activate_proc_entry("bar");
	return 0;

Note that this code change is *only* required because the code is
modular.  The code has works perfectly fine in the kernel, and has for
years, and very few people have ever noticed any problem with it.

Now, let's imagine one simple implementation of reserve_proc_entry and
activate_proc_entry: a proc entry gets a flag (call it "live") which
it can use to tell the difference between reserved and activated
entries, and it ignores !live ones.

Now, if you substitute the "live" flag in the proc entry for a "live"
flag in the proc->owner entry, you have the previous module code,
except:

1) You don't need to change all the modules to do two-stage init.
2) You don't need to change all the interfaces to two-stage init.
3) You *do* have problems with complex interfaces which need to do
   something more than just flip the flag to make it "live".

Now do you see why I like this scheme?  For most interfaces, it "just
works": I shall endevour to fix the remaining cases in a way which is
no less clear than current code, and if I fail, hey, we leave your
change in and we're no worse than 2.4.

> If so, then bye bye new module loader.

Fair enough.  Frankly, I just wanted to neaten the module code to
allow other improvements without breaking userspace every time.  But I
felt it wrong to re-implement the same module races: let this be a
valuable lesson to me not to bite off more than I can chew 8(

Thanks for your patience,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
