Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752125AbWJZJPG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125AbWJZJPG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 05:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752134AbWJZJPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 05:15:06 -0400
Received: from rzcomm12.rz.tu-bs.de ([134.169.9.59]:48370 "EHLO
	rzcomm12.rz.tu-bs.de") by vger.kernel.org with ESMTP
	id S1752125AbWJZJPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 05:15:04 -0400
Message-ID: <45407C71.5070407@l4x.org>
Date: Thu, 26 Oct 2006 11:14:25 +0200
From: Jan Dittmer <jdi@l4x.org>
User-Agent: Thunderbird 2.0b1pre (Windows/20061025)
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: sds@tycho.nsa.gov, jmorris@namei.org, chrisw@sous-sol.org,
       selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org, aviro@redhat.com
Subject: Re: Security issues with local filesystem caching
References: <16969.1161771256@redhat.com>
In-Reply-To: <16969.1161771256@redhat.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
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
> 
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
> 
> I can see a few ways to deal with this:
> 
>  (1) Do all the cache operations in their own thread (sort of like knfsd).
> 
>  (2) Add further security ops for the caching code to call.  These might be of
>      use elsewhere in the kernel.  These would set cache-specific security
>      labels and check for them.
> 
>  (3) Add a flag or something to current to override the normal security on the
>      basis that it should be using the cache's security rather than the
>      process's security.

Why again no local userspace daemon to do the caching? That would
put the policy out of the kernel. The additional context switches
are probably pretty cheap compared to the io operations.

Thanks,

Jan
