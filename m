Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268488AbTCABc0>; Fri, 28 Feb 2003 20:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268492AbTCABc0>; Fri, 28 Feb 2003 20:32:26 -0500
Received: from fmr01.intel.com ([192.55.52.18]:34276 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S268488AbTCABcY> convert rfc822-to-8bit;
	Fri, 28 Feb 2003 20:32:24 -0500
content-class: urn:content-classes:message
Subject: RE: [BUG] 2.5.63: ESR killed my box!
Date: Fri, 28 Feb 2003 17:42:43 -0800
Message-ID: <DC675A50D067E045B80AAEDCBD2648BD2F2C3C@fmsmsx408.fm.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BUG] 2.5.63: ESR killed my box!
X-MimeOLE: Produced By Microsoft Exchange V6.0.6334.0
Thread-Index: AcLeURVl/AucJyFTSoG5Ora7YzHpRwBCtTvQ
From: "Mallick, Asit K" <asit.k.mallick@intel.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       "Linus Torvalds" <torvalds@transmeta.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       "William Lee Irwin III" <wli@holomorphy.com>,
       "Rusty Russell" <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
       <mingo@redhat.com>, "Mikael Pettersson" <mikpe@csd.uu.se>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
X-OriginalArrivalTime: 01 Mar 2003 01:42:43.0685 (UTC) FILETIME=[DA623150:01C2DF93]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Your interpretation is correct. The algorithm in the documentation (PRM
vol3) is defined to make it work for both Pentium and P6 and above
family of processors.

As Maciej mentioned, on Pentium any read of ESR will clear the ESR and
writes to ESR have no effect except the errata #3AP that was fixed in
C-stepping Pentium processors.

On P6 and above processors a write is needed to make the current error
bits to be visible in the ESR (the latch as you mentioned). Also this
write will make the current error bits 0 (clear). So, this will provide
the current status of the errors:

> >  - latch current state and read it:
> >
> > 	apic_write(0, APIC_ESR);	// I doubt the value matters
> > 	value = apic_read(APIC_ESR);
> >
> >    This reads the real "current state", leaving it in the latch.

To clear the ESR (the latch) you need to do a back-to-back write as the
first write will clear the current error bits and the 2nd write will
move the cleared bits (form previous write) to readable ESR. So, your
algorithm should work: 

> >  - clear and read current state:
> >
> > 	apic_write(0, APIC_ESR);
> > 	value = apic_read(APIC_ESR);

					<<<====== another error can
occur
> > 	apic_write(0, APIC_ESR);
> >

However, there is a window where another error could be generated after
the first write and read. In this case, a read after the last write will
see a non-zero value and the ESR will not be cleared. You can handle
this by doing write and read in a loop until the ESR read value becomes
0.

> > Also, I would _assume_ that the error interrupt is active based on
the
> > bit-wise "or" of both the latched and the real value, since the docs
> > clearly say that it must be cleared by sw by back-to-back writes
> 
>  I believe only the real value matters.

It is the real value. Error interrupt is generated when any bit is set
in the real value (error bits) and does not use visible ESR. However,
the ESR (latch) bits are cumulative and if the ESR is not cleared (using
2 writes) when we handle the interrupt the read of ESR status will also
contain the errors for the previous error. So, the interrupt handler
also should use the clear and read current state as you mentioned.

I do not know the problem that James mentioned but it will be good to
know the kind of errors that were causing the problem. Also, if someone
can provide a test case we will be glad to look at this.

Thanks,
Asit


