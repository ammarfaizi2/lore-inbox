Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135274AbRALVbJ>; Fri, 12 Jan 2001 16:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132972AbRALVbB>; Fri, 12 Jan 2001 16:31:01 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:5625 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S133088AbRALVat>;
	Fri, 12 Jan 2001 16:30:49 -0500
Date: Fri, 12 Jan 2001 16:30:44 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Chris Mason <mason@suse.com>
cc: alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: generic_file_write change in 2.4.0-ac8
In-Reply-To: <30380000.979331192@tiny>
Message-ID: <Pine.GSO.4.21.0101121614150.20629-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 Jan 2001, Chris Mason wrote:

> 
> Hi guys,
> 
> This code for generic_file_write calls vmtruncate without i_sem held.  Is
> that intentional?  It should cause problems for reiserfs at least...

Erm... generic_file_write() grabs i_sem upon entry and drops it on exit.
This call of vmtruncate() is deep inside the protected area.

It is taken out of the main path for obvious reasons, but as far as
control flow counts it sits inside the main loop. FWIW, it might
as well be written as
	....
	status = mapping->a_ops->prepare_write(.....);
	if (status) {
		UnlockPage(page);
		deactivate_page(page);
		page_cache_release(page);
		if (pos + bytes > inode->i_size)
			vmtruncate(inode, inode->i_size);
		break;
	}
	...
except that this variant would litter the main path. And the whole loop
is under the ->i_sem - check the beginning of the function.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
