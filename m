Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272559AbTHBJs6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 05:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272563AbTHBJs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 05:48:58 -0400
Received: from web14202.mail.yahoo.com ([216.136.172.144]:48405 "HELO
	web14202.mail.yahoo.com") by vger.kernel.org with SMTP
	id S272559AbTHBJsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 05:48:54 -0400
Message-ID: <20030802094854.19141.qmail@web14202.mail.yahoo.com>
Date: Sat, 2 Aug 2003 02:48:54 -0700 (PDT)
From: Erik McKee <camhanaich99@yahoo.com>
Subject: minixfs question
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Let me apologize in advance for any ignorance I might exhibit here.  I am
curious about the following code, from minix_new_inode in fs/minix/bitmap.c. 
The if statement on line 232 checks !bh.  It seems that if bh was null at this
point, then sbi->s_imap_blocks == 0, in which case we fail the other half of
the if.  If bh == NULL in any other case, wouldn't the bh->b_data in the
minix_find_first_zero_bit call be deref. a NULL pointer, which would trigger a
kernel panic or some such terminal event?  Also, why does at least this
filesystem use minix specific version of these bitmap operations?  Isn't there
a generic set of these operations?  In other functions, it seems like these
tests have to be protected by the BKL?  Isn't the point of things like
test_and_set and test_and_clear that they are atomic?  If so, why the need for
the BKL (for example, minix_free_block)?  Also I noticed this these files seem
to have very sparse commenting, would a patch consisting of germane commenting
for this fs be welcome?  Also, would it be beneficial if this fs was converted
to use one or more minixfs specific locks instead of the BKL?

223         j = 8192;
224         bh = NULL;
225         *error = -ENOSPC;
226         lock_kernel();
227         for (i = 0; i < sbi->s_imap_blocks; i++) {
228                 bh = sbi->s_imap[i];
229                 if ((j = minix_find_first_zero_bit(bh->b_data, 8192)) <
8192)
230                         break;
231         }
232         if (!bh || j >= 8192) {
233                 unlock_kernel();
234                 iput(inode);
235                 return NULL;
236         }
237         if (minix_test_and_set_bit(j,bh->b_data)) {     /* shouldn't happen
*/
238                 printk("new_inode: bit already set");
239                 unlock_kernel();
240                 iput(inode);
241                 return NULL;
242         }
243         unlock_kernel();

TIA
Erik McKee
*Who is hoping this fs is a good place to start learning about fs in linux.*
Please cc me in replies, as I am not on list.

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
