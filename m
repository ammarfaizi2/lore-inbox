Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283705AbRK3Tjl>; Fri, 30 Nov 2001 14:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280984AbRK3Tjb>; Fri, 30 Nov 2001 14:39:31 -0500
Received: from cp1s4p1.dashmail.net ([216.36.32.37]:16400 "EHLO sr71.net")
	by vger.kernel.org with ESMTP id <S280994AbRK3TjW>;
	Fri, 30 Nov 2001 14:39:22 -0500
Message-ID: <3C07E04A.7020301@sr71.net>
Date: Fri, 30 Nov 2001 11:38:50 -0800
From: "David C. Hansen" <dave@sr71.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011129
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        Rick Lindsley <ricklind@us.ibm.com>
Subject: Re: [PATCH] remove BKL from drivers' release functions
In-Reply-To: <Pine.GSO.4.21.0111300444180.13367-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
 > ->release() is not serialized AT ALL.  It is serialized for given
 > struct file, but call open(2) twice and you've got two struct file
 > for the same device. close() both and you've got two calls of
 > ->release(), quite possibly - simultaneous.
OK, that clears some things up.  So, the file->fcount is only used in 
cases where the file descriptor was dup'd, right?

As Rick Lindsley pointed out to me:
 > In cases where we removed BKL from release() and left obvious locking
 > issues as "an exercise to the reader", we MAY have broken things
 > because the BKL (we now know) may have been serializing opens and
 > closes.
 > In cases where we replaced it with atomic locking or a spinlock, we've
 > done nothing but replace one lock with another (unless there are
 > subtleties

back to Alexander  Viro:
 > In other words, patch is completely bogus.
No, not completely.  In a lot of cases we just replaced some regular 
arithmetic with atomic instructions of some sort.  These changes are 
still completely valid.  But, in the cases where we added locking, we 
need to reevaluate them for potential problem.  In the cases where we 
just removed the BKL, we really need to check them to make sure that we 
didn't introduce anything.
Thanks for the feedback, Al!  This has been very helpful!

--
Dave Hansen
dave@sr71.net

