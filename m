Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316682AbSG0Edi>; Sat, 27 Jul 2002 00:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318696AbSG0Edh>; Sat, 27 Jul 2002 00:33:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22283 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316682AbSG0Edh>;
	Sat, 27 Jul 2002 00:33:37 -0400
Message-ID: <3D422553.6B126242@zip.com.au>
Date: Fri, 26 Jul 2002 21:45:07 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: linux-kernel@vger.kernel.org, lse <lse-tech@lists.sourceforge.net>,
       riel@conectiva.com.br
Subject: Re: [RFC] Scalable statistics counters using kmalloc_percpu
References: Your message of "Fri, 26 Jul 2002 11:46:34 MST."
	             <3D41990A.EDC1A530@zip.com.au> <20020727015833.D0C534134@lists.samba.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> 
> > > +       for( i=0; i < NR_CPUS; i++ )
> > > +               res += *per_cpu_ptr(stctr->ctr, i);
> > > +       return res;
> > > +}
> >
> > Oh dear.  Most people only have two CPUs.
> >
> > Rusty, can we *please* fix this?  Really soon?
> 
> Linus just applied the hotplug cpu boot patch in bk, which gives
> cpu_possible(i), for exactly this purpose.

Good.  And will it be possible to iterate across all CPUs
without having to iterate across NR_CPUS?

> > General comment:  we need to clean up the kernel_stat stuff.  We
> > cannot just make it per-cpu because it is 32k in size already.  I
> > would suggest that we should break out the disk accounting and
> > make the rest of kernel_stat per CPU.
> 
> kernel_stat is dynamically allocated???

No.  It's jut a big lump of bss.
 
> Personally, I think that dynamically allocated per-cpu datastructures,
> like dynamically-allocated brlocks, are something we might need
> eventually, but look at what a certain driver did with the "make it
> per-cpu" concept already.  I don't want to rush in that direction.

What driver is that?

And no, we need to do something about the NR_CPUS bloat Right Now.

In my build there is a quarter megabyte of per cpu data.  And that
does not include the (currently small) .data.percpu * 32.

The is pretty much entirely wasted memory, and it will only get
worse. Making NR_CPUS compile-time configurable is a lame solution.
Wasting the memory is out of the question.

Dynamic allocation is the only thing left, yes?

-
