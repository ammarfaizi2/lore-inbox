Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263151AbSJBNJJ>; Wed, 2 Oct 2002 09:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263152AbSJBNJI>; Wed, 2 Oct 2002 09:09:08 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40708 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263151AbSJBNJH>;
	Wed, 2 Oct 2002 09:09:07 -0400
Date: Wed, 2 Oct 2002 14:14:35 +0100
From: Matthew Wilcox <willy@debian.org>
To: John Levon <levon@movementarian.org>
Cc: linux-kernel@vger.kernel.org, willy@debian.org
Subject: Re: flock(fd, LOCK_UN) taking 500ms+ ?
Message-ID: <20021002141435.A18377@parcelfarce.linux.theplanet.co.uk>
References: <20021002023901.GA91171@compsoc.man.ac.uk> <20021002032327.GA91947@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021002032327.GA91947@compsoc.man.ac.uk>; from levon@movementarian.org on Wed, Oct 02, 2002 at 04:23:27AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2002 at 04:23:27AM +0100, John Levon wrote:
> --- linux-linus/fs/locks.c	Sat Sep 28 15:56:28 2002
> +++ linux/fs/locks.c	Wed Oct  2 04:15:54 2002
> @@ -727,11 +727,11 @@
>  	}
>  	unlock_kernel();
>  
> -	if (found)
> -		yield();
> -
>  	if (new_fl->fl_type == F_UNLCK)
>  		return 0;
> +
> +	if (found)
> +		yield();
>  
>  	lock_kernel();
>  	for_each_lock(inode, before) {
> 
> "fixes" the problem (a simultaneous kernel compile is going on; it's a
> 2-way SMP machine). What is the yield for ? What's the right fix (if
> any) ? This turns our app's main loop from a second or two into a
> 90-second behemoth.

I'm pretty sure this is correct.  There's no particular reason to yield()
if we're unlocking.

I wonder if yield() is the correct call to make anyway.  We certainly need
to schedule() to allow any higher-priority task the opportunity to run.
But if we're the highest-priority task downgrading our write-lock to
a read-lock which permits other tasks the opportunity to run, i see no
reason we should _yield_ to them.

Scheduling is a bit of a black art as far as I'm concerned.  Someone with
a bit more experience care to comment?

-- 
Revolutions do not require corporate support.
