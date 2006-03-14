Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750972AbWCNQa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbWCNQa0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 11:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWCNQaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 11:30:25 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:37000 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750972AbWCNQaZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 11:30:25 -0500
Subject: Re: [PATCH] Add "-o bh" option to ext3
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: akpm@osdl.org, ext2-devel <Ext2-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20060314094745.GA10870@elf.ucw.cz>
References: <1142016591.21442.38.camel@dyn9047017100.beaverton.ibm.com>
	 <20060313095215.GA3700@elf.ucw.cz>
	 <1142296405.21442.54.camel@dyn9047017100.beaverton.ibm.com>
	 <20060314094745.GA10870@elf.ucw.cz>
Content-Type: text/plain
Date: Tue, 14 Mar 2006 08:32:03 -0800
Message-Id: <1142353923.21442.90.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-14 at 10:47 +0100, Pavel Machek wrote:
> Hi!
> 
> > > > Its not really need for now, but as we try to make "nobh"
> > > > as default option, it would be nice to have a "-obh" fallback
> > > > option - if things go wrong.
> > > 
> > > Docs patch is missing...
> > > 
> > > ...and no, it is not even clear to me what bh vs. nobh does...
> > 
> > Hope this helps.
> 
> Not really, I still am not sure what it does. Is it like "nobh is more
> effective code, and should have exactly zero impact to the user, but
> as it is new, we make it optional"?

I wish, its that easy to say :)

Historically (2.4 and earlier), buffer_head is the primary structure for
doing IO. We also used it as the interface between VFS, helper functions
and filesystem-specific code to pass physical disk block# information.
We also used them to link buffers/pages/data to JBD transactions to
provide ordering guarantees (for various journal modes).

Now (2.6), we no longer use buffer_head as a primary IO descriptor, 
but we still use it for other reasons. In general, buffer_heads are 
evil - eats up low mem, lots of them floating around, bigger code path,
bigger memory foot print, causes TLB/SLB misses, causes fragmentation
etc..

"nobh" option tries to attaching buffer_head to pages to cache disk
block mapping information. Where ever its needed, it uses temporary
(on stack) buffer_head to pass it to lower-level filesystem-specific
code and uses the disk block# mapping info from it - to create bios.
(BTW, since its also used for transaction ordering - we can't support
"nobh" option for all journaling modes).

Now, "zero impact to user ?" - don't know for sure. Since buffer_head
nicely cache disk block mapping information - we save on calls to
filesystem->get_block() when we need this. With "nobh" option, 
we need to do this every time. Especially on filesystems with 
blocksize < pagesize (1k, 2k) - we may need to multiple calls to 
->get_block() to get all the disk block#s for a single page (4k). 
These calls,  *in theory* could end up doing a disk read. All the
benefits of not having buffer_heads may be worth taking this 
overhead ?  Don't know for sure - thats why this is an "option" 
for now :(

Clear as mud ? :)

Thanks,
Badari

