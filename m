Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964947AbVITJez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964947AbVITJez (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 05:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964948AbVITJez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 05:34:55 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:41407 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964947AbVITJey
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 05:34:54 -0400
Date: Tue, 20 Sep 2005 10:34:50 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Ram <linuxram@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@osdl.org,
       miklos@szeredi.hu, mike@waychison.com, bfields@fieldses.org,
       serue@us.ibm.com
Subject: Re: [RFC PATCH 10/10] vfs: shared subtree documentation
Message-ID: <20050920093450.GL7992@ftp.linux.org.uk>
References: <20050916182620.GA28560@RAM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050916182620.GA28560@RAM>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2005 at 11:26:20AM -0700, Ram wrote:
> 
> Complete description of shared subtrees.

BTW, one note on naming: s/next_shared/next_peer/ would probably be a good
idea.

> +     --------------------------------------------------------------------
> +     |                          BIND MOUNT OPERATION                    |
> +     |******************************************************************|

> +     	Details follow:

Do they ever...  That's one hell of an overkill.  Moreover, there's a
nasty subtle point that needs to be dealt with: you are using "slave"
in two different meanings - "slave that is not shared" and "slave of".
Your case 7 (slave on shared) is very confusing because of that -
C becomes a slave of Z, but it also becomes shared.  Which is what
we want, but everything prior to that uses "slave" only for solitary
ones.

	* if 'A' is an unclonable mount, operation is invalid.
	  An unclonable mount cannot be bind mounted.

	* otherwise a new mount 'C' is created; it is a clone of 'A'.
	  It is mounted on mount 'B' at dentry 'b'.

	* if 'A' is a shared mount, 'C' is made a peer of 'A'; if 'A' is a
	  slave of 'Z', 'C' is made a slave of 'Z'.

	* if 'B' is a shared mount, new mounts 'C1', 'C2', ... are created
	  and mounted at 'b' on all mounts where 'B' propagates to.  A new
	  propagation tree is set containing all new mounts 'C', ..., 'Cn'
	  exactly with the same configuration as the propagation tree of 'B'.

Same comment about use of "slave" applies through the rest of text.  IMO
it's worth a discussion _before_ you get to description of operations,
I.e. your 6F would save a lot of confusion if it went before the rest.

> +	Only a slave mount can be made as 'shared and slave' by executing
> +	the following command
> +		mount --make-shared mount

... but 'shared and slave' can be created by binding a slave on shared.

> +	->mnt_slave_list links all the mounts to which this mount propagates to.
> +
> +	->mnt_slave links together all the slaves that its master mount
> +	propagates to.
> +
> +	->mnt_master points to the master mount from which this mount receives
> +	propagation.

Missing bit:
	(1) all peers have the same ->mnt_master
	(2) all vfsmounts with the same ->mnt_master sit on a cyclic list
anchored in ->mnt_master->mnt_slave_list and going through ->mnt_slave.
	Aside of (1) ->mnt_master can point to arbitrary (and possibly
different) members of master peer group.  IOW, to find all immediate slaves
of a peer group you need to go through _all_ ->mnt_slave_list of its members.
Conceptually it's just a single set - distribution among the individual
lists does not affect propagation or the way propagation tree is modified
by operations.

> +	A example propagation tree looks as shown in the figure below.
> +	[ NOTE: Though it looks like a forest, if we consider all the shared
> +	mounts as a conceptual entity called 'pnode', it becomes a tree]
s/mounts/& in a peer group/ - there's a whole lot of shared mounts out
there, most of them not related to each other.

BTW, discussion of loop prevention in MS_MOVE is worth adding.

One note on splitting this stuff: I suspect that it might end up with
doing pure sharing (i.e. only peer groups) first (split as now, but
much simpler), then a series adding slaves, then the rest.  In any
case, I would expect the final splitup to be considerably more than 10
chunks.  IME that's worth doing - time spent on such massage pays off
since one tends to get cleaner code out of it; stuff that got missed
while writing the thing in the first place.
