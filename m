Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316538AbSIIGRm>; Mon, 9 Sep 2002 02:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316541AbSIIGRl>; Mon, 9 Sep 2002 02:17:41 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:47301 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S316538AbSIIGRk>; Mon, 9 Sep 2002 02:17:40 -0400
Date: Mon, 9 Sep 2002 02:22:23 -0400
To: Luca Barbieri <ldb@ldb.ods.org>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Initial support for struct vfs_cred   [0/1]
Message-ID: <20020909062223.GA19766@ravel.coda.cs.cmu.edu>
Mail-Followup-To: Luca Barbieri <ldb@ldb.ods.org>,
	Linux-Kernel ML <linux-kernel@vger.kernel.org>
References: <15730.8121.554630.859558@charged.uio.no> <1030890022.2145.52.camel@ldb> <15730.17171.162970.367575@charged.uio.no> <1030906488.2145.104.camel@ldb> <15730.27952.29723.552617@charged.uio.no> <1030916061.2145.344.camel@ldb> <15730.36080.987645.452664@charged.uio.no> <1030920630.1993.420.camel@ldb> <20020903034607.GF29452@ravel.coda.cs.cmu.edu> <1031522643.3025.279.camel@ldb>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1031522643.3025.279.camel@ldb>
User-Agent: Mutt/1.4i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2002 at 12:04:03AM +0200, Luca Barbieri wrote:
> > Now if this is a multithreaded application that does this in one thread
> > and another thread happens to open a completely unrelated file around
> > the time that the first thread drops this application's setuid
> > permissions. If we don't use a copy during the open upcall, but copy it
> > after the fact, we don't have the correct permissions around the time
> > the file is closed.
> You would copy them during the filesystem open.
> My point was that in the generic vfs open there is no need to use copied
> credentials so credentials copying can be restricted to network
> filesystems with not-very-good designs.
> 
> > > BTW, imho a correctly designed network filesystem should have a single
> > > stateful encrypted connection (or a pool of equally authenticated ones)
> > > and credentials (i.e. passwords) should only be passed when the user
> > > makes the first filesystem access. After that the server should do
> > > authentication with the OR of all credentials received and the client
> > > kernel should further decide whether it can give access to a particular
> > > user.
> > 
> > Right, which is pretty close to what Coda does.
> This is in contradiction with your statement about credentials sent
> during close.

How so, Coda has a pool of authenticated connections per user. But the
userspace cachemanager still needs to know which user performed the
operation in order to pick the right connection to send the message.

If user A opens a file and then user B writes/closes it, should it send
the write/close message over the authenticated connection of user B?
Ofcourse not, so we need to store the credentials of the opener with the
file.

This behaviour is the same for any filesystem that performs/requires
additional permission checking after a file is opened, i.e. probably all
network filesystems.

> The advantage of the model I described is that, with the exception of
> connection management, it works exactly like a normal filesystem with
> the exception of some totally inaccessible files due to server access
> denies.

Filedescriptors being used by processes with different user credentials
compared to the opener are more common than you might think. One common
example is stdout/stderr redirection with setuid apps in a shellscript,
another is due to fd passing through Unix domain sockets, or apps that
open files and then drop their priveledges. And it happens even more
with network sockets and pipes, although those possibly don't affect the
VFS (haven't checked if they use generic VFS paths, pipes probably do,
network sockets might).

Jan

