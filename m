Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262870AbUCRSre (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 13:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262877AbUCRSre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 13:47:34 -0500
Received: from fw.osdl.org ([65.172.181.6]:51913 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262870AbUCRSr2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 13:47:28 -0500
Date: Thu, 18 Mar 2004 10:47:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: mjy@geizhals.at, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PREEMPT and server workloads
Message-Id: <20040318104729.0de30117.akpm@osdl.org>
In-Reply-To: <20040318183844.GD32573@dualathlon.random>
References: <40591EC1.1060204@geizhals.at>
	<20040318060358.GC29530@dualathlon.random>
	<20040318015004.227fddfb.akpm@osdl.org>
	<20040318145129.GA2246@dualathlon.random>
	<20040318093902.3513903e.akpm@osdl.org>
	<20040318175855.GB2536@dualathlon.random>
	<20040318102623.04e4fadb.akpm@osdl.org>
	<20040318183844.GD32573@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> > hand so we should only fall into the kmap() if the page was suddenly stolen
>  > again.
> 
>  Oh so you mean the page fault insn't only interrupting the copy-user
>  atomically, but the page fault is also going to sleep and pagein the
>  page? I though you didn't want to allow other tasks to steal the kmap
>  before you effectively run the kunmap_atomic. I see it can be safe if
>  kunmap_atomic is a noop though, but you're effectively allowing
>  scheduling inside a kmap this way.

No, we don't schedule with the atomic kmap held.  What I meant was:

	get_user(page);		/* fault it in */
	kmap_atomic(page);
	if (copy_from_user(page))
		goto slow_path;
	kunmap_atomic(page);

	...

slow_path:
	kunmap_atomic(page);
	kmap(page);
	copy_from_user(page);
	kunmap(page);


slow_path is only taken if the vm (or truncate in the case of read())
unmapped the page in that little window after the get_user().
