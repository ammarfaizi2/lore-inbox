Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262064AbVANVRY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262064AbVANVRY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 16:17:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbVANVQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 16:16:26 -0500
Received: from alog0392.analogic.com ([208.224.222.168]:20608 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262064AbVANVNR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 16:13:17 -0500
Date: Fri, 14 Jan 2005 16:12:38 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Avishay Traeger <atraeger@cs.sunysb.edu>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Adding a new system call from a module in 2.6
In-Reply-To: <1105735760.3253.23.camel@avishay.fsl.cs.sunysb.edu>
Message-ID: <Pine.LNX.4.61.0501141554530.6747@chaos.analogic.com>
References: <1105735760.3253.23.camel@avishay.fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jan 2005, Avishay Traeger wrote:

> Now that the sys_call_table is no longer exported, what would be the
> best way to add a new system call from a module in 2.6?  I have only
> seen the system call table in assembly code (such as in
> arch/i386/kernel/entry.S) and do not know how to export it.  I know that
> doing this is not recommended, but it would save me a lot of time while
> developing new system calls (no need to recompile kernel and reboot for
> every change).  Thanks in advance for any suggestions.
>
> Avishay Traeger
>

Just add some dummy function pointers at the end of the table
and have them point to a procedure that returns -ENOSYS.

 	existing:

 	.long	sys_request_key
 	.long	sys_keyctl
syscall_table_size = (. -sys_call_table)

 	new:

 	.long	sys_request_key
 	.long	sys_keyctl
mine:	.long	sys_in_syscall
 	.long	sys_in_syscall
 	.long	sys_in_syscall
 	.long	sys_in_syscall

.global	mine
.type	mine,@object

syscall_table_size = (. -sys_call_table)

Export whatever you want to find your entries in your module.
Your module modifies the pointers at will ('mine' is now an
array of 4 pointers). To prevent crashes, save what was in
the pointer you modified and put it back before your module exits!

Just don't expect this to be put into a standard kernel.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
