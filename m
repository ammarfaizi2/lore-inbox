Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263402AbTJBRXW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 13:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263408AbTJBRXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 13:23:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58243 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263402AbTJBRXU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 13:23:20 -0400
Date: Thu, 2 Oct 2003 18:23:19 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.0-test6-mm2
Message-ID: <20031002172318.GF7665@parcelfarce.linux.theplanet.co.uk>
References: <20031002022341.797361bc.akpm@osdl.org> <16252.23200.511369.466054@laputa.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16252.23200.511369.466054@laputa.namesys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 02, 2003 at 09:04:32PM +0400, Nikita Danilov wrote:
> Andrew Morton writes:
>  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test6/2.6.0-test6-mm2/
>  > 
>  > . A large series of VFS patches from Al Viro which replace usage of
>  >   file->f_dentry->d_inode->i_mapping with the new file->f_mapping.
>  > 
>  >   This is mainly so we can get disk hot removal right.
> 
> What consequences does this have for (out-of-the-tree) file systems,
> beyond s/->f_dentry->d_inode->i_mapping/->f_mapping/g ?

None.  It only matters for block device inodes.  Out-of-tree fs is free to
do whatever it does with inodes of regular files/directories/etc.  

In quite a few cases you can cut down on dereferencing that way, but that's
covered by what you've mentioned.

If you take a look at the patchset you'll see
	* change of method prototypes in block devices (aka "you don't need
to start with bdev = inode->i_bdev, you get it from arguments" - check RD1--RD6
and you'll see)
	* a lot of places in mm/* that got aforementioned search-and-replace
treatment
	* very few changes in fs code, most of them of the same variety (same
search-and-replace)
	* couple of helper functions changed their prototypes:
		generic_write_checks() lost "inode" argument
		generic_osync_inode(), OTOH, got explicit address_space one.

That's it.
