Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261789AbVERMvU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261789AbVERMvU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 08:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbVERMvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 08:51:20 -0400
Received: from mail.shareable.org ([81.29.64.88]:27352 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261509AbVERMvK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 08:51:10 -0400
Date: Wed, 18 May 2005 13:50:41 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: trond.myklebust@fys.uio.no, dhowells@redhat.com, linuxram@us.ibm.com,
       viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fix race in mark_mounts_for_expiry()
Message-ID: <20050518125041.GA29107@mail.shareable.org>
References: <E1DXuiu-0007Mj-00@dorka.pomaz.szeredi.hu> <1116360352.24560.85.camel@localhost> <E1DYI0m-0000K5-00@dorka.pomaz.szeredi.hu> <1116399887.24560.116.camel@localhost> <1116400118.24560.119.camel@localhost> <6865.1116412354@redhat.com> <7230.1116413175@redhat.com> <E1DYMB6-0000dw-00@dorka.pomaz.szeredi.hu> <1116414429.10773.57.camel@lade.trondhjem.org> <E1DYMn1-0000kp-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DYMn1-0000kp-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:
> > Some archs already have an atomic_dec_if_positive() (see for instance
> > the PPC). It won't take much work to convert that to an
> > atomic_inc_if_positive().
> > 
> > For those arches that don't have that sort of thing, then writing a
> > generic atomic_inc_if_positive() using cmpxchg() will often be possible,
> > but there are exceptions (for instance the original 386 does not have a
> > cmpxchg, so there you will have to use something else).
> 
> The problem with introducing architecture specific code, is that it's
> just asking for new bugs.
> 
> If it's something used all over the kernel, than obviously it's OK,
> but for the sake of just one caller it's a bit crazy I think.

I agree.

And I think you're just adding to the case for removing mnt_namespace
entirely.  We'd still keep CLONE_NS, and users currently using
namespaces (in the normal ways) would see no difference.

mnt_namespace has these visible effects:

    - Prevents some tasks from mounting/umounting in a "foreign"
      namespace, even when they are granted access to the directory
      tree of the foreign namespace.

      It's not clear if the restriction is a useful security tool.

    - Causes every mount in a mount tree to be detached (independently),
      when last task associated with a namespace is destroyed.

And this invisible effect:

    - More concurrency than a global mount lock would have.

Is that all?  Are any of these effects important enough to keep?

-- Jamie
