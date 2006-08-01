Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932564AbWHAKSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932564AbWHAKSs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 06:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932558AbWHAKSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 06:18:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:53958 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932557AbWHAKSr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 06:18:47 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060801090259.GB10032@X40.localnet> 
References: <20060801090259.GB10032@X40.localnet>  <20060727205222.8443.29381.stgit@warthog.cambridge.redhat.com> <20060727205333.8443.97943.stgit@warthog.cambridge.redhat.com> 
To: Jan Blunck <j.blunck@tu-harburg.de>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       steved@redhat.com, trond.myklebust@fys.uio.no,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 30/30] VFS: Destroy the dentries contributed by a superblock on unmounting [try #11] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 01 Aug 2006 11:18:05 +0100
Message-ID: <25845.1154427485@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Blunck <j.blunck@tu-harburg.de> wrote:

> IMHO it is better to fix shrink_dcache_for_umount() so that it is a
> replacement for shrink_dcache_sb().

The former may only be used when we *know* there aren't any references
remaining to any of the dentries (as it severely reduces the amount of time
spent holding the dcache_lock).  The latter is used in situations in which the
assumptions of the former don't hold true.

Now I could make the former hold the locking a lot more (I had a version of
the patch that did that), but the former destroys all an sb's dentries,
whether or not they're still in use (which they shouldn't be), and the latter
does not.

The latter also doesn't reap the anon list directly; only where anon dentries
are also unused does any anon reaping occur.  The former reaps them directly
and forcibly.

So, in conclusion, I don't think you can replace the latter with the former,
and the latter is insufficiently complete to replace the former.

> BTW: Talking about shrink_dcache_sb(): is it really necessary to call
> shrink_dcache_sb() when remounting a filesystem? The only reason I can see
> are changes to the lookup mechanism (hash algorithm etc) but a quick look
> into the different filesystems forbid the change of this options during
> remount.

If you're just remounting, then not all dentries can necessarily be purged
anyway - some of them may still be open.  Consider remounting root for
read-only or read-write...

David
