Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262180AbVERNWR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262180AbVERNWR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 09:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbVERNWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 09:22:16 -0400
Received: from rev.193.226.233.9.euroweb.hu ([193.226.233.9]:26383 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262169AbVERNWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 09:22:00 -0400
To: jamie@shareable.org
CC: miklos@szeredi.hu, trond.myklebust@fys.uio.no, dhowells@redhat.com,
       linuxram@us.ibm.com, viro@parcelfarce.linux.theplanet.co.uk,
       akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-reply-to: <20050518125041.GA29107@mail.shareable.org> (message from Jamie
	Lokier on Wed, 18 May 2005 13:50:41 +0100)
Subject: Re: [PATCH] fix race in mark_mounts_for_expiry()
References: <E1DXuiu-0007Mj-00@dorka.pomaz.szeredi.hu> <1116360352.24560.85.camel@localhost> <E1DYI0m-0000K5-00@dorka.pomaz.szeredi.hu> <1116399887.24560.116.camel@localhost> <1116400118.24560.119.camel@localhost> <6865.1116412354@redhat.com> <7230.1116413175@redhat.com> <E1DYMB6-0000dw-00@dorka.pomaz.szeredi.hu> <1116414429.10773.57.camel@lade.trondhjem.org> <E1DYMn1-0000kp-00@dorka.pomaz.szeredi.hu> <20050518125041.GA29107@mail.shareable.org>
Message-Id: <E1DYOTs-0000ub-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 18 May 2005 15:21:00 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And I think you're just adding to the case for removing mnt_namespace
> entirely.  We'd still keep CLONE_NS, and users currently using
> namespaces (in the normal ways) would see no difference.
> 
> mnt_namespace has these visible effects:
> 
>     - Prevents some tasks from mounting/umounting in a "foreign"
>       namespace, even when they are granted access to the directory
>       tree of the foreign namespace.
> 
>       It's not clear if the restriction is a useful security tool.
> 
>     - Causes every mount in a mount tree to be detached (independently),
>       when last task associated with a namespace is destroyed.

I don't understand.  The tree _has_ to be detached when no task uses
the namespace.  That is the main purpose of the namespace structure,
to provide an anchor for the mount tree.

> And this invisible effect:
> 
>     - More concurrency than a global mount lock would have.

This is the key issue I think.  It may even have security implications
in the future if we want to allow unprivileged mounts : a user could
DoS the system by just doing lots of mounts umounts in a private
namespace.

Miklos



