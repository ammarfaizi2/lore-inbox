Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263100AbUDLVCE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 17:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263085AbUDLVCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 17:02:04 -0400
Received: from adsl-207-214-87-84.dsl.snfc21.pacbell.net ([207.214.87.84]:49039
	"EHLO lade.trondhjem.org") by vger.kernel.org with ESMTP
	id S263100AbUDLVCA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 17:02:00 -0400
Subject: Re: NFS file handle cached incorrectly
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: David Mansfield <lkml@dm.cobite.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0404121407530.23214@dhcp07.cobite.com>
References: <Pine.LNX.4.58.0404121407530.23214@dhcp07.cobite.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1081803713.7181.26.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 12 Apr 2004 14:01:53 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På m , 12/04/2004 klokka 13:38, skreiv David Mansfield:

> rm foo; date >foo; sleep 1; cat foo; \
> ssh -x othermachine 'touch foo.new; rm foo; mv foo.new foo'; cat foo; date
> 
> Basically, what happens is that the inode (on server) of the file 'foo'
> changes 'out from under' the client (by another client, 'othermachine',
> that has mounted same directory).  Client then uses the cached file handle
> and gets a 'stale nfs handle' error visible to user space for the last
> 'cat foo'.
> 
> If more than one second passes between the rename on 'othermachine' and 
> the 'cat foo' on the client, the problem doesn't appear.
> 
> In reality, this is adversely affecting 'ssh' with X11 forwarding (funny
> things happening with the xauth program on either end of the ssh).
> 
> Could we retry the LOOKUP if the fh comes from the cache and we get a 
> stale file handle error automatically?

No! The file handle is assumed to be correct if the directory
revalidated without any errors. It is cached until it is needed. The
ESTALE occurs long after we've exited from LOOKUP.

> Any other ideas?

I am sorry: you are simply violating the NFS caching premises. This is
something that is not *ever* guaranteed to work whether or not you have
READDIRPLUS enabled.
The problem here is rather that you are making remote modifications to
the NFS server's directory within < 1second (which is the resolution on
"mtime" on Linux 2.4.x) of the previous modification. Linux (and all
other NFS clients that I'm aware of) uses the mtime in order to decide
whether or not a file/directory/... has been modified since the cache
was last updated (unless it is a modification that was made by this
client).

The only "solution" to your problem here is to upgrade the *server* to
Linux-2.6.x: the latter has 1 nanosecond resolution on the "mtime", and
so can register modifications that are far smaller than 1second.

Cheers,
  Trond
