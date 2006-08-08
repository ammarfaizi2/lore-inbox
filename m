Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbWHHGoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbWHHGoQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 02:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbWHHGoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 02:44:15 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:19933 "EHLO
	out4.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S932201AbWHHGoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 02:44:15 -0400
Message-Id: <1155019454.29767.267870507@webmail.messagingengine.com>
X-Sasl-Enc: Ivl/XbOfiOjGA/WFAH5CxSLVIm75z9Vl0ena+m/ehdRw 1155019454
From: "Dan Bastone" <dan@pwienterprises.com>
To: "Eric Sandeen" <sandeen@sandeen.net>
Cc: linux-kernel@vger.kernel.org, bfennema@falcon.csc.calpoly.edu
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
X-Mailer: MessagingEngine.com Webmail Interface
References: <44D36E60.2020006@sandeen.net>
   <1154934860.6783.267775866@webmail.messagingengine.com>
   <44D7C26F.1040609@sandeen.net>
Subject: Re: [PATCH]: initialize parts of udf inode earlier in create
In-Reply-To: <44D7C26F.1040609@sandeen.net>
Date: Mon, 07 Aug 2006 23:44:14 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Aug 2006 17:45:03 -0500, "Eric Sandeen" <sandeen@sandeen.net>
said:
> That looks fine to me, but I wonder if there's a cleaner way, rather
> than sprinkling these initializations in the code.  If __udf_read_inode
> fails, then it calls mark_bad_inode; maybe the code should check for
> that before trying to discard prealloced blocks?  I don't really know
> enough about all the UDF codepaths (by far!) to know for sure what the
> best solution is, here.

I'm certainly not an expert on this code either, but it seems like doing
the initializations once in udf_alloc_inode() makes the most sense.  As
I said it should fix both of the scenarios you & I experienced as well
as any others that assume the udf_inode_info structs are zeroed.  Now
that I look at it again, I think it also makes the initializations in
udf_new_inode() redundant.

So, assuming my previous patch is applied and yours is not, I think the
following is right:

---

Signed-off-by: Dan Bastone <dan@pwienterprises.com>

--- linux-2.6.17.7/fs/udf/ialloc.c.orig
+++ linux-2.6.17.7/fs/udf/ialloc.c
@@ -84,11 +84,6 @@
        }

        mutex_lock(&sbi->s_alloc_mutex);
-       UDF_I_UNIQUE(inode) = 0;
-       UDF_I_LENEXTENTS(inode) = 0;
-       UDF_I_NEXT_ALLOC_BLOCK(inode) = 0;
-       UDF_I_NEXT_ALLOC_GOAL(inode) = 0;
-       UDF_I_STRAT4096(inode) = 0;
        if (UDF_SB_LVIDBH(sb))
        {
                struct logicalVolHeaderDesc *lvhd;

---

Dan

-- 
http://www.fastmail.fm - Faster than the air-speed velocity of an
                          unladen european swallow

