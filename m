Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263828AbUECSPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263828AbUECSPe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 14:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263842AbUECSPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 14:15:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:13284 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263828AbUECSPR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 14:15:17 -0400
Date: Mon, 3 May 2004 11:14:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jan Kara <jack@ucw.cz>
Cc: linux-kernel@vger.kernel.org, crosser@average.org
Subject: Re: Deadlock problems
Message-Id: <20040503111456.5d7ea77c.akpm@osdl.org>
In-Reply-To: <20040503115837.GC360@atrey.karlin.mff.cuni.cz>
References: <20040503115837.GC360@atrey.karlin.mff.cuni.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kara <jack@ucw.cz> wrote:
>
>   Hi Andrew!
> 
>   I've found hard to fix problem causing deadlock - call path is
> generally following:
>   some operation -> quota code -> read/write quota -> vfs -> needs a page ->
> shrink caches -> free inodes -> free quota -> Ouch... (we need to acquire
> some lock which is already held by the quota code)
>
>    I hope I can fix the problems with quota locks but there's also a
> problem that transaction can be already started when we want to free
> some inodes etc.

yes, there could be any number of deadlocks due to this.

> So I'd like to ask: Is there somewhere documented what
> can/cannot hold a caller using GFP_FS?

I don't understand the question, sorry.  But memory allocations while
holding fs locks should not be using __GFP_FS.

>   One a bit hacky solution would also be to clear GFP_FS from i_mapping
> of quotafile inode. Do you think that is a reasonable solution?

yes, I think that is a reasonable expression of what is going on.

It would be better to rework the filesystems so that it is not necessary,
but I assume that is complex.
