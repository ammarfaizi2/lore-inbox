Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbUBTSAs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 13:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbUBTSAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 13:00:48 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51666 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261357AbUBTSAp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 13:00:45 -0500
Date: Fri, 20 Feb 2004 18:00:43 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, Tridge <tridge@samba.org>,
       Jamie Lokier <jamie@shareable.org>, "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] explicit dcache <-> user-space cache coherency, sys_mark_dir_clean(), O_CLEAN
Message-ID: <20040220180043.GL31035@parcelfarce.linux.theplanet.co.uk>
References: <16435.61622.732939.135127@samba.org> <Pine.LNX.4.58.0402181511420.18038@home.osdl.org> <20040219081027.GB4113@mail.shareable.org> <Pine.LNX.4.58.0402190759550.1222@ppc970.osdl.org> <20040219163838.GC2308@mail.shareable.org> <Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org> <20040219182948.GA3414@mail.shareable.org> <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org> <20040220120417.GA4010@elte.hu> <20040220132352.GA11618@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040220132352.GA11618@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 20, 2004 at 02:23:52PM +0100, Ingo Molnar wrote:
 
> i've also attached dir-cache.c, a simple testcode for the new
> functionality. It marks the current directory clean and tries to open
> the "./1" file via O_CLEAN with 1 second delay. Start this in one shell
> and do VFS-namespace modifying ops in another window (eg. "rm -f 2;
> touch 2") and see the dir-cache code react to it - the 'clean' bit is
> lost, and the file open-create does not succeed if the directory is not
> clean.
> 
> there's a new dentry flag that is maintained under the directory's i_sem
> semaphore. (It would be simpler to have the flag on the inode level,
> that way the invalidation could be done as a simple filter to the
> dnotify function.)

IMO putting that in dentry (let alone inode) is fundamentally broken.
Basically, your flag says "somebody in userland knows the contents
of directory".  So your create-if-clean is inherently racy - if we get

task A                       task B                 task C
had learnt the contents
marked clean
                             changed the contents
                                                        had learnt the contents
                                                        marked clean
did create-if-clean, assuming
its knowledge to be accurate

then A will succeed just fine.
