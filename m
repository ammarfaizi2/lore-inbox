Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265967AbTFWGSF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 02:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265969AbTFWGSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 02:18:04 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:6972 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S265967AbTFWGR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 02:17:59 -0400
Date: Sun, 22 Jun 2003 23:32:35 -0700
From: Andrew Morton <akpm@digeo.com>
To: paulmck@us.ibm.com
Cc: andrea@suse.de, dmccr@us.ibm.com, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix vmtruncate race and distributed filesystem race
Message-Id: <20030622233235.0924364d.akpm@digeo.com>
In-Reply-To: <20030623032842.GA1167@us.ibm.com>
References: <133430000.1055448961@baldur.austin.ibm.com>
	<20030612134946.450e0f77.akpm@digeo.com>
	<20030612140014.32b7244d.akpm@digeo.com>
	<150040000.1055452098@baldur.austin.ibm.com>
	<20030612144418.49f75066.akpm@digeo.com>
	<184910000.1055458610@baldur.austin.ibm.com>
	<20030620001743.GI18317@dualathlon.random>
	<20030623032842.GA1167@us.ibm.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Jun 2003 06:32:04.0389 (UTC) FILETIME=[2942E550:01C33951]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul E. McKenney" <paulmck@us.ibm.com> wrote:
>
> > but you can't trap this with a single counter increment in do_truncate:
>  > 
>  > 	CPU 0			CPU 1
>  > 	----------		-----------
>  > 				do_no_page
>  > 	truncate

        i_size = new_i_size;

>  > 	increment counter
>  > 				read counter
>  > 				->nopage

                                check i_size

>  > 	vmtruncate
>  > 				read counter again -> different so retry
>  > 
>  > thanks to the second counter increment after vmtruncate in my fix, the
>  > above race couldn't happen.
> 
>  The trick is that CPU 0 is expected to have updated the filesystem's
>  idea of what pages are available before calling vmtruncate,
>  invalidate_mmap_range() or whichever.

i_size has been updated, and filemap_nopage() will return NULL.

