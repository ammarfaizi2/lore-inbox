Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbVLIMDF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbVLIMDF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 07:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbVLIMDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 07:03:05 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:60592 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932231AbVLIMDE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 07:03:04 -0500
Date: Fri, 9 Dec 2005 12:02:45 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: JANAK DESAI <janak@us.ibm.com>, chrisw@osdl.org, dwmw2@infradead.org,
       jamie@shareable.org, serue@us.ibm.com, linuxram@us.ibm.com,
       jmorris@namei.org, sds@tycho.nsa.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm 1/5] New system call, unshare
Message-ID: <20051209120244.GL27946@ftp.linux.org.uk>
References: <1134079791.5476.8.camel@hobbs.atlanta.ibm.com> <20051209105502.GA20314@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051209105502.GA20314@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2005 at 11:55:02AM +0100, Ingo Molnar wrote:
> 
> * JANAK DESAI <janak@us.ibm.com> wrote:
> 
> > [PATCH -mm 1/5] unshare system call: System call handler function 
> > sys_unshare
> 
> >+       if (unshare_flags & ~(CLONE_NEWNS | CLONE_VM))
> >+               goto errout;
> 
> just curious, did you consider all the other CLONE_* flags as well, to 
> see whether it makes sense to add unshare support for them?

IMO the right thing to do is
	* accept *all* flags from the very beginning
	* check constraints ("CLONE_NEWNS must be accompanied by CLONE_FS")
and either -EINVAL if they are not satisfied or silently force them.
	* for each unimplemented flag check if we corresponding thing
is shared; -EINVAL otherwise.

Then for each flag we care to implement we should replace such check with
actual unsharing - a patch per flag.

CLONE_FS and CLONE_FILES are *definitely* worth implementing and are
trivial to implement.  The only thing we must take care of is doing
all replacements under task_lock, without dropping it between updates.
I would say that CLONE_SIGHAND is also an obvious candidate for adding.
