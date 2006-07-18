Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWGREUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWGREUA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 00:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbWGREUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 00:20:00 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:10576 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750716AbWGREUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 00:20:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hVWVMNwTHk6BDWTW7u8lV4NbKCYGlHXj3HjWx1aE8yQogjvOfYYKYBLIBAXm5AmYfsFLHd4v6AzC/lnkJHn0QCR+mQEsP6KZOpu04XRlooMCGY62r3WtX0sFTTlLpM1tqTMddRegRYozB2aZtu8OkL87eI10cep4egjhK92Z7sU=
Message-ID: <bda6d13a0607172119v3c908ac8u8a39acd315dc6336@mail.gmail.com>
Date: Mon, 17 Jul 2006 21:19:57 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: How to explain to lock validator: locking inodes in inode order
In-Reply-To: <1153193513.4533.3.camel@testmachine>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <bda6d13a0607171924v5cd15811v7c9749ad481b232d@mail.gmail.com>
	 <1153193513.4533.3.camel@testmachine>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/06, Arjan van de Ven <arjan@infradead.org> wrote:
> On Mon, 2006-07-17 at 19:24 -0700, Joshua Hudson wrote:
> > Code does this:
> >
> > /* Lock two items. See locking.txt */
> > static inline void kb0_lock2m(struct kb0_idata *m1, struct kb0_idata *m2)
> > {
> >         if (m1->vi.i_ino > m2->vi.i_ino)
> >                 mutex_lock(&m2->k_mutex);
> >         mutex_lock(&m1->k_mutex);
> >         if (m1->vi.i_ino < m2->vi.i_ino)
> >                 mutex_lock(&m2->k_mutex);
> > }
> >
> > Not sure how to explain to the lock validator that this code can never deadlock.
>
> you're sure it can;t?
Yes. It never takes a lock on any higher inode without holding the lock on a
lower inode first. I have a full proof across the VFS+FS [see below].

>
> all places in the kernel that take this mutex in that order only do it
> in i_ino order, including all directory operations like cross directory
> rename?

I had to disable the kernel's locking of multiple objects in namei.c using a
new FS_ flag because it would actually deadlock for this filesystem.

> (which fs is this btw?)
Custom filesystem (kb0), not in any tree but mine. I am in progress
with syncing it up
to the latest kernel.

If anybody really wants it, it is 70-odd K of bzip2-compressed code of
filesystem + utilities. It's not ready for non-acedemic use though.
