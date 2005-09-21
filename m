Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750852AbVIUAwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbVIUAwd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 20:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbVIUAwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 20:52:33 -0400
Received: from smtp104.rog.mail.re2.yahoo.com ([206.190.36.82]:6074 "HELO
	smtp104.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750851AbVIUAwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 20:52:32 -0400
Subject: Re: [patch] stop inotify from sending random DELETE_SELF event
	under load
From: John McCutchan <ttb@tentacle.dhs.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, Ray Lee <ray@madrabbit.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>, Al Viro <viro@ZenIV.linux.org.uk>
In-Reply-To: <Pine.LNX.4.58.0509201728360.2553@g5.osdl.org>
References: <1127190971.18595.5.camel@vertex>
	 <20050920044623.GD7992@ftp.linux.org.uk> <1127191992.19093.3.camel@vertex>
	 <20050920045835.GE7992@ftp.linux.org.uk> <1127192784.19093.7.camel@vertex>
	 <20050920051729.GF7992@ftp.linux.org.uk>
	 <76677C3D-D5E0-4B5A-800F-9503DA09F1C3@tentacle.dhs.org>
	 <20050920163848.GO7992@ftp.linux.org.uk>
	 <1127238257.9940.14.camel@localhost>
	 <Pine.LNX.4.58.0509201108120.2553@g5.osdl.org>
	 <20050920182249.GP7992@ftp.linux.org.uk>
	 <Pine.LNX.4.58.0509201234560.2553@g5.osdl.org>
	 <1127256814.749.5.camel@vertex>
	 <Pine.LNX.4.58.0509201728360.2553@g5.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 20 Sep 2005 20:52:59 -0400
Message-Id: <1127263979.3593.3.camel@vertex>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-20 at 17:33 -0700, Linus Torvalds wrote:
> 
> On Tue, 20 Sep 2005, John McCutchan wrote:
> > 
> > Is there some reason we can't just do this from vfs_unlink
> > 
> > inode = dentry->inode;
> > iget (inode);
> > d_delete (dentry);
> > fsnotify_inoderemove (inode);
> > iput (inode);
> 
> Mainly that it slows things down, and that it's wrong.
> 
> The thing is, I don't consider fsnotify_inoderemove() that important.
> 
> It is a fundamentally broken interface. We should document it as such. It 
> is _senseless_. 
> 
> If you want immediate notification of a filename going away, then check 
> the directory. That is something with a _meaning_. 
> 
> But the whole IN_DELETE_SELF is a STUPID INTERFACE.
> 
> I don't want to have stupid interfaces doing stupid things.
> 
> I'm perfectly willing to give an approximate answer if one is easy to 
> give. But there IS no "exact" answer, as shown by the fact that you didn't 
> even know what the semantics should be in the presense of links and 
> keeping a file open.
> 
> The file still _exists_ when it's open. You can read it, write it, extend
> it, truncate it.. It's only the name that is gone.  So I think delaying 
> the "IN_DELETE_SELF" until you can't do that any more is the RIGHT THING, 
> dammit.
> 
> All of the problems with the interface have come from expecting semantics 
> that simply aren't _valid_.
> 
> Live with the fact that files live on after the name is gone. Embrace it. 
> IT'S HOW THE UNIX WORLD WORKS. Arguing against it is like arguing against 
> gravity.
> 

Alright, at this point I was just throwing out ideas ;). Anyways, you've
convinced me! Now, what about my last patch and your last patch getting
included? 

-- 
John McCutchan <ttb@tentacle.dhs.org>
