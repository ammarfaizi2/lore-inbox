Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269059AbUIBUff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269059AbUIBUff (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 16:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269040AbUIBUeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 16:34:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:51123 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269025AbUIBUbL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 16:31:11 -0400
Date: Thu, 2 Sep 2004 13:31:09 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andrey Savochkin <saw@saw.sw.com.sg>
Cc: Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exec: atomic MAY_EXEC check and SUID/SGID handling
Message-ID: <20040902133109.H1973@build.pdx.osdl.net>
References: <20040902174521.A13656@castle.nmd.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040902174521.A13656@castle.nmd.msu.ru>; from saw@saw.sw.com.sg on Thu, Sep 02, 2004 at 05:45:21PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrey Savochkin (saw@saw.sw.com.sg) wrote:
> There is a time window between permission(MAY_EXEC) check in
> open_exec() and S_ISUID check plus bprm->e_uid setting in prepare_binprm().
> And S_ISUID is checked and bprm->e_uid is copied from the inode without
> any serialization with attribute updates.
> 
> That means that some executable may have permissions
> -rwxr-xr-x    root     disk     /bin/file
> at the moment of MAY_EXEC check and
> -rwsr-x---    root     disk     /bin/file
> at the moment of S_ISUID check, providing lucky users starting /bin/file at
> the moment of permission change with a setuid-root program.
> 
> It's arguable whether it's a big security issue, but certainly such behavior
> is not what administrators may expect.

If you can find a way for a user to exploit this it's an issue.  Looks
like it's not, and doesn't warrant such a big change as your patch.
The fact that you introduce a new field and then almost always supply it
with NULL is a clue that it's not the right direction IMO.  Something
simple (as you mentioned) that grabs i_sem and rechecks during suid
setup in binprm_prepare is sufficient.  Worth it?  Guess I'm not
convinced.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
