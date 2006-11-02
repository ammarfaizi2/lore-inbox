Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752463AbWKBTuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752463AbWKBTuA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 14:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752465AbWKBTuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 14:50:00 -0500
Received: from pat.uio.no ([129.240.10.4]:35839 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1752463AbWKBTt7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 14:49:59 -0500
Subject: Re: Security issues with local filesystem caching
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: David Howells <dhowells@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Karl MacMillan <kmacmill@redhat.com>,
       jmorris@namei.org, chrisw@sous-sol.org, selinux@tycho.nsa.gov,
       linux-kernel@vger.kernel.org, aviro@redhat.com
In-Reply-To: <25037.1162487801@redhat.com>
References: <1162402218.32614.230.camel@moss-spartans.epoch.ncsc.mil>
	 <1162387735.32614.184.camel@moss-spartans.epoch.ncsc.mil>
	 <16969.1161771256@redhat.com> <31035.1162330008@redhat.com>
	 <4417.1162395294@redhat.com>   <25037.1162487801@redhat.com>
Content-Type: text/plain
Date: Thu, 02 Nov 2006 14:49:27 -0500
Message-Id: <1162496968.6071.38.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.794, required 12,
	autolearn=disabled, AWL 1.21, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-02 at 17:16 +0000, David Howells wrote:
> Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> > Unless there is some benefit to setting a ->fssid and checking against
> > it (e.g. safeguarding the module against unintentional internal access),
> > I think the task flag approach is preferable.
> 
> Well, I think the use of ->fssid is simpler and faster from an implementation
> standpoint (see the attached patch), and it can always be used for such as the
> in-kernel nfsd later.
> 
> The way I've done it in this patch is to have ->fssid shadow ->sid as long as
> they're the same.  But ->fssid can be set to something else and then later
> reset, at which point it becomes the same as ->sid again.  A hook is provided
> to perform both of these operations:
> 
> 	security_set_fssid(overriding_SID);  //set
> 	...
> 	security_set_fssid(SECSID_NULL);  //reset
> 
> The rest of the patch is that more or less anywhere ->sid is used to represent
> a process as an actor, this is replaced with ->fssid.  This part requires no
> conditional jumps.  It becomes a bit tricky around execve() time, but I think
> it's reasonable to ignore that as execve() is unlikely to happen in an
> overridden context; or maybe the execve() related ops should be failed if
> ->sid != ->fssid.
> 
> Do you think this is reasonable?  Or do you definitely want me to use the
> suppression flag approach instead?

Just why are you doing all this? Why do we need a back-end that requires
all this extra client-side security infrastructure in order to work? 

IOW: What is wrong with the existing CacheFS?

Trond

