Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964882AbVIMQvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964882AbVIMQvN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 12:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbVIMQvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 12:51:13 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:32946 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964882AbVIMQvL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 12:51:11 -0400
Date: Tue, 13 Sep 2005 17:51:02 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Sripathi Kodi <sripathik@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, patrics@interia.pl,
       Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH 2.6.13.1] Patch for invisible threads
Message-ID: <20050913165102.GR25261@ZenIV.linux.org.uk>
References: <4325BEF3.2070901@in.ibm.com> <20050912134954.7bbd15b2.akpm@osdl.org> <4326CFE2.6000908@in.ibm.com> <Pine.LNX.4.58.0509130744070.3351@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509130744070.3351@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2005 at 07:53:40AM -0700, Linus Torvalds wrote:

> So this patch is _wrong_.

Definitely.
 
> I think the problem is "proc_check_root()", which just refuses to do a lot 
> of things without a fs. Many of those things are unnecessary, afaik - we 
> should allow it. But allowing it means that some other paths may need more 
> checking..
>
> So you can _try_ to just make proc_check_root() return 0 when 
> proc_root_link() returns an error...

I very much doubt the correctness of that.

The real problem here is obvious: it's about permissions on /proc/<pid>/task.
That's where the things go wrong - we use proc_permission() for it and we
have group leader as associated task.

Note that stuff _in_ proc/<pid>/task will keep working just fine, if we
manage to get to it - there we have other threads as associated tasks,
so everything works as it should.

What we need is to decide what kind of access control do we really want on
/proc/<pid>/task.  That's it.
