Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263824AbVBDRS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263824AbVBDRS6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 12:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264890AbVBDRS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 12:18:57 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:61969 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S264490AbVBDRSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 12:18:31 -0500
Date: Fri, 4 Feb 2005 17:17:55 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: Bryan Henderson <hbryan@us.ibm.com>, David Howells <dhowells@redhat.com>,
       Andrew Morton <akpm@osdl.org>, fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>, nathans@sgi.com,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: RFC: [PATCH-2.6] Add helper function to lock multiple page cache
    pages - nopage alternative
In-Reply-To: <1107531392.12460.14.camel@imp.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.61.0502041657080.10578@goblin.wat.veritas.com>
References: <OF29E48791.2D4A4A03-ON88256F9D.0068D5C2-88256F9D.006A8ECF@us.ibm.com> 
    <1107531392.12460.14.camel@imp.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Feb 2005, Anton Altaparmakov wrote:
> On Thu, 2005-02-03 at 11:23 -0800, Bryan Henderson wrote:
> > 
> > I think the point is that we can't have a "handler for writes," because 
> > the writes are being done by simple CPU Store instructions in a user 
> > program.  The handler we're talking about is just for page faults.  Other 
> 
> That was my understanding.
> 
> > operating systems approach this by actually _having_ a handler for a CPU 
> > store instruction, in the form of a page protection fault handler -- the 
> > nopage routine adds the page to the user's address space, but write 
> > protects it.  The first time the user tries to store into it, the 
> > filesystem driver gets a chance to do what's necessary to support a dirty 
> > cache page -- allocate a block, add additional dirty pages to the cache, 
> > etc.  It would be wonderful to have that in Linux.
> 
> It would.  This would certainly solve this problem.

Isn't this exactly what David Howells' page_mkwrite stuff in -mm's
add-page-becoming-writable-notification.patch is designed for?

Though it looks a little broken to me as it stands (beyond the two
fixup patches already there).  I've not found time to double-check
or test, apologies in advance if I'm libelling, but...

(a) I thought the prot bits do_nopage gives a pte in a shared writable
    mapping include write permission, even when it's a read fault:
    that can't be allowed if there's a page_mkwrite.

(b) I don't understand how do_wp_page's "reuse" logic for whether it
    can just go ahead and use the existing anonymous page, would have
    any relevance to calling page_mkwrite on a shared writable page,
    which must be used and not COWed however many references there are.

Didn't look further, think you should take a look at page_mkwrite,
but don't expect the implementation to be correct yet.

Hugh
