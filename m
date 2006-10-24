Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161028AbWJXMqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161028AbWJXMqt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 08:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161048AbWJXMqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 08:46:49 -0400
Received: from 87-237-56-54.northerncolo.co.uk ([87.237.56.54]:57990 "EHLO
	totally.trollied.org") by vger.kernel.org with ESMTP
	id S1161028AbWJXMqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 08:46:48 -0400
Date: Tue, 24 Oct 2006 13:46:50 +0100
From: John Levon <levon@movementarian.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mike Kravetz <kravetz@us.ibm.com>, phil.el@wanadoo.fr,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       oprofile-list@lists.sourceforge.net
Subject: Re: oprofile can cause an NMI to schedule (was: [RT] scheduling and oprofile)
Message-ID: <20061024124650.GA2668@totally.trollied.org>
References: <20061023212307.GA21498@monkey.beaverton.ibm.com> <1161656674.13276.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161656674.13276.17.camel@localhost.localdomain>
X-Url: http://www.movementarian.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2006 at 10:24:34PM -0400, Steven Rostedt wrote:

> > caller is rt_mutex_slowlock+0x156/0x1dd
> >  [<c032051a>] schedule+0x65/0xd2 (8)
> >  [<c0321338>] rt_mutex_slowlock+0x156/0x1dd (12)
> >  [<c032142a>] rt_mutex_lock+0x24/0x28 (72)
> >  [<c0134904>] rt_down_read+0x38/0x3b (20)
> >  [<c0322a89>] do_page_fault+0xe3/0x52d (12)
> >  [<c03229a6>] do_page_fault+0x0/0x52d (76)
> >  [<c01033bb>] error_code+0x4f/0x54 (8)
> >  [<c01ce6d0>] __copy_from_user_ll+0x55/0x7c (44)
> >  [<f89be7ef>] dump_user_backtrace+0x2e/0x56 [oprofile] (24)
> >  [<c0134869>] rt_up_read+0x3e/0x41 (20)
> >  [<f89be864>] x86_backtrace+0x4a/0x5a [oprofile] (20)
> >  [<f89bd53a>] oprofile_add_sample+0x73/0x89 [oprofile] (20)
> >  [<f89beea3>] athlon_check_ctrs+0x22/0x4a [oprofile] (32)
> >  [<f89be8c5>] nmi_callback+0x18/0x1b [oprofile] (28)
> >  [<c01041ff>] do_nmi+0x24/0x33 (12)
> >  [<c0103462>] nmi_stack_correct+0x1d/0x22 (16)
> > 
> > It seems strange to me that oprofile would be calling
> > '__copy_from_user_ll' in this context.  I can see why the
> > changes made for RT locking expose this.  But, doesn't this
> > issue also exist on non-RT (default) kernels?  What happens
> > when we generate a page fault in this context on non-RT kernels?
> > 
> 
> As Mike has pointed out here, oprofile _can_ cause the nmi to schedule.

in_atomic() is supposed to be true in this context, so the test in
do_page_fault() catches it.

john
