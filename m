Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751215AbWDTSHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbWDTSHA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 14:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbWDTSHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 14:07:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:3250 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751208AbWDTSG7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 14:06:59 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060420171857.GA21659@infradead.org> 
References: <20060420171857.GA21659@infradead.org>  <20060420165927.9968.33912.stgit@warthog.cambridge.redhat.com> <20060420165932.9968.40376.stgit@warthog.cambridge.redhat.com> 
To: Christoph Hellwig <hch@infradead.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       steved@redhat.com, sct@redhat.com, aviro@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] FS-Cache: Avoid ENFILE checking for kernel-specific open files 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Thu, 20 Apr 2006 19:06:42 +0100
Message-ID: <22114.1145556402@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:

> > Make it possible to avoid ENFILE checking for kernel specific open files,
> > such as are used by the CacheFiles module.
> > 
> > After, for example, tarring up a kernel source tree over the network, the
> > CacheFiles module may easily have 20000+ files open in the backing
> > filesystem, thus causing all non-root processes to be given error ENFILE
> > when they try to open a file, socket, pipe, etc..
> 
> No, just increase the limit.  The whole point of the limit is to avoid
> resource exaustion.  A file doesn't use any less ressources just becuase
> it's opened from kernelspace.  In doubt increase the limit or even the
> default limit.

As I saw it, the limit is there to prevent userspace from pinning too many
file resources.  Yes, each userspace process is limited by its rlimit, but you
have to multiply that by the number of processes that can be around:

	1024 * 32767 > 32 million files


Besides, you say "increase the limit", but there are two problems with that:

 (1) Each AFS or NFS _dentry_ retained in the system pins a file in the
     backing cache if it's also cached, whether or not it's open.  So on my
     desktop box, I've got about a million dentries cached.  That means I
     might also have anything up to a million files open... Except that the
     netfs would be denied caching rights on any file beyond the ENFILE limit
     - not that that matters, since you wouldn't be able to exec or open
     anything if you weren't root - and that might include running su and the
     like.

 (2) And what should the limit actually _be_?  You haven't said.  If you
     include the cache in the limit, you can at best open ENFILE limit / 2
     files on the netfs before you get moaned at by the system... And then
     closed files aren't immediately released by the cache, so you can quickly
     find yourself backed into a corner...

With this patch, CacheFiles's consumption of files is controlled by the dcache
reclaimer and not by ENFILE, and allocating more files will cause other cache
files to be closed automatically.

The cache can't arbitrarily close backing files for which no userspace file
descriptor remains open: there may be dirty pages, or the file may be mmapped.

David
