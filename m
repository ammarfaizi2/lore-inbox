Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154605AbQDHXtg>; Sat, 8 Apr 2000 19:49:36 -0400
Received: by vger.rutgers.edu id <S154586AbQDHXtM>; Sat, 8 Apr 2000 19:49:12 -0400
Received: from deliverator.sgi.com ([204.94.214.10]:19236 "EHLO deliverator.sgi.com") by vger.rutgers.edu with ESMTP id <S154628AbQDHXqT>; Sat, 8 Apr 2000 19:46:19 -0400
From: kanoj@google.engr.sgi.com (Kanoj Sarcar)
Message-Id: <200004082354.QAA62699@google.engr.sgi.com>
Subject: Re: zap_page_range(): TLB flush race
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Sat, 8 Apr 2000 16:54:32 -0700 (PDT)
Cc: manfreds@colorfullife.com (Manfred Spraul), linux-kernel@vger.rutgers.edu, linux-mm@kvack.org, torvalds@transmeta.com, davem@redhat.com, alan@lxorguk.ukuu.org.uk
In-Reply-To: <E12e4mo-0003Pn-00@the-village.bc.nu> from "Alan Cox" at Apr 09, 2000 12:37:05 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

> 
> > > Yes, establish_pte() is broken. We should reverse the calls:
> > > 
> > > 	set_pte(); /* update the kernel page tables */
> > > 	update_mmu(); /* update architecture specific page tables. */
> > > 	flush_tlb();  /* and flush the hardware tlb */
> > >
> > 
> > People are aware of this too, it was introduced during the 390 merge. 
> > I tried talking to the IBM guy about this, I didn't see a response from
> > him ...
> 
> Strange since I did and it included you

Yes, I did get the first mail from the IBM guy (was he from Denmark, seem 
to have seen ibm.de in his email?) explaining why the 390 wanted this
ordering ... In response, I pointed out that the 390 was either prone
to other races then, or was doing something in its low level handlers, 
and could he please confirm what is the case? 

Let me remember: he mentioned the old pte must be around for the ipte(?)
instruction to flush the tlb. If the new pte is dropped in before, the 
flush fails, the stale tlb entry stays, problems happen. So I pointed out
other places which do set_pte, then flush_tlb. I also wanted to know 
whether the flush_tlb somehow makes sure that other threads/cpus can not
pull in the old translation till the set_pte completes (something like
what freeze_pte_* does in my patch). I did not receive a response to this.

> 
> > I think what we now need is a critical mass, something that will make us
> > go "okay, lets just fix these races once and for all".
> 
> Basically establish_pte() has to be architecture specific, as some processors
> need different orders either to avoid races or to handle cpu specific
> limitations.

Even if you did that, wouldn't it just mean that the 390 would still be
prone to races, but other platforms are not? Of course, that's much
better than having all platforms be prone to the race!

And we should also handle the generic races with clones and ptes, an
example of which Manfred just demonstrated.

Kanoj
> 
> Alan
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux.eu.org/Linux-MM/
> 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
