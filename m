Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262158AbVERKyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262158AbVERKyi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 06:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262161AbVERKyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 06:54:38 -0400
Received: from rev.193.226.233.9.euroweb.hu ([193.226.233.9]:14863 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262158AbVERKyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 06:54:31 -0400
To: dhowells@redhat.com
CC: miklos@szeredi.hu, linuxram@us.ibm.com, jamie@shareable.org,
       viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <7230.1116413175@redhat.com> (message from David Howells on Wed,
	18 May 2005 11:46:15 +0100)
Subject: Re: [PATCH] fix race in mark_mounts_for_expiry()
References: <E1DYLvb-0000as-00@dorka.pomaz.szeredi.hu>  <E1DYLCv-0000W7-00@dorka.pomaz.szeredi.hu> <1116005355.6248.372.camel@localhost> <E1DWf54-0004Z8-00@dorka.pomaz.szeredi.hu> <1116012287.6248.410.camel@localhost> <E1DWfqJ-0004eP-00@dorka.pomaz.szeredi.hu> <1116013840.6248.429.camel@localhost> <E1DWprs-0005D1-00@dorka.pomaz.szeredi.hu> <1116256279.4154.41.camel@localhost> <20050516111408.GA21145@mail.shareable.org> <1116301843.4154.88.camel@localhost> <E1DXm08-0006XD-00@dorka.pomaz.szeredi.hu> <20050517012854.GC32226@mail.shareable.org> <E1DXuiu-0007Mj-00@dorka.pomaz.szeredi.hu> <1116360352.24560.85.camel@localhost> <E1DYI0m-0000K5-00@dorka.pomaz.szeredi.hu> <1116399887.24560.116.camel@localhost> <1116400118.24560.119.camel@localhost> <6865.1116412354@redhat.com> <7230.1116413175@redhat.com>
Message-Id: <E1DYMB6-0000dw-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 18 May 2005 12:53:28 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes you can. cmpxchg() is atomic. Several archs implement atomic_inc() and co
> with cmpxchg() or similar.
> 
> Something like:
> 
> 	static inline struct namespace *grab_namespace(struct namespace *n)
> 	{
> 		int old = atomic_read(&n->count);
> 
> 		while (old > 0) {
> 			/* attempt to increment the counter */
> 			old = cmpxchg(&n->count, old, old + 1);
> 		}
> 
> 		return old > 0 ? n : NULL;
> 	}
> 

Ahh OK :)

There's still the problem of cmpxchg meddling in the internals of an
atomic_t.  Is that OK?  Will that work on all archs?

Miklos
