Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129657AbQLGQ1l>; Thu, 7 Dec 2000 11:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129824AbQLGQ1b>; Thu, 7 Dec 2000 11:27:31 -0500
Received: from app79.hitnet.RWTH-Aachen.DE ([137.226.181.79]:46084 "EHLO
	anduin.gondor.com") by vger.kernel.org with ESMTP
	id <S129657AbQLGQ11>; Thu, 7 Dec 2000 11:27:27 -0500
Date: Thu, 7 Dec 2000 16:56:59 +0100
From: Jan Niehusmann <jan@gondor.com>
To: linux-kernel@vger.kernel.org
Subject: attempt to access beyond end of device
Message-ID: <20001207165659.A1167@gondor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ll_rw_blk.c: generic_make_request() contains the following code:

if (maxsector < count || maxsector - count < sector) {
	bh->b_state &= (1 << BH_Lock) | (1 << BH_Mapped);
	if (blk_size[major][MINOR(bh->b_rdev)]) {

		/* This may well happen - the kernel calls bread()
		   without checking the size of the device, e.g.,
		   when mounting a device. */
		printk(KERN_INFO
		       "attempt to access beyond end of device\n");
		printk(KERN_INFO "%s: rw=%d, want=%d, limit=%d\n",
		       kdevname(bh->b_rdev), rw,
		       (sector + count)>>1,
		       blk_size[major][MINOR(bh->b_rdev)]);
	}
	bh->b_end_io(bh, 0);
	return;
}


That means that if blk_size[major][MINOR(bh->b_rdev)] == 0, the request
is canceled but no message is printed. Shouldn't there be a warning message?

Jan





-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
