Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbUBUED0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 23:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbUBUED0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 23:03:26 -0500
Received: from post.tau.ac.il ([132.66.16.11]:55739 "EHLO post.tau.ac.il")
	by vger.kernel.org with ESMTP id S261492AbUBUEDU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 23:03:20 -0500
Date: Sat, 21 Feb 2004 06:02:39 +0200
From: Micha Feigin <michf@post.tau.ac.il>
To: linux-kernel@vger.kernel.org
Subject: Re: laptop mode in 2.4.24
Message-ID: <20040221040239.GH18007@luna.mooo.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <1077276719.6533.16.camel@piro> <20040220134218.GA15112@fpirisp.portsdebalears.com> <87vfm136lu.fsf@ceramic.fifi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87vfm136lu.fsf@ceramic.fifi.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.24.0.4; VDF: 6.24.0.13; host: localhost)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 20, 2004 at 11:15:25AM -0800, Philippe Troin wrote:
> Kiko Piris <kernel@pirispons.net> writes:
> 
> > On 20/02/2004 at 12:32, Cristiano De Michele wrote:
> > 
> > > that is only journaling is writing to my HD
> > > and anyway every minute more or less something
> > > gets written to HD preventing it from being spinned down
> > 
> > IIRC, laptop-mode included in mainline 2.4 does not reset commit
> > interval of ext3 filesystems (as surely did the patch you applied to
> > older kernels).
> > 

Yes, there was a bug with the version included in the official kernel
that it updates the value in the wrong place.

> > You need to remount your filesystems with appropate commit option. You
> > can see the updated control script that's in 2.6.*-mm* trees.
> 

There is one problem with the commit option that you have to reset the
default option manually because there is currently no reset option (you
need to change the script to do a commit=30 when leaving laptop mode).

> Or use this patch...
> 

The problem with this patch is that it overrides the built in commit
option that existed before the laptop mode patch was introduced.

> diff -ruN linux-2.4.24.orig/fs/jbd/transaction.c linux-2.4.24/fs/jbd/transaction.c
> --- linux-2.4.24.orig/fs/jbd/transaction.c	Fri Nov 28 10:26:21 2003
> +++ linux-2.4.24/fs/jbd/transaction.c	Mon Jan 12 12:01:54 2004
> @@ -56,7 +56,11 @@
>  	transaction->t_journal = journal;
>  	transaction->t_state = T_RUNNING;
>  	transaction->t_tid = journal->j_transaction_sequence++;
> -	transaction->t_expires = jiffies + journal->j_commit_interval;
> +	/*
> +	 * have to do it here, otherwise changed age_buffers since boot
> +	 * wont have any effect
> +	 */
> +	transaction->t_expires = jiffies + get_buffer_flushtime();
>  	INIT_LIST_HEAD(&transaction->t_jcb);
>  
>  	/* Set up the commit timer for the new transaction. */

> 
> Phil.

