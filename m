Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263521AbTEMXrt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 19:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263528AbTEMXrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 19:47:48 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:48392 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263521AbTEMXrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 19:47:45 -0400
Date: Tue, 13 May 2003 16:56:06 -0700
From: Andrew Morton <akpm@digeo.com>
To: green@namesys.com, jdike@karaya.com, roland@redhat.com,
       linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: build problems on architectures where FIXADDR_* stuff is not
 constant
Message-Id: <20030513165606.25212829.akpm@digeo.com>
In-Reply-To: <20030513134620.3dafeaf3.akpm@digeo.com>
References: <20030513122329.GA31609@namesys.com>
	<20030513134620.3dafeaf3.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 May 2003 00:00:27.0424 (UTC) FILETIME=[D3749200:01C319AB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> wrote:
>
> The new code in get_user_pages() is rather rude - it's returning a
> statically allocated VMA which isn't in the VMA tree - the caller (who
> holds mmap_sem()) could reasonably expect that the VMA can be located via
> find_vma(), or removed from the tree or whatever.  But it cannot.
> 
> I think it needs to be redone.  Either by stuffing a VMA into every
> process's mm which describes the fixmap area, or by failing
> get_user_pages() if the caller has passed in a non-NULL `vmas' and is
> requesting access to the fixmap area.

Or by lazily instantiating the fixmap VMA within get_user_pages().  So if
someone happens to want to access the fixmap, that's when the vma which
describes it gets stuffed into the tree.

That'd require that get_user_pages() be called under down_write(mmap_sem).

