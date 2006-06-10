Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932300AbWFJC6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbWFJC6j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 22:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWFJC6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 22:58:39 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:63918 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932300AbWFJC6i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 22:58:38 -0400
Message-ID: <448A3554.6080800@garzik.org>
Date: Fri, 09 Jun 2006 22:58:28 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Theodore Tso <tytso@mit.edu>, Andreas Dilger <adilger@clusterfs.com>,
       "Stephen C. Tweedie" <sct@redhat.com>
CC: Andrew Morton <akpm@osdl.org>, Matthew Frost <artusemrys@sbcglobal.net>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Mingming Cao <cmm@us.ibm.com>,
       linux-fsdevel@vger.kernel.org, Alex Tomas <alex@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <20060609194959.GC10524@thunk.org> <4489D44A.1080700@garzik.org> <1149886670.5776.111.camel@sisko.sctweedie.blueyonder.co.uk> <4489ECDD.9060307@garzik.org> <1149890138.5776.114.camel@sisko.sctweedie.blueyonder.co.uk> <448A07EC.6000409@garzik.org> <20060610004727.GC7749@thunk.org> <448A1BBA.1030103@garzik.org> <20060610013048.GS5964@schatzie.adilger.int> <448A23B2.5080004@garzik.org> <20060610020306.GA449@thunk.org>
In-Reply-To: <20060610020306.GA449@thunk.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso wrote:
> Inodes per group and inode blocks per group are maintained
> across an online resize.  So there is no difference in inodes per
> group for a filesystem created at size S1 and resized to size S2
> (using either an on-line or off-line resize), and a filesystem which
> is created to be size S2.


Here are real numbers, which illustrate how the above two statements 
contradict, and how the second statement is false:

blkdev A, formatted with a 50MB filesystem
	block size		4096
	block count		12800 (size S1)
	inodes per group	12800
blkdev A, formatted to full capacity (~350GB)
	block size		4096
	block count		95472256 (size S2)
	inodes per group	32768

Case 1:	online resize from 50MB to 350GB
Result:	inodes per group == 12800 (it remains the same)

Case 2: mke2fs blkdev A, with no block-count restrictions
Result:	inodes per group == 32768

Thus, each inode group holds fewer inodes per group in case #1 than #2.
Thus, case #2 has greater inode density than case #1.

Overall,
a) mke2fs chooses optimal values based on creation-time block count
b) online resize does not change these values

thus the values are no longer optimal.  And in this case, they are never 
-more- optimal, and potentially -less- optimal.

	Jeff



