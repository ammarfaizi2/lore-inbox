Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbTEELLB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 07:11:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbTEELLB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 07:11:01 -0400
Received: from elin.scali.no ([62.70.89.10]:28548 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id S262134AbTEELK7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 07:10:59 -0400
Subject: Re: The disappearing sys_call_table export.
From: Terje Eggestad <terje.eggestad@scali.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, D.A.Fedorov@inp.nsk.su
In-Reply-To: <20030505112531.B16914@infradead.org>
References: <1052122784.2821.4.camel@pc-16.office.scali.no>
	 <20030505092324.A13336@infradead.org>
	 <1052127216.2821.51.camel@pc-16.office.scali.no>
	 <20030505112531.B16914@infradead.org>
Content-Type: text/plain
Organization: Scali AS
Message-Id: <1052133798.2821.122.camel@pc-16.office.scali.no>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 05 May 2003 13:23:19 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-05 at 12:25, Christoph Hellwig wrote:
> On Mon, May 05, 2003 at 11:33:36AM +0200, Terje Eggestad wrote:
> > 1. performance is everything. 
> 
> then Linux is the wrong OS for you :)
> 

Strangely enough not. You just have to try and stay out of the kernel as
much as possible ;-)

Of course some idiot sold the total-cost-of-ownership thingy of linux to
the customers. What they really need is a OS/360... 
  
> > 2. We're making a MPI library, and as such we don't have any control
> > with the application. 
> 
> I can't remember that the MPI spec tells anything about intercepting
> syscalls..
> 

It's says quite a bit about what memory can be used for comm buffers. 


> > 3b. the performance loss from copying from a receive area to the
> > userspace buffer is unacceptable. 
> > 3c. It's therefore necessary for HW to access user pages. 
> > 4. In order to to 3, the user pages must be pinned down. 
> > 5. the way MPI is written, it's not using a special malloc() to allocate
> > the send receive buffers. It can't since it would break language binding
> > to fortran. Thus ANY writeable user page may be used. 
> 
> so use get_user_pages.

Let me clearify: pinning pages are not, repeat not a problem. 

The problem occur when you 
1. pinn a buffer  
2. sbrk(-n) or munmap() (usually thru free()) the area the buffer  
3. a new malloc() resulting in a sbrk(+n) or mmap()
4. then my new buffer has the exactly same virtual address as the prev.

(belive it or not this happens, and relatively frequently). 
 
> 
> > 6. point 4: pinning is VERY expensive (point 1), so I can't pin the
> > buffers every time they're used. 
> 
> Umm, pinning memory all the time means you get a bunch of nice DoS
> attachs due to the huge amount of memory.
> 

This is HPC clusters. DoS is a non issue. This is not the normal multi
user systems. In fact you run one active process per CPU.  

> > 7. The only way to cache buffers (to see if they're used before and
> > hence pinned) is the user space virtual address. A syscall, thus ioctl
> > to a device file is prohibitive expensive under point 1.  
> 
> That's a horribly b0rked approach..
> 

It's *FAST*.

> Again, where's your driver source so we can help you to find a better
> approach out of that mess?
>  

The trace module we made to trace munmap() and sbrk() could be opened,
but you'll be disappointed since all the pinning ( get_user_pages() and
friends), send() recv() etc are in the drivers for the various hardware,
most of which are not our property.  

The module works as follows. It catches sbrk(-arg) and munmap() and lays
out the trace info in a memory area mmap()'able thru the device file.  
So when processes need the trace info they have the info in memory to
avoid doing a ioctl().

Thats all we need to know if a given virtual address needs to be
(re)pinned. 

Lets deal, I'll GPL the trace module if you get me a 
EXPORT_SYMBOL_GPL(sys_call_table);



TJ


-- 
_________________________________________________________________________

Terje Eggestad                  mailto:terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 150, Oppsal                     +47 975 31 574  (MOBILE)
N-0619 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________

