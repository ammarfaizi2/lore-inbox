Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262310AbVERQpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262310AbVERQpa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 12:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbVERQm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 12:42:57 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:60072 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S262287AbVERPbQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 11:31:16 -0400
Message-ID: <428B5FC1.3090704@freenet.de>
Date: Wed, 18 May 2005 17:31:13 +0200
From: Carsten Otte <cotte@freenet.de>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       schwidefsky@de.ibm.com, akpm@osdl.org
Subject: Re: [RFC/PATCH 2/5] mm/fs: execute in place (V2)
References: <1116422644.2202.1.camel@cotte.boeblingen.de.ibm.com> <1116424413.2202.17.camel@cotte.boeblingen.de.ibm.com> <20050518142707.GA23162@infradead.org> <428B57AA.2030006@freenet.de> <20050518150053.GA24389@infradead.org>
In-Reply-To: <20050518150053.GA24389@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>On Wed, May 18, 2005 at 04:56:42PM +0200, Carsten Otte wrote:
>  
>
>>I do plainly agree that this would make the code more readable here.
>>But it has a significant downside:
>>Once you have a different set of file operations for either case, you
>>also need to have a different file_operations struct in each individual
>>filesystem using this. Also, this moves the check "do we have xip today?"
>>from here to the filesystem that needs to decide which file operations
>>struct to use.
>>Looking forward, there may be multiple filesystems using this which
>>leads to duplicating the need for this check.
>>    
>>
>
>I don't think that's much of a problem.  The filesystem has a new file_operations
>instance and decided at read_inode time which one to use.  You already have different
>address_space operations and a different truncate anyway.
>
>  
>
Yea, but in addition to the multiplication for the check it would duplicate
significant part of filemap:
- generic_file_read           => xip_file_read
- generic_file_aio_read    => xip_file_aio_read
- __generic_file_aio_read => __xip_file_aio_read
- generic_file_sendfile     => xip_file_sendfile
- generic file_readv          => xip_file_readv
- generic_file_write          => xip_file_write
- generic_file_aio_write_nolock => xip_file_write_nolock
- __generic_file_write_nolock => __xip_file_write_nolock
- generic_file_write_nolock => xip_file_write_nolock
- generic_file_aio_write => xip_file_aio_write
- generic_file_mmap => xip_file_mmap
- generic_file_readonly_mmap => xip_file_readonly_mmap

All changes to these functions would need to be mirrored, and the binary
kernel images with xip enabled would grow by the size of those functions.

But given that the copies of those function would be equivalent to their
original, I honestly think that duplicating them is worse then splitting
the read/write pathes at where handling is in fact different:
- mapping_read
- nopage
- generic_file_write
- truncate page

