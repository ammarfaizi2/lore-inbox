Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269059AbUIXXcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269059AbUIXXcO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 19:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269063AbUIXXcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 19:32:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:61365 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269059AbUIXXcM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 19:32:12 -0400
Date: Fri, 24 Sep 2004 16:32:10 -0700
From: Chris Wright <chrisw@osdl.org>
To: Roland McGrath <roland@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix PTRACE_ATTACH race with real parent's wait calls
Message-ID: <20040924163210.X1973@build.pdx.osdl.net>
References: <200409242312.i8ONCJ6w004680@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200409242312.i8ONCJ6w004680@magilla.sf.frob.com>; from roland@redhat.com on Fri, Sep 24, 2004 at 04:12:19PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Roland McGrath (roland@redhat.com) wrote:
> There is a race between PTRACE_ATTACH and the real parent calling wait.
> For a moment, the task is put in PT_PTRACED but with its parent still
> pointing to its real_parent.  In this circumstance, if the real parent
> calls wait without the WUNTRACED flag, he can see a stopped child status,
> which wait should never return without WUNTRACED when the caller is not
> using ptrace.  Here it is not the caller that is using ptrace, but some
> third party.
> 
> This patch avoids this race condition by only setting PT_PTRACED while
> holding the tasklist_lock.
> 
> ptrace_attach used task_lock for this, and a comment in sched.h says that
> it covers ->ptrace.  But in fact, no other users of ->ptrace use task_lock
> for synchronization.  The places that clear ->ptrace all do so while

Well, checking for setuid during exec does.  I wonder if this opens a
race (again, this area is always touchy).  /me looks deeper

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
