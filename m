Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750891AbVHXLs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbVHXLs7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 07:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbVHXLs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 07:48:58 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:40095 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750815AbVHXLs6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 07:48:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=bidL4kZbpbFVywAf4BbQ6csZ98rIl1SRn1ObouIzU90r3gc0vz3H0eOgeN2q3ElN3ZRERk3dei9q9KFnhUz7Yg05KYtWXNHfhGGl5XKhFOn7EDEmJeOM4MKojrb4dOJZSdtZ67gnfekPfqCYVp+gytkBOu9PuRyh6EFlaLSR9/Q=
Message-ID: <1e33f5710508240448305d9648@mail.gmail.com>
Date: Wed, 24 Aug 2005 17:18:55 +0530
From: Gaurav Dhiman <gaurav4lkg@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [Enhancement] : Improvement suggestion in read-write spinlock code
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is to suggest and discuss the enhancement in spinlock code.
If we look into the implementation of helper function (
__read_lock_failed ) of read-write spinlocks (file :
arch/i386/kernel/semaphore.c), that is implemented as follows:

    279 .align  4
    280 .globl  __read_lock_failed
    281 __read_lock_failed:
    282         lock ; incl     (%eax)
    283 1:      rep; nop
    284         cmpl    $1,(%eax)
    285         js      1b
    286
    287         lock ; decl     (%eax)
    288         js      __read_lock_failed
    289         ret
    290 "
    291 );


In lines 284 and 285 above, we are comparing, if the value of spinlock
is greater than equal to 1, go ahead and try to acquire the lock. I
think in plcae of comparing it with 1 we should compare it with value
2.

My reasoning for this is that we should only come out of loop and try
to hold the lock when there is any space for reader to go in critical
region (CR). Lets take the case when there are maximum number of
readers in CR (critical region), the lock will have value 0x00000001
(that means 1), so at value 1 there is nospace for more readers in CR
and incoming readers should keep on looping, as soon as the value is
incremented by the outgoing reader from CR, the value will become 2
and at this time the waiting readers should try to get in CR, so I
think the condition for looping should be:

1: lock; cmpl $2, (%eax)
   js 1b


With current code if there are maximum readers in CR, we will have
spinlock value 0x00000001 and will be uselessly keep on trying to get
lock by decrementing the lock count and incrementing it again. We will
be looping on the outer loop, rather we should not be coming out of
the inner loop till the time there is some space for a new reader
(lock count >= 2)

If we analyse the problem in more detail, reader will have to wait in
following two cases:

Case 1. when there is already a writer in CR - incoming reader will
keep on looping between cmpl and js instuctions (line 284 - 285), as
the value of lock is 0. Now as soon as the writer leaves the CR, it
will make the lock value to 0x01000000 (which is greater than 1 as
well as 2), so the condition for coming out of loop can be, lock
should be >= 2, rather than 1.

Case 2: maximum number of readers already in CR (this case is already
discussed above) - in this case the value of lock will be 0x00000001,
and we should keep on looping between cmpl and js instructions (line
284 - 285) because there is no space for more readers in CR. Space
will be created when any of the present reader will be leaving out of
CR and making the value of lock to 2, so in this case also the
condition of coming out of loop can be, lock value >= 2.


Looking forward to your comments on this.

regards,
Gaurav Dhiman
Email: gaurav4lkg@gmail.com
___________________________
