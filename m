Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262579AbUCRM0u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 07:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262576AbUCRM0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 07:26:50 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52928 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262579AbUCRM0q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 07:26:46 -0500
Date: Thu, 18 Mar 2004 12:26:45 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bind Mount Extensions 0.04.1 3/5
Message-ID: <20040318122645.GJ31500@parcelfarce.linux.theplanet.co.uk>
References: <20040315035506.GB30948@MAIL.13thfloor.at> <20040314201457.23fdb96e.akpm@osdl.org> <20040315042541.GA31412@MAIL.13thfloor.at> <20040314203427.27857fd9.akpm@osdl.org> <20040315075814.GE31818@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040315075814.GE31818@MAIL.13thfloor.at>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2004 at 08:58:14AM +0100, Herbert Poetzl wrote:
> -extern int vfs_permission(struct inode *, int);
> +extern int vfs_permission(struct inode *, int, struct nameidata *);

Vetoed, along with IS_RDONLY() prototype change.

Note that you are doing exactly the opposite of the changes we'll need
to deal with remount races.

What we need is to push readonly checks _up_ - into callers of fs methods.
vfs_permission() is default ->permission() - no more, no less.  Neither
it nor other instances have any business touching "this vfsmount is readonly"
logics - it's not something where fs can override stuff; it's "admin said
no r/w access here".

IOW, the check for r/w access to file/directory/symlink on a r/o mount should
be moved into the callers (very few of them) of ->permission() and away from
the methods themselves.
