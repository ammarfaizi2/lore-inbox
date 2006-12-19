Return-Path: <linux-kernel-owner+w=401wt.eu-S932411AbWLSAFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbWLSAFF (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 19:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932408AbWLSAFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 19:05:05 -0500
Received: from smtp.osdl.org ([65.172.181.25]:33251 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932411AbWLSAFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 19:05:03 -0500
Date: Mon, 18 Dec 2006 16:04:45 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrei Popa <andrei.popa@i-neo.ro>
cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
In-Reply-To: <1166485691.6977.6.camel@localhost>
Message-ID: <Pine.LNX.4.64.0612181559230.3479@woody.osdl.org>
References: <1166314399.7018.6.camel@localhost>  <20061217040620.91dac272.akpm@osdl.org>
 <1166362772.8593.2.camel@localhost>  <20061217154026.219b294f.akpm@osdl.org>
 <1166460945.10372.84.camel@twins>  <Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>
  <1166466272.10372.96.camel@twins>  <Pine.LNX.4.64.0612181030330.3479@woody.osdl.org>
  <1166468651.6983.6.camel@localhost>  <Pine.LNX.4.64.0612181114160.3479@woody.osdl.org>
  <1166471069.6940.4.camel@localhost>  <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org>
  <Pine.LNX.4.64.0612181230330.3479@woody.osdl.org>  <1166476297.6862.1.camel@localhost>
  <Pine.LNX.4.64.0612181426390.3479@woody.osdl.org> <1166485691.6977.6.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 19 Dec 2006, Andrei Popa wrote:
> > 
> > There's exactly two call sites that call "page_mkclean()" (an dthat is the 
> > only thing in turn that calls "page_mkclean_one()", which we already 
> > determined will cause the corruption). 
> >
> > Can you just TOTALLY DISABLE that case for the test_clear_page_dirty() 
> > case? Just do an "#if 0 .. #endif" around that whole if-statement, leaving 
> > the _only_ thing that actually calls "page_mkclean()" to be the 
> > "clear_page_dirty_for_io()" call.
> > 
> > Do you still see corruption?
> 
> nope, no file corruption at all.

Ok. That's interesting, but I think you actually #ifdef'ed out too 
much:

> +
> +#if 0
>  	if (TestClearPageDirty(page)) {
>  		radix_tree_tag_clear(&mapping->page_tree,
>  				page_index(page), PAGECACHE_TAG_DIRTY);
> @@ -866,11 +868,19 @@ int test_clear_page_dirty(struct page *p
>  		 * page is locked, which pins the address_space
>  		 */
>  		if (mapping_cap_account_dirty(mapping)) {
> -			page_mkclean(page);
> +			int cleaned = page_mkclean(page);
> +			if (!must_clean_ptes && cleaned){
> +			WARN_ON(1);
> +			set_page_dirty(page);
> +			}
> +
>  			dec_zone_page_state(page, NR_FILE_DIRTY);
>  		}
>  		return 1;
>  	}
> +
> +#endif
> +

It was really just the _inner_ "if (mapping_cap_account_dirty(.." 
statement that I meant you should remove.

Can you try that too?

		Linus
