Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267528AbUJPELg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267528AbUJPELg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 00:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267561AbUJPELg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 00:11:36 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:9869 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267528AbUJPELc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 00:11:32 -0400
DomainKey-Signature: a=rsa-sha1; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=IncanizSZx/z9UMMsEJ435Dvu4ZR3ooC3C7ax/HPuW8z1yzhZzdKAEfbv9/fhkdaXw9r5hnpswFuGWZquR2RTLXfp1D9B7LeayRPW2ayTdY5JQH8VPM2hhA0HEEccCaEj34DMD1ycGm7XpqQNL3aYkG7j8cCjdQTQDJ/Kfiud8g
Message-ID: <82fa66380410152111143f75ec@mail.gmail.com>
Date: Sat, 16 Oct 2004 14:11:32 +1000
From: Simon Kissane <skissane@gmail.com>
Reply-To: Simon Kissane <skissane@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Running user processes in kernel mode; Java and .NET support in kernel
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have some ideas, which I think:
-	Wouldn't be too hard to implement,
-	And would give Linux a distinctive advantage over competing
platforms such as Solaris or Windows, when executing Java or .NET code

Basic functionality:
-	Enable some user processes to execute user code in kernel mode. This
would reduce the need for context switches, especially for programs
which spend a great deal of time making system calls.
-	However, this could threaten system stability if the user process'
code had bugs in it. So the functionality ought to be restricted only
to trusted processes.

So lets define a new capability: CAP_KERNELMODE meaning the process
can enter kernel mode.

New system call: syskernelmode(int flag). Provides a means of a user
process to enter/exit kernel mode execution. Flag turns kernel mode
on/off. Only can be called by processes with the CAP_KERNELMODE
capability.

Mono & Java

The kernel of an operating system provides isolation and protection
between processes, partially since traditional programming languages
such as C provide no such protection. However, some newer languages
such as Java and Mono/CLI/.NET do. Thus, for programs written in such
a system, it should be safe (assuming the security and safety
mechanisms provided by the language are sufficiently complete and the
runtime is bug-free) to run them in kernel mode, without the OS'
protection mechanisms being exercised, relying instead on the
guarantees of safety provided by the compiler.

Also, in both Java and the CLI, the ability is provided to develop
software in a mixture of Java/C#/whatever, and traditional programming
languages such as C, which do not provide the same safety guarantees.
Thus the same process may contain some code which we want to allow to
run in kernel mode, and some code which we don't.

So, I would propose controlling the ability to run in kernel mode on a
page-by-page basis. So with each page, the following flag would be
associated or not: KERNELTRUST, indicating the code contained in this
page is trusted to run in kernel mode. Now, JITed bytecode can be put
in KERNELTRUST pages, and allowed to run in kernel mode by calling
syskernelmode; but native code pages will not have KERNELTRUST, and
attempts by them to call syskernelmode will fail.

A few other considerations: 
-	As well as CAP_KERNELMODE capability, we should have another one
CAP_KRNLMODEBYPAGE, indicating that the CAP_KERNELMODE capability
extending only to KERNELTRUST pages of a process.
-	KERNELTRUST pages should all be set read/only, so native code cannot
overwrite them.

One problem is preventing native code from jumping to the middle of a
function in a KERNELTRUST page; it should only be able to reach them
through valid entry points. One solution might be to have a
syskerneljump(void * address) system call, which enters kernel mode
and jumps to address, but only if address is declared in executable
file to be a valid entry point in a KERNELTRUST page. Then, a
KERNELTRUST page would only be privileged if entered via
syskerneljump, which checks that a valid entry point is being called.

Finally, attributes can be added to functions in the programming
language (Java or C#)
* AlwaysKernelMode – function should always execute in kernel mode; if
called in user mode, context switch to kernel mode.
* AlwaysUserMode – function should always execute in user mode; if
called in kernel mode, context switch to user mode.
* UseCallersMode – execute in whatever mode (kernel or user) the caller was in.

If a process has CAP_KRNLMODEBYPAGE, these attributes should only be
respected for native code JITed for verifiable managed code (to use
the CLI terminology); but if CAP_KERNELMODE is set, the attributes can
be respected for native (i.e. C language) code also.

Cheers
Simon Kissane
