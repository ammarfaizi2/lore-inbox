Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269470AbUI3UV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269470AbUI3UV3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 16:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269471AbUI3UV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 16:21:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14520 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269470AbUI3UVV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 16:21:21 -0400
Subject: Re: [PATCH/RFC] Simplified Readahead
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: Stephen Tweedie <sct@redhat.com>, Steven Pratt <slpratt@austin.ibm.com>,
       Ram Pai <linuxram@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040929231327.GM2061@schnapps.adilger.int>
References: <Pine.LNX.4.44.0409291113580.4449-600000@localhost.localdomain>
	 <415B3845.3010005@austin.ibm.com>
	 <20040929231327.GM2061@schnapps.adilger.int>
Content-Type: text/plain
Organization: 
Message-Id: <1096575644.1977.463.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 30 Sep 2004 21:20:44 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2004-09-30 at 00:13, Andreas Dilger wrote:
> On a readahead-related note, I'm wondering how hard it would be to have
> some tunables and/or hooks from the readahead state manchine made
> available to the filesystem?  With the 2.4 readahead code it was basically
> impossible for the filesystem to disable the readahead, I haven't looked
> at the 2.6 readahead enough to determine whether we need that or not.

Well, readahead is still done internally by filemap.c without consulting
the individual fs.

> The real issue (reason for turning off RA in 2.4) is that within Lustre
> there can be many DLM extent locks for a single file, so client A can
> be writing to one part of the file, and client B can be reading from
> another part of the same file.  With the stock readahead it wouldn't
> stay within the lock extent boundaries, and we couldn't turn it off
> easily.  Having some sort of FS method that says "don't do RA beyond
> this offset" would be useful here.

Do you really want that, though?  I'd have thought that grabbing a DLM
lock was potentially a high-latency operation, so you might actually
_benefit_ from notification that you want to start acquiring it early. 
If it's going to be prohibitively expensive to acquire, though, you'd
still want the option of not doing so.

But there's not really any way for the fs to tell right now whether a
read is for readahead or not.  It can _nearly_ do so: if you implement
a_ops->readpages(), then that only gets called for readahead.  

Trouble is, that same readahead code is also used to kick off early
reads when the user actually requested a single large read.  If the app
reads 100k at once, then do_generic_mapping_read() first kicks off
readahead, then does individual page-sized read_page()s to get the
data.  And the readahead code doesn't really know about this at all; it
can't tell what amount of sequential data the user is guaranteed to
want.

ext3 could make use of this sort of information too, btw.  Currently,
mpage_readpages() ends up calling the fs get_block() to map all the
pages for reading, before submitting the IO request; and even though
the final IO is async, the get_block() is still fully synchronous.  If
ext3 knew it was a readahead, it could potentially queue the read for
the indirect block and return EAGAIN, stopping the readahead at the
point where we don't yet have mapping information in cache.

But you don't want ext3_get_block() returning EAGAIN for synchronous
reads. :-)

> The other problem that Lustre had was that the stock readahead would
> send out page reads in small chunks as the window grew instead of
> sending out large requests that could be turned into large, efficient
> network RPCs.  So the desire would be to have some sort of tunable in
> the readahead state (per fs or per file) that says "don't submit
> another readahead until the window is growing by X pages".

Does the current 2.6 ahead-window readahead still show that problem?

--Stephen


