Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964860AbWAWSUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbWAWSUz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 13:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWAWSUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 13:20:55 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:37398 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751412AbWAWSUy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 13:20:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GnzkwITc68Q3t52yDOOy+SgJRNhZZnMvwZDFVMhMXtljY+xLl8bBJ5HGIv1j5xs4gqiZVXIGPb8ALjNe2gB+x0rsBLJuBXoJUb65VwIMbQpYeUmS7EaJFf533RBgfVB/4LloAw568MVPATZlVJ+RKGkcoR6Cike5uI7jLrHQ+KU=
Message-ID: <1c190f10601231020v7bacc3e8t31e0378093be8596@mail.gmail.com>
Date: Mon, 23 Jan 2006 11:20:52 -0700
From: Todd Kneisel <todd.kneisel@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [robust-futex-4] futex: robust futex support
Cc: david singleton <dsingleton@mvista.com>, drepper@gmail.com, mingo@elte.hu,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060118212256.1553b0ec.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43C84D4B.70407@mvista.com>
	 <a36005b50601141602y641567ebh5ff9b6a1fad4d7d2@mail.gmail.com>
	 <746DBAD6-855A-11DA-A824-000A959BB91E@mvista.com>
	 <a36005b50601142118h3a07a640ra668dab13129683b@mail.gmail.com>
	 <C59522FA-8700-11DA-B27C-000A959BB91E@mvista.com>
	 <a36005b50601170950u307ffb9dl52dc3655a1b90fa6@mail.gmail.com>
	 <F3EB614C-8892-11DA-AF83-000A959BB91E@mvista.com>
	 <20060118212256.1553b0ec.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/06, Andrew Morton <akpm@osdl.org> wrote:
> > +/**
> > + * futex_free_robust_list - release the list of registered futexes.
> > + * @inode: inode that may be a memory mapped file
> > + *
> > + * Called from dput() when a dentry reference count reaches zero.
> > + * If the dentry is associated with a memory mapped file, then
> > + * release the list of registered robust futexes that are contained
> > + * in that mapping.
> > + */
> > +void futex_free_robust_list(struct inode *inode)
> > +{
> > +     struct address_space *mapping;
> > +     struct list_head *head;
> > +     struct futex_robust *this, *next;
> > +     struct futex_head *futex_head = NULL;
> > +
> > +     if (inode == NULL)
> > +             return;
>
> Is this test needed?
>
> This function is called when a dentry's refcount falls to zero.  But there
> could be other refs to this inode which might get upset at having their
> robust futexes thrown away.  Shouldn't this be based on inode destruction
> rather than dentry?
>

In an early version, it was based on inode destruction. But inodes are
not destroyed
at process termination. If I understand the code, they're cached so that another
process that opens the same file will not have to build the inode from scratch.

So I based it on the dentry's refcount falling to zero, which occurs at process
termination. I did consider the problem of other references to the
inode. The only
scenario I could come up with was mapping the file using hard links. Then there
would be multiple dentrys referencing the same inode. This could be fixed by
adding a refcount to the futex_robust structure, but I never got around to doing
this.

Todd.
