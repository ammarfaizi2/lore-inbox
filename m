Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262434AbVDGLnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbVDGLnS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 07:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262439AbVDGLnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 07:43:18 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:29081 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262434AbVDGLnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 07:43:12 -0400
Date: Thu, 7 Apr 2005 12:43:02 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       linux-aio@kvack.org
Subject: Re: [RFC] Add support for semaphore-like structure with support for asynchronous I/O
Message-ID: <20050407114302.GA13363@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Benjamin LaHaise <bcrl@kvack.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Suparna Bhattacharya <suparna@in.ibm.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
	linux-aio@kvack.org
References: <20050330143409.04f48431.akpm@osdl.org> <1112224663.18019.39.camel@lade.trondhjem.org> <1112309586.27458.19.camel@lade.trondhjem.org> <20050331161350.0dc7d376.akpm@osdl.org> <1112318537.11284.10.camel@lade.trondhjem.org> <20050401141225.GA3707@in.ibm.com> <20050404155245.GA4659@in.ibm.com> <20050404162216.GA18469@kvack.org> <1112637395.10602.95.camel@lade.trondhjem.org> <20050405154641.GA27279@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050405154641.GA27279@kvack.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2005 at 11:46:41AM -0400, Benjamin LaHaise wrote:
> On Mon, Apr 04, 2005 at 01:56:35PM -0400, Trond Myklebust wrote:
> > IOW: the current semaphore implementations really all need to die, and
> > be replaced by a single generic version to which it is actually
> > practical to add new functionality.
> 
> I can see that goal, but I don't think introducing iosems is the right 
> way to acheive it.  Instead (and I'll start tackling this), how about 
> factoring out the existing semaphore implementations to use a common 
> lib/semaphore.c, much like lib/rwsem.c?  The iosems can be used as a 
> basis for the implementation, but we can avoid having to do a giant 
> s/semaphore/iosem/g over the kernel tree.

Note that iosem is also a total misowner, it's not a counting semaphore
but a sleeping mutex with some special features.

Now if someone wants my two cent on how to resolve the two gazillion different
implementations mess:

 - switch all current semaphore users that don't need counting semaphores
   over to use a mutex_t type.  For now it can map to struct semaphore.
 - rip out all existing complicated struct semaphore implementations and
   replace it with a portable C implementation.  There's not a lot of users
   anyway.  Add a mutex_t implementation that allows sensible assembly hooks
   for architectures instead of reimplementing all of it
 - add more features to mutex_t where nessecary

