Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbVEKVYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbVEKVYP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 17:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262061AbVEKVYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 17:24:15 -0400
Received: from mail.shareable.org ([81.29.64.88]:49872 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262056AbVEKVYH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 17:24:07 -0400
Date: Wed, 11 May 2005 22:23:43 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Bodo Eggert <7eggert@gmx.de>
Cc: Miklos Szeredi <miklos@szeredi.hu>, ericvh@gmail.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       smfrench@austin.rr.com, hch@infradead.org
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
Message-ID: <20050511212343.GC5093@mail.shareable.org>
References: <406SQ-5P9-5@gated-at.bofh.it> <40rNB-6p8-3@gated-at.bofh.it> <40t37-7ol-5@gated-at.bofh.it> <42VeB-8hG-3@gated-at.bofh.it> <42WNo-1eJ-17@gated-at.bofh.it> <E1DVuHG-0006YJ-Q7@be1.7eggert.dyndns.org> <20050511170700.GC2141@mail.shareable.org> <Pine.LNX.4.58.0505112121190.11888@be1.lrz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505112121190.11888@be1.lrz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert wrote:
> > > > How about a new clone option "CLONE_NOSUID"?
> > > 
> > > IMO, the clone call ist the wrong place to create namespaces. It
> > > should be deprecated by a mkdir/chdir-like interface.
> > 
> > And the mkdir/chdir interface already exists, see "cd /proc/NNN/root".
> 
> If you want persistent namespaces, this will be a PITA (I don't want a 
> keep-the-namespace-open-daemon), and if you don't, it will be racy 
> (user a logs in, while his second/nth login expires).
> 
> Keeping a list of named namespaces in kernel can be made cheap and secure.

Still easy.

To keep persistent named namespaces in /var/namespaces, thus:

     # Just once please!
     mount -t tmpfs none /var/namespaces

     # Make a named namespace.
     NSNAME='fred'
     mkdir /var/namespaces/$NSNAME
     run_in_new_namespace mount -t bind / /var/namespaces/$NSNAME

     # Make a named namespace for the _original_ namespace.
     mkdir /var/namespaces/initial
     mount -t bind / /var/namespaces/initial

     # Access the namespace.
     ls /var/namespaces/fred

     # Enter the namespace.
     chroot /var/namespaces/fred

     # Delete a named namespace.
     NSNAME='fred'
     umount /var/namespaces/$NSNAME
     rmdir /var/namespaces/$NSNAME

Some of the above will fail due to security checks in fs/namespace.c,
where it tests against current->namespace.  Without those checks,
which seem to have no purpose _other_ than preventing the above usage,
I think the above would all work.

-- Jamie
