Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269724AbUJMO2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269724AbUJMO2M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 10:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269727AbUJMO2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 10:28:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24750 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269724AbUJMO2D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 10:28:03 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16749.15133.627859.786023@segfault.boston.redhat.com>
Date: Wed, 13 Oct 2004 10:26:37 -0400
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, akpm@osdl.org
Subject: Re: [patch rfc] towards supporting O_NONBLOCK on regular files
In-Reply-To: <1097531370.2128.356.camel@sisko.scot.redhat.com>
References: <16733.50382.569265.183099@segfault.boston.redhat.com>
	<20041005112752.GA21094@logos.cnet>
	<16739.61314.102521.128577@segfault.boston.redhat.com>
	<20041006120158.GA8024@logos.cnet>
	<1097119895.4339.12.camel@orbit.scot.redhat.com>
	<20041007101213.GC10234@logos.cnet>
	<1097519553.2128.115.camel@sisko.scot.redhat.com>
	<16746.55283.192591.718383@segfault.boston.redhat.com>
	<1097531370.2128.356.camel@sisko.scot.redhat.com>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> Regarding Re: [patch rfc] towards supporting O_NONBLOCK on regular files; "Stephen C. Tweedie" <sct@redhat.com> adds:

sct> Hi, On Mon, 2004-10-11 at 19:58, Jeff Moyer wrote:

sct> I think it's worth getting this right in the long term, though.
sct> Getting readahead of indirect blocks right has other benefits too ---
sct> eg. we may be able to fix the situation where we end up trying to read
sct> indirect blocks before we've even submitted the IO for the previous
sct> data blocks, breaking the IO pipeline ordering.
>> So for the short term, are you an advocate of the patch posted?

sct> In the short term, can't we just disable readahead for O_NONBLOCK?
sct> That has true non-blocking semantics --- if the data is already
sct> available we return it, but if not, it's up to somebody else to
sct> retrieve it.

sct> That's exactly what you want if you're genuinely trying to avoid
sct> blocking at all costs on a really hot event loop, and the semantics
sct> seem to make sense to me.  It's not that different from the networking
sct> case where no amount of read() on a non-blocking fd will get you more
sct> data unless there's another process somewhere filling the stream.

Yes, that sounds like a fine idea.  Here is a patch which does this.
Andrew, I know you only want bug fixes, but I'd like to get this into your
queue for post 2.6.9, if possible.

Thanks,

Jeff

--- linux-2.6.9-rc4-mm1/mm/filemap.c~	2004-10-12 12:40:01.000000000 -0400
+++ linux-2.6.9-rc4-mm1/mm/filemap.c	2004-10-12 12:53:13.202396656 -0400
@@ -692,7 +692,7 @@ void do_generic_mapping_read(struct addr
 	unsigned long index, end_index, offset;
 	loff_t isize;
 	struct page *cached_page;
-	int error;
+	int error, nonblock = filp->f_flags & O_NONBLOCK;
 	struct file_ra_state ra = *_ra;
 
 	cached_page = NULL;
@@ -721,16 +721,27 @@ void do_generic_mapping_read(struct addr
 		nr = nr - offset;
 
 		cond_resched();
-		page_cache_readahead(mapping, &ra, filp, index);
+		if (!nonblock)
+			page_cache_readahead(mapping, &ra, filp, index);
 
 find_page:
 		page = find_get_page(mapping, index);
 		if (unlikely(page == NULL)) {
+			if (nonblock) {
+				desc->error = -EWOULDBLOCK;
+				break;
+			}
 			handle_ra_miss(mapping, &ra, index);
 			goto no_cached_page;
 		}
-		if (!PageUptodate(page))
+		if (!PageUptodate(page)) {
+			if (nonblock) {
+				page_cache_release(page);
+				desc->error = -EWOULDBLOCK;
+				break;
+			}
 			goto page_not_up_to_date;
+		}
 page_ok:
 
 		/* If users can be writing to this page using arbitrary
@@ -976,7 +987,7 @@ __generic_file_aio_read(struct kiocb *io
 			desc.error = 0;
 			do_generic_file_read(filp,ppos,&desc,file_read_actor);
 			retval += desc.written;
-			if (!retval) {
+			if (!retval || desc.error) {
 				retval = desc.error;
 				break;
 			}

