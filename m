Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290356AbSAXVwc>; Thu, 24 Jan 2002 16:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290361AbSAXVwY>; Thu, 24 Jan 2002 16:52:24 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:43651 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S290356AbSAXVwM>; Thu, 24 Jan 2002 16:52:12 -0500
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200201242152.g0OLq4n08807@eng2.beaverton.ibm.com>
Subject: O_DIRECT broken in 2.5.3-preX ?
To: axboe@suse.de (Jens Axboe)
Date: Thu, 24 Jan 2002 13:52:04 -0800 (PST)
Cc: andrea@suse.de (Andrea Arcangeli), linux-kernel@vger.kernel.org (lkml),
        pbadari@us.ibm.com
In-Reply-To: <20020115145549.M31878@suse.de> from "Jens Axboe" at Jan 15, 2002 01:55:49 PM PST
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am reading the O_DIRECT code patch for 2.5.3-pre4. I was wondering
how is this working in 2.5.X ? Here is my concern:

generic_direct_IO() creates a blocks[] list and passes it to
brw_kiovec() with a single kiobuf.
	
	retval = brw_kiovec(rw, 1, &iobuf, inode->i_dev, blocks, blocksize);

But brw_kiovec() uses only b[0] to call ll_rw_bio().

	for (i = 0; i < nr; i++) {
                iobuf = iovec[i];
                iobuf->errno = 0;

                ll_rw_kio(rw, iobuf, dev, b[i] * (size >> 9));
        }


Note that nr = 1 here. ll_rw_kio() uses b[0] as starting sector
and does the entire IO (for iobuf->length). This is wrong !!!
It is doing IO from wrong blocks.  Some one should use other 
block numbers from blocks[] list. Isn't it ?

What am I missing here ? Please let me know.

Thanks,
Badari
