Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261674AbVB1QjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbVB1QjZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 11:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbVB1QjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 11:39:25 -0500
Received: from alog0146.analogic.com ([208.224.220.161]:39808 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261674AbVB1QjS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 11:39:18 -0500
Date: Mon, 28 Feb 2005 11:35:29 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Payasam Manohar <pmanohar@lantana.cs.iitm.ernet.in>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: user space program from keyboard driver
In-Reply-To: <Pine.LNX.4.60.0502282118480.2017@lantana.cs.iitm.ernet.in>
Message-ID: <Pine.LNX.4.61.0502281104480.31437@chaos.analogic.com>
References: <Pine.LNX.4.60.0502282118480.2017@lantana.cs.iitm.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Feb 2005, Payasam Manohar wrote:

> hai all,
>   I am a newbie to kernel, I want to work on linux kernel modules.
> My task is to call a user program from keyboard driver under certain 
> conditions. I know that we can call user program using call_usermodehelper(), 
> but we can not call it direcly from driver as it is a interrupt context. So 
> we need to call using schedule_work(). But I need more clarification on these 
> points. How to call user program from the keyboard driver. Please give ur 
> ideas for doing this.
>
> Any small help is appreciated.
>

You don't call a user-mode program from a driver period. It is
possible to screw with kernel internals in such as way to do this,
then unscrew what you've screwed up (sometimes) then state; "See
it can be done.....!". Wrong! Learn that the kernel is designed
to perform tasks on behalf of a user-mode caller. That's what it's
designed for. The kernel doesn't have its own context which is
needed to open files, etc. It has to steal somebody else's context
to do that. It results in a very precarious situation where the
stolen task's context can exit at any time and leave the kernel
in a mess or one steals the context of `init` assuming that
it's not going to quit. The result is a kludge which is
filthy with races.

You should NEVER design anything that runs in the kernel that
expects to call user-mode code. The usermodehelper() code
was used ONLY to get a module for automatic loading of modules.
Even that shouldn't exist and it doesn't need to exist for
the purpose being used. It creates a 'child' of the kernel-
event daemon. If that code was done correctly, none of that
bloat would be in the kernel and fewer persons might expect
to make calls to user-mode code.

The CORRECT design for a user-mode helper requires a user-mode
task called a daemon. That daemon normally sleeps. You can
usually see a lot of such daemons when you execute `ps lae`.
So, you write a program that waits for a signal to wake it
up, perhaps using select() or poll(). It has opened your
driver that exists in the kernel. When your driver wants
your user-mode helper to do something it wakes it up, perhaps
using wake_up_interruptible() or other such kernel functions.
The user-mode helper might make an ioctl() call to find out
what the driver wants done (like reading/writing file data).
The data goes across the driver/user I/O interface like
read() write() or ioctl(). The actual file is open/created/
read/write/closed by the user-mode daemon.

You can wake up a user-mode task from within an interrupt.
However, it only starts executing when it's safe to do
so. In other words, you will NEVER do anything with files
inside an interrupt-service routine.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
