Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262171AbVERLH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262171AbVERLH4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 07:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbVERLH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 07:07:56 -0400
Received: from pat.uio.no ([129.240.130.16]:14843 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262170AbVERLHh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 07:07:37 -0400
Subject: Re: [PATCH] fix race in mark_mounts_for_expiry()
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: dhowells@redhat.com, linuxram@us.ibm.com, jamie@shareable.org,
       viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <E1DYMB6-0000dw-00@dorka.pomaz.szeredi.hu>
References: <E1DYLvb-0000as-00@dorka.pomaz.szeredi.hu>
	 <E1DYLCv-0000W7-00@dorka.pomaz.szeredi.hu>
	 <1116005355.6248.372.camel@localhost>
	 <E1DWf54-0004Z8-00@dorka.pomaz.szeredi.hu>
	 <1116012287.6248.410.camel@localhost>
	 <E1DWfqJ-0004eP-00@dorka.pomaz.szeredi.hu>
	 <1116013840.6248.429.camel@localhost>
	 <E1DWprs-0005D1-00@dorka.pomaz.szeredi.hu>
	 <1116256279.4154.41.camel@localhost>
	 <20050516111408.GA21145@mail.shareable.org>
	 <1116301843.4154.88.camel@localhost>
	 <E1DXm08-0006XD-00@dorka.pomaz.szeredi.hu>
	 <20050517012854.GC32226@mail.shareable.org>
	 <E1DXuiu-0007Mj-00@dorka.pomaz.szeredi.hu>
	 <1116360352.24560.85.camel@localhost>
	 <E1DYI0m-0000K5-00@dorka.pomaz.szeredi.hu>
	 <1116399887.24560.116.camel@localhost>
	 <1116400118.24560.119.camel@localhost> <6865.1116412354@redhat.com>
	 <7230.1116413175@redhat.com>  <E1DYMB6-0000dw-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Date: Wed, 18 May 2005 07:07:09 -0400
Message-Id: <1116414429.10773.57.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-4.95, required 12,
	autolearn=disabled, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on den 18.05.2005 Klokka 12:53 (+0200) skreiv Miklos Szeredi:
> > Yes you can. cmpxchg() is atomic. Several archs implement atomic_inc() and co
> > with cmpxchg() or similar.
> > 
> > Something like:
> > 
> > 	static inline struct namespace *grab_namespace(struct namespace *n)
> > 	{
> > 		int old = atomic_read(&n->count);
> > 
> > 		while (old > 0) {
> > 			/* attempt to increment the counter */
> > 			old = cmpxchg(&n->count, old, old + 1);
> > 		}
> > 
> > 		return old > 0 ? n : NULL;
> > 	}
> > 
> 
> Ahh OK :)
> 
> There's still the problem of cmpxchg meddling in the internals of an
> atomic_t.  Is that OK?  Will that work on all archs?

Some archs already have an atomic_dec_if_positive() (see for instance
the PPC). It won't take much work to convert that to an
atomic_inc_if_positive().

For those arches that don't have that sort of thing, then writing a
generic atomic_inc_if_positive() using cmpxchg() will often be possible,
but there are exceptions (for instance the original 386 does not have a
cmpxchg, so there you will have to use something else).

Cheers,
  Trond

