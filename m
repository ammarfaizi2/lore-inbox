Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286928AbRL1PPe>; Fri, 28 Dec 2001 10:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286929AbRL1PPY>; Fri, 28 Dec 2001 10:15:24 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:62080 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S286928AbRL1PPI>; Fri, 28 Dec 2001 10:15:08 -0500
Date: Fri, 28 Dec 2001 15:50:06 -0500
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de
Subject: bio_io_vec and kvecs integration
Message-ID: <20011228155006.A1519@in.ibm.com>
Reply-To: suparna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since bio, aio and zero-copy networking code all make use of a similar 
representation of a memory vector or i/o currency, I was looking at
what it would take at bio level to make sure that these descriptors can
be passed down as is to the block layer (without having to translate or
copy descriptors). 

Ben has already posted some patches to change bio and skbuff fragments to
his kveclet representation. Once all these subsystems share the same
representation, the next step is to be able to pass the vectors around as
is.

Some of the changes towards this sort of a thing went in during one of
the early updates to bio. The bio structure was modified to maintain a 
pointer to the vector list, so it can point to a vector list sent down
to it by the calling subsystem. Well, this change was also needed for
bio cloning (for lvm etc) and that's all its been used for so far since 
we don't have kvecs in the kernel yet.

I think just a little more work is needed to get bio layer to take in
a vector directly. This is because currently the block layer could modify
the bv_offset and bv_len fields in the vector directly (as part of
end_that_request_first processing) in case the whole segment/veclet/bvec 
doesn't get transfered/completed in one shot. This could result in 
unexpected effects for the higher layer if it tried to interpret the
vector or say copy data from it after the i/o completes.

So, should we add a bi_voffset field, which can be used in conjunction with
bi_vidx to locate exactly where to start the next i/o transfer from/to, and 
try to leave bv_offset and bv_len fields untouched during request processing ?
Or is there some other way to do this ?

One of these days we're going to have to sort out the kiobuf/kvec decision
for 2.5, but that's probably a discussion for a little later.

Regards
Suparna
