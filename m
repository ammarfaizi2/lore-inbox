Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281999AbRKUXdv>; Wed, 21 Nov 2001 18:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281997AbRKUXdl>; Wed, 21 Nov 2001 18:33:41 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:31727 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S282001AbRKUXdd>;
	Wed, 21 Nov 2001 18:33:33 -0500
Message-ID: <3BFC399A.3040101@us.ibm.com>
Date: Wed, 21 Nov 2001 15:32:42 -0800
From: "David C. Hansen" <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5+) Gecko/20011110
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>,
        Rick Lindsley <ricklind@us.ibm.com>
Subject: [PATCH] Remove needless BKL from release functions
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  The following is a patch which removes the BKL from quite a few 
drivers' release functions.  The release functions are already 
serialized in the VFS code by an atomic_t which guarantees that each 
function will be called only once, after all file descriptors have been 
closed.  In addition, in these drivers, the BKL was _only_ held in the 
release function and nowhere else in the driver where it might be needed.

Many of these patches simply remove the BKL from the file.  This causes 
no harm because the BKL was not really protecting anything, anyway.  
Other patches try to actually fix the locking.  Some do this by making 
use of atomic operations with the atomic_* functions, or the 
(test|set)_bit functions.  Most of these patches replace uses of normal 
integers which were used to keep open counts in the drivers.  In other 
some cases, a spinlock was added when the atomic operations could not 
guarantee proper serialization by themselves.  And, in very few cases, 
the existing locking was extended to protect more things.  These cases 
are very uncommon because locking is very uncommon in most of these drivers.

Special care has been taken not to introduce more locking issues into 
the drivers (do no harm). They're available as one big patch which is 
against 2.4.14.  The big patch is about 50k, so, instead of attaching 
it, here is a link: http://lse.sourceforge.net/lockhier/patches/bkl.rollup
Here is documentation describing some of the patches and other locking 
issues in the drivers: http://lse.sourceforge.net/lockhier/
The patch applies against 2.4.14.

--
David C. Hansen
haveblue@us.ibm.com


