Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281533AbRLAKHW>; Sat, 1 Dec 2001 05:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281527AbRLAKHM>; Sat, 1 Dec 2001 05:07:12 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:62433 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S281533AbRLAKHH>; Sat, 1 Dec 2001 05:07:07 -0500
Message-Id: <200112011007.fB1A70429394@eng4.beaverton.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: viro@math.psu.edu (Alexander Viro), dave@sr71.net (David C. Hansen),
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove BKL from drivers' release functions 
In-Reply-To: Your message of "Sat, 01 Dec 2001 09:52:57 GMT."
             <E16A6pN-0006d0-00@the-village.bc.nu> 
Date: Sat, 01 Dec 2001 02:06:59 -0800
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    This is why we have a development tree. Its moving things in the
    right direction which is important. I suspect many drivers will
    want to use semaphores rather than atomic counts however, to ensure
    that an open doesn't complete while a previous release is still
    shutting down hardware

Yes, the only successful application for atomic counts that I've seen
(in this context) is for exclusive open code that looks like

    if (count++) {
	count--;
	return -EBUSY;
    }

in the open routine and

    count--;

in the release.  If you want to do anything else as a result of that
count, you'll need additional locking because it could have changed a
nanosecond after it was (safely) incremented or decremented. You can't
count on it remaining that value after you check it.

release()s that want to shutdown the device, free memory, or take other
actions will want to employ either a spinlock (plain or r/w as
appropriate) or a sleeping semaphore to insure things remain stable
until those actions are complete.

Rick
