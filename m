Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290968AbSBFXpS>; Wed, 6 Feb 2002 18:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290965AbSBFXpE>; Wed, 6 Feb 2002 18:45:04 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:3054 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S290966AbSBFXoP>;
	Wed, 6 Feb 2002 18:44:15 -0500
Message-ID: <3C61BFC9.8030905@us.ibm.com>
Date: Wed, 06 Feb 2002 15:44:09 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Removal of big kernel lock from isdn drivers
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been examining the continuing additions of the big kernel lock 
(BKL) to the 2.5 tree.  I noticed that in 2.5.3, the ISDN subsystem 
added the BKL to several places.  In response to this, I have written 
several patches to attempt removal of the BKL from the ISDN subsystem. 
I have little knowledge of the drivers themselves, so I would like some 
assistance from those of you who understand them better.  I probably 
have an over-simplified view of the code, so my patches may be too 
simplistic.  They're a bit big, so I've made them available here:
http://www.sr71.net/ibm/isdn/

isdn.bkl-remove.ippp_lock.patch:
   http://www.sr71.net/ibm/isdn/isdn.bkl-remove.isdn_dev_sem.patch
   added ippp_lock to ippp_struct
   * It appeared that the BKL was being used to guard the file struct's
     private data field, which is a ippp_struct.  I added a semaphore to
     that structure which can be locked instead of the BKL.

isdn.bkl-remove.hydsn_cards_sem.patch:
   http://www.sr71.net/ibm/isdn/isdn.bkl-remove.hydsn_cards_sem.patch
   adds rwsemaphore hydsn_cards_sem
* hydsn_cards_sem guards the card_root list.  It is a read/write
   semaphore which must be held for write when modifying the list.

isdn.bkl-remove.isdn_dev_rwsem.patch:
http://www.sr71.net/ibm/isdn/isdn.bkl-remove.ppp_lock.patch
* changes name of "dev" to "isdn_dev"
      - If there are going to be global variables,
        they can at least not have exceedingly generic
        names like "dev"!
* adds global isdn_dev_rwsem
      - isdn_dev_rwsem must be held when manipulating "isdn_dev"

I know that these patches should probably be separate, but this is 
easier for me.

-- 
Dave Hansen
haveblue@us.ibm.com



