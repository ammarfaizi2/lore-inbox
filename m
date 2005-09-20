Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964865AbVITDpe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbVITDpe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 23:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964866AbVITDpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 23:45:34 -0400
Received: from smtp102.rog.mail.re2.yahoo.com ([206.190.36.80]:58711 "HELO
	smtp102.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S964865AbVITDpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 23:45:34 -0400
Subject: Re: [patch] stop inotify from sending random DELETE_SELF event
	under load
From: John McCutchan <ttb@tentacle.dhs.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>, Al Viro <viro@ZenIV.linux.org.uk>
In-Reply-To: <Pine.LNX.4.58.0509191909220.2553@g5.osdl.org>
References: <1127177337.15262.6.camel@vertex>
	 <Pine.LNX.4.58.0509191821220.2553@g5.osdl.org>
	 <1127181641.16372.10.camel@vertex>
	 <Pine.LNX.4.58.0509191909220.2553@g5.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 19 Sep 2005 23:46:55 -0400
Message-Id: <1127188015.17794.6.camel@vertex>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-19 at 19:20 -0700, Linus Torvalds wrote:
> 
> On Mon, 19 Sep 2005, John McCutchan wrote:
> > 
> > To quote you:
> 
> Yeah, sometimes I'm more right than other times. That wasn't one of them.
> 
> It's actually _almost_ right. The problem being that dentry_iput() is 
> called for non-delete events too.
> 
> However, your patch is _worse_. Your patch will cause it not to report the 
> delete at all, because what will happen is that if the delete() is done 
> while somebody else has a pointer to the dentry, then we won't call 
> "dentry_iput()" with a "delete" AT ALL. We will only call it later when 
> the _other_ person (who didn't do a delete) releases the dentry.
> 
> See? It's very very wrong to send a flag that depends on the call-chain, 
> because the call-chain is _not_ what determines whether the inode gets 
> deleted or not.
> 

Yeah, I see this now. 

> The only way to know whether it gets deleted or not is whan the actual
> i_nlink goes down to 0, and the inode gets deleted. Ie exactly the
> generic_delete_inode() case.
> 
> But if you keep a reference to the inode, that will never actually happen. 
> Hmm.
> 
> Who wants that inode delete event anyway? It's fundamentally harder than 
> removing a name, partly because of the delayed delete, partly because an 
> inode may be reachable multiple ways.
> 

I think the name fsnotify_inoderemove is causing some confusion. We only
care that some name that is pointing to this inode has been deleted. 
Remember, it was suggested as a replacement for fsnotify_unlink. We
don't care if the inode is actually going away or not. 

> Maybe this patch instead? It's not going to be reliable on networked 
> filesystems, though. Nothing is.
> 

Thanks, I will have it tested.

-- 
John McCutchan <ttb@tentacle.dhs.org>
