Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751085AbWHPKAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbWHPKAz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 06:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbWHPKAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 06:00:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23021 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751085AbWHPKAz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 06:00:55 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <29660.1155720852@warthog.cambridge.redhat.com> 
References: <29660.1155720852@warthog.cambridge.redhat.com>  <20060815114912.d8fa1512.akpm@osdl.org> <20060815104813.7e3a0f98.akpm@osdl.org> <20060815065035.648be867.akpm@osdl.org> <20060814143110.f62bfb01.akpm@osdl.org> <20060813133935.b0c728ec.akpm@osdl.org> <20060813012454.f1d52189.akpm@osdl.org> <10791.1155580339@warthog.cambridge.redhat.com> <918.1155635513@warthog.cambridge.redhat.com> <29717.1155662998@warthog.cambridge.redhat.com> <6241.1155666920@warthog.cambridge.redhat.com> 
To: Ian Kent <raven@themaw.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       David Howells <dhowells@redhat.com>
Subject: Re: 2.6.18-rc4-mm1 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 16 Aug 2006 11:00:39 +0100
Message-ID: <30157.1155722439@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ian,

I think this is probably a problem with the automounter daemon.

What I think happens is this:

 (1) I've got an NFS server (trash) with the following configuration:

	[root@trash dhowells]# cat /etc/exports 
	/               *(rw,async)
	/usr/src        *(rw,async)
	/mnt/export     *(rw,async)

 (2) I do "ls -l" on the client to use the automounter to view the root NFS
     share on the machine.

 (3) The automounter makes /net/trash and mounts trash:/ on it.

 (4) The automount daemon asks the server what other shares it has available.

 (5) For each share, the automounter attempts to create the directories on
     which to mount it:

	SHARE			DIRECTORIES TO BE CREATED
	=======================	=============================================
	trash:/usr/src		/net/trash/usr, /net/trash/usr/src
	trash:/mnt/exports	/net/trash/mnt, /net/trash/mnt/exports

 (6) The automount daemon issued mkdir() syscalls to create these directories,
     _despite_ the fact that it is doing so in a mounted filesystem.

 (7) SELinux prohibits the mkdir() syscall by refusing write permission on the
     directory.

 (8) An unconstructed dentry is left, which causes the "?---------" lines to
     appear in the ls -l listing.


With the new internal automounting code in NFS, the automounter shouldn't
attempt to do step (4) onwards for submounts as the NFS filesystem itself will
take care of that.

And, in my opinion, it shouldn't be attempting to create directories on the
server.

However, (8) might well represent a bug in NFS.

David
