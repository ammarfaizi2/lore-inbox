Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbTKVAdO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 19:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbTKVAdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 19:33:14 -0500
Received: from gaia.cela.pl ([213.134.162.11]:36868 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S261769AbTKVAdN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 19:33:13 -0500
Date: Sat, 22 Nov 2003 01:32:34 +0100 (CET)
From: Maciej Zenczykowski <maze@cela.pl>
To: Michael Welles <mike@bangstate.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Using get_cwd inside a module.
In-Reply-To: <3FBEA83B.1060001@bangstate.com>
Message-ID: <Pine.LNX.4.44.0311220123550.4193-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ))(sys_call_table[__NR_getcwd]);
> 
> and use it as I used to:
> 
>          len = getcwd(fullnewname, MAX_PATH);

sys_getcwd is the actual function name.

> Everything built just fine, but whenever I load the module and the above 
> statement runs,  the function returns -14.   This is true on my debian 
> testing box, and also on my YDL 3.0 machine, where the old version (with 
> the cut n' paste code) still runs just fine.

Well -14 is EFAULT - i.e. memory protection failure.  You are passing a 
kernel area pointer (the buf) to a userspace oriented function - it checks 
the access and fails it as the user process doesn't have access to the kernel 
memory of your module (Ie it doesn't realise it is being called from the 
kernel and checks whether the user process currently running would have 
access to your modules memory (likely stack) - obviously it wouldn't and 
thus it fails with -EFAULT.

Don't think there is anyway around this - so you'll probably need to 
cut'n'paste.  On the other hand if such functionality is required it is 
probably best to split the fs/dcache.c sys_getcwd implementation into two 
pieces - the userspace verify wrapper and the function which performs the 
actual work.

Cheers,
MaZe.

PS. you'd basically need to stick everything except the kernel memory 
allocation/freeing in a seperate helper function (probably named 
do_getcwd).  sys_getcwd would alloc page, call helper, free page.
Your code would just directly call the helper.  If you need further help 
just holler.

