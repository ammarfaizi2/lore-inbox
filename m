Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267199AbUIFVjB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267199AbUIFVjB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 17:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267350AbUIFVjB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 17:39:01 -0400
Received: from fw.osdl.org ([65.172.181.6]:48858 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267199AbUIFVil (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 17:38:41 -0400
Date: Mon, 6 Sep 2004 14:36:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ray Bryant <raybry@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, riel@redhat.com,
       piggin@cyberone.com.au, mbligh@aracnet.com, kernel@kolivas.org
Subject: Re: swapping and the value of /proc/sys/vm/swappiness
Message-Id: <20040906143641.71a2b08c.akpm@osdl.org>
In-Reply-To: <413CD4FF.8070408@sgi.com>
References: <413CB661.6030303@sgi.com>
	<20040906131027.227b99ac.akpm@osdl.org>
	<413CD4FF.8070408@sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ray Bryant <raybry@sgi.com> wrote:
>
> 
> 
> Andrew Morton wrote:
> 
> > 
> > That being said, your tests are interesting.  There's a wide spread of
> > results across different kernel versions and across different swappiness
> > settings.  But the question is: which behaviour is correct for your users,
> > and why?
> > 
> 
> Andrew,
> 
> Behavior more like that of 2.6.5 and 2.6.6 is what we would like to see, I 
> think.  We have had problems in the past with a single large HPC application 
> that runs for a long time then wants to push its data out quickly.  What 
> happens to us in 2.4.21 is that the page cache pages swap out the user pages, 
> and that is somethine we would like to avoid, since it can reduce the data
> rate significantly.

You probably need to decrease /proc/sys/vm/dirty_ratio and
dirty_background_ratio by a lot.  That will reduce the amount of
unreclaimable pagecache and will take pressure off page reclaim.

Also, converting the application to explicitly tell the kernel that it
doesn't want certain data cached will help things a lot. 
posix_fadvise(POSIX_FADV_DONTNEED), preferably preceded by fsync().

> We were planning on suggesting that such users set swappiness=0 to give
> user pages priority over the page cache pages.  But it doesn't look like that 
> works very well in the more recent kernels.

As I say above: avoiding putting all that pressure onto page reclaim in the
first case would be preferable to trying to fix stuff up after it has
happened.

> ...
> On a separate issue, the response to my proposal for a mempolicy to control
> allocation of page cache pages has been <ahem> underwhelming.
> 
> (See: http://marc.theaimsgroup.com/?l=linux-mm&m=109416852113561&w=2
>   and  http://marc.theaimsgroup.com/?l=linux-mm&m=109416852416997&w=2 )
> 
> I wonder if this is because I just posted it to linux-mm or its not fleshed 
> out enough yet to be interesting?
> 

General brain-fry, I expect.  There's a lot happening.
