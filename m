Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbUBTSSU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 13:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbUBTSSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 13:18:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:10112 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261278AbUBTSSM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 13:18:12 -0500
Date: Fri, 20 Feb 2004 10:22:56 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
cc: Ingo Molnar <mingo@elte.hu>, Tridge <tridge@samba.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: explicit dcache <-> user-space cache coherency, sys_mark_dir_clean(),
 O_CLEAN
In-Reply-To: <20040220173307.GF8994@mail.shareable.org>
Message-ID: <Pine.LNX.4.58.0402201017370.2533@ppc970.osdl.org>
References: <16435.61622.732939.135127@samba.org> <Pine.LNX.4.58.0402181511420.18038@home.osdl.org>
 <20040219081027.GB4113@mail.shareable.org> <Pine.LNX.4.58.0402190759550.1222@ppc970.osdl.org>
 <20040219163838.GC2308@mail.shareable.org> <Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org>
 <20040219182948.GA3414@mail.shareable.org> <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org>
 <20040220120417.GA4010@elte.hu> <Pine.LNX.4.58.0402200733350.1107@ppc970.osdl.org>
 <20040220173307.GF8994@mail.shareable.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 20 Feb 2004, Jamie Lokier wrote:
> 
> How about this: we clean up dnotify, so it can be used for
> user<->kernel dcache coherency

No can do.

There is no _way_ dnotify can do a race-free update, exactly because any 
user-level state is fundamentally irrelevant because it isn't tested under 
the directory semaphore.

See? You can have a user-level cache, but the flag and the notification 
absolutely has to be under the inode semaphore (and thus in kernel space) 
if you want to avoid all races with unrelated processes.

Now, for samba this isn't necessarily a huge problem, because you can 
basically say "don't do that, then", and just document that you shouldn't 
mess with a samba export using anything but SMB accesses. So in a sense, 
the samba unix-side coherency is nothing more than politeness, and then 
dnotify or similar works fine (by virtue of not being an absolute 
coherency guarantee, just a "best effort").

But then it should be documented as such. It's not coherent, it's only 
"almost coherent".

		Linus
