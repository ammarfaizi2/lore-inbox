Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131407AbRDJKLU>; Tue, 10 Apr 2001 06:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132963AbRDJKLK>; Tue, 10 Apr 2001 06:11:10 -0400
Received: from csl.Stanford.EDU ([171.64.66.149]:58866 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S131407AbRDJKLI>;
	Tue, 10 Apr 2001 06:11:08 -0400
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200104101011.DAA29579@csl.Stanford.EDU>
Subject: [CHECKER] amusing copy_from_user bug
To: linux-kernel@vger.kernel.org
Date: Tue, 10 Apr 2001 03:11:05 -0700 (PDT)
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

copy_from_user should probably have something like
                (sizeof(agp_segment) * reserve.seg_count)
as it's size argumenbt rather than
		GFP_KERNEL 

/u2/engler/mc/oses/linux/2.4.3/drivers/char/agp/agpgart_fe.c:882:agpioc_reserve_
wrap: ERROR:SIZE-CHECK:882:882: segment = 'copy_from_user'(7 bytes), need 12

                agp_segment *segment;

                segment = kmalloc((sizeof(agp_segment) * reserve.seg_count),
                                  GFP_KERNEL);

                if (segment == NULL) {
                        return -ENOMEM;
                }
                if (copy_from_user(segment, (void *) reserve.seg_list,
                                   GFP_KERNEL)) {
                        kfree(segment);
                        return -EFAULT;
                }

As a side question: is it still true that verify_area's must be done before
any use of __put_user/__get_user/__copy_from_user/etc?
