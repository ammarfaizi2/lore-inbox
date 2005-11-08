Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964990AbVKHFWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964990AbVKHFWy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 00:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965197AbVKHFWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 00:22:54 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:27923 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S964990AbVKHFWx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 00:22:53 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/6] fat: Support a truncate() for expanding size
References: <87hdaotlci.fsf@devron.myhome.or.jp>
	<87d5lctl5y.fsf@devron.myhome.or.jp>
	<878xw0tl3r.fsf_-_@devron.myhome.or.jp>
	<874q6otl0q.fsf_-_@devron.myhome.or.jp>
	<87zmogs6cs.fsf_-_@devron.myhome.or.jp>
	<87vez4s6b7.fsf_-_@devron.myhome.or.jp>
	<87r79ss658.fsf_-_@devron.myhome.or.jp>
	<20051107170626.4d08e8d6.akpm@osdl.org>
	<87ek5rx1ur.fsf@devron.myhome.or.jp>
	<20051107201934.4c01a472.akpm@osdl.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 08 Nov 2005 14:22:44 +0900
In-Reply-To: <20051107201934.4c01a472.akpm@osdl.org> (Andrew Morton's message of "Mon, 7 Nov 2005 20:19:34 -0800")
Message-ID: <874q6nww63.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

>> The generic_cont_expand() is too generic.
>
> But can it be fixed??

Oh, probably we can...

>> If "size" is block boundary, generic_cont_expand() expands the
>> ->i_size to "size + 1", after it, the caller of it will truncate to
>> "size" by vmtruncate().
>
> Something like this?
>

[...]

> -int generic_cont_expand(struct inode *inode, loff_t size)
> +static int __generic_cont_expand(struct inode *inode, loff_t size, int dont_do_that)
>  {
>  	struct address_space *mapping = inode->i_mapping;
>  	struct page *page;
> @@ -2182,9 +2182,8 @@ int generic_cont_expand(struct inode *in
>  	** skip the prepare.  make sure we never send an offset for the start
>  	** of a block
>  	*/
> -	if ((offset & (inode->i_sb->s_blocksize - 1)) == 0) {
> +	if (!dont_do_that &&  (offset & (inode->i_sb->s_blocksize - 1)) == 0)
>  		offset++;

Yes. But, if size is the page boundary, index is different.

Probably something like the below. And I'd like to do vmtruncate()
if ->prepare_write() returns a error. The sync_page_range_nolock()
can do by caller, so not necessary.

Hmm, I'll rethink this at tonight (10 hours later), the result may be
same after all though.

Thanks.


if (!dont_do_that) {
	offset = (size & (PAGE_CACHE_SIZE-1)); /* Within page */

	/* ugh.  in prepare/commit_write, if from==to==start of block, we 
	** skip the prepare.  make sure we never send an offset for the start
	** of a block
	*/
	if ((offset & (inode->i_sb->s_blocksize - 1)) == 0) {
		offset++;
	}
	index = size >> PAGE_CACHE_SHIFT;
} else {
	/* calculate the stuff of last page */
	loff_t pos = size - 1;
	index = pos >> PAGE_CACHE_SHIFT;
	offset = (pos & (PAGE_CACHE_SIZE - 1)) + 1;
}
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
