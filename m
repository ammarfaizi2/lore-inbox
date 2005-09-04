Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751009AbVIDElr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbVIDElr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 00:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbVIDElr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 00:41:47 -0400
Received: from agminet04.oracle.com ([141.146.126.231]:32914 "EHLO
	agminet04.oracle.com") by vger.kernel.org with ESMTP
	id S1750998AbVIDElr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 00:41:47 -0400
Date: Sat, 3 Sep 2005 21:41:36 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Andrew Morton <akpm@osdl.org>, phillips@istop.com,
       linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [RFC][PATCH 1 of 4] Configfs is really sysfs
Message-ID: <20050904044136.GR8684@ca-server1.us.oracle.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, phillips@istop.com,
	linux-kernel@vger.kernel.org, greg@kroah.com
References: <200508310854.40482.phillips@istop.com> <20050830231307.GE22068@insight.us.oracle.com> <20050830162846.5f6d0a53.akpm@osdl.org> <20050904035341.GO8684@ca-server1.us.oracle.com> <20050904041224.GP8684@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050904041224.GP8684@ca-server1.us.oracle.com>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.10i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 03, 2005 at 09:12:24PM -0700, Joel Becker wrote:
> On Tue, Aug 30, 2005 at 04:28:46PM -0700, Andrew Morton wrote:
> > Sure, but all that copying-and-pasting really sucks.  I'm sure there's some
> > way of providing the slightly different semantics from the same codebase?

	The final piece of similar code is the buffered I/O setup for
attribute files.  Here, the major difference is how config_items and
kobjects refer to their show/store operations.  The functions have
different rules on this.
	A kobject doesn't need show/store, it can provide one for the
entire kset or subsystem.  A config_item necessarily has one for its
type, and cannot chain up.  So somehow the code would need to know which
was the case.
	 A kobject directly has a sysfs_ops structure.  The config_item
has show/store in a config_item_operations strucutre.  If you split them
out, you add a pointer and some needless complexity.  So the different
code paths need to refer to the functions differently.
	The attribute and configfs_attribute structures are physically
identical, but the sysfs one has poor naming (IMHO).  If struct
attribute wasn't going to change, and no magic would be added to its
usage (magic like kobject_add()'s intertwining with sysfs), they could
probably be shared.

Joel

-- 

"The doctrine of human equality reposes on this: that there is no
 man really clever who has not found that he is stupid."
	- Gilbert K. Chesterson

Joel Becker
Senior Member of Technical Staff
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
