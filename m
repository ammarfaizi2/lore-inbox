Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262400AbVAZJBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262400AbVAZJBe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 04:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262403AbVAZJBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 04:01:33 -0500
Received: from canuck.infradead.org ([205.233.218.70]:24081 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262400AbVAZJBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 04:01:18 -0500
Subject: Re: make flock_lock_file_wait static
From: Arjan van de Ven <arjanv@infradead.org>
To: paulmck@us.ibm.com
Cc: Arjan van de Ven <arjan@infradead.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>, viro@zenII.uk.linux.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050125185812.GA1499@us.ibm.com>
References: <20050109194209.GA7588@infradead.org>
	 <1105310650.11315.19.camel@lade.trondhjem.org>
	 <1105345168.4171.11.camel@laptopd505.fenrus.org>
	 <1105346324.4171.16.camel@laptopd505.fenrus.org>
	 <1105367014.11462.13.camel@lade.trondhjem.org>
	 <1105432299.3917.11.camel@laptopd505.fenrus.org>
	 <1105471004.12005.46.camel@lade.trondhjem.org>
	 <1105472182.3917.49.camel@laptopd505.fenrus.org>
	 <20050125185812.GA1499@us.ibm.com>
Content-Type: text/plain
Date: Wed, 26 Jan 2005 10:01:00 +0100
Message-Id: <1106730061.6307.62.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-25 at 10:58 -0800, Paul E. McKenney wrote:
> On Tue, Jan 11, 2005 at 08:36:22PM +0100, Arjan van de Ven wrote:
> > On Tue, 2005-01-11 at 14:16 -0500, Trond Myklebust wrote:
> > > > (you may think "it's only 100 bytes", well, there are 700+ other such
> > > > functions, total that makes over at least 70Kb of unswappable, wasted
> > > > memory if not more.)
> > > 
> > > A list of these 700+ unused exported APIs would be very useful so that
> > > we can deprecate and/or get rid of them.
> > 
> > http://people.redhat.com/arjanv/unused
> >
> > has the list of symbols that are unused on an i386 allmodconfig based on
> > the -bk tree 2 days ago.
> 
> <donning asbestos suit with the tungsten pinstripes...>
> 
> SAN Filesystem is an out-of-tree GPL module that uses the following:

any plans to submit this for inclusion?

> 
> o	blk_get_queue(): used to submit I/O requests using the
> 	make_request_fn().

sounds really like the wrong level, any reason to not use submit_bio /
submit_bh instead? Every piece of code outside the core block layer that
I've seen that tries to do this has been wrong/broken to date.

> 
> o	sock_setsockopt(): used to control communication with other
> 	nodes in the SAN Filesystem.
> 

again this very much looks like a misuse; sock_setsocketopt() gets a
*userspace* pointer as argument. Bad API to use (and if you look at
CIFS, they would also like a real nice internal api instead, but don't
use sock_setsockopt() since it's the wrong api)


> SDD is a binary module that has committed to get itself to GPL on its
> first release after December 31, 2005.  It uses:
> 
> o	__read_lock_failed() and __write_lock_failed(): due to SDD's use
> 	of read_lock() and write_lock().  So, if the plan is to change
> 	read_lock() and write_lock() to do something different, never mind!

those two exports are "internal" following from copying the
implementation of read_lock() into the code before compiling it (by the
preprocessor) and currently of course won't go away unless readlocks
change/go away.

Another question: is the SDD module even available for mainline kernels,
or is it only available for distribution kernels ?

