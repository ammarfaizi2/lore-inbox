Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbVBLVEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbVBLVEl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 16:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbVBLVEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 16:04:41 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:16257 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261179AbVBLVEi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 16:04:38 -0500
Subject: Re: [RFC 2.6.11-rc2-mm2 7/7] mm: manual page migration --
	sys_page_migrate
From: Dave Hansen <haveblue@us.ibm.com>
To: Ray Bryant <raybry@sgi.com>
Cc: Hirokazu Takahashi <taka@valinux.co.jp>, Hugh DIckins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>, Marcello Tosatti <marcello@cyclades.com>,
       Ray Bryant <raybry@austin.rr.com>, linux-mm <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050212032620.18524.15178.29731@tomahawk.engr.sgi.com>
References: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com>
	 <20050212032620.18524.15178.29731@tomahawk.engr.sgi.com>
Content-Type: text/plain
Date: Sat, 12 Feb 2005 13:04:22 -0800
Message-Id: <1108242262.6154.39.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-02-11 at 19:26 -0800, Ray Bryant wrote:
> This patch introduces the sys_page_migrate() system call:
> 
> sys_page_migrate(pid, va_start, va_end, count, old_nodes, new_nodes);
> 
> Its intent is to cause the pages in the range given that are found on
> old_nodes[i] to be moved to new_nodes[i].  Count is the the number of
> entries in these two arrays of short.

Might it be useful to use nodemasks instead of those arrays?  That's
already the interface that the mbind() interfaces use, and it probably
pays to be consistent with all of the numa syscalls.

There also probably needs to be a bit more coordination between the
other NUMA API and this one.  I noticed that, for now, the migration
loop only makes a limited number of passes.  It appears that either you
don't require that, once the syscall returns, that *all* pages have been
migrated (there could have been allocations done behind the loop) or you
have some way of keeping the process from doing any more allocations.

There might also be some use to making sure that the NUMA binding API
and the migration code agree what is in the affected VMA.  Otherwise,
there might be some interesting situations where kswapd is swapping
pages out behind a migration call, and the NUMA API is refilling those
pages with ones that the migration call doesn't agree with.

That's one reason I was looking at the loop to make sure it's only one
pass.  I think doing passes until all pages are migrated gives you a
livelock, so the limited number obviously makes sense. 

Will you need other APIs to tell how successful the migration request
was?  Simply returning how many pages were migrated back from the
syscall doesn't really tell you anything concrete because there could be
kswapd activity or other migration calls that could be messing up the
work from the previous call.  Are all of these VMAs meant to be
mlock()ed?

-- Dave

