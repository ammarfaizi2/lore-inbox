Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269204AbUICHWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269204AbUICHWL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 03:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269264AbUICHWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 03:22:10 -0400
Received: from castle.nmd.msu.ru ([193.232.112.53]:25864 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id S269204AbUICHVi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 03:21:38 -0400
Message-ID: <20040903112133.A1834@castle.nmd.msu.ru>
Date: Fri, 3 Sep 2004 11:21:33 +0400
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: Chris Wright <chrisw@osdl.org>
Cc: Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: exec: atomic MAY_EXEC check and SUID/SGID handling
References: <20040902174521.A13656@castle.nmd.msu.ru> <20040902133109.H1973@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <20040902133109.H1973@build.pdx.osdl.net>; from "Chris Wright" on Thu, Sep 02, 2004 at 01:31:09PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2004 at 01:31:09PM -0700, Chris Wright wrote:
> * Andrey Savochkin (saw@saw.sw.com.sg) wrote:
> > There is a time window between permission(MAY_EXEC) check in
> > open_exec() and S_ISUID check plus bprm->e_uid setting in prepare_binprm().
> > And S_ISUID is checked and bprm->e_uid is copied from the inode without
> > any serialization with attribute updates.
> > 
> > That means that some executable may have permissions
> > -rwxr-xr-x    root     disk     /bin/file
> > at the moment of MAY_EXEC check and
> > -rwsr-x---    root     disk     /bin/file
> > at the moment of S_ISUID check, providing lucky users starting /bin/file at
> > the moment of permission change with a setuid-root program.
> > 
> > It's arguable whether it's a big security issue, but certainly such behavior
> > is not what administrators may expect.
> 
> If you can find a way for a user to exploit this it's an issue.  Looks

Exploiting it requires waiting for the administrator to change file
permissions...  May be, some social engineering.
But THERE IS a race, which may result in user having more permissions than
he is expected to have.
I'm not comfortable living with such a race.

Instead of
	inode->i_mode = attr->ia_mode;
we can write inode_setattr() as
	inode->i_mode |= 06777;
	inode->i_mode &= attr->ia_mode;

Will it be easily exploitable?  I guess, no.
Will I be comfortable if the code is vulnerable in this way?  No.

> like it's not, and doesn't warrant such a big change as your patch.
> The fact that you introduce a new field and then almost always supply it
> with NULL is a clue that it's not the right direction IMO.  Something
> simple (as you mentioned) that grabs i_sem and rechecks during suid
> setup in binprm_prepare is sufficient.  Worth it?  Guess I'm not
> convinced.

I explained my arguments against re-checking permissions:
 - the locking convention where ->permission() method may be called with or
   without i_sem doesn't look suberb;
 - it's better to avoid calling permission() with the same arguments for
   the second time, especially if it does something complicated in
   security_inode_permission(), with ACLs or in case of a remote filesystem.

	Andrey
