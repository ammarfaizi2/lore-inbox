Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264577AbUD1BiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264577AbUD1BiZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 21:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264582AbUD1BiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 21:38:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:21189 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264577AbUD1BiW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 21:38:22 -0400
Date: Tue, 27 Apr 2004 18:38:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: sgoel01@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc{1,2} bad VM/NFS interaction in case of dirty page
 writeback
Message-Id: <20040427183800.1668613c.akpm@osdl.org>
In-Reply-To: <1083115735.5928.119.camel@lade.trondhjem.org>
References: <1083080207.2616.31.camel@lade.trondhjem.org>
	<20040428004707.89142.qmail@web12824.mail.yahoo.com>
	<20040427180253.5a043319.akpm@osdl.org>
	<1083115735.5928.119.camel@lade.trondhjem.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
>
> On Tue, 2004-04-27 at 21:02, Andrew Morton wrote:
> > Shantanu Goel <sgoel01@yahoo.com> wrote:
> > >
> > > Andrew/Trond,
> > > 
> > > Any consensus as to what the right approach is here?
> > 
> > For now I suggest you do
> > 
> > -	err = WRITEPAGE_ACTIVATE;
> > +	err = 0;
> > 
> > in nfs_writepage().
> 
> That will just cause the page to be put back onto the inactive list
> without starting writeback. Won't that cause precisely those kswapd
> loops that Shantanu was worried about?

Possibly - but the process which is in reclaim will throttle and will kick
pdflush which will do the writepages() thing.

It needs testing.  

> AFAICS if you want to do this, you probably need to flush the page
> immediately to disk on the server using a STABLE write as per the
> appeanded patch. The problem is that screws the server over pretty hard
> as it will get flooded with what are in effect a load of 4k O_SYNC
> writes.

Well I'd be interested in discovering which workloads actually suffer
significantly from doing this.  If it's a significant problem then perhaps
we should resurrect the writearound-from-within-writepage thing.  It's
pretty simple to do, especially since we now have efficient ways of finding
neighbouring dirty pages.

