Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267813AbTBROCm>; Tue, 18 Feb 2003 09:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267817AbTBROCm>; Tue, 18 Feb 2003 09:02:42 -0500
Received: from almesberger.net ([63.105.73.239]:62984 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S267813AbTBROCc>; Tue, 18 Feb 2003 09:02:32 -0500
Date: Tue, 18 Feb 2003 11:12:15 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, kuznet@ms2.inr.ac.ru,
       davem@redhat.com, kronos@kronoz.cjb.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Is an alternative module interface needed/possible?
Message-ID: <20030218111215.T2092@almesberger.net>
References: <20030217221837.Q2092@almesberger.net> <20030218050349.44B092C04E@lists.samba.org> <20030218042042.R2092@almesberger.net> <Pine.LNX.4.44.0302181252570.1336-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302181252570.1336-100000@serv>; from zippel@linux-m68k.org on Tue, Feb 18, 2003 at 01:06:36PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I think we should limit the Cc:s to Roman, Rusty, the list, and me,
and leave the others in peace. Please yell if you really want that
extra copy :-)

Roman Zippel wrote:
> Basically I can agree with this, although I'd like to avoid that we 
> iterate too much over these steps, as it would too easily divert the 
> discussion to other things, so I'd rather take smaller steps and keep the 
> scope a bit broader.

Good :-) I want to avoid modules as much as possible, because
they've extensively been tackled in the past (which didn't help
much making the interfaces better), and also because they're
just a bit too political an issue.

Okay, this brings us to the issue of broken interfaces. Do we
have agreement that there are cases where interfaces like
remove_proc_entry, in their current state, cannot be used
correctly ?

Example:

static ...callback...(... struct file *file ...)
{
	void *user = PDE(file->f_dentry->d_inode)->data;

	...
	do something with "*user"
	...
}

...
	struct proc_dir_entry *de = create_proc_entry(...);
	void *my_data;

	de->data = my_data = kmalloc(...);
	...
	remove_proc_entry(...);
	/* what happens with "my_data", formerly known as "de->data" ? */

a) kfree it. May cause an oops or other problems if we're in the
   middle of the callback.

b) don't kfree it. So we now have a (hopefully small) memory leak.
   Problem: my_data may point to a lot more than just some tiny
   allocation.

Okay so far ?

(Possible solutions on the next, slid^H^H^H^Hposting :-)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
