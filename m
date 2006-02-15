Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422992AbWBOHbi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422992AbWBOHbi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 02:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422994AbWBOHbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 02:31:38 -0500
Received: from nproxy.gmail.com ([64.233.182.200]:50235 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422992AbWBOHbh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 02:31:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oJa1yQivBbFbFWHfU8sOjwhfZQtZSjvdbnIQ7PpnY5zoD1b6mObxX0p/f6K3v9Fj8HefR5oklvemUbRRHlVVxkApiwR039eDMLVXOmrzL73SBX58oVpPf5ouvO6Br5w5sJ4PbDYpvuJK6WM0euomGytbO7iJ0mb1PZAve5X45pA=
Message-ID: <84144f020602142331s756aff15o69d1d67f1b18127e@mail.gmail.com>
Date: Wed, 15 Feb 2006 09:31:35 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: [RFC][PATCH] UDF filesystem uid fix
Cc: Peter Osterlund <petero2@telia.com>, linux-kernel@vger.kernel.org,
       bfennema@falcon.csc.calpoly.edu, Christoph Hellwig <hch@lst.de>,
       Al Viro <viro@ftp.linux.org.uk>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <43F1FD39.1040900@cfl.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <m3lkwg4f25.fsf@telia.com>
	 <84144f020602130149k72b8ebned89ff5719cdd0c2@mail.gmail.com>
	 <43F0B8FC.6020605@cfl.rr.com>
	 <Pine.LNX.4.58.0602140916230.15339@sbz-30.cs.Helsinki.FI>
	 <43F1FD39.1040900@cfl.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/06, Phillip Susi <psusi@cfl.rr.com> wrote:
> This seems to meet user expectations much better than the
> previous behavior of changing ownership to root when unmounted.

Reading mount man pages, the definition for uid/gid mount option for
udf is "default user/group." I am pretty convinced that their original
intent was to provide meaningful id for inodes that don't have one.
Now what you're looking for sounds more like "mount whole filesystem
as user/group" which is something different.

The ownership changing to root thing is a bug caused by explicit
memset() straight after we read the inode followed by flawed logic
that forgets to set the uid. Your patch doesn't really fix that
either, but it masks it. Unfortunately, now combining uid/git options
with filesystem in which some inodes _have_ proper id yields to
strange results. I don't see how it's reasonable for a filesystem to
write invalid id on disk if I change the owner to myself even if I did
use the mount options.

So I don't think your patch is a proper fix for the ownership changing
to root bug, nor do I think it is sufficient to provide the "mount fs
as user" thing (which does sound useful). Now if you want to change
uid/gid option semantics to "mount fs as user", please explain why you
don't think my case matters, that is using uid/gid to provide id for
inodes that don't have one but still expecting chown to work?

                                        Pekka
