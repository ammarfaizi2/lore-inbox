Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbUCILcj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 06:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261880AbUCILcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 06:32:39 -0500
Received: from [218.22.21.1] ([218.22.21.1]:64114 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S261879AbUCILcf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 06:32:35 -0500
Date: Tue, 9 Mar 2004 19:28:25 +0800
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fadvise invalidating range fix
Message-ID: <20040309112825.GA4150@mail.ustc.edu.cn>
References: <20040308130754.GA5204@mail.ustc.edu.cn> <20040308120322.118a640b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040308120322.118a640b.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: WU Fengguang <wfg@mail.ustc.edu.cn>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2004 at 12:03:22PM -0800, Andrew Morton wrote:
> WU Fengguang <wfg@mail.ustc.edu.cn> wrote:
> >
> > 
> >  - When 'offset' and/or 'offset+len' do no align to page boundary, we must
> >    decide whether to abandon the partial page at the beginning/end of the range. 
> >    My patch assumes that the application is scanning forward,
> >    which is the most common case.
> >    So 'end_index' is set to the page just before the ending partial page.
> 
> If you're going to preserve the partial page at `end' (which seems
> reasonable) then you should also preserve the partial page at `start', don't
> you agree?
> 
> -	start_index = offset >> PAGE_CACHE_SHIFT;
> +	start_index = (offset + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
> 
In fact, it depends on the access pattern.
I would expect the normal usage of fadvise to be:
	
	for() {
		read() and consume() data in [offset, offset+LEN);
		fadvise(fd, offset, LEN, POSIX_FADV_DONTNEED);
		offset += LEN; /*scanning forward*/
	}
	
In this case, the partial page at `start' should be freed.
Certainly there may be other patterns. 

I wonder the best solution in kernel is to code in favor of the normal case,
and the best(safe and portable) practice in usermode code is to always align
'offset' and 'offset+len' to page boundaries.
And some comment in the manual page of posix_fadvise is recommended.
