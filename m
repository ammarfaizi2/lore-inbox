Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313087AbSFLUDY>; Wed, 12 Jun 2002 16:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313190AbSFLUDX>; Wed, 12 Jun 2002 16:03:23 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3091 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313087AbSFLUDW>; Wed, 12 Jun 2002 16:03:22 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] 2.5.21 Nonlinear CPU support
Date: 12 Jun 2002 13:03:14 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <ae89e2$qhs$1@cesium.transmeta.com>
In-Reply-To: <5.1.0.14.2.20020612155646.048fd520@pop.cus.cam.ac.uk> <5.1.0.14.2.20020611155046.00af3980@pop.cus.cam.ac.uk> <5.1.0.14.2.20020612155646.048fd520@pop.cus.cam.ac.uk> <5.1.0.14.2.20020612192802.045b08c0@pop.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <5.1.0.14.2.20020612192802.045b08c0@pop.cus.cam.ac.uk>
By author:    Anton Altaparmakov <aia21@cantab.net>
In newsgroup: linux.dev.kernel
> 
> >2) If you need to do decompression on a cpu you check the array entry
> >    for that CPU and if is NULL you vmalloc() the decompression buffers once
> >    for that CPU.  This avoid vmalloc() overhead for each read.
> 
> The vmalloc() sleeps and by the time you get control back you are executing 
> on a different CPU. Ooops. The only valid way of treating per-cpu data is:
> 
> - disable preemption
> - get the cpu number = START OF CRITICAL SECTION: no sleep/schedule allowed
> - do work using the cpu number
> - reenable preemption = END OF CRITICAL SECTION
> 

Actually, that doesn't matter, because it's a quickly convergent
operation.

Basically, once you've been invoked on a particular CPU once, you are
pretty much guaranteed to get invoked on that same CPU again, so the
fact that you may end up using a different buffer post-allocation is
not an issue.

Have an array and a semaphore called here allocation_semaphore:

/* PSEUDO-CODE */

while ( 1 ) {
      disable_preemption();
      cpu = current_cpu();
      if ( decompression_buffers[cpu] ) {
	 do_decompression(decompression_buffers[cpu]);
	 enable_preemption();
	 break;		/* DONE, EXIT LOOP */
      } else {
	 enable_preemption();
	 down_sem(allocation_semaphore);
	 /* Avoid race condition here */
	 if ( !decompression_buffers[cpu] )
	    decompression_buffers[cpu] = vmalloc(BUFFER_SIZE);
	 up_sem(allocation_semaphore);
      }
}

Note that there is no requirement that we're still on cpu "cpu" when
we allocate the buffer.  Furthermore, if we fail, we just loop right
back to the top.

	-hpa
      
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
