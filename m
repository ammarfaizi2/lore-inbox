Return-Path: <linux-kernel-owner+w=401wt.eu-S1751149AbXAPTOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbXAPTOa (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 14:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751052AbXAPTOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 14:14:30 -0500
Received: from [213.46.243.15] ([213.46.243.15]:19098 "EHLO
	amsfep13-int.chello.nl" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751156AbXAPTO3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 14:14:29 -0500
X-Greylist: delayed 5863 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Jan 2007 14:14:28 EST
Subject: Re: [patch 6/10] mm: be sure to trim blocks
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Nick Piggin <npiggin@suse.de>
Cc: Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Filesystems <linux-fsdevel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1168968985.5975.30.camel@lappy>
References: <20070113011159.9449.4327.sendpatchset@linux.site>
	 <20070113011255.9449.33228.sendpatchset@linux.site>
	 <1168968985.5975.30.camel@lappy>
Content-Type: text/plain
Date: Tue, 16 Jan 2007 20:14:16 +0100
Message-Id: <1168974857.5975.36.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2007-01-16 at 18:36 +0100, Peter Zijlstra wrote:
>   							buf, bytes);
> > @@ -1935,10 +1922,9 @@ generic_file_buffered_write(struct kiocb
> >  						cur_iov, iov_offset, bytes);
> >  		flush_dcache_page(page);
> >  		status = a_ops->commit_write(file, page, offset, offset+bytes);
> > -		if (status == AOP_TRUNCATED_PAGE) {
> > -			page_cache_release(page);
> > -			continue;
> > -		}
> > +		if (unlikely(status))
> > +			goto fs_write_aop_error;
> > +
> 
> I don't think this is correct, see how status >= 0 is used a few lines
> downwards. Perhaps something along the lines of an
> is_positive_aop_return() to test on?

Hmm, if commit_write() will never return non error positive values then
this and 8/10 look sane.

