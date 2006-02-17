Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161140AbWBQBGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161140AbWBQBGm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 20:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161142AbWBQBGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 20:06:42 -0500
Received: from smtp.osdl.org ([65.172.181.4]:29330 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161140AbWBQBGl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 20:06:41 -0500
Date: Thu, 16 Feb 2006 17:06:22 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] i386: fix singlestepping though a syscall
In-Reply-To: <200602161914_MC3-1-B89C-55BE@compuserve.com>
Message-ID: <Pine.LNX.4.64.0602161659590.916@g5.osdl.org>
References: <200602161914_MC3-1-B89C-55BE@compuserve.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 16 Feb 2006, Chuck Ebbert wrote:
>
> Singlestep through a syscall using vsyscall-sysenter had two bugs:
> 
>     1.  Setting TIF_SINGLESTEP is not enough to force
>         do_notify_resume() to be run on return to user;
>         TIF_IRET must also be set.

Interesting, but I think you pinpointed the _real_ bug.

TIF_SINGLESTEP very much should be enough to force do_notify_resume() to 
be run on return to user space.

Sounds like somebody is testing _TIF_WORK_MASK rather than 
_TIF_ALLWORK_MASK.

I'd suspect the "work_pending" case. Looks like we miss testing the TIF 
flags there.

Oh, actually, I think you should just remove the clearing of 
_TIF_SINGLESTEP from _TIF_WORK_MASK. Does that fix the bug.

		Linus
