Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129771AbRBBSJp>; Fri, 2 Feb 2001 13:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129904AbRBBSJf>; Fri, 2 Feb 2001 13:09:35 -0500
Received: from hermes.mixx.net ([212.84.196.2]:47108 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129771AbRBBSJX>;
	Fri, 2 Feb 2001 13:09:23 -0500
From: Daniel Phillips <phillips@innominate.de>
To: linux-kernel@vger.kernel.org
Subject: SMP Race in brelse
Date: Fri, 2 Feb 2001 15:19:34 +0100
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <0102021907250D.15914@gimli>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a rare SMP race in brelse:

1138 void __brelse(struct buffer_head * buf)
1139 {
1140         if (atomic_read(&buf->b_count)) {
1141                 atomic_dec(&buf->b_count);
1142                 return;
1143         }
1144         printk("VFS: brelse: Trying to free free buffer\n");
1145 }

                cpu1                                 cpu2

Starting with buf->b_count = 1, if we have:

   if (atomic_read(&buf->b_count))
					 if (atomic_read(&buf->b_count))
       atomic_dec(&buf->b_count);
					      atomic_dec(&buf->b_count);

buf->b_count is now 0, but it should be -1, we fail to to report
an erroneous extra brelse.

-- 
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
