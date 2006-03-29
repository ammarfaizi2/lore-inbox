Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750904AbWC2K5g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904AbWC2K5g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 05:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbWC2K5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 05:57:36 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:52635 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1750762AbWC2K5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 05:57:35 -0500
Message-ID: <442A680D.5050705@bull.net>
Date: Wed, 29 Mar 2006 12:57:17 +0200
From: Zoltan Menyhart <Zoltan.Menyhart@bull.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en, fr, hu
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
Cc: "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       Zoltan Menyhart <Zoltan.Menyhart@free.fr>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Fix unlock_buffer() to work the same way as bit_unlock()
References: <200603281853.k2SIrGg28290@unix-os.sc.intel.com> <4429ADBC.50507@free.fr> <Pine.LNX.4.64.0603281537500.15037@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0603281537500.15037@schroedinger.engr.sgi.com>
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 29/03/2006 12:59:32,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 29/03/2006 12:59:34,
	Serialize complete at 29/03/2006 12:59:34
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Tue, 28 Mar 2006, Zoltan Menyhart wrote:
> 
> 
>>Why not to use separate bit operations for different purposes?
>>
>>- e.g. "test_and_set_bit_N_acquire()" for lock acquisition
>>- "test_and_set_bit()", "clear_bit()" as they are today
>>- "release_N_clear_bit()"...
>>
> 
> 
> That would force IA64 specifics onto all other architectures.
> 
> Could we simply define these smb_mb__*_clear_bit to be noops
> and then make the atomic bit ops to have full barriers? That would satisfy 
> Nick's objections.

I do not want to force IA64 specifics...
I think the lock - unlock are as they are because of some historical reasons.
IA64 only helps me to see what is really necessary for the lock
implementation and what is just a heritage of the PCs.

I try to summarize my thoughts about the locks in an architecture
independent way. If we can agree upon how it should work, then we can
enter into the details later :-)

1. lock():

The lock acquisition semantics guarantees that the lock is acquired by
its new owner and the new ownership is made globally visible prior to all
subsequent orderable instructions (issued by the new owner) becoming
visible to the others.

Example:

  |
  v
  |
store_X ----------+
  |               |
  v               |
  |               |
======== lock ====+=======
  |               |   ^ ^
  v               v   ^ ^
  |                   | |
load_Y ---------------+ |
store_Z ----------------+
  |
  v
  |

Note that "store_X" is not guaranteed to be globally performed before
the lock.


2. unlock():

The lock release semantics guarantees that all previous orderable
instructions (issued by the lock owner) are made globally visible prior
to make visible to the others the lock becoming free.


Example:

  |
  v
  |
store_A ----------+
  |               |
  v               v   ^
  |               v   |
======= unlock =======+===
  |                   |
  v                   |
  |                   |
load_B ---------------+
  |
  v
  |

Note that "load_B" can be globally performed before the unlock.


The mutual exclusion means:

- "store_A" is before unlocking
- unlocking is before locking by the next owner
- locking is before "load_Y" or "store_Z"

therefore "store_A" is before "load_Y" or "store_Z".

No relation is defined between "store_X" and any other operation,
nor is between "load_B" and any other operation.


Can we agree that locking and unlocking mean no more than what I
described, especially, they do not imply bidirectional fencing?


Should someone need a bidirectional fencing, s/he would have to
use some additional shync. methods.


In order to separate the theory (how is should work) and the practice
(how is should be implemented), I put the bit-op stuff in another
mail.


Thanks.

Zoltan





