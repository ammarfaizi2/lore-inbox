Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbUCZTBA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 14:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264124AbUCZTBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 14:01:00 -0500
Received: from mail.cyclades.com ([64.186.161.6]:18070 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262138AbUCZTAf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 14:00:35 -0500
Date: Fri, 26 Mar 2004 15:39:59 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Fredrik Steen <fredrik@stone.nu>
Cc: linux-kernel@vger.kernel.org, dwmw2@infradead.org
Subject: 2.4: kernel BUG at inode.c:334!
Message-ID: <20040326183959.GC4218@logos.cnet>
References: <90520000.1080235942@flay> <20040326154915.GC3472@logos.cnet> <20040326155806.GD3472@logos.cnet> <20040326154000.GA28389@panic.unixguru.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040326154000.GA28389@panic.unixguru.info>
User-Agent: Mutt/1.5.5.1i
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2004 at 04:40:00PM +0100, Fredrik Steen wrote:
> On [040326 16:20] Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
> >  On Thu, Mar 25, 2004 at 09:32:22AM -0800, Martin J. Bligh wrote:
> >  > http://bugme.osdl.org/show_bug.cgi?id=2367
> >  
> > This is the second bug report of "BUG at inode.c:334" I have seen. 
> > The other one reported by Mika Fischer.
> >  
> > Its indeed not valid for I_LOCK or I_FREEING inode's to be on the 
> > superblock dirty list. I cannot see how this is happening.
> >  
> > Martin, Mika, can you please apply the attached patch and rerun the tests? 
> >  
> > It might give a bit more clue. Thanks.
> >  
> > --- fs/inode.c.orig	2004-03-26 12:30:01.961087616 -0300
> [...]
> 
> I ran the patch and got this:
> inode->i_istate:f
> Kernel BUG at inode.c:340!
> [...]

Hi Fredik, 

It seems Trond already figured it out, we are erroneously moving 
locked inodes to the dirty list. He attached the following patch in 
the bugzilla to fix the problem. Can you please give it a try?

--- linux-2.4.26-up/fs/inode.c.orig	2004-03-19 17:12:46.000000000 -0500
+++ linux-2.4.26-up/fs/inode.c	2004-03-26 13:01:23.000000000 -0500
@@ -319,7 +319,8 @@ void refile_inode(struct inode *inode)
 	if (!inode)
 		return;
 	spin_lock(&inode_lock);
-	__refile_inode(inode);
+	if (!(inode->i_state & I_LOCK))
+		__refile_inode(inode);
 	spin_unlock(&inode_lock);
 }



