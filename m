Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267956AbTBSD0R>; Tue, 18 Feb 2003 22:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267951AbTBSDZU>; Tue, 18 Feb 2003 22:25:20 -0500
Received: from dp.samba.org ([66.70.73.150]:63163 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267935AbTBSDY1>;
	Tue, 18 Feb 2003 22:24:27 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Werner Almesberger <wa@almesberger.net>
Cc: Roman Zippel <zippel@linux-m68k.org>, kuznet@ms2.inr.ac.ru,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Is an alternative module interface needed/possible? 
In-reply-to: Your message of "Tue, 18 Feb 2003 14:22:57 -0300."
             <20030218142257.A10210@almesberger.net> 
Date: Wed, 19 Feb 2003 14:30:46 +1100
Message-Id: <20030219033429.9DA592C0CC@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030218142257.A10210@almesberger.net> you write:
> Next round: possible remedies and their side-effects. As
> usual, if you disagree with something, please holler.
> 
> If yes, let's look at possible (and not overly insane) solutions,
> using remove_proc_entry as a case study:
> 
> 1) still don't kfree, and leave it to the user to somehow
>    minimize the damage. (Good luck :-)
> 
> 2) add a callback that is invoked when the proc entry gets
>    deleted. (This callback may be called before remove_proc_entry
>    completes.) Problem: unload/return race for modules.

OK.  For reference, the "state of 2.4" solution (which is also the
"state of 2.5" solution) looks like:

> 	struct proc_dir_entry *de = create_proc_entry(...);
> 	void *my_data;
> 
> 	de->data = my_data = kmalloc(...);
=====>  de->owner = THIS_MODULE;
> 	...
> 	remove_proc_entry(...);
> 	/* what happens with "my_data", formerly known as "de->data" ? */

And have proc_file_operations do the standard owner get and release:

	open: proc_open,
	release: proc_release,

static int proc_open(struct inode *inode, struct file *filp)
{
	struct proc_dir_entry *dp = PDE(inode);
	if (!try_module_get(dp->owner))
		return -ENOENT;
	return 0;
}

static int proc_release(struct inode *inode, struct file *filp)
{
	struct proc_dir_entry *dp = PDE(inode);
	module_put(dp->owner);
	return 0;
}

Now, if remove_proc_entry() is called from module_exit(), the kfree()
works fine, since (1) we wouldn't be in module_exit() if the proc
entry was in used, and (2) the try_module_get() prevents any new
users.

Of course, if you wanted to remove the entry at any other time
(eg. hotplug), this doesn't help you one damn bit (which is kind of
your point).

> 3) change remove_proc_entry or add remove_proc_entry_wait that
>    works like remove_proc_entry, but blocks until the entry is
>    deleted. Problem: may sleep "forever".

This is what network devices do, and what the sockopt registration
code does, too, so this is already in the kernel, too.  It's not
great, but it becomes a noop for the module deregistration stuff.

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
