Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbTENA4Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 20:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbTENA4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 20:56:24 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:34067 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261450AbTENA4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 20:56:23 -0400
Date: Tue, 13 May 2003 18:10:18 -0700
From: Andrew Morton <akpm@digeo.com>
To: Dave McCracken <dmccr@us.ibm.com>
Cc: mika.penttila@kolumbus.fi, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: Race between vmtruncate and mapped areas?
Message-Id: <20030513181018.4cbff906.akpm@digeo.com>
In-Reply-To: <199610000.1052864784@baldur.austin.ibm.com>
References: <154080000.1052858685@baldur.austin.ibm.com>
	<3EC15C6D.1040403@kolumbus.fi>
	<199610000.1052864784@baldur.austin.ibm.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 May 2003 01:09:03.0090 (UTC) FILETIME=[68955D20:01C319B5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave McCracken <dmccr@us.ibm.com> wrote:
>
> After some though it occurred to me there is a simple alternative scenario
>  that's not protected.  If a task is *already* in a page fault mapping the
>  page in, then vmtruncate() could call zap_page_range() before the page
>  fault completes.  When the page fault does complete the page will be mapped
>  into the area previously cleared by vmtruncate().

That's the one.  Process is sleeping on I/O in filemap_nopage(), wakes up
after the truncate has done its thing and the page gets instantiated in
pagetables.

But it's an anon page now.  So the application (which was racy anyway) gets
itself an anonymous page.

Which can still have buffers attached, which the swapout code needs to be
careful about.

