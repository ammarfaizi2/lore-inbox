Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262445AbUKDVv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262445AbUKDVv1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 16:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262442AbUKDVv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 16:51:27 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:10762 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP id S262445AbUKDVvP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 16:51:15 -0500
Date: Thu, 4 Nov 2004 21:51:13 +0000
From: John Levon <levon@movementarian.org>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, Jack Steiner <steiner@sgi.com>,
       linux-kernel@vger.kernel.org, edwardsg@sgi.com, dipankar@in.ibm.com
Subject: Re: contention on profile_lock
Message-ID: <20041104215113.GA54024@compsoc.man.ac.uk>
References: <200411021152.16038.jbarnes@engr.sgi.com> <200411041156.23559.jbarnes@engr.sgi.com> <20041104201257.GA14786@holomorphy.com> <200411041249.21718.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411041249.21718.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Graham Coxon - Happiness in Magazines
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1CPpVi-000J1Y-9B*GWTZmMLe5y6*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2004 at 12:49:21PM -0800, Jesse Barnes wrote:

> John pointed out that this breaks modules.  Would registering and 
> unregistering a function pointer thus be module safe?  Dipankar, hopefully 
> you have something better?
> 
> static int timer_start(void)
> {
>  /* Setup the callback pointer */
>  oprofile_timer_notify = oprofile_timer;
>  return 0;
> }

Surely something like (profile.c):

funcptr_t timer_hook;

static int register_timer_hook(funcptr_t hook)
{
	if (timer_hook)
		return -EBUSY;
	timer_hook = hook;
}

static void unregister_timer_hook(funcptr_t hook)
{
	WARN_ON(hook != timer_hook);
	timer_hook = NULL;
	/* make sure all CPUs see the NULL hook */
	synchronize_kernel();
}

john
