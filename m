Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261933AbVCAPIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261933AbVCAPIm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 10:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbVCAPIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 10:08:42 -0500
Received: from lantana.tenet.res.in ([202.144.28.166]:16282 "EHLO
	lantana.cs.iitm.ernet.in") by vger.kernel.org with ESMTP
	id S261933AbVCAPIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 10:08:15 -0500
Date: Tue, 1 Mar 2005 20:38:01 +0530 (IST)
From: Payasam Manohar <pmanohar@lantana.cs.iitm.ernet.in>
To: linux-os <linux-os@analogic.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: user space program from keyboard driver
In-Reply-To: <Pine.LNX.4.61.0502281104480.31437@chaos.analogic.com>
Message-ID: <Pine.LNX.4.60.0503012031560.13310@lantana.cs.iitm.ernet.in>
References: <Pine.LNX.4.60.0502282118480.2017@lantana.cs.iitm.ernet.in>
 <Pine.LNX.4.61.0502281104480.31437@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Mail-scanner Found to be clean
X-MailScanner-From: pmanohar@lantana.cs.iitm.ernet.in
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>> hai all,
>>   I am a newbie to kernel, I want to work on linux kernel modules.
>> My task is to call a user program from keyboard driver under certain 
>> conditions. I know that we can call user program using 
>> call_usermodehelper(), but we can not call it direcly from driver as it is 
>> a interrupt context. So we need to call using schedule_work(). But I need 
>> more clarification on these points. How to call user program from the 
>> keyboard driver. Please give ur ideas for doing this.
>> 
>> Any small help is appreciated.
>> 
>
> You don't call a user-mode program from a driver period. It is
> possible to screw with kernel internals in such as way to do this,
> then unscrew what you've screwed up (sometimes) then state; "See
> it can be done.....!". Wrong! Learn that the kernel is designed
> to perform tasks on behalf of a user-mode caller. That's what it's
> designed for. The kernel doesn't have its own context which is
> needed to open files, etc. It has to steal somebody else's context
> to do that. It results in a very precarious situation where the
> stolen task's context can exit at any time and leave the kernel
> in a mess or one steals the context of `init` assuming that
> it's not going to quit. The result is a kludge which is
> filthy with races.
>
> You should NEVER design anything that runs in the kernel that
> expects to call user-mode code. The usermodehelper() code
> was used ONLY to get a module for automatic loading of modules.
> Even that shouldn't exist and it doesn't need to exist for
> the purpose being used. It creates a 'child' of the kernel-
> event daemon. If that code was done correctly, none of that
> bloat would be in the kernel and fewer persons might expect
> to make calls to user-mode code.
>
> The CORRECT design for a user-mode helper requires a user-mode
> task called a daemon. That daemon normally sleeps. You can
> usually see a lot of such daemons when you execute `ps lae`.
> So, you write a program that waits for a signal to wake it
> up, perhaps using select() or poll(). It has opened your
> driver that exists in the kernel. When your driver wants
> your user-mode helper to do something it wakes it up, perhaps
> using wake_up_interruptible() or other such kernel functions.
> The user-mode helper might make an ioctl() call to find out
> what the driver wants done (like reading/writing file data).
> The data goes across the driver/user I/O interface like
> read() write() or ioctl(). The actual file is open/created/
> read/write/closed by the user-mode daemon.
>

Hai thank u for ur information. If possible can u please give some 
reference for the above task of creating a daemon and waking up in demand.

Is it possible to call a daemon from keyboard driver on pressing certain 
key, if so how to kill the daemon from the driver itself with some other 
condition.
