Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbTKVMaO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 07:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbTKVMaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 07:30:14 -0500
Received: from [62.233.185.126] ([62.233.185.126]:260 "EHLO
	aclaptop.unregistered.futuro.pl") by vger.kernel.org with ESMTP
	id S262196AbTKVMaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 07:30:10 -0500
From: Szymon =?iso-8859-2?q?Aceda=F1ski?= <accek@poczta.gazeta.pl>
To: Maciej Zenczykowski <maze@cela.pl>
Subject: Re: Using get_cwd inside a module.
Date: Sat, 22 Nov 2003 13:30:00 +0100
User-Agent: KMail/1.5
References: <Pine.LNX.4.44.0311220123550.4193-100000@gaia.cela.pl>
In-Reply-To: <Pine.LNX.4.44.0311220123550.4193-100000@gaia.cela.pl>
Cc: Michael Welles <mike@bangstate.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311221330.01156.accek@poczta.gazeta.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 22 November 2003 01:32, Maciej Zenczykowski wrote:
> > ))(sys_call_table[__NR_getcwd]);
> >
> > and use it as I used to:
> >
> >          len = getcwd(fullnewname, MAX_PATH);
>
> sys_getcwd is the actual function name.
>
> > Everything built just fine, but whenever I load the module and the above
> > statement runs,  the function returns -14.   This is true on my debian
> > testing box, and also on my YDL 3.0 machine, where the old version (with
> > the cut n' paste code) still runs just fine.
>
> Well -14 is EFAULT - i.e. memory protection failure.  You are passing a
> kernel area pointer (the buf) to a userspace oriented function - it checks
> the access and fails it as the user process doesn't have access to the
> kernel memory of your module (Ie it doesn't realise it is being called from
> the kernel and checks whether the user process currently running would have
> access to your modules memory (likely stack) - obviously it wouldn't and
> thus it fails with -EFAULT.
>
> Don't think there is anyway around this - so you'll probably need to
> cut'n'paste.  On the other hand if such functionality is required it is
> probably best to split the fs/dcache.c sys_getcwd implementation into two
> pieces - the userspace verify wrapper and the function which performs the
> actual work.

You can consider doing similar hack as kHTTPd does. It calls temporarily 
set_fs(KERNEL_DS), disabling memlimit checking, then calls userspace-aware 
function, and then restores everything back. Try looking at 
linux/net/khttpd/rfc.c:SendHTTPHeader (it's in 2.4 kernels, but not in 2.6).

Cheers
accek
