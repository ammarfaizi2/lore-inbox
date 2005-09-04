Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750834AbVIDDHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbVIDDHU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 23:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbVIDDHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 23:07:20 -0400
Received: from agminet03.oracle.com ([141.146.126.230]:47530 "EHLO
	agminet03.oracle.com") by vger.kernel.org with ESMTP
	id S1750822AbVIDDHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 23:07:18 -0400
Date: Sat, 3 Sep 2005 20:06:40 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-cluster@redhat.com, wim.coekaerts@oracle.com,
       linux-fsdevel@vger.kernel.org, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [Linux-cluster] Re: GFS, what's remaining
Message-ID: <20050904030640.GL8684@ca-server1.us.oracle.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, linux-cluster@redhat.com,
	wim.coekaerts@oracle.com, linux-fsdevel@vger.kernel.org, ak@suse.de,
	linux-kernel@vger.kernel.org
References: <20050901104620.GA22482@redhat.com> <200509030242.36506.phillips@istop.com> <20050903064633.GB4593@ca-server1.us.oracle.com> <200509031821.27070.phillips@istop.com> <20050904010912.GJ8684@ca-server1.us.oracle.com> <20050903183241.1acca6c9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050903183241.1acca6c9.akpm@osdl.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.10i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 03, 2005 at 06:32:41PM -0700, Andrew Morton wrote:
> If there's duplicated code in there then we should seek to either make the
> code multi-purpose or place the common or reusable parts into a library
> somewhere.

	Regarding sysfs and configfs, that's a whole 'nother
conversation.  I've not yet come up with a function involved that is
identical, but that's a response here for another email.
	Understanding that Daniel is talking about dlmfs, dlmfs is far
more similar to devptsfs, tmpfs, and even sockfs and pipefs than it is
to sysfs.  I don't see him proposing that sockfs and devptsfs be folded
into sysfs.
	dlmfs is *tiny*.  The VFS interface is less than his claimed 500
lines of savings.  The few VFS callbacks do nothing but call DLM
functions.  You'd have to replace this VFS glue with sysfs glue, and
probably save very few lines of code.
	In addition, sysfs cannot support the dlmfs model.  In dlmfs,
mkdir(2) creates a directory representing a DLM domain and mknod(2)
creates the user representation of a lock.  sysfs doesn't support
mkdir(2) or mknod(2) at all.
	More than mkdir() and mknod(), however, dlmfs uses open(2) to
acquire locks from userspace.  O_RDONLY acquires a shared read lock (PR
in VMS parlance).  O_RDWR gets an exclusive lock (X).  O_NONBLOCK is a
trylock.  Here, dlmfs is using the VFS for complete lifetiming.  A lock
is released via close(2).  If a process dies, close(2) happens.  In
other words, ->release() handles all the cleanup for normal and abnormal
termination.
	sysfs does not allow hooking into ->open() or ->release().  So
this model, and the inherent lifetiming that comes with it, cannot be
used.  If dlmfs was changed to use a less intuitive model that fits
sysfs, all the handling of lifetimes and cleanup would have to be added.
This would make it more complex, not less complex.  It would give it a
larger code size, not a smaller one.  In the end, it would be harder to
maintian, less intuitive to use, and larger.

Joel


-- 

"Anything that is too stupid to be spoken is sung."  
        - Voltaire

Joel Becker
Senior Member of Technical Staff
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127

