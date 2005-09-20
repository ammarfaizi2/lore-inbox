Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964880AbVITE0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880AbVITE0N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 00:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964878AbVITE0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 00:26:13 -0400
Received: from smtp101.rog.mail.re2.yahoo.com ([206.190.36.79]:10625 "HELO
	smtp101.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S964880AbVITE0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 00:26:12 -0400
Subject: Re: [patch] stop inotify from sending random DELETE_SELF event
	under load
From: John McCutchan <ttb@tentacle.dhs.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>, Al Viro <viro@ZenIV.linux.org.uk>
In-Reply-To: <Pine.LNX.4.58.0509192054060.2553@g5.osdl.org>
References: <1127177337.15262.6.camel@vertex>
	 <Pine.LNX.4.58.0509191821220.2553@g5.osdl.org>
	 <1127181641.16372.10.camel@vertex>
	 <Pine.LNX.4.58.0509191909220.2553@g5.osdl.org>
	 <1127188015.17794.6.camel@vertex>
	 <Pine.LNX.4.58.0509192054060.2553@g5.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 20 Sep 2005 00:27:52 -0400
Message-Id: <1127190473.18595.2.camel@vertex>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-19 at 21:03 -0700, Linus Torvalds wrote:
> 
> On Mon, 19 Sep 2005, John McCutchan wrote:
> > 
> > I think the name fsnotify_inoderemove is causing some confusion. We only
> > care that some name that is pointing to this inode has been deleted. 
> > Remember, it was suggested as a replacement for fsnotify_unlink. We
> > don't care if the inode is actually going away or not. 
> 
> Ahh. 
> 
> Well, the problem is one of ordering. You could do it unconditionally at 
> the top of d_delete(). If that's ok, then good.
> 
> The problem with that is that the name will still be available for a while 
> afterwards - another process could look it up on another CPU.
> 
> And the _name_ won't be gone until after we've already dropped the inode.  
> Remember? You got oopses because you were trying to access an inode that
> simply didn't exist any more..
> 
> That's where "dentry_iput()" comes in. It's after you've removed the name, 
> but before the inode is gone. However, then you do end up having the 
> problem that you can't tell a delete from a "drop the dcache entry" any 
> more.

Yep, that sums it up. The new patch looks good, I will have it tested.

-- 
John McCutchan <ttb@tentacle.dhs.org>
