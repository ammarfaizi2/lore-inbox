Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262803AbVCPVQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262803AbVCPVQE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 16:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262805AbVCPVQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 16:16:03 -0500
Received: from fire.osdl.org ([65.172.181.4]:3504 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262803AbVCPVPx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 16:15:53 -0500
Date: Wed, 16 Mar 2005 13:15:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: rostedt@goodmis.org
Cc: mingo@elte.hu, rlrevell@joe-job.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 0/3] j_state_lock, j_list_lock, remove-bitlocks
Message-Id: <20050316131521.48b1354e.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503161234350.14460@localhost.localdomain>
References: <Pine.LNX.4.58.0503141024530.697@localhost.localdomain>
	<Pine.LNX.4.58.0503150641030.6456@localhost.localdomain>
	<20050315120053.GA4686@elte.hu>
	<Pine.LNX.4.58.0503150746110.6456@localhost.localdomain>
	<20050315133540.GB4686@elte.hu>
	<Pine.LNX.4.58.0503151150170.6456@localhost.localdomain>
	<20050316085029.GA11414@elte.hu>
	<20050316011510.2a3bdfdb.akpm@osdl.org>
	<20050316095155.GA15080@elte.hu>
	<20050316020408.434cc620.akpm@osdl.org>
	<20050316101906.GA17328@elte.hu>
	<20050316024022.6d5c4706.akpm@osdl.org>
	<Pine.LNX.4.58.0503160600200.11824@localhost.localdomain>
	<20050316031909.08e6cab7.akpm@osdl.org>
	<Pine.LNX.4.58.0503160853360.11824@localhost.localdomain>
	<Pine.LNX.4.58.0503161141001.14087@localhost.localdomain>
	<Pine.LNX.4.58.0503161234350.14460@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> wrote:
>
> /*
>   * Try to acquire jbd_lock_bh_state() against the buffer, when j_list_lock
>  is
>   * held.  For ranking reasons we must trylock.  If we lose, schedule away
>  and
>   * return 0.  j_list_lock is dropped in this case.
>   */
>  static int inverted_lock(journal_t *journal, struct buffer_head *bh)
>  {
>  	if (!jbd_trylock_bh_state(bh)) {
>  		spin_unlock(&journal->j_list_lock);
>  		schedule();
>  		return 0;
>  	}
>  	return 1;
>  }
> 

That's very lame code, that.  The old "I don't know what the heck to do now
so I'll schedule" trick.  Sorry.

>  I guess one way to solve this is to add a wait queue here (before
>  schedule()), and have the one holding the lock to wake up all on the
>  waitqueue when they release it.

yup.  A patch against mainline would be appropriate, please.
