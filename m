Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269100AbUIHLDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269100AbUIHLDX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 07:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269101AbUIHLDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 07:03:23 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:22970 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S269100AbUIHLDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 07:03:20 -0400
Date: Wed, 8 Sep 2004 13:02:34 +0200
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Jay Lan <jlan@engr.sgi.com>
Subject: Re: [patch 2.6.8.1] BSD accounting: update chars transferred value
Message-ID: <20040908110234.GA9970@frec.bull.fr>
References: <20040908090657.GA9879@frec.bull.fr> <20040908101704.A29949@infradead.org>
Mime-Version: 1.0
In-Reply-To: <20040908101704.A29949@infradead.org>
User-Agent: Mutt/1.5.6+20040722i
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 08/09/2004 13:08:07,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 08/09/2004 13:08:09,
	Serialize complete at 08/09/2004 13:08:09
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2004 at 10:17:04AM +0100, Christoph Hellwig wrote:
> On Wed, Sep 08, 2004 at 11:06:57AM +0200, Guillaume Thouvenin wrote:
> > Hello,
> > 
> >   The goal of this patch is to improve BSD accounting by using what 
> > is done in the CSA into BSD accounting. The final goal is to have a
> > uniform accounting structure. 
> > 
> >   This patch updates information given by BSD accounting concerning
> > bytes read and written. A field is already present in the BSD accounting
> > structure but it is never updated. We don't add information about blocks
> > read and written because, as it was discussed in previous email, the 
> > information is inaccurate. Most writes which are flushed delayed would 
> > get accounted to pdflushd. Thus, one solution to get this kind of 
> > information is to add counters when the write back is performed. The 
> > problem is that we don't know how to get information about the IID at 
> > the page level (ie from struct page). So we remove this information for 
> > the moment and it will be provided in another patch.
> > 
> > Changelog:
> >   
> >   - Adds two counters in the task_struct (rchar, wchar)
> >   - Init fields during the creation of the process (during the fork)
> >   - File I/O operations are done through sys_read(), sys_write(), 
> >     sys_readv(), sys_writev() and sys_sendfile(). Thus we increment 
> >     counters into those functions except with sys_sendfile(). For the
> >     latter, the incrementation is done in the do_sendfile() because this
> >     routine be directly called from the return of sys_sendfile().
> 
> I think it should be done in vfs_readv/vfs_write.  Else we'll miss the
> updates from inekrnel consumers like nfsd.

Yes you're right. vfs_readv() and vfs_writev() called do_readv_writev().
Thus I will send a new patch which updates counters in functions
vfs_read(), vfs_write(), do_readv_writev() and sys_sendfile()
