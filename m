Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261934AbVELNXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261934AbVELNXw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 09:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbVELNXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 09:23:52 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:8935 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261934AbVELNXq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 09:23:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q0rzWYq/QikJg11CbktRIcw4kOi0e5fJJdH3neUTkI8Cfwj7LM7C5N5zSHfhV/79D5cO4OKNj10yLth2hhFhXnZB8GMTifw4Sl6RvjU/iG/mkJRncz58vYN+0KkgLD/HE5efXHULon+rVohxIqzFG9Nwa6LLafInk/gBjW67eug=
Message-ID: <a4e6962a0505120623645c0947@mail.gmail.com>
Date: Thu, 12 May 2005 08:23:18 -0500
From: Eric Van Hensbergen <ericvh@gmail.com>
Reply-To: Eric Van Hensbergen <ericvh@gmail.com>
To: Jamie Lokier <jamie@shareable.org>
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
Cc: Ram <linuxram@us.ibm.com>, Miklos Szeredi <miklos@szeredi.hu>,
       7eggert@gmx.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, smfrench@austin.rr.com, hch@infradead.org
In-Reply-To: <20050512064514.GA12315@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42WNo-1eJ-17@gated-at.bofh.it>
	 <20050511170700.GC2141@mail.shareable.org>
	 <E1DVwGn-0002BB-00@dorka.pomaz.szeredi.hu>
	 <1115840139.6248.181.camel@localhost>
	 <20050511212810.GD5093@mail.shareable.org>
	 <1115851333.6248.225.camel@localhost>
	 <a4e6962a0505111558337dd903@mail.gmail.com>
	 <20050512010215.GB8457@mail.shareable.org>
	 <a4e6962a05051119181e53634e@mail.gmail.com>
	 <20050512064514.GA12315@mail.shareable.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/05, Jamie Lokier <jamie@shareable.org> wrote:
> Eric Van Hensbergen wrote:
> > On 5/11/05, Jamie Lokier <jamie@shareable.org> wrote:
> > > Please read carefully: I've described what _current_ kernels do.
> > >
> >
> > I guess I misread when you wrote:
> 
> There are some things which you can't do with current kernels due to
> the checks against current->namespace.  I'm not sure how important
> those checks are.  And there are some things which you _can_ do, such
> as passing directory file descriptors among processes which are in
> different namespaces.
> 

I'm not sure passing directory file descriptors is the right semantic
we want - but at least it provides a point of explicit control (in
much the same way as a bind).  Are you sure the clone + open("/") +
pass-to-parent scenario you allows the parent to traverse the child's
private name space through that fd?  That seems as bad as accessing
pid name space via the /proc file system.

In Plan 9, file descriptors are passed between name spaces, but the
only use of such a facility (described in fork(2) [plan9man]) is to
pass channels to file servers which can then be mounted in a blank
name space.  exportfs(4)[plan9man] seems to provide a much nicer
semantic for this sort of name space sharing.

Let's focus on baby steps first, and to me that's:
a) get rid of holes that allow users to traverse out of a chroot jail
by using the creation of private name spaces (is anyone working on
this, did I miss a patch?)
b) make CLONE_NEWNS (and any other name space creation mechanisms such
as the proposed unshare system call) available to normal users
c) Get the unshare system call adopted as it seems to be generally useful
d) Get Miklos' unprivileged mount/umount patch adopted in mainline

These 4 things open up lots of opportunities and alternatives, if they
prove to be insufficient then we can press forward on name spaces as
first class objects, etc.

          -eric


[plan9man] Plan 9 manual pages are available at
http://plan9.bell-labs.com/sys/man/index.html
