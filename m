Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750977AbWC2SeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbWC2SeE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 13:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750981AbWC2SeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 13:34:04 -0500
Received: from palrel10.hp.com ([156.153.255.245]:34230 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S1750973AbWC2SeB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 13:34:01 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: Fix unlock_buffer() to work the same way as bit_unlock()
Date: Wed, 29 Mar 2006 10:33:57 -0800
Message-ID: <65953E8166311641A685BDF71D865826A23CF1@cacexc12.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Fix unlock_buffer() to work the same way as bit_unlock()
Thread-Index: AcZS//g/drY6W1DvSX+w2pJ31AkrGwAWNIvA
From: "Boehm, Hans" <hans.boehm@hp.com>
To: "Christoph Lameter" <clameter@sgi.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "Zoltan Menyhart" <Zoltan.Menyhart@free.fr>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>
X-OriginalArrivalTime: 29 Mar 2006 18:33:57.0765 (UTC) FILETIME=[57431350:01C6535F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For what it's worth, I've been involved in some recent work whose goals
currently include properly specifying such things at the user level,
currently primarily in the context of C++, with the hope that this will
eventually migrate into C.  (See
http://www.hpl.hp.com/personal/Hans_Boehm/c++mm/ for details.)

Some potentially relevant observations:

- Java uses the terms "acquire" and "release" to express approximately
what "lock" and "unlock" mean here.  The major difference is that
performing a "release" operation on a particular object only ensures
visibility to threads that later perform an "acquire" operation on the
same object.  I'm not sure that there are any architectures on which
that difference would currently result in a different implementation,
though it may matter for software DSM implementations.  I think this
terminology has been in fairly widespread use in the architecture
community since at least 1990 or so.  (Google "release consistency".)

- C# uses similar terminology, as we have been doing so far for C++.
I'm not convinced these are Itanium specific terms.

- At user level, the ordering semantics required for something like
pthread_mutex_lock() are unfortunately unclear.  If you try to interpret
the current standard, you arrive at the conclusion that
pthread_mutex_lock() basically needs a full barrier, though
pthread_mutex_unlock() doesn't.  (See
http://www.hpl.hp.com/techreports/2005/HPL-2005-217.html .)  There is
some evidence that this is unintentional, inconsistently implemented,
and probably undesired. 

- The C++ equivalent of this is not very far along and still
controversial.  But I think the current majority sentiment is in favor
of expressing the ordering constraints in a way that ensures they cannot
accidentally become dynamically computed arguments. i.e. in favor of
making them either part of the operation name or template arguments, but
not regular arguments.

Hans

> -----Original Message-----
> From: linux-ia64-owner@vger.kernel.org 
> [mailto:linux-ia64-owner@vger.kernel.org] On Behalf Of 
> Christoph Lameter
> Sent: Tuesday, March 28, 2006 11:11 PM
> To: Chen, Kenneth W
> Cc: 'Nick Piggin'; Zoltan Menyhart; akpm@osdl.org; 
> linux-kernel@vger.kernel.org; linux-ia64@vger.kernel.org
> Subject: RE: Fix unlock_buffer() to work the same way as bit_unlock()
> 
> On Tue, 28 Mar 2006, Chen, Kenneth W wrote:
> 
> > Nick Piggin wrote on Tuesday, March 28, 2006 6:36 PM
> > > Hmm, not sure. Maybe a few new bitops with _lock / 
> _unlock postfixes?
> > > For page lock and buffer lock we'd just need 
> test_and_set_bit_lock, 
> > > clear_bit_unlock, smp_mb__after_clear_bit_unlock.
> > > 
> > > I don't know, _for_lock might be a better name. But it's 
> getting long.
> > 
> > I think kernel needs all 4 variants:
> > 
> > clear_bit
> > clear_bit_lock
> > clear_bit_unlock
> > clear_bit_fence
> > 
> > And the variant need to permutated on all other bit ops ... 
>  I think 
> > it would be indeed a better API and be more explicit about 
> the ordering.
> 
> How about clear_bit(why, bit, address) in order to keep the 
> variants down? Get rid of the smp_mb__*_xxxx stuff.
> 
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-ia64" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
