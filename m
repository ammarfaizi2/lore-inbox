Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932512AbWIVOIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932512AbWIVOIn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 10:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932513AbWIVOIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 10:08:43 -0400
Received: from tomts40.bellnexxia.net ([209.226.175.97]:3065 "EHLO
	tomts40-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S932512AbWIVOIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 10:08:42 -0400
Date: Fri, 22 Sep 2006 10:03:29 -0400
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Martin Bligh <mbligh@google.com>, "Frank Ch. Eigler" <fche@redhat.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Linux Kernel Markers 0.5 for Linux 2.6.17 (with probe management)
Message-ID: <20060922140329.GA20839@Krystal>
References: <20060921160009.GA30115@Krystal> <20060921160656.GA24774@elte.hu> <20060921214248.GA10097@Krystal> <20060922064955.GA4167@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20060922064955.GA4167@elte.hu>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 10:00:53 up 30 days, 11:09,  4 users,  load average: 0.26, 0.87, 1.07
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ingo Molnar (mingo@elte.hu) wrote:
> 
> * Mathieu Desnoyers <compudj@krystal.dyndns.org> wrote:
> 
> > >   "As an example, LTTng traces the page fault handler, when kprobes 
> > >   just can't instrument it."
> > > 
> > > but tracing a raw pagefault at the arch level is a bad idea anyway, 
> > > we want to trace __handle_mm_fault(). That way you can avoid having 
> > > to modify every architecture's pagefault handler ...
> > 
> > Then you lose the ability to trace in-kernel minor page faults.
> 
> that's wrong, minor pagefaults go through __handle_mm_fault() just as 
> much.
> 

Hi Ingo,

On a 2.6.17 kernel tree :

In do_page_fault()
  
        if (unlikely(address >= TASK_SIZE)) {
                if (!(error_code & 0x0000000d) && vmalloc_fault(address) >= 0)
                        return;

In vmalloc_fault()

static inline int vmalloc_fault(unsigned long address)
{
        unsigned long pgd_paddr;
        pmd_t *pmd_k;
        pte_t *pte_k;
        /*
         * Synchronize this task's top level page-table
         * with the 'reference' page table.
         *
         * Do _not_ use "current" here. We might be inside
         * an interrupt in the middle of a task switch..
         */
        pgd_paddr = read_cr3();
        pmd_k = vmalloc_sync_one(__va(pgd_paddr), address);
        if (!pmd_k)
                return -1;
        pte_k = pte_offset_kernel(pmd_k, address);
        if (!pte_present(*pte_k))
                return -1;
        return 0;
}


It seems like a shortcut path that will never call __handle_mm_fault. This path
is precisely used to handle vmalloc faults.

Mathieu

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
