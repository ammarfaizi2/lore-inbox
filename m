Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265352AbUAEU1J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 15:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265357AbUAEU1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 15:27:09 -0500
Received: from fw.osdl.org ([65.172.181.6]:17883 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265352AbUAEU1G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 15:27:06 -0500
Date: Mon, 5 Jan 2004 12:27:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: suparna@in.ibm.com, daniel@osdl.org, janetmor@us.ibm.com,
       pbadari@us.ibm.com, linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6.0-test10-mm1] filemap_fdatawait.patch
Message-Id: <20040105122749.1a09d236.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58L.0401051146480.1188@logos.cnet>
References: <20031231091828.GA4012@in.ibm.com>
	<20031231013521.79920efd.akpm@osdl.org>
	<20031231095503.GA4069@in.ibm.com>
	<20031231015913.34fc0176.akpm@osdl.org>
	<20031231100949.GA4099@in.ibm.com>
	<20031231021042.5975de04.akpm@osdl.org>
	<20031231104801.GB4099@in.ibm.com>
	<20031231025309.6bc8ca20.akpm@osdl.org>
	<20031231025410.699a3317.akpm@osdl.org>
	<20031231031736.0416808f.akpm@osdl.org>
	<20040102055020.GA3410@in.ibm.com>
	<Pine.LNX.4.58L.0401051146480.1188@logos.cnet>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>
> 
> 
> On Fri, 2 Jan 2004, Suparna Bhattacharya wrote:
> 
> > On Wed, Dec 31, 2003 at 03:17:36AM -0800, Andrew Morton wrote:
> > > Andrew Morton <akpm@osdl.org> wrote:
> > > >
> > > > Let me actually think about this a bit.
> > >
> > > Nasty.  The same race is present in 2.4.x...
> 
> filemap_fdatawait() is always called with i_sem held and
> there is no "!PG_dirty and !PG_writeback" window.
> 
> Where does the race lies in 2.4 ?

kupdate and bdflush run filemap_fdatawait() without i_sem.  If kupdate has
moved a page off locked_pages to wait on it, a caller of fsync() just won't
see that page at all, and fsync can return while I/O is still in flight.

Given that this only applies to mmap data in 2.4 it doesn't seem
super-important.  A good way to fix it would be to not call
filemap_fdatawait() *at all* if the caller is kupdate or bdflush - it's
silly.   Could use a PF_foo flag for this?

