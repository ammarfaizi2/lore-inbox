Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751496AbWJHWSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbWJHWSZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 18:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbWJHWSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 18:18:25 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:34833 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751496AbWJHWSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 18:18:24 -0400
Date: Mon, 9 Oct 2006 00:18:19 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, R.E.Wolff@BitWizard.nl
Subject: drivers/char/specialix.c: broken baud conversion
Message-ID: <20061008221818.GL6755@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

your commit commit 67cc0161ecc9ebee6eba4af6cbfdba028090b1b9
"specialix - remove private speed decoding" converted the variable baud 
from an index in the array baud_table[] to containing the baud value 
itself.

Unfortunately, it contains at least two bugs:


The Coverity checker spotted that the following line was forgotten:

           baud = (baud_table[baud] + 5) / 10;   /* Estimated CPS */

BTW: After the trivial fix, baud_table[] could be removed.


While looking at the patch, I noticed it contains another bug that is 
not that easy to fix:

-       if (baud == 15) {
+       if (baud == 38400) {
                if ((port->flags & ASYNC_SPD_MASK) == ASYNC_SPD_HI)
                        baud ++;
                if ((port->flags & ASYNC_SPD_MASK) == ASYNC_SPD_VHI)
                        baud += 2;
        }

Increasing the index for baud_table[] by 1 or 2 is quite different from 
increasing baud by 1 or 2.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

