Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267083AbSKSRsd>; Tue, 19 Nov 2002 12:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267027AbSKSRsd>; Tue, 19 Nov 2002 12:48:33 -0500
Received: from chaos.analogic.com ([204.178.40.224]:6020 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S267083AbSKSRsb>; Tue, 19 Nov 2002 12:48:31 -0500
Date: Tue, 19 Nov 2002 12:57:57 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Super user <lnxuser2002@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Killing kernel threads
In-Reply-To: <20021119165847.58163.qmail@web14604.mail.yahoo.com>
Message-ID: <Pine.LNX.3.95.1021119124918.4890A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Nov 2002, Super user wrote:

> Hi,
> 
> Is there any guaranted way to kill kernel threads
> started from loadable modules. I've written a kernel
> module that starts 8 kernel threads and sometimes one
> of them goes into uninterruptible sleep. Is there
> anyway to flush away such threads while unloading
> modules.
> 
> I've tried using kill_proc with SIGKILL but it doesn't
> seem to help.


#ifdef NEW_THREAD_EXIT
	struct completion quit;
#else
	struct semaphore quit;
#endif


In the kernel thread, someplace it can be awakened by a signal:

#ifdef NEW_THREAD_EXIT
	complete_and_exit(&quit, 0);
#else
        up_and_exit(&quit, 0);
#endif


In cleanup_module:

#ifdef NEW_THREAD_EXIT
	wait_for_completion(&quit);
#else
	down(&quit);
#endif


You define NEW_THREAD_EXIT based upon the kernel version. 2.4.18
uses the new syntax.

If you have a lot of threads, you need to have one of these constructs
for each of the threads and don't forget to initialize the semaphores.
Last I knew, this was the way to do it (and it works).


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
   Bush : The Fourth Reich of America


