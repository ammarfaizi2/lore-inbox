Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbVLUTIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbVLUTIv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 14:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbVLUTIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 14:08:50 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:41180 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751198AbVLUTIt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 14:08:49 -0500
Date: Wed, 21 Dec 2005 19:08:49 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH] handle module ref count on sysctl tables.
Message-ID: <20051221190849.GM27946@ftp.linux.org.uk>
References: <20051221103520.258ced08@dxpl.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051221103520.258ced08@dxpl.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2005 at 10:35:19AM -0800, Stephen Hemminger wrote:
> Right now there is a hole in the module ref counting system because
> there is no proper ref counting for sysctl tables used by modules.
> This means that if an application is holding /proc/sys/foo open and
> module that created it is unloaded, then the application touches the
> file the kernel will oops.
> 
> This patch fixes that by maintaining source compatibility via macro.
> I am sure someone already thought of this, it just doesn't appear to
> have made it in yet.

NAK.
	a) holding the file open will *NOT* pin any module structures down.
IO in progress will, but it unregistering sysctl table will block until it's
over.  The same goes for sysctl(2) in progress.  See use_table() and
friends in kernel/sysctl.c
	b) you are not protecting any code in module; what needs protection
(and gets it) is a pile of data structures.  With lifetimes that don't have
to be related to module lifetimes.  IOW, use of reference to module is 100%
wrong here - it wouldn't fix anything.

As a general rule, when you pin something down, think what you are trying
to protect; if it's not just a bunch of function references - module is
the wrong thing to hold.

In particular, sysctl tables are dynamically created and removed in a
kernel that is not modular at all.  Which kills any hope to get a solution
based on preventing rmmod.

Solution is fairly simple:
	* put use counter into sysctl table head (i.e. object allocated by
kernel/sysctl.c)
	* bump use counter when examining table in sysctl(2) and around the
actual IO in procfs access; put reference to table into proc_dir_entry to
be able to do the latter.  Decrement when done with the table; if it had
hit zero _and_ there's unregistration waiting for completion - kick it.
	* have unregistration kill all reference to table head and if use
counter is positive - wait for completion.  Once we get it, we know that
we can safely proceed.


