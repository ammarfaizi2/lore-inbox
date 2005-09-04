Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750904AbVIDEMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904AbVIDEMg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 00:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750926AbVIDEMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 00:12:36 -0400
Received: from agminet04.oracle.com ([141.146.126.231]:59250 "EHLO
	agminet04.oracle.com") by vger.kernel.org with ESMTP
	id S1750895AbVIDEMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 00:12:35 -0400
Date: Sat, 3 Sep 2005 21:12:24 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Andrew Morton <akpm@osdl.org>, phillips@istop.com,
       linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [RFC][PATCH 1 of 4] Configfs is really sysfs
Message-ID: <20050904041224.GP8684@ca-server1.us.oracle.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, phillips@istop.com,
	linux-kernel@vger.kernel.org, greg@kroah.com
References: <200508310854.40482.phillips@istop.com> <20050830231307.GE22068@insight.us.oracle.com> <20050830162846.5f6d0a53.akpm@osdl.org> <20050904035341.GO8684@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050904035341.GO8684@ca-server1.us.oracle.com>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.10i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2005 at 04:28:46PM -0700, Andrew Morton wrote:
> Sure, but all that copying-and-pasting really sucks.  I'm sure there's some
> way of providing the slightly different semantics from the same codebase?

	What about the backing store?  Specifically, sysfs_dirent vs
configfs_dirent.
	The structures are almost identical.  What's different?
configfs has a list of symlinks, as these are hard linkages and involve
pinning and reference counting.  So, to merge the structures, you have
to add two pointers (a list_head) to every sysfs object.
	Allocating, initializing, and freeing them really does appear to
be virtually identical.  The functions that call the creation are very
different, but they could call the same thing.  There are more types of
things in configfs, so all shared calls would have to be able to handle
them.
	Oh, but the get_name() functions, the one that return the string
name of a _dirent, are very different.  So you'd have to add another
pointer to the structure, a ->get_name() callback.  That's an additional
pointer for every sysfs object.
	The attach_attr() functions are different.  Some of that is the
BIN_ATTR type of sysfs, which configfs doesn't and shouldn't have.  In
that case, the code still works, as BIN_ATTR test wouldn't succeed.
They configure dentry_ops, which are different in sysfs and configfs.
So the API would have to change to specify the appropriate dentry_ops.
	This is certainly not insurmountable.  I don't know what you'd
call it, fs/libfs/backing_store.c?  I'm interested in what the sysfs
folks have to say on this, and how much they'd like to help.

Joel

-- 

A good programming language should have features that make the
kind of people who use the phrase "software engineering" shake
their heads disapprovingly.
	- Paul Graham

Joel Becker
Senior Member of Technical Staff
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
