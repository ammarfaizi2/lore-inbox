Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290843AbSBSJ1V>; Tue, 19 Feb 2002 04:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290953AbSBSJ1L>; Tue, 19 Feb 2002 04:27:11 -0500
Received: from ns.suse.de ([213.95.15.193]:52488 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S290843AbSBSJ1H>;
	Tue, 19 Feb 2002 04:27:07 -0500
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Moving fasync_struct into struct file?
In-Reply-To: <E16d4XU-0003VI-00@wagner.rustcorp.com.au.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 19 Feb 2002 10:27:01 +0100
In-Reply-To: Rusty Russell's message of "19 Feb 2002 08:21:27 +0100"
Message-ID: <p73u1sdlt3u.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> writes:

> Hi guys,
> 
> 	Stephen Rothwell pointed out that if you set up SIGIO from an
> fd, fork, and exit, and PIDs wrap, the new process may be clobbered by
> the SIGIO.  IMVHO the best way to clean this up is to check the
> fasync_list in sys_close, and if pid == filp->f_owner.pid and fd ==
> fasync_list->fa_fd, unregister the SIGIO.

The pid/owner checking at setup time is very broken anyways. Consider a 
threaded application that wants to set up SIGIO from one thread but receive
from another. It has to be root currently to do that.
Best would be to never check anything in F_SETOWN, but just save the 
uid/pid/gid and always check at signal sending time. 

[in addition sk->proc should go and use the fasync list, but that is a 
different thing for now]

-Andi

