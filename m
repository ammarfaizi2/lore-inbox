Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154855AbQDKSI5>; Tue, 11 Apr 2000 14:08:57 -0400
Received: by vger.rutgers.edu id <S154696AbQDKSDf>; Tue, 11 Apr 2000 14:03:35 -0400
Received: from colorfullife.com ([216.156.138.34]:3870 "EHLO colorfullife.com") by vger.rutgers.edu with ESMTP id <S154765AbQDKRqX>; Tue, 11 Apr 2000 13:46:23 -0400
Message-ID: <38F364B3.5A4A45D9@colorfullife.com>
Date: Tue, 11 Apr 2000 19:45:23 +0200
From: Manfred Spraul <manfreds@colorfullife.com>
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.2.14 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, "David S. Miller" <davem@redhat.com>, alan@lxorguk.ukuu.org.uk, kanoj@google.engr.sgi.com, linux-kernel@vger.rutgers.edu, linux-mm@kvack.org, torvalds@transmeta.com
Subject: Re: zap_page_range(): TLB flush race
References: <Pine.LNX.4.21.0004111824090.19969-100000@maclaurin.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

Andrea Arcangeli wrote:
> 
> On Tue, 11 Apr 2000, Manfred Spraul wrote:
> 
> >* They need the old pte value and the virtual address for their flush
> >ipi.
> 
> Why can't they flush all the address space unconditionally on the other
> cpus?

They have a special instruction that flushes one mapping on all cpus in
the system. 
It has 2 parameters:
	* virtual address of the page
	* segment of the physical page to be flushed???

Is someone out there with a s390 asm handbook? I only have these
comments:

+/*
+ * s390 has two ways of flushing TLBs
+ * 'ptlb' does a flush of the local processor
+ * 'ipte' invalidates a pte in a page table and flushes that out of 
+ * the TLBs of all PUs of a SMP 
+ */

+       /*
+        * S390 has 1mb segments, we are emulating 4MB segments
+        */
+
+       pto = (pte_t*) (((unsigned long) pte) & 0x7ffffc00);
+              
+               __asm__ __volatile("    ic   0,2(%0)\n"
+                          "    ipte %1,%2\n"
+                          "    stc  0,2(%0)"
+: : "a" (pte), "a" (pto), "a" (addr): "0");
+}

> I can't find a valid reason for which they do need the old pte
> value. The tlb should be a virtual->physical mapping only, the pte isn't
> relevant at all with the TLB. however if they really need both old pte
> address and the virtual address of the page, they can trivially pass the
> parameters to the other CPUs acquring a spinlock and using some global
> variable exactly as IA32 does to avoid flushing the whole TLB on the other
> CPUs in the flush_tlb_page case.
> 
> >Obviously their work-around
> >       flush_tlb_page()
> >       set_pte()
> >is wrong as well, and it breaks all other architectures :-/
> 
> I bet it breaks s390 too.
> 

Of course :-)

> The other filemap_sync race with threads that Kanoj was talking about is
> very less severe since it can't make the machine unstable, but it can only
> forgot to write some bit using strange userspace app design (only _data_
> corruption can happen to the shared mmaping of the patological app).

Yes. 
Can we ignore the munmap+access case?
I'd say that if 2 threads race with munmap+access, then the behaviour is
undefined.
Tlb flushes are expensive, I'd like to avoid the second tlb flush as in
Kanoj's patch.

--
	Manfred


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
