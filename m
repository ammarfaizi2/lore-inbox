Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314429AbSDRS5w>; Thu, 18 Apr 2002 14:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314428AbSDRS5v>; Thu, 18 Apr 2002 14:57:51 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:40465 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S314425AbSDRS5t>; Thu, 18 Apr 2002 14:57:49 -0400
Message-ID: <3CBF1722.EDA8631F@zip.com.au>
Date: Thu, 18 Apr 2002 11:57:38 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Peloquin <peloquin@us.ibm.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Bio pool & scsi scatter gather pool usage
In-Reply-To: <OFA8584441.22F71259-ON85256B9F.00627FAA@pok.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Peloquin wrote:
> 
> ...
> > Tell me why this won't work?
> 
> This would require the BIO assembly code to make at least one
> call to find the current permissible BIO size at offset xyzzy.
> Depending on the actual IO size many foo_max_bytes calls may
> be required. Envision the LVM or RAID case where physical
> extents or chunks sizes can be as small as 8Kb I believe. For
> a 64Kb IO, its conceivable that 9 calls to foo_max_bytes may
> be required to package that IO into permissibly sized BIOs.

True.  But probably the common case is not as bad as that, and
these repeated calls are probably still cheaper than allocating
and populating the redundant top-level BIO.

Also, the top-level code can be cache-friendly.  The bad way
to write it would be to do:

	while (more to send) {
		maxbytes = bio_max_bytes(block);
		build_and_send_a_bio(block, maxbytes);
		block += maxbytes / whatever;
	}

That creates long code paths and L1 cache thrashing.  Kernel
tends to do that rather a lot in the IO paths.

The good way is:

	int maxbytes[something];
	int i = 0;

	while (more_to_send) {
		maxbytes[i] = bio_max_bytes(block);
		block += maxbytes[i++] / whatever;
	}
	i = 0;
	while (more_to_send) {
		build_and_send_a_bio(block, maxbytes[i]);
		block += maxbytes[i++] / whatever;
	}

if you get my drift.  This way the computational costs of
the second and succeeding bio_max_bytes() calls are very
small.


One thing which concerns me about the whole scheme at
present is that the uncommon case (volume managers, RAID,
etc) will end up penalising the common case - boring
old ext2 on boring old IDE/SCSI.

Right now, BIO_MAX_SECTORS is only 64k, and IDE can
take twice that.  I'm not sure what the largest
request size is for SCSI - certainly 128k.

Let's not create any designed-in limitations at this
stage of the game.

-
