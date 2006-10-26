Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423249AbWJZK4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423249AbWJZK4j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 06:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423270AbWJZK4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 06:56:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15274 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1423249AbWJZK4i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 06:56:38 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <45407C71.5070407@l4x.org> 
References: <45407C71.5070407@l4x.org>  <16969.1161771256@redhat.com> 
To: Jan Dittmer <jdi@l4x.org>
Cc: sds@tycho.nsa.gov, jmorris@namei.org, chrisw@sous-sol.org,
       selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org, aviro@redhat.com
Subject: Re: Security issues with local filesystem caching 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 26 Oct 2006 11:55:25 +0100
Message-ID: <8791.1161860125@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Dittmer <jdi@l4x.org> wrote:

> > I can see a few ways to deal with this:
> >
> >  (1) Do all the cache operations in their own thread (sort of like knfsd).
> >
> >  (2) Add further security ops for the caching code to call.  These might
> >      be of use elsewhere in the kernel.  These would set cache-specific
> >      security labels and check for them.
> >
> >  (3) Add a flag or something to current to override the normal security on
> >      the basis that it should be using the cache's security rather than
> >      the process's security.
> 
> Why again no local userspace daemon to do the caching?

Because that reduces the problem to option (1), and then we add context
switches and pushing the metadata in and out of userspace.  In addition, the
cache calls back into the netfs to get information.

I'm guess you're thinking of a halfway-house with userspace deciding which
files to open and then opening the file and telling the kernel to use that
file to back a particular netfs inode, with the kernel handling the actual
read/write ops.  If you are, then this brings us back to the ENFILE problem,
and also raises EMFILE as a new possible problem.  But this time, there isn't
a way to escape the ENFILE problem - you're opening files in userspace.

We could have userspace tell the kernel use a file by name rather than
actually opening it and handing over the fd, I suppose; but you still have the
serialisation issue to deal with.

> That would put the policy out of the kernel. The additional context switches
> are probably pretty cheap compared to the io operations.

It's not just a pair of context switches you have to add in.

David
