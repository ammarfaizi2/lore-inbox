Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267057AbUBEWR5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 17:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267059AbUBEWR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 17:17:57 -0500
Received: from gw0.infiniconsys.com ([65.219.193.226]:3870 "EHLO
	mail.infiniconsys.com") by vger.kernel.org with ESMTP
	id S267057AbUBEWRv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 17:17:51 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Infiniband-general] Getting an Infiniband access layer in theLinux kernel
Date: Thu, 5 Feb 2004 17:17:50 -0500
Message-ID: <08628CA53C6CBA4ABAFB9E808A5214CB01DB96FA@mercury.infiniconsys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Infiniband-general] Getting an Infiniband access layer in theLinux kernel
Thread-Index: AcPsLs89w9yLLeYgQ3eZJ/EqsnTR3QAAxrlw
From: "Tillier, Fabian" <ftillier@infiniconsys.com>
To: "Greg KH" <greg@kroah.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, <sean.hefty@intel.com>,
       <linux-kernel@vger.kernel.org>, <hozer@hozed.org>, <woody@co.intel.com>,
       <bill.magro@intel.com>, <woody@jf.intel.com>,
       <infiniband-general@lists.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

I'm not arguing about the spinlocks here, and never have.  I'm arguing
about the atomic abstraction for the x86 platforms.  My last question
was not a yes/no question so I'm not sure what you're answering with
your "No" - your reply makes no sense.  To clarify, the answer to a
"chose one of two things" question is not "No".  Basic XOR logic is all
that's needed here.  I'm not sure what you're asking about with the
whole quotations thing.

Having atomic operations return a value allows one to do something like
test for zero when decrementing an atomic variable such as a reference
count, to determine whether final cleanup should proceed.  This removes
the need for an actual spinlock protecting the reference count.  As you
know, reading the value post-decrement does not guarantee that said
value reflects the result of only that decrement operation.  It would be
catastrophic if two threads checked the value of a reference count
without proper synchronization - they could both end up running the
cleanup code with undesired (and perhaps catastrophic) results.

I'll try a simple example for you assuming atomic_dec returns the
decremented value:

if( atomic_dec( x ) == 0 )
{
    cleanup();
}

In the current implementation of atomic operations for x86 however,
atomic_dec doesn't return anything.  To get the proper behavior would
require a true spinlock because the following code sample would not work
properly since there's no atomicity guaranteed between the decrement and
the read:

atomic_dec( x )
if( atomic_read( x ) == 0 )
{
    cleanup();
}

So without returning the result of the decrement, you lose the ability
to use atomic variables for reference counting.

Hope this clarifies things for you,

- Fab
 

-----Original Message-----
From: Greg KH [mailto:greg@kroah.com] 
Sent: Thursday, February 05, 2004 1:27 PM
To: Tillier, Fabian
Cc: Randy.Dunlap; sean.hefty@intel.com; linux-kernel@vger.kernel.org;
hozer@hozed.org; woody@co.intel.com; bill.magro@intel.com;
woody@jf.intel.com; infiniband-general@lists.sourceforge.net
Subject: Re: [Infiniband-general] Getting an Infiniband access layer in
theLinux kernel

A: No.
Q: Should I include quotations after my reply?

On Thu, Feb 05, 2004 at 03:32:09PM -0500, Tillier, Fabian wrote:
> So which is more important to the "Linux kernel" project: i386
backwards
> compatibility, or consistent API and functionality across processor
> architectures? ;)

Anyway, why not describe what you are trying to accomplish that made you
determine that you _had_ to have these kinds of functions.

Basically, what is lacking in the current kernel locks that the
infiniband project has to have in order to work properly.  We can work
from there.

thanks,

greg k-h
