Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266996AbUBEW50 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 17:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267046AbUBEW50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 17:57:26 -0500
Received: from mail3.iserv.net ([204.177.184.153]:12754 "EHLO mail3.iserv.net")
	by vger.kernel.org with ESMTP id S266996AbUBEW5W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 17:57:22 -0500
Message-ID: <4022CA25.8070507@didntduck.org>
Date: Thu, 05 Feb 2004 17:56:37 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Tillier, Fabian" <ftillier@infiniconsys.com>
CC: Greg KH <greg@kroah.com>, "Randy.Dunlap" <rddunlap@osdl.org>,
       sean.hefty@intel.com, linux-kernel@vger.kernel.org, hozer@hozed.org,
       woody@co.intel.com, bill.magro@intel.com, woody@jf.intel.com,
       infiniband-general@lists.sourceforge.net
Subject: Re: [Infiniband-general] Getting an Infiniband access layer in theLinux
 kernel
References: <08628CA53C6CBA4ABAFB9E808A5214CB01DB96FA@mercury.infiniconsys.com>
In-Reply-To: <08628CA53C6CBA4ABAFB9E808A5214CB01DB96FA@mercury.infiniconsys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tillier, Fabian wrote:
> Greg,
> 
> I'm not arguing about the spinlocks here, and never have.  I'm arguing
> about the atomic abstraction for the x86 platforms.  My last question
> was not a yes/no question so I'm not sure what you're answering with
> your "No" - your reply makes no sense.  To clarify, the answer to a
> "chose one of two things" question is not "No".  Basic XOR logic is all
> that's needed here.  I'm not sure what you're asking about with the
> whole quotations thing.
> 
> Having atomic operations return a value allows one to do something like
> test for zero when decrementing an atomic variable such as a reference
> count, to determine whether final cleanup should proceed.  This removes
> the need for an actual spinlock protecting the reference count.  As you
> know, reading the value post-decrement does not guarantee that said
> value reflects the result of only that decrement operation.  It would be
> catastrophic if two threads checked the value of a reference count
> without proper synchronization - they could both end up running the
> cleanup code with undesired (and perhaps catastrophic) results.
> 
> I'll try a simple example for you assuming atomic_dec returns the
> decremented value:
> 
> if( atomic_dec( x ) == 0 )
> {
>     cleanup();
> }

I guess you missed this then:
/**
  * atomic_dec_and_test - decrement and test
  * @v: pointer of type atomic_t
  *
  * Atomically decrements @v by 1 and
  * returns true if the result is 0, or false for all other
  * cases.  Note that the guaranteed
  * useful range of an atomic_t is only 24 bits.
  */

There is also atomic_dec_and_lock():
/*
  * This is an architecture-neutral, but slow,
  * implementation of the notion of "decrement
  * a reference count, and return locked if it
  * decremented to zero".
  *
  * NOTE NOTE NOTE! This is _not_ equivalent to
  *
  *      if (atomic_dec_and_test(&atomic)) {
  *              spin_lock(&lock);
  *              return 1;
  *      }
  *      return 0;
  *
  * because the spin-lock and the decrement must be
  * "atomic".
  *
  * This slow version gets the spinlock unconditionally,
  * and releases it if it isn't needed. Architectures
  * are encouraged to come up with better approaches,
  * this is trivially done efficiently using a load-locked
  * store-conditional approach, for example.
  */

--
				Brian Gerst
