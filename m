Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292851AbSCMJCc>; Wed, 13 Mar 2002 04:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292848AbSCMJCM>; Wed, 13 Mar 2002 04:02:12 -0500
Received: from mail.webmaster.com ([216.152.64.131]:22780 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S292847AbSCMJCA> convert rfc822-to-8bit; Wed, 13 Mar 2002 04:02:00 -0500
From: David Schwartz <davids@webmaster.com>
To: <ak@suse.de>
CC: Brad Pepers <brad@linuxcanada.com>, <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.51 (1003) - Registered Version
Date: Wed, 13 Mar 2002 01:01:34 -0800
In-Reply-To: <20020313092306.A5570@wotan.suse.de>
Subject: Re: Multi-threading
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <20020313090150.AAA28331@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 13 Mar 2002 09:23:06 +0100, Andi Kleen wrote:


>>If it was in public view, whatever held it in public view would be
>> using it,
>>and hence its use count could not drop to zero.

>That's not correct at least in the usual linux kernel pattern of using
>reference counts for objects. Hash tables don't hold reference counts,
>only users do. If you think about it a hash table or global list holding
>a reference count doesn't make too much sense.

	That's the way I've always done it and it has saved me a lot of heartache. A 
use count of 'zero' means that it's really not used at all, and hence nothing 
would have any way of finding it. Anything with a future interest in 
something should 'use' it.

	In any event, hash tables require locks themselves anyway. So if you find an 
object in a hash table, you must be holding some lock when you find it, so 
you can increment the use count under the protection of that lock. The trick 
becomes the decrement operation, because ideally you'd prefer not to have to 
lock the hash table again unless you have to remove the object.

	I believe, however, that you are completely safe if you decrement the use 
count atomically, and if it's zero, you grab the hash lock, confirm that the 
use count is still zero, and then remove the object.

	Since the use count is always locked for the first time in any usage chain 
with the hash lock held (lock it when you find it), an increment from zero to 
one can only occur while the lock is held. So if you hold the lock, an 
increment from zero to one cannot occur. No race.

	DS


