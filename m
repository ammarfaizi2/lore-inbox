Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964975AbWAXMJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964975AbWAXMJj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 07:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbWAXMJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 07:09:38 -0500
Received: from mx1.redhat.com ([66.187.233.31]:31180 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964975AbWAXMJi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 07:09:38 -0500
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17366.6372.383039.125496@segfault.boston.redhat.com>
Date: Tue, 24 Jan 2006 07:09:08 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [patch] fix O_DIRECT read of last block in a sparse file
In-Reply-To: <20060123155401.62f7b756.akpm@osdl.org>
References: <17365.11127.860256.702246@segfault.boston.redhat.com>
	<20060123155401.62f7b756.akpm@osdl.org>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> Regarding Re: [patch] fix O_DIRECT read of last block in a sparse file; Andrew Morton <akpm@osdl.org> adds:

akpm> Jeff Moyer <jmoyer@redhat.com> wrote:
>> Currently, if you open a file O_DIRECT, truncate it to a size that is
>> not a multiple of the disk block size, and then try to read the last
>> block in the file, the read will return 0.  The problem is in
>> do_direct_IO, here:
>> 
>> /* Handle holes */ if (!buffer_mapped(map_bh)) { char *kaddr;
>> 
>> ...
>> 
>> if (dio->block_in_file >= i_size_read(dio->inode)>>blkbits) { /* We hit
>> eof */ page_cache_release(page); goto out; }
>> 
>> We shift off any remaining bytes in the final block of the I/O,
>> resulting in a 0-sized read.  I've attached a patch that fixes this.
>> I'm not happy about how ugly the math is getting, so suggestions are
>> more than welcome.
>> 
>> I've tested this with a simple program that performs the steps outlined
>> for reproducing the problem above.  Without the patch, we get a 0-sized
>> result from read.  With the patch, we get the correct return value from
>> the short read.

akpm> OK.  We do have some helper functions to make the math a little
akpm> clearer. How does this look?

That's much cleaner, thanks!

-Jeff
