Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264296AbUFXLyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264296AbUFXLyT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 07:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264299AbUFXLyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 07:54:19 -0400
Received: from cantor.suse.de ([195.135.220.2]:29886 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264296AbUFXLyI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 07:54:08 -0400
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SUSE Labs
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: [PATCH] Make POSIX locks compatible with the NPTL thread model
Date: Thu, 24 Jun 2004 13:56:19 +0200
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <1088010468.5806.52.camel@lade.trondhjem.org>
In-Reply-To: <1088010468.5806.52.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200406241356.19925.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trond,

On Wednesday 23 June 2004 19:07, Trond Myklebust wrote:
> Hi,
>
> At some point in 2.5.x we introduced the NPTL thread model at the kernel
> level, and hence redefined the idea of a process: a process appears
> currently to be defined as one or more threads with the same tgid...
> However we failed to completely update the POSIX locking code to reflect
> that change: currently, the POSIX locking code defines the process to be
> a set of one or more threads with the same tgid and a shared file
> table...
>
> As a result we end up with abominations like the steal_locks() function
> that is required in order to move the locks from from one file table to
> another on exec etc.

Nice to see you working on this. I briefly looked into how to fix the same 
thing but didn't find the time to finish it. Here is what I thought; maybe 
it's useful to you.

There are local and remote locks, and both of them need a pid discriminator. 
We have used the files_struct pointer so far which was either a struct 
files_struct pointer or a struct nlm_host pointer. By using pointers we had a 
host+pid "uniquifier". Now we could change the fields from:

	struct file_lock {
		[...]
		fl_owner_t fl_owner;
		unsigned int fl_pid;
		[...]
	};

to:

	struct file_lock {
		[...]
		struct nlm_host *fl_host;	/* NULL for local locks */
		unsigned int fl_pid;
		[...]
	};

There would be no casting of other types into a fl_host here.

Cheers,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX AG
