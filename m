Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154735AbQDKQtD>; Tue, 11 Apr 2000 12:49:03 -0400
Received: by vger.rutgers.edu id <S154714AbQDKQsG>; Tue, 11 Apr 2000 12:48:06 -0400
Received: from Cantor.suse.de ([194.112.123.193]:4754 "HELO Cantor.suse.de") by vger.rutgers.edu with SMTP id <S154932AbQDKQkl>; Tue, 11 Apr 2000 12:40:41 -0400
Date: Tue, 11 Apr 2000 18:40:06 +0200 (CEST)
From: Andrea Arcangeli <andrea@suse.de>
To: Manfred Spraul <manfreds@colorfullife.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, "David S. Miller" <davem@redhat.com>, alan@lxorguk.ukuu.org.uk, kanoj@google.engr.sgi.com, linux-kernel@vger.rutgers.edu, linux-mm@kvack.org, torvalds@transmeta.com
Subject: Re: zap_page_range(): TLB flush race
In-Reply-To: <38F339A2.FB3F1699@colorfullife.com>
Message-ID: <Pine.LNX.4.21.0004111824090.19969-100000@maclaurin.suse.de>
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

On Tue, 11 Apr 2000, Manfred Spraul wrote:

>* They need the old pte value and the virtual address for their flush
>ipi.

Why can't they flush all the address space unconditionally on the other
cpus? I can't find a valid reason for which they do need the old pte
value. The tlb should be a virtual->physical mapping only, the pte isn't
relevant at all with the TLB. however if they really need both old pte
address and the virtual address of the page, they can trivially pass the
parameters to the other CPUs acquring a spinlock and using some global
variable exactly as IA32 does to avoid flushing the whole TLB on the other
CPUs in the flush_tlb_page case.

>Obviously their work-around
>	flush_tlb_page()
>	set_pte()
>is wrong as well, and it breaks all other architectures :-/

I bet it breaks s390 too.

The other filemap_sync race with threads that Kanoj was talking about is
very less severe since it can't make the machine unstable, but it can only
forgot to write some bit using strange userspace app design (only _data_
corruption can happen to the shared mmaping of the patological app).

Andrea



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
