Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132727AbRDILqU>; Mon, 9 Apr 2001 07:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132728AbRDILqI>; Mon, 9 Apr 2001 07:46:08 -0400
Received: from ns.suse.de ([213.95.15.193]:37899 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132727AbRDILqB>;
	Mon, 9 Apr 2001 07:46:01 -0400
Date: Mon, 9 Apr 2001 13:45:50 +0200
From: Andi Kleen <ak@suse.de>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Q: process concurrency and sigaction()
Message-ID: <20010409134550.A26660@gruyere.muc.suse.de>
In-Reply-To: <5.0.2.1.2.20010409115354.00a311a0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <5.0.2.1.2.20010409115354.00a311a0@pop.cus.cam.ac.uk>; from aia21@cam.ac.uk on Mon, Apr 09, 2001 at 12:32:02PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2001 at 12:32:02PM +0100, Anton Altaparmakov wrote:
> 1. On SMP, is it guaranteed that only one (handler vs. normal program code) 
> executes at the same time? (Or is it possible, for example, that signal 
> handler runs on CPU1 while the normal program code is executing on CPU2?)

It's not possible (as long as you don't use multiple threads at least) 

> 
> 2. Is it guaranteed that execution of the normal program code is only 
> resumed when the handler "return"s? (Or is it possible, for example, that 
> while the handler is running, a reschedule occurs in such a way as that 
> normal program code is executed before a subsequent reschedule continues 
> with the handler code?)

It's is guaranteed. A signal handler is really like a private interrupt,
not a special thread.

> If this is correct, the program (non-handler) code can assume for sure that 
> it will never encounter any of the locks held as the handler will have 
> finished and unlocked them before execution is returned.

Yes.

> 
> This would mean 1) I can grab locks in normal program code knowing that 
> they will succeed immediately and 2) the signal handler doesn't need to do 
> any locking at all. Just need to check if lock is held and if it is return 
> immediately as it is impossible that the lock is unlocked while we are in 
> the handler or that any code executes which would necessitate the lock to 
> be held. - This would mean I can use a simple spinlock and use spin_lock() 
> and spin_unlock() in the normal code and just a spin_is_locked() test in 
> the handler. Anyone can see anything wrong with this? (Apart from the usual 

It's ok, but you don't really need to spin. A flag is enough. Also you
could use the signal blocking function (sigprocmask), but they're slightly
more expensive than just setting a flag. 


-Andi
