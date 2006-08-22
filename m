Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbWHVLgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbWHVLgu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 07:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbWHVLgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 07:36:50 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:15850 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932177AbWHVLgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 07:36:49 -0400
Date: Tue, 22 Aug 2006 20:39:54 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, ebiederm@xmission.com, pj@sgi.com,
       saito.tadashi@soft.fujitsu.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] ps command race fix take2 [4/4] proc_pid_readdir
Message-Id: <20060822203954.9ca154cb.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <p733bbp81p9.fsf@verdi.suse.de>
References: <20060822174302.e97f23d1.kamezawa.hiroyu@jp.fujitsu.com>
	<p733bbp81p9.fsf@verdi.suse.de>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Aug 2006 13:11:30 +0200
Andi Kleen <ak@suse.de> wrote:

> KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> writes:
> 
> > proc_pid_readdir() by list_token.
> > 
> > Remember 'where we are reading' by inserting a token in the list.
> > It seems a bit complicated because of RCU but what we do is very simple.
> > 
> 
> What happens when you have multiple readers at the same time? Can't
> the tokens then be mixed up?
> 
multiple readers will insert their own token to a list. And list_next_rcu_skiptoken()
skips all token (not-data). it's used by next_task().


> >+		/* this small kmalloc() can fail in rare case, but readdir()
> >+		 * is not allowed to return ENOMEM. retrying is reasonable. */
> 
> Who disallows this? Such retry loops are normally discouraged 
> because they can lead to deadlocks in OOM situations.
> I think it would be better to just return ENOMEM.
> 

Hmm, to be honest, not disallowed. but not allowed. The apps don't expect
readdir(3) failed with -ENOMEM. 
But yes, ps command or ls /proc may be caught in the kernel for some time.

-Kame

