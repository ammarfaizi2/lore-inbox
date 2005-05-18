Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261235AbVERMJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbVERMJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 08:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbVERMJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 08:09:58 -0400
Received: from rev.193.226.233.9.euroweb.hu ([193.226.233.9]:528 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261345AbVERMJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 08:09:38 -0400
To: dhowells@redhat.com
CC: miklos@szeredi.hu, linuxram@us.ibm.com, jamie@shareable.org,
       viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <9498.1116417099@redhat.com> (message from David Howells on Wed,
	18 May 2005 12:51:39 +0100)
Subject: Re: [PATCH] fix race in mark_mounts_for_expiry()
References: <E1DYMVf-0000hD-00@dorka.pomaz.szeredi.hu>  <E1DYMB6-0000dw-00@dorka.pomaz.szeredi.hu> <E1DYLvb-0000as-00@dorka.pomaz.szeredi.hu> <E1DYLCv-0000W7-00@dorka.pomaz.szeredi.hu> <1116005355.6248.372.camel@localhost> <E1DWf54-0004Z8-00@dorka.pomaz.szeredi.hu> <1116012287.6248.410.camel@localhost> <E1DWfqJ-0004eP-00@dorka.pomaz.szeredi.hu> <1116013840.6248.429.camel@localhost> <E1DWprs-0005D1-00@dorka.pomaz.szeredi.hu> <1116256279.4154.41.camel@localhost> <20050516111408.GA21145@mail.shareable.org> <1116301843.4154.88.camel@localhost> <E1DXm08-0006XD-00@dorka.pomaz.szeredi.hu> <20050517012854.GC32226@mail.shareable.org> <E1DXuiu-0007Mj-00@dorka.pomaz.szeredi.hu> <1116360352.24560.85.camel@localhost> <E1DYI0m-0000K5-00@dorka.pomaz.szeredi.hu> <1116399887.24560.116.camel@localhost> <1116400118.24560.119.camel@localhost> <6865.1116412354@redhat.com> <7230.1116413175@redhat.com> <8247.1116413990@redhat.com> <9498.1116417099@redhat.com>
Message-Id: <E1DYNLt-0000nu-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 18 May 2005 14:08:41 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What you're doing is tricky. It's asking for a race.

I know.  The comment above the function is there to make sure the user
is aware of this.

> Admittedly, it may not
> occur in the particular situation you're looking at, but can you always
> guarantee that?

Yes, if it's always called under lock.

> Remember, it may be a race against some piece of code that's not yet
> written, by an author who doesn't realise what _you_ are doing here
> because their changeset doesn't intersect with yours.
> 
> Remember: you have, in effect, made the usage count on that structure
> non-atomic.

But _only after_ it's has gone to zero.  When in fact there are no
more references to it, so it shouldn't matter.

The fact that it does matter and that mark_mounts_for_expiry()
derefences mnt->mnt_namespace without actually having a proper
reference to the namespace is the real culprit here.

This is the third bug found by Jamie Lokier, Ram and me in the
mnt_namespace change.  So if we are looking at proper solutions I
think that is what we should be examining.

Thanks,
Miklos
