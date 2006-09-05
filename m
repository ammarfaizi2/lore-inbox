Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965152AbWIEEyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965152AbWIEEyS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 00:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965146AbWIEEyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 00:54:17 -0400
Received: from pat.uio.no ([129.240.10.4]:46500 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S965148AbWIEEyQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 00:54:16 -0400
Subject: Re: [PATCH 0/7] Permit filesystem local caching and NFS superblock
	sharing [try #13]
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Ian Kent <raven@themaw.net>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, steved@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1157429030.3915.8.camel@raven.themaw.net>
References: <20060901195009.187af603.akpm@osdl.org>
	 <20060831102127.8fb9a24b.akpm@osdl.org>
	 <20060830135503.98f57ff3.akpm@osdl.org>
	 <20060830125239.6504d71a.akpm@osdl.org>
	 <20060830193153.12446.24095.stgit@warthog.cambridge.redhat.com>
	 <27414.1156970238@warthog.cambridge.redhat.com>
	 <9849.1157018310@warthog.cambridge.redhat.com>
	 <9534.1157116114@warthog.cambridge.redhat.com>
	 <20060901093451.87aa486d.akpm@osdl.org>
	 <1157130044.5632.87.camel@localhost>
	 <28945.1157370732@warthog.cambridge.redhat.com>
	 <1157376295.3240.13.camel@raven.themaw.net>
	 <1157421445.5510.13.camel@localhost>
	 <1157424937.3002.4.camel@raven.themaw.net>
	 <1157428241.5510.72.camel@localhost>
	 <1157429030.3915.8.camel@raven.themaw.net>
Content-Type: text/plain
Date: Tue, 05 Sep 2006 00:53:59 -0400
Message-Id: <1157432039.32412.37.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.107, required 12,
	autolearn=disabled, AWL 1.89, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-05 at 12:03 +0800, Ian Kent wrote:
> Sure but this is an old version of autofs which is in use so changing
> the expected behavior of a system call is not acceptable and I expect
> other applications may well have a problem with this also.

Applications that rely on mkdir() to never return EACCES are broken.
Particularly so in an selinux system (as was the case here).

Note that an ordinary application will not see this: if I do

Machine 1				Machine 2
---------				---------
mkdir foo
					mkdir foo/bar
					chmod 555 foo/bar foo
mkdir foo/bar
mkdir: cannot create directory 
`foo/bar': File exists

i.e. as expected. So this really only affects applications that are not
supposed to be calling mkdir() in the first place.

> > > It is coping with the EACCESS return by not mounting the filesystem
> > > which is the correct response in this case.
> > 
> > No it isn't. The directory exists. It can be looked up. There is no
> > reason why you can't mount something on top of it.
> > 
> > Being permitted to do mkdir() or not has nothing to do with anything.
> 
> Agreed.
> 
> The fact that it's a mkdir is irrelevant given that nfs_lookup is
> returning an EACCESS instead of EEXIST this will likely affect other
> system calls such as "stat". I'll check this.

In both cases, the call to vfs_mkdir() is returning the EACCES. Not
nfs_lookup. The reason why we are no longer returning EEXIST is because
the intents have changed due to the patch

http://kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=a634904a7de0d3a0bc606f608007a34e8c05bfee;hp=ddeff520f02b92128132c282c350fa72afffb84a

I suspect that reverting that patch would 'fix' the autofs bug.

