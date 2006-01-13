Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423032AbWAMW1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423032AbWAMW1T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 17:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423034AbWAMW1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 17:27:18 -0500
Received: from uproxy.gmail.com ([66.249.92.195]:41294 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1423031AbWAMW1Q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 17:27:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bOU2S43T3f9m1/SSsWKEGjC0V9n+HMTgW2Mqd6vuyHuhwHAr7YCr38n6EHCyrOR8KwJC1QoQMCQScfvQziNG1eAZ125bVnwWwSt92liFOwx2su+Oc6+BlBZq2+2cRli9Z+fZUVkFMthZrXMmmCmFUzIkPbLVtmv4bAtZvXiaiaU=
Message-ID: <a4e6962a0601131427m4fc2f88p74da20cdc2fd7fe@mail.gmail.com>
Date: Fri, 13 Jan 2006 16:27:14 -0600
From: Eric Van Hensbergen <ericvh@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH]: v9fs: add readpage support
Cc: linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <20060113141445.14b6469a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060111011437.451FD5A809A@localhost.localdomain>
	 <20060111033821.4b3d4d7b.akpm@osdl.org>
	 <a4e6962a0601131345x6bf4ef3ftf3e6c6fb7bb2b530@mail.gmail.com>
	 <20060113141445.14b6469a.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/06, Andrew Morton <akpm@osdl.org> wrote:
> Eric Van Hensbergen <ericvh@gmail.com> wrote:
> >
> > I went looking for an example of how to do this better.  More or less,
> > v9fs reads and writes are similar to DirectIO since they don't go
> > through the page-cache.
>
> hm.  Why not?
>

At the moment we'd rather not cache anything with v9fs as it hides
operations from the servers, and in the case of synthetic servers it
can be a bad thing.  There is a somewhat well-understood strategy for
how to do cacheing of static files in a sane manner under 9P, but we
were holding off on trying to move that into v9fs for the time being. 
The only reason we added the read-only mmap support back in was to
support users who were trying to access executables over 9P
connections.

> >
> > Now, that being said, it still seems to me to be a bit heavy weight --
> > do folks have a better pointer to code that I can use as an example of
> > how to do this more efficiently?
>
> Not really.  If that's what you need to do then that's the way to do it.
> We've had nasty races and other problems wrt invalidate_inode_pages2 and
> pagefaults, so I suggest you test that mix carefully.
>
> Have you tried fsx-linux?  It's really good for finding data integrity
> bugs.  There's a copy in
> http://www.zip.com.au/~akpm/linux/patches/stuff/ext3-tools.tar.gz.
>

We've been regression testing with vanilla fsx, I'll upgrade to
fsx-linux and make sure we are clean.

>
> I'd suggest that you want the mapping->nrpages test - it'll be a useful
> speedup in the common case.
>

Yeah, as I was tracing through the invalidate_inode_pages2() this
morning I realized this is probably a good idea.  Should have a new
patch to you by the end of the weekend.

          -eric
