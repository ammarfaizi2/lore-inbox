Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270881AbTGVP1F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 11:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270883AbTGVP1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 11:27:05 -0400
Received: from 224.Red-217-125-129.pooles.rima-tde.net ([217.125.129.224]:23029
	"HELO cocodriloo.com") by vger.kernel.org with SMTP id S270881AbTGVP1A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 11:27:00 -0400
Date: Tue, 22 Jul 2003 17:38:38 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: "Deas, Jim" <James.Deas@warnerbros.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vmalloc - kmalloc and page locks
Message-ID: <20030722153838.GB29384@wind.cocodriloo.com>
References: <S270278AbTGVNmc/20030722134232Z+5616@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <S270278AbTGVNmc/20030722134232Z+5616@vger.kernel.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 22, 2003 at 06:57:26AM -0700, Deas, Jim wrote:
> Thanks for the clarification. I am using mlockall on the user application. This 
> still leaves me with the mystery of why my system usage goes from 3% to
> 50% randomly while playing data streams off the harddrive. I can also make
> system usage stay at 50% by opening a third stream.
> These streams are pulling data at 1.5MB/s each from different files (same HD).
> I don't see that as a big strain on the hardware (4.5MB/s total data rate).
> Where else should I look to find the bottleneck/latency issue?
> 

Are you doing read() or mmap()?

If you are only reading and not modifying, having it mmap'ed as read only
and sequential access could be much faster.

Late 2.4 and 2.5+ kernels do read-ahead both with read() and mmap() access.

For extra effect, try using madvise() to ask the kernel to prefetch data
and to discard the already used ones.


> 
> -----Original Message-----
> From: G?bor L?n?rt [mailto:lgb@lgb.hu]
> Sent: Tuesday, July 22, 2003 6:13 AM
> To: Deas, Jim
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: vmalloc - kmalloc and page locks
> 
> 
> Errrrr ... Sorry, I did not read your mail carefully ;-(
> I meant in case of a user process you can use mlock() and such :)
> AFAIK the kernel itself is not pagable ...
> 
> On Tue, Jul 22, 2003 at 03:07:18PM +0200, G?bor L?n?rt wrote:
> > Please read something about the mlock() and/or mlockall() functions.
> > The prototype can be found in [/usr/include/]sys/mman.h
> > You can read there:
> > 
> > /* Guarantee all whole pages mapped by the range [ADDR,ADDR+LEN) to
> >    be memory resident.  */
> > extern int mlock (__const void *__addr, size_t __len) __THROW;
> > [...]
> > /* Cause all currently mapped pages of the process to be memory resident
> >    until unlocked by a call to the `munlockall', until the process exits,
> >    or until the process calls `execve'.  */
> > extern int mlockall (int __flags) __THROW;
> > 
> > On Tue, Jul 22, 2003 at 06:00:14AM -0700, Deas, Jim wrote:
> > > How can I look at what memory are being paged out of memory in the kernel
> > > or how to lock kmalloc and vmalloc pages so they do not get put to swap?
> > [...]
> > 
> > - G?bor (larta'H)
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> -- 
> - G?bor (larta'H)
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 

1. Dado un programa, siempre tiene al menos un fallo.
2. Dadas varias lineas de codigo, siempre se pueden acortar a menos lineas.
3. Por induccion, todos los programas se pueden
   reducir a una linea que no funciona.
