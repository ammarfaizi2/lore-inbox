Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314395AbSFLU4e>; Wed, 12 Jun 2002 16:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314433AbSFLU4d>; Wed, 12 Jun 2002 16:56:33 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:16182 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S314395AbSFLU41>; Wed, 12 Jun 2002 16:56:27 -0400
Message-Id: <5.1.0.14.2.20020612214327.04590b70@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 12 Jun 2002 21:57:23 +0100
To: "H. Peter Anvin" <hpa@zytor.com>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [PATCH] 2.5.21 Nonlinear CPU support
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <ae89e2$qhs$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 21:03 12/06/02, H. Peter Anvin wrote:
>Followup to:  <5.1.0.14.2.20020612192802.045b08c0@pop.cus.cam.ac.uk>
>By author:    Anton Altaparmakov <aia21@cantab.net>
>In newsgroup: linux.dev.kernel
> >
> > >2) If you need to do decompression on a cpu you check the array entry
> > >    for that CPU and if is NULL you vmalloc() the decompression 
> buffers once
> > >    for that CPU.  This avoid vmalloc() overhead for each read.
> >
> > The vmalloc() sleeps and by the time you get control back you are 
> executing
> > on a different CPU. Ooops. The only valid way of treating per-cpu data is:
> >
> > - disable preemption
> > - get the cpu number = START OF CRITICAL SECTION: no sleep/schedule allowed
> > - do work using the cpu number
> > - reenable preemption = END OF CRITICAL SECTION
>
>Actually, that doesn't matter, because it's a quickly convergent
>operation.
>
>Basically, once you've been invoked on a particular CPU once, you are
>pretty much guaranteed to get invoked on that same CPU again, so the
>fact that you may end up using a different buffer post-allocation is
>not an issue.
>
>Have an array and a semaphore called here allocation_semaphore:

I have a semaphore serializing allocation already. (-:

>/* PSEUDO-CODE */
>
>while ( 1 ) {
>       disable_preemption();
>       cpu = current_cpu();
>       if ( decompression_buffers[cpu] ) {
>         do_decompression(decompression_buffers[cpu]);
>         enable_preemption();
>         break;          /* DONE, EXIT LOOP */
>       } else {
>         enable_preemption();
>         down_sem(allocation_semaphore);
>         /* Avoid race condition here */
>         if ( !decompression_buffers[cpu] )
>             decompression_buffers[cpu] = vmalloc(BUFFER_SIZE);
>         up_sem(allocation_semaphore);
>       }
>}
>
>Note that there is no requirement that we're still on cpu "cpu" when
>we allocate the buffer.  Furthermore, if we fail, we just loop right
>back to the top.

What is the point though? Why not just:

         if (!unlikely(decompression_buffers)) {
                 down_sem();
                 allocate_decompression_buffers();
                 up_sem();
         }

And be done with it?

I don't see any justification for the increased complexity...

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

