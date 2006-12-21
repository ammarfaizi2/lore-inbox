Return-Path: <linux-kernel-owner+w=401wt.eu-S1161074AbWLUAMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161074AbWLUAMp (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 19:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161071AbWLUAMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 19:12:44 -0500
Received: from smtp.osdl.org ([65.172.181.25]:51729 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161074AbWLUAMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 19:12:43 -0500
Date: Wed, 20 Dec 2006 16:11:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Martin Michlmayr <tbm@cyrius.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
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
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content
 corruption on ext3)
Message-Id: <20061220161158.acb77ce6.akpm@osdl.org>
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
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Dec 2006 15:55:14 -0800 (PST)
Linus Torvalds <torvalds@osdl.org> wrote:

> > > @@ -386,12 +399,8 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
> > 
> > invalidate_complete_page2() is pretty gruesome.  We're handling the case
> > where someone went and redirtied the page (and hence its buffers) after the
> > invalidate_inode_pages2() caller (generic_file_direct_IO) synced it to
> > disk.
> > 
> > I'd prefer to just fail the direct-io if someone did that, but then
> > people's tests fail and they whine.
> 
> So with my change, afaik, we will just return EIO to the invalidate, and 
> do the write.

The write's already been done by this stage.

> Which should be ok. In fact, it appears to be the only 
> possibly valid thing to do.
> 
> It really boils down to that same thing: if you remove the dirty bit, 
> there is NO CONCEIVABLE GOOD THING YOU CAN DO EXCEPT FOR:
>  - do the damn IO already ("clear_page_dirty_for_io()")
>  - truncate the page (unmap and destroy it both from page cache AND from 
>    any user-visible filesystem cases)

There's also redirty_page_for_writepage().

