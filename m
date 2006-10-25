Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbWJYQwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWJYQwI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 12:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbWJYQwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 12:52:08 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:60302 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750726AbWJYQwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 12:52:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cUTK6HzNBArXAY0IWQDd/zjWKQrzmXoD7nD5+dT2gnZYVFTCD9jaMkS1Qw5w+K/CqGxpmkTnKUMOsWQ41A2GX0z+P4FRNIhDQ5/qSEY3ZQOqFtuE9jXt3xV3i+GOvm8GpGQwDOqcVV3O3ODEmkb6X+pCbg+8Hmykf9bkcUaz19k=
Message-ID: <5c49b0ed0610250952i2fcc64b7t47fb7565cada14c6@mail.gmail.com>
Date: Wed, 25 Oct 2006 09:52:03 -0700
From: "Nate Diller" <nate.diller@gmail.com>
To: "David Howells" <dhowells@redhat.com>
Subject: Re: Security issues with local filesystem caching
Cc: sds@tycho.nsa.gov, jmorris@namei.org, chrisw@sous-sol.org,
       selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org, aviro@redhat.com,
       "Christoph Hellwig" <hch@infradead.org>
In-Reply-To: <16969.1161771256@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <16969.1161771256@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/06, David Howells <dhowells@redhat.com> wrote:
>
> Hi,
>
> Some issues have been raised by Christoph Hellwig over how I'm handling
> filesystem security in my CacheFiles module, and I'd like advice on how to deal
> with them.
>
> CacheFiles stores its cache objects as files and directories in a tree under a
> directory nominated by the configuration.  This means the data it is holding
> (a) is potentially exposed to userspace, and (b) must be labelled for access
> control according to the usual filesystem rules.
>
> Currently, CacheFiles temporarily changes fsuid and fsgid to 0 whilst doing its
> own pathwalk through the cache and whilst creating files and directories in the
> cache.  This allows it to deal with DAC security directly.  All the directories
> it creates are given permissions mask 0700 and all files 0000.
>
> However, Christoph has objected to this practice, and has said that I'm not
> allowed to change fsuid and fsgid.  The problem with not doing so is that this
> code is running in the context of the process that issued the original open(),
> read(), write(), etc, and so any accesses or creations it does would be done
> with that process's fsuid and fsgid, which would lead to a cache with bits that
> can't be shared between users.

I don't really understand the objection here.  Is it likely to cause
security breaches?  None of the proposed solutions seem particularly
elegant, so arguing that the current approach is a hack doesn't hold
much water with me.

> Another thing I'm currently doing is bypassing the usual calls to the LSM
> hooks.  This means that I'm not setting and checking security labels and MACs.
> The reason for this is again that I'm running in some random process's context
> and labelling and MAC'ing will affect the sharability of the cache.  This was
> objected to also.
>
> This also bypasses auditing (I think).  I don't want the CacheFiles module's
> access to the cache to be logged against whatever process was accessing, say,
> an NFS file.  That process didn't ask to access the cache, and the cache is
> meant to be transparent.

Christoph, are you objecting to this behavior as well?  This seems
like the desired outcome.  Do you think there is buggy behavior here,
or do you just have issues with David's design?  Can you suggest any
alternatives of your own?

NATE
