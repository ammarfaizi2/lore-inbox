Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264507AbTLQTZx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 14:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264511AbTLQTZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 14:25:53 -0500
Received: from fw.osdl.org ([65.172.181.6]:46761 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264507AbTLQTZv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 14:25:51 -0500
Subject: Re: [PATCH linux-2.6.0-test10-mm1] filemap_fdatawait.patch
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: janetmor@us.ibm.com, Suparna Bhattacharya <suparna@in.ibm.com>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20031216180319.6d9670e4.akpm@osdl.org>
References: <3FCD4B66.8090905@us.ibm.com>
	 <1070674185.1929.9.camel@ibm-c.pdx.osdl.net>
	 <1070907814.707.2.camel@ibm-c.pdx.osdl.net>
	 <1071190292.1937.13.camel@ibm-c.pdx.osdl.net>
	 <1071624314.1826.12.camel@ibm-c.pdx.osdl.net>
	 <20031216180319.6d9670e4.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1071689105.1826.46.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 17 Dec 2003 11:25:05 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-12-16 at 18:03, Andrew Morton wrote:
> Daniel McNeil <daniel@osdl.org> wrote:
> >
> > I have found something else that might be causing the problem.
> > filemap_fdatawait() skips pages that are not marked PG_writeback.
> > However, when a page is going to be written, PG_dirty is cleared
> > before PG_writeback is set (while the PG_locked is set).  So it
> > looks like filemap_fdatawait() can see a page just before it is
> > going to be written and not wait for it.  Here is a patch that
> > makes filemap_fdatawait() wait for locked pages as well to make
> > sure it does not missed any pages.
> 
> This filemap_fdatawait() behaviour is as-designed.  That function is only
> responsible for waiting on I/O which was initiated prior to it being
> invoked.  Because it is designed for fsync(), fdatasync(), O_SYNC, msync(),
> sync(), etc.
> 
> Now, it could be that this behaviour is not appropriate for the O_DIRECT
> sync function - the result of your testing will be interesting.
> 

My tests still failed overnight.  I was thinking that maybe a
non-blocking do_writepages() was happening at the same time as
the filemap_fdatawrite()/filemap_fdatawait(), so even though the
page was dirty before the filemap_fdatawrite(), it was missed.

Daniel

