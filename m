Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264786AbSK0Uoy>; Wed, 27 Nov 2002 15:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264790AbSK0Uoy>; Wed, 27 Nov 2002 15:44:54 -0500
Received: from chaos.analogic.com ([204.178.40.224]:12928 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S264786AbSK0Uow>; Wed, 27 Nov 2002 15:44:52 -0500
Date: Wed, 27 Nov 2002 15:52:48 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux Geek <linux-geek@hornyaksys.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Question about copy_from/copy_to
In-Reply-To: <3DE52A93.3060404@hornyaksys.com>
Message-ID: <Pine.LNX.3.95.1021127154031.4051A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Nov 2002, Linux Geek wrote:

> I'm trying to write a device driver (module) for one of my customers and 
> have the following problem.
> 
> kernel veraion 2.4.18...
> 
> Memory is allocated (kmalloc) in the "open" call.

Hmmm. What happens if there are multiple tasks that open the same
device? Do you end up with multiple allocations? If so, why? And
How do you keep track of what opened what? Are you using the
private-data pointer in struct file? 

These are all questions that would have to be answered. The 'best'
place to allocate memory, if you are going to re-use it for all
access to the driver, is in init_module(). You free it in
cleanup_module(). That "solves" a lot of race problems.

If you intend to allocate memory every time you call the driver,
you allocate it when you need it, i.e., in read(), write(), etc.
You immediately free it when you are done.

Unless you seg-fault the kernel, you should always have control
after the copy/to/from to release the memory, even if the user
gave you a bad pointer.

So, I would say that it's not a good idea to allocate memory during
an open(). If you some political reason, you are forced to do this,
you need to count the number of open/close operations and only
deallocate memory after the final close. There are atomic-counter
macros you can use for this.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
   Bush : The Fourth Reich of America


