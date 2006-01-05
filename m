Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWAEXSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWAEXSp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 18:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbWAEXSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 18:18:45 -0500
Received: from smtp.osdl.org ([65.172.181.4]:4318 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750712AbWAEXSo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 18:18:44 -0500
Date: Thu, 5 Jan 2006 15:18:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: tshxiayu@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: what is the state of current after an mm_fault occurs?
Message-Id: <20060105151811.23f82ad8.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0601051228320.7328@schroedinger.engr.sgi.com>
References: <7cd5d4b40601040240n79b2d654t33424e91059988a9@mail.gmail.com>
	<20060104174808.7b882af8.akpm@osdl.org>
	<7cd5d4b40601041920u596551d2h75e167311e9452e4@mail.gmail.com>
	<20060104192334.1e88cfda.akpm@osdl.org>
	<Pine.LNX.4.62.0601051228320.7328@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@engr.sgi.com> wrote:
>
> On Wed, 4 Jan 2006, Andrew Morton wrote:
> 
> > >  You mean in some pagefault place we do schedule()?
> > 
> > We used to - that should no longer be the case.  The TASK_RUNNING thing is
> > probably redundant now.
> 
> The page fault handler calls the page allocator in various places 
> which may sleep. 

That's OK - they should all do set_current_state() before sleeping.  It's
the bare schedule() without previously setting TASK_foo which is the
problem.  We used to do that sort of thing in 2.4 as a lame yield point but
we really shouldn't be doing that at all anywhere any more.

> current may not point to the current process if the page fault handler was 
> called from get_user_pages.

current always points at the current process.  In the situation
ptrace->access_process_vm->get_user_pages->pagefault we'll have mm !=
current->mm.
