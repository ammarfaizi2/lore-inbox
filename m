Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbUDOT2P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 15:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbUDOT2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 15:28:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2963 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263117AbUDOT2J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 15:28:09 -0400
Date: Thu, 15 Apr 2004 15:27:35 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Manfred Spraul <manfred@colorfullife.com>, Andrew Morton <akpm@osdl.org>,
       Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mq_open() honor leading slash
Message-ID: <20040415192735.GO31589@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20040415113951.G21045@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040415113951.G21045@build.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2004 at 11:39:51AM -0700, Chris Wright wrote:
> SUSv3 requires the following on mq_open() with name containing leading
> slash:
> 
> 	If name begins with the slash character, then processes
> 	calling mq_open() with the same value of name shall refer to
> 	the same message queue object, as long as that name has not
> 	been removed. If name does not begin with the slash character,
> 	the effect is implementation-defined.  The interpretation of
> 	slash characters other than the leading slash character in name
> 	is implementation-defined.
> 
> The use of lookup_one_len() to force all lookups relative to the
> mqueue_mnt root guarantees absolute rather than relative lookup without
> leading slash, and generates an error on a name that contains any slashes
> at all.  This is inconsitent with the part of the spec that requires
> leading slash to be effectively an absolute path (unless you consider
> -EACCES being "the same message queue object" ;-)
> 
> Patch below simply eats all leading slashes before passing name to
> lookup_one_len() in mq_open() and mq_unlink().

glibc already strips the leading slash in userland.
If you want to do it in the kernel instead, it shouldn't IMHO be silent if it
doesn't see a leading slash or sees more than one. I.e.
	error = -EINVAL;
	if (name[0] != '/')
		goto out_err;
...
	dentry = lookup_one_len(name + 1, mqueue_mnt->mnt_root, strlen(name + 1));

	Jakub
