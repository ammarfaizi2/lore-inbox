Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318147AbSGWSDH>; Tue, 23 Jul 2002 14:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318156AbSGWSDH>; Tue, 23 Jul 2002 14:03:07 -0400
Received: from ns.suse.de ([213.95.15.193]:41230 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318147AbSGWSDA>;
	Tue, 23 Jul 2002 14:03:00 -0400
Date: Tue, 23 Jul 2002 20:06:04 +0200
From: Andi Kleen <ak@suse.de>
To: Gregory Giguashvili <Gregoryg@ParadigmGeo.com>
Cc: "'Andi Kleen'" <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Problem with msync system call
Message-ID: <20020723200604.A10501@wotan.suse.de>
References: <EE83E551E08D1D43AD52D50B9F511092E114A4@ntserver2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EE83E551E08D1D43AD52D50B9F511092E114A4@ntserver2>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2002 at 08:45:07PM +0200, Gregory Giguashvili wrote:
> >Do a F_SETFL lock/unlock on the file  That should act as a 
> >full NFS write barrier and flush all buffers. Best is if you synchronize 
> >between the various writers with the full lock.
> 
> Do you mean F_SETLK? If so, this didn't help (the source is attached).

F_SETLK sorry.

You need to do it on both reader and writer. On the writer it acts
like a fsync(), on the reader it should clear the cache.

I think the problem in your case is that you have the pages mmaped.
NFS uses invalidate_inode_pages() to throw away the cache, but that
doesn't work when the pages are mapped. It may work to munmap/mmap
around the locking.

In theory with rmap (=2.5) the kernel could do that unmap/remap for you,
but it will be probably non trivial to implement.

-Andi
