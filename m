Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262140AbVBUVmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262140AbVBUVmk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 16:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262141AbVBUVmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 16:42:39 -0500
Received: from fire.osdl.org ([65.172.181.4]:31634 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262140AbVBUVmh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 16:42:37 -0500
Date: Mon, 21 Feb 2005 13:42:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: Martin Hicks <mort@wildopensource.com>
Cc: pj@sgi.com, linux-kernel@vger.kernel.org, raybry@sgi.com
Subject: Re: [PATCH/RFC] A method for clearing out page cache
Message-Id: <20050221134220.2f5911c9.akpm@osdl.org>
In-Reply-To: <20050221192721.GB26705@localhost>
References: <20050214154431.GS26705@localhost>
	<20050214193704.00d47c9f.pj@sgi.com>
	<20050221192721.GB26705@localhost>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Hicks <mort@wildopensource.com> wrote:
>
> This patch introduces a new sysctl for NUMA systems that tries to drop
>  as much of the page cache as possible from a set of nodes.  The
>  motivation for this patch is for setting up High Performance Computing
>  jobs, where initial memory placement is very important to overall
>  performance.

- Using a write to /proc for this seems a bit hacky.  Why not simply add
  a new system call for it?

- Starting a kernel thread for each node might be overkill.  Yes, it
  would take longer if one process was to do all the work, but does this
  operation need to be very fast?

  If it does, then userspace could arrange for that concurrency by
  starting a number of processes to perform the toss, each with a different
  nodemask.

- Dropping "as much pagecache as possible" might be a bit crude.  I
  wonder if we should pass in some additional parameter which specifies how
  much of the node's pagecache should be removed.

  Or, better, specify how much free memory we will actually require on
  this node.  The syscall terminates when it determines that enough
  pagecache has been removed.

- To make the syscall more general, we should be able to reclaim mapped
  pagecache and anonymous memory as well.


So what it comes down to is

sys_free_node_memory(long node_id, long pages_to_make_free, long what_to_free)

where `what_to_free' consists of a bunch of bitflags (unmapped pagecache,
mapped pagecache, anonymous memory, slab, ...).
