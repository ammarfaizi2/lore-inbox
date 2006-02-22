Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751412AbWBVUPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbWBVUPv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 15:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbWBVUPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 15:15:51 -0500
Received: from smtp.osdl.org ([65.172.181.4]:8629 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751412AbWBVUPu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 15:15:50 -0500
Date: Wed, 22 Feb 2006 12:12:13 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Joel Becker <Joel.Becker@oracle.com>, gombasg@sztaki.hu, tytso@mit.edu,
       kay.sievers@suse.de, penberg@cs.helsinki.fi, gregkh@suse.de,
       bunk@stusta.de, rml@novell.com, linux-kernel@vger.kernel.org,
       johnstul@us.ibm.com
Subject: Re: 2.6.16-rc4: known regressions
In-Reply-To: <20060222115410.1394ff82.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0602221205040.30245@g5.osdl.org>
References: <20060221225718.GA12480@vrfy.org> <20060221153305.5d0b123f.akpm@osdl.org>
 <20060222000429.GB12480@vrfy.org> <20060221162104.6b8c35b1.akpm@osdl.org>
 <Pine.LNX.4.64.0602211631310.30245@g5.osdl.org> <Pine.LNX.4.64.0602211700580.30245@g5.osdl.org>
 <20060222112158.GB26268@thunk.org> <20060222154820.GJ16648@ca-server1.us.oracle.com>
 <20060222162533.GA30316@thunk.org> <20060222173354.GJ14447@boogie.lpds.sztaki.hu>
 <20060222185923.GL16648@ca-server1.us.oracle.com> <20060222115410.1394ff82.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 Feb 2006, Andrew Morton wrote:
> 
> Yes, I tend to think that insmod should just block until all devices are
> ready to be used.  insmod doesn't just "insert a module".  It runs that
> module's init function.

It really is very hard to accept the "blocking" behaviour.

Some things can take a _loong_ time to be ready, including even requiring 
user intervention. And even when scanning takes "only" a few seconds, if 
there are multiple modules, you really want to scan things in parallel. 

Not finding a disk is often a matter of timing out - not all buses even 
have any real "enumeration" capability, and enumeration literally ends up 
being "try these addresses, and if nothing answers in 500 msec, assume 
it's empty".

Now, 500 msec may not sound very bad, but it all adds up. I get unhappy if 
my bootup is a minute. I'd prefer booting up in a couple of seconds.

Also, how ready do you want things to be? Do you want to know the device 
is there ("disk at physical location X exists"), or do you want to have 
read the UUID off the disk and partitioned it? The latter is what is 
needed for a mount, but it's often a _lot_ more expensive than just 
knowing the disk is there, and it's not even necessarily needed in many 
circumstances.

For example, say that you have more than just a couple of disks attached 
to the system, but many of them are for non-critical stuff. You do not 
necessarily want to wait for them all to spin up at all. You usually only 
care about one of them - the root device.

		Linus
