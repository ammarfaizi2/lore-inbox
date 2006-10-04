Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030297AbWJDRvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030297AbWJDRvY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 13:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030685AbWJDRvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 13:51:24 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:8165 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1030297AbWJDRvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 13:51:22 -0400
Message-ID: <4523F486.1000604@oracle.com>
Date: Wed, 04 Oct 2006 10:51:02 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jeff Moyer <jmoyer@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] call truncate_inode_pages in the DIO fallback to buffered
 I/O path
References: <x49zmcc6mhh.fsf@segfault.boston.devel.redhat.com> <20061004102522.d58c00ef.akpm@osdl.org>
In-Reply-To: <20061004102522.d58c00ef.akpm@osdl.org>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Why is this a problem?  It's just like someone did a write(), and we'll
> invalidate the pagecache on the next direct-io operation.

This was noticed as a distro regression as they moved from the kernels
that used to invalidate the entire address space on direct io ops to
more modern ones that only invalidate the region being written.

You can end up with significant memory pressure after this change with a
large enough working set on disk.

> eek.  truncate_inode_pages() will throw away dirty data.  Very dangerous,
> much chin-scratching needed.

Yeah, I failed to tell Jeff that it should be calling
filemap_fdatawrite() first to get things into writeback.  (And
presumably not truncating if that returns an error.)
