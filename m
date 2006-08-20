Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbWHTO0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWHTO0E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 10:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbWHTO0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 10:26:03 -0400
Received: from mail.dotsterhost.com ([72.5.54.21]:55195 "HELO
	mail.dotsterhost.com") by vger.kernel.org with SMTP
	id S1750796AbWHTO0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 10:26:02 -0400
Date: Sun, 20 Aug 2006 22:25:40 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: David Howells <dhowells@redhat.com>
cc: Andrew Morton <akpm@osdl.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org, aviro@redhat.com
Subject: Re: [PATCH] NFS: Replace null dentries that appear in readdir's list
 [try #2]
In-Reply-To: <3976.1156079732@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.64.0608202223220.29268@raven.themaw.net>
References: <20060819094840.083026fd.akpm@osdl.org> 
 <13319.1155744959@warthog.cambridge.redhat.com> <1155743399.5683.13.camel@localhost>
 <20060813133935.b0c728ec.akpm@osdl.org> <20060813012454.f1d52189.akpm@osdl.org>
 <5910.1155741329@warthog.cambridge.redhat.com> <2138.1155893924@warthog.cambridge.redhat.com>
  <3976.1156079732@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Aug 2006, David Howells wrote:

> Andrew Morton <akpm@osdl.org> wrote:
> 
> > The funny-looking dentries in /net/bix have gone away.
> > 
> > But `ls -l /net/bix/usr/src' doesn't mount bix:/usr/src.
> 
> Yes, that I believe is due to the automounter program combined with that
> optimisation in the NFS client code.  *readdir* fixes the falsely negative
> dentry, but only if you _do_ a readdir of the parent directory, and only then
> if you read enough of the directory to locate the dodgy dentry.
> 
> This is normally only a problem if SELinux aborts the mkdir operation between
> calling the filesystem's lookup() op and the filesystem's mkdir() op, if the
> filesystem is written - as NFS is - to assume the the lookup() op _will_ be
> followed by a call to the mkdir() op whatever happens.  Unfortunately, with
> SELinux sticking its foot in the way, this no longer holds true, and the
> initial lookup _must_ properly instantiate the dentry it is given - and that
> means it must query the server in such a case.
> 
> That said, that will likely prevent autofs from being able to create arbitrary
> directories if the underlying security constraints don't let it.
> 
> There is another problem with autofs arbitrarily creating directory dentries
> in this manner: the automount program doesn't know whether the directory it is
> creating corresponds to a directory on the server - or whether it corresponds
> to a symbolic link...  The server _must_ be queried.
> 
> So, I think:
> 
>  (1) I have to change my patch again, and that I have to make nfs_lookup()
>      unconditionally query the server (comments Trond?), and
> 
>  (2) Ian has to patch the automounter to not attempt to mount undermounts
>      automatically - with the new in-NFS-client automounting code, this should
>      be unnecessary, except for when the an intervening directory is
>      inaccessible, and I'm not sure what you can do about that (Ian? Trond?)

I guess I knew this would with the nfs v4 mounting.

I don't have a server with v4 nested type mounts handy. How can I tell, 
from the output of the exports list, what I should leave alone?

Ian

