Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271356AbTGWWU4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 18:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271362AbTGWWU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 18:20:56 -0400
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:18906 "HELO
	develer.com") by vger.kernel.org with SMTP id S271356AbTGWWUm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 18:20:42 -0400
From: Bernardo Innocenti <bernie@develer.com>
Organization: Develer S.r.l.
To: Christoph Hellwig <hch@infradead.org>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: [uClinux-dev] Kernel 2.6 size increase - get_current()?
Date: Thu, 24 Jul 2003 00:35:38 +0200
User-Agent: KMail/1.5.9
Cc: uclinux-dev@uclinux.org, linux-kernel@vger.kernel.org
References: <200307232046.46990.bernie@develer.com> <20030723132256.58ee50e7.davem@redhat.com> <20030723212755.A608@infradead.org>
In-Reply-To: <20030723212755.A608@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200307240035.38502.bernie@develer.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 July 2003 22:27, Christoph Hellwig wrote:

> On Wed, Jul 23, 2003 at 01:22:56PM -0700, David S. Miller wrote:
> > Drivers weren't audited much, and there's a lot of boneheaded
> > stuff in this area.  But these should be mostly identical
> > to what would happen on the 2.4.x side
>
> Please read the original message again - he stated that every single
> module in fs/ got alot bigger - if it gets smaller or at least the
> same size as 2.4 it's clearly a sign of inlines gone mad in the
> filesystem/VM code and we need to look at that.  If not we have to look
> elsewhere.

I have my humbling opinion:

In 2.4.20 (m68knommu):
-------------------------------------------------------------------------
#define current _current_task
-------------------------------------------------------------------------

In 2.6.0-test1 (m68knommu):
-------------------------------------------------------------------------
#define current get_current()
static inline struct task_struct *get_current(void)
{
        return(current_thread_info()->task);
}
static inline struct thread_info *current_thread_info(void)
{
        struct thread_info *ti;
        __asm__(
                "move.l %%sp, %0 \n\t"
                "and.l  %1, %0"
                : "=&d"(ti)
                : "d" (~(THREAD_SIZE-1))
                );
        return ti;
}
-------------------------------------------------------------------------

The latter expands to:

 0:	movel #-8192,%d0
 6:	movel %sp,%d2
 8:	andl %d0,%d2
 a:	moveal %d2,%a1
 c:	moveal %a1@,%a0
 e:	moveal %a0@(92),%a0
12:

It's a sequence of 6 instructions, 18 bytes long, clobbering 4 registers.
The compiler cannot see around it.

"current" is being used very lightly all over the kernel, like in this
code snippet from fs/open.c:

        old_fsuid = current->fsuid;
        old_fsgid = current->fsgid;
        old_cap = current->cap_effective;
        current->fsuid = current->uid;
        current->fsgid = current->gid;
        if (current->uid)
                cap_clear(current->cap_effective);
        else
                current->cap_effective = current->cap_permitted;

This takes 18*11 = 198 bytes just for invoking the 'current'
macro so many times.

Perhaps adding __attribute__((const)) on current_thread_info() and
get_current() would help eliminating some unnecessary accesses.

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

Please don't send Word attachments - http://www.gnu.org/philosophy/no-word-attachments.html


