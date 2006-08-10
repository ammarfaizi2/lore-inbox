Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161092AbWHJGkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161092AbWHJGkK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 02:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161091AbWHJGkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 02:40:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32921 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161089AbWHJGkH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 02:40:07 -0400
Date: Wed, 9 Aug 2006 23:39:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: cmm@us.ibm.com
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/9] extents for ext4
Message-Id: <20060809233940.50162afb.akpm@osdl.org>
In-Reply-To: <1155172827.3161.80.camel@localhost.localdomain>
References: <1155172827.3161.80.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Aug 2006 18:20:26 -0700
Mingming Cao <cmm@us.ibm.com> wrote:

> 
> Add extent map support to ext4. Patch from Alex Tomas.
> 
> On disk extents format:
> /*
>   * this is extent on-disk structure
>   * it's used at the bottom of the tree
>   */
> struct ext3_extent {
>         __le32  ee_block;       /* first logical block extent covers */
>         __le16  ee_len;         /* number of blocks covered by extent */
>         __le16  ee_start_hi;    /* high 16 bits of physical block */
>         __le32  ee_start;       /* low 32 bigs of physical block */
> };
> 

>From a quick scan:

- The code is very poorly commented.  I'd want to spend a lot of time
  reviewing this implementation, but not in its present state.  

- Far, far too many inlines

- overly-terse variable naming

- There are several places which appear to be putting block numbers into
  an `int'.

- Needs kmalloc()->kzalloc() conversion

- replace all brelse() calls with put_bh().  Because brelse() is
  old-fashioned, has a weird name and neelessly permits a NULL arg.

  In fact it would be beter to convert JBD and ext3 to put_bh before
  copying it all over.

- The open-coded __clear_bit(BH_New, ...) in ext4_ext_get_blocks is a bit
  nasty.  We can live with nasty, but are we sure that it isn't buggy??

- It has about 7,000 instances of

	if ((lhs = expression)) {

  whereas the preferred coding style is

	lhs = expression;
	if (lhs) {

- The existing comments could benefit from some rework by a native English
  speaker.


