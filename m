Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261938AbUCQSen (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 13:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbUCQSen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 13:34:43 -0500
Received: from chaos.analogic.com ([204.178.40.224]:29581 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261938AbUCQSej
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 13:34:39 -0500
Date: Wed, 17 Mar 2004 13:36:59 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: VINOD GOPAL <vinod_gopal74@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: arithmetic functions for linux driver
In-Reply-To: <20040317175939.75460.qmail@web60705.mail.yahoo.com>
Message-ID: <Pine.LNX.4.53.0403171317430.19593@chaos>
References: <20040317175939.75460.qmail@web60705.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Mar 2004, VINOD GOPAL wrote:

> Hi,
>  I am new to linux world and this mailing list.
>
>  I need to use the arithmetic functions like sin, cos,
> exp, log, etc in linux device driver.
>
>  On search read , not to use libm from kernel driver
> as it will harm the fpu registers.
>
>   Do you have any insight how to support these
> functions in linux driver or any code that is
> available which I can make use of?
>
> thanks
> vinod

There are at least three problems.
(1) The kernel does not save and restore FPU registers across
system calls, only context-switches. This means that you will
probably break some user-mode code that is using the FPU.
You could, of course, save then restore the FPU state in your
code. However, there are other problems, read on.

(2) Some versions of the GCC compiler rely on the floating-
point library and do not generate FPU instructions in-line.
You absolutely-positively cannot link your kernel code against
such a library. The shared libraries don't even exist from
within the kernel, and the static library assumes user-mode
code.

(3) The use of FP within the kernel means that you have
lost the reason for a kernel module. Any such code must
execute in user-mode. The Unix/Linux way involves a
task called a daemon. Such a task does all the user-mode
stuff like floating-point math and file-I/O. It interfaces
with your driver either through the POSIX API (open/close/read/write),
/proc, or sockets.

A Unix/Linux "driver" is NOT anything like a Windows "driver".
Most Windows drivers are not drivers at all, but Libraries!
Such Libraries run in user-mode. Making such a library
in Linux is easy, just compile your library-code and link
against it. You can use any resources other user-mode code
can use.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


