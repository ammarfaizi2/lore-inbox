Return-Path: <linux-kernel-owner+w=401wt.eu-S1161163AbWLUCzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161163AbWLUCzG (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 21:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161164AbWLUCzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 21:55:05 -0500
Received: from pat.uio.no ([129.240.10.15]:53049 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161163AbWLUCzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 21:55:03 -0500
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content
	corruption on ext3)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Martin Michlmayr <tbm@cyrius.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Andrei Popa <andrei.popa@i-neo.ro>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>, gordonfarquharson@gmail.com,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>
In-Reply-To: <Pine.LNX.4.64.0612201548410.3576@woody.osdl.org>
References: <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org>
	 <1166571749.10372.178.camel@twins>
	 <Pine.LNX.4.64.0612191609410.6766@woody.osdl.org>
	 <1166605296.10372.191.camel@twins>
	 <1166607554.3365.1354.camel@laptopd505.fenrus.org>
	 <1166614001.10372.205.camel@twins>
	 <Pine.LNX.4.64.0612201237280.28787@blonde.wat.veritas.com>
	 <1166622979.10372.224.camel@twins>
	 <20061220170323.GA12989@deprecation.cyrius.com>
	 <Pine.LNX.4.64.0612200928090.6766@woody.osdl.org>
	 <20061220175309.GT30106@deprecation.cyrius.com>
	 <Pine.LNX.4.64.0612201043170.6766@woody.osdl.org>
	 <Pine.LNX.4.64.0612201139280.3576@woody.osdl.org>
	 <20061220153207.b2a0a27f.akpm@osdl.org>
	 <Pine.LNX.4.64.0612201548410.3576@woody.osdl.org>
Content-Type: text/plain
Date: Wed, 20 Dec 2006 21:54:43 -0500
Message-Id: <1166669683.5909.52.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=12.0, autolearn=no, UIO_MAIL_IS_INTERNAL=-5)
X-UiO-SPAM-Test: UIO-GREYLIST 69.242.210.120 spam_score -49 maxlevel 200 minaction 2 bait 0 blacklist 0 greylist 1 ratelimit 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-20 at 15:55 -0800, Linus Torvalds wrote:
> > With your change I think what'll happen is that we'll correctly handle the
> > case where the page and its buffers are dirty (it gets left in place), but
> > we'll needlessy fail in the case where the page is dirty but the buffers
> > are clean.  How important that will be in practice I do not know.  People
> > will get -EIOs where they used not to.
> 
> People will now get -EIO where they used to get an inconsistent system 
> image. I really think it sounds like an improvement.

The hell it is. You end up with a corrupted page cache because
invalidate_inode_pages2_range() immediately exits without throwing out
the pages in the rest of the range.

I can't see that it is the business of invalidate_inode_pages2() to
resolve races between ->direct_IO() and pages that are redirtied by
mmap(). All it needs to ensure is that pages that clean are discarded,
since those are neither consistent with data that the ->directIO() call
wrote to the disk nor are they scheduled to be written to disk.

The only case that I can see that is still problematic is NFS because it
may have unstable writes (hence the ->launder_page() patch that I posted
yesterday).

Trond

