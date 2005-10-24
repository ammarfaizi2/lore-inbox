Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbVJXQCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbVJXQCu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 12:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbVJXQCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 12:02:50 -0400
Received: from gold.veritas.com ([143.127.12.110]:24134 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751131AbVJXQCt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 12:02:49 -0400
Date: Mon, 24 Oct 2005 17:01:53 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: David Howells <dhowells@redhat.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Carsten Otte <cotte@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: what happened to page_mkwrite? - was: Re: page_mkwrite seems
 broken
In-Reply-To: <1130168619.19518.43.camel@imp.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.61.0510241648170.4338@goblin.wat.veritas.com>
References: <1130167005.19518.35.camel@imp.csi.cam.ac.uk> 
 <Pine.LNX.4.61.0502091357001.6086@goblin.wat.veritas.com> 
 <7872.1130167591@warthog.cambridge.redhat.com> <1130168619.19518.43.camel@imp.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 24 Oct 2005 16:02:49.0265 (UTC) FILETIME=[6192CA10:01C5D8B4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Oct 2005, Anton Altaparmakov wrote:
> 
> I don't really mind either way.  I am stuck with ntfs at the moment at
> the point where I am either going to use my own ->nopage handler to
> allocate on-disk clusters or have a ->page_mkwrite handler do it.  The
> former is not nice as it means we allocate space even when only reading
> whilst the later is very nice as it only triggers when someone actually
> does an mmapped write.

A complication to beware of there (and I may be misunderstanding, but
the point is worth making).  If you have already mmaped readonly zero
pages into some mms, you'll need to update those mms with the new
shared writable pages once they are allocated.  That put me off using
page_mkwrite in tmpfs, but Carsten has solved the problem (though
not going so far as to use page_mkwrite) with his xip_file_nopage
in mm/filemap_xip.c - has to go down the vma_prio_tree like rmap.

(That code is a little different in -mm, partly because of my page
table locking changes, partly because of Nick's ZERO_PAGE changes.)

Hmm, strictly speaking, it should be substituting the new page
when VM_LOCKED: whether that's worth the effort of implementing....

Hugh
