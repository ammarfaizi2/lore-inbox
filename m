Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263045AbUDLUiS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 16:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263079AbUDLUiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 16:38:18 -0400
Received: from dhcp07.cobite.com ([208.222.80.37]:44709 "EHLO
	dhcp07.cobite.com") by vger.kernel.org with ESMTP id S263045AbUDLUiP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 16:38:15 -0400
Date: Mon, 12 Apr 2004 16:38:07 -0400 (EDT)
From: David Mansfield <lkml@dm.cobite.com>
X-X-Sender: david@dhcp07.cobite.com
To: trond.myklebust@fys.uio.no
cc: linux-kernel@vger.kernel.org
Subject: NFS file handle cached incorrectly
Message-ID: <Pine.LNX.4.58.0404121407530.23214@dhcp07.cobite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Trond,

I have a problem with the fedora core 1 kernels, which as I understand,
have a patch which you originally created which creates a function called
nfs_cached_lookup, as well as adding handling for READDIRPLUS.

I'm guessing that this is the cause, after looking at diffs between 
systems that work and those that don't.

It would appear this patch hasn't made it to the mainline 2.4 kernels, and
I haven't tested the 2.6 for this problem, so I understand if this is
something you cannot help me with.

(I have filed a bugzilla with redhat, but it is languishing in NEW state 
for a while now bug#118922).

For this test, client is FC1, NFS server is RHEL3, 'othermachine' is any 
other NFS client that also mounts the same network home directory.  
Current working directory is home directory (NFS mounted).  You'll need an 
ssh-agent assisted session to get the timing right.

To reproduce (all as one command to get the timing right):

rm foo; date >foo; sleep 1; cat foo; \
ssh -x othermachine 'touch foo.new; rm foo; mv foo.new foo'; cat foo; date

Basically, what happens is that the inode (on server) of the file 'foo'
changes 'out from under' the client (by another client, 'othermachine',
that has mounted same directory).  Client then uses the cached file handle
and gets a 'stale nfs handle' error visible to user space for the last
'cat foo'.

If more than one second passes between the rename on 'othermachine' and 
the 'cat foo' on the client, the problem doesn't appear.

In reality, this is adversely affecting 'ssh' with X11 forwarding (funny
things happening with the xauth program on either end of the ssh).

Could we retry the LOOKUP if the fh comes from the cache and we get a 
stale file handle error automatically?

Any other ideas?

David

-- 
/==============================\
| David Mansfield              |
| lkml@dm.cobite.com           |
\==============================/
