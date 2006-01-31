Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030354AbWAaG7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030354AbWAaG7E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 01:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030356AbWAaG7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 01:59:04 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:41413
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1030354AbWAaG7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 01:59:03 -0500
Date: Mon, 30 Jan 2006 22:58:44 -0800
From: Greg KH <greg@kroah.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH 1/5] pid: Implement task references.
Message-ID: <20060131065843.GA24733@kroah.com>
References: <m1psmba4bn.fsf@ebiederm.dsl.xmission.com> <m1lkwza479.fsf@ebiederm.dsl.xmission.com> <20060129190539.GA26794@kroah.com> <m1mzhe7l2c.fsf@ebiederm.dsl.xmission.com> <20060130045153.GC13244@kroah.com> <m14q3l79uv.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m14q3l79uv.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2006 at 01:13:12PM -0700, Eric W. Biederman wrote:
> Greg KH <greg@kroah.com> writes:
> 
> > On Sun, Jan 29, 2006 at 02:58:51PM -0700, Eric W. Biederman wrote:
> >> 
> >> What does the kref abstraction buy?  How does it simplify things?
> >> We already have equivalent functions in atomic_t on which it is built.
> >
> > It ensures that you get the logic of the reference counting correctly.
> > It forces you to do the logic of the get and put and release properly.
> >
> > To roughly quote Andrew Morton, "When I see a kref, I know it is used
> > properly, otherwise I am forced to read through the code to see if the
> > author got the reference counting logic correct."
> >
> > It costs _nothing_ to use it, and let's everyone know you got the logic
> > correct.
> >
> > So don't feel it is a "abstraction", it's a helper for both the author
> > (who doesn't have to get the atomic_t calls correct), and for everyone
> > else who has to read the code.
> 
> So looking at kref and looking at my code I have a small amount of feedback.
> It looks like using kref would increase the size of my code as I would
> have to add an additional function.  Further I don't see that it would
> simplify anything in my code. 

What function would you have to add?  A release function?  You should
have that logic somewhere already, so net gain should be the same.

> The extra debugging checks in krefs are nice, but not something I
> am lusting over.

Heh, but they do catch a lot of improper usages.

> As for code recognition I don't see how recognizing the atomic_t idiom
> versus the kref idiom is much different.  But I haven't had this issue
> come up in a code review so I have no practical experience there.

It's not a different "idiom", but rather, a way to implement the
reference counting logic without having to code it all by hand, and
ensure that you get it correct.

> The biggest issue I can find with kref is the name.  kref is not a
> reference it is a count.  A reference count if you want to be long
> about it. Just skimming code using it looks like kref is a pointer to
> a generic object that you are getting and putting. 

Yes.  You are "getting" and "putting" your structure, without having to
handle the reference count.  I don't see the issue here...

> It also doesn't help that current krefs are used in little enough code
> that I still find it jarring to see one.

They are used all the time, and there's not that many atomic_t usages in
the kernel that do reference counting that have not been already
converted to use kref (the vfs not-withstanding, for other reasons.)

> One more abstraction to read.  Whereas atomic_t are everywhere, so I
> am familiar with them.

They should not be "everywhere" as reference counts, except for the vm
and mm cores.

> So those are all of the nits I can pick. :)  I don't kref seems to be
> a perfectly usable piece of code but not one that seems to help my
> code.  Unless it becomes a mandate from the code correctness police.

As you are adding a new reference count, it is highly encouraged that
you not reimplement the same logic, but rather use the functions already
provided in the kernel to do that work for you.  That way you don't have
to write the extra code, and we don't have to check the logic for you.

thanks,

greg k-h
