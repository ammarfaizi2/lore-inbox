Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265023AbSJPPAs>; Wed, 16 Oct 2002 11:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265027AbSJPPAs>; Wed, 16 Oct 2002 11:00:48 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:53488 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S265023AbSJPPAq>; Wed, 16 Oct 2002 11:00:46 -0400
Date: Wed, 16 Oct 2002 11:06:42 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Janet Morgan <janetmor@us.ibm.com>
Cc: Christoph Hellwig <hch@sgi.com>, akpm@digeo.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: [RFC] iovec in ->aio_read/->aio_write
Message-ID: <20021016110642.A9121@redhat.com>
References: <20021015153427.A16156@redhat.com> <200210160651.g9G6pMm17385@eng4.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200210160651.g9G6pMm17385@eng4.beaverton.ibm.com>; from janetmor@us.ibm.com on Tue, Oct 15, 2002 at 11:51:21PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 11:51:21PM -0700, Janet Morgan wrote:
> - two new opcodes (IOCB_CMD_PREADV and IOCB_CMD_PWRITEV)
> - a field to the iocb for the user vector
> - aio_readv/writev methods to the file_operations structure
> - routine aio.c/io_readv_writev, which borrows heavily from do_readv_writev. 

A few comments about the interface to userland: don't add fields to the 
iocb, that breaks the abi.  Also, the iovec should be pointed to by 
iocb->aio_buf, with aio_nbytes containing the length of the iovec (that 
avoids the need for an additional field).  The structure of the iovec 
itself should probably match the iovec struct, but that means we'll need 
different opcodes for the 32 bit and 64 bit variants.  Alternatively a 
new iovec that is the same on both (like the iocb) could be defined, but 
that would be inconvenient for userland.

Within the kernel, the loff_t *pos shouldn't be a pointer -- I'm trying to 
get rid of extraneous pointers as that means an additional chunk of memory 
has to be held over the entirety of the aio request.  Similarly, the iovec 
passed into the operation itself can never be allocated on the stack.  This 
probably works for direct io where the iovec gets translated into a scatter 
gather list of pages, but wouldn't work for something like networking where 
the iovec itself gets used to determine where in the user address space to 
copy data (as this can occur after the submit operation has returned).

Aside from those details, I guess if people really need vectored ios it's 
okay.

		-ben
