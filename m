Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261775AbVDZUJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbVDZUJx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 16:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261772AbVDZUJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 16:09:35 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:45272 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S261767AbVDZUJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 16:09:19 -0400
Date: Tue, 26 Apr 2005 22:08:15 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Bryan Henderson <hbryan@us.ibm.com>
Cc: Bodo Eggert <7eggert@gmx.de>, akpm@osdl.org, Jan Hudec <bulb@ucw.cz>,
       hch@infradead.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] private mounts
In-Reply-To: <OF7E89A8B8.2AC04C42-ON88256FEF.005DACE1-88256FEF.005E7421@us.ibm.com>
Message-ID: <Pine.LNX.4.58.0504262031490.3393@be1.lrz>
References: <OF7E89A8B8.2AC04C42-ON88256FEF.005DACE1-88256FEF.005E7421@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2005, Bryan Henderson wrote:

> >> >mknamespace -p users/$UID # (like mkdir -p)
> >> >setnamespace users/$UID   # (like cd)
> >>                               ^^^^^^^^
> >> 
> >> You realize that 'cd' is a shell command, and has to be, I hope.  That 
> >> little fact has thrown a wrench into many of the ideas in this thread.
> >
> >I suppose it will be called by the login process or by wrappers like 
> >'nice'.
> 
> Just to be clear, then: this idea is fundamentally different from the 
> mkdir/cd analogy the thread starts with above.

NACK, it's very similar to the cd "$HOME" (or ulimit calls) done by the
login mechanism, except for the fact that no shell does implement a
setnamespace command and therefore can't leave that namespace. If the
shell were actually modified to implement setnamespace, that command would
be exactly like the cd command.

The wrapper I mentioned will usurally not be needed for normal operation,
but if users want additional private namespaces, they'll need this
seperate wrapper (or to modify the application or the shell) in order to
switch into them.

>  And it misses one rather 
> important requirement compared to mkdir/cd:  You can't add a new mount to 
> an existing shell.

The mount would be a part of the current namespace, which is shared across
all current user processes unless they are started without login (e.g.
procmail[0]) or running in a different namespace (the user called
setnamespace).



[0] If you want procmail in a user namespace, use a wrapper like
---/usr/bin/procmail---
#!/bin/sh
exec /usr/bin/setnamespace /users/"$UID" -- /usr/bin/procmail.bin "$@"
---

BTW: I think the namespaces will need the normal file permissions.

-- 
Fun things to slip into your budget
Paradigm pro-activator (a whole pack)
	(you mean beer?)
