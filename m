Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261888AbVCHJTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbVCHJTb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 04:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbVCHJTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 04:19:31 -0500
Received: from fire.osdl.org ([65.172.181.4]:49068 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261888AbVCHJTV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 04:19:21 -0500
Date: Tue, 8 Mar 2005 01:18:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: suparna@in.ibm.com
Cc: sebastien.dugue@bull.net, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org, pbadari@us.ibm.com
Subject: Re: [PATCH] 2.6.10 -  direct-io async short read bug
Message-Id: <20050308011814.706c094e.akpm@osdl.org>
In-Reply-To: <20050308090946.GA4100@in.ibm.com>
References: <1110189607.11938.14.camel@frecb000686>
	<20050307223917.1e800784.akpm@osdl.org>
	<20050308090946.GA4100@in.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suparna Bhattacharya <suparna@in.ibm.com> wrote:
>
> ...
> 
> Bugs in this area seem never-ending don't they - plug one, open up
> another - hard to be confident/verify :( - someday we'll have to
> rewrite a part of this code.

It's solving a complex problem.  Any rewrite would probably end up just as
hairy once all the new bugs and corner cases are fixed.  Maybe.


> Hmm, shouldn't dio->result ideally have been adjusted to be within
> i_size at the time of io submission, so we don't have to deal with
> this during completion ? We are creating bios with the right size
> after all. 
> 
> We have this: 
> 		if (!buffer_mapped(map_bh)) {
> 				....
> 				if (dio->block_in_file >=
>                                         i_size_read(dio->inode)>>blkbits) {
>                                         /* We hit eof */
>                                         page_cache_release(page);
>                                         goto out;
>                                 }
> 
> and
> 		dio->result += iov[seg].iov_len -
>                         ((dio->final_block_in_request - dio->block_in_file) <<
>                                         blkbits);
> 
> 
> can you spot what is going wrong here that we have to try and
> workaround this later ?

Good question.  Do we have the i_sem coverage to prevent a concurrent
truncate?

But from Sebastien's description it doesn't soound as if a concurrent
truncate is involved.

