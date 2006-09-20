Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbWITBJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWITBJr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 21:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbWITBJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 21:09:47 -0400
Received: from tomts25-srv.bellnexxia.net ([209.226.175.188]:51892 "EHLO
	tomts25-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1750822AbWITBJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 21:09:46 -0400
Date: Tue, 19 Sep 2006 21:09:43 -0400
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Martin Bligh <mbligh@google.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, "Frank Ch. Eigler" <fche@redhat.com>,
       Ingo Molnar <mingo@elte.hu>, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com
Subject: Re: [PATCH] Linux Kernel Markers
Message-ID: <20060920010943.GA28097@Krystal>
References: <20060919081124.GA30394@elte.hu> <451008AC.6030006@google.com> <20060919154612.GU3951@redhat.com> <4510151B.5070304@google.com> <20060919093935.4ddcefc3.akpm@osdl.org> <45101DBA.7000901@google.com> <20060919063821.GB23836@in.ibm.com> <45102641.7000101@google.com> <20060919175405.GC26339@Krystal> <1158710925.32598.120.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <1158710925.32598.120.camel@localhost.localdomain>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 21:03:17 up 27 days, 22:11,  2 users,  load average: 0.13, 0.17, 0.09
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox (alan@lxorguk.ukuu.org.uk) wrote:
> Ar Maw, 2006-09-19 am 13:54 -0400, ysgrifennodd Mathieu Desnoyers:
> > Very good idea.. However, overwriting the second instruction with a jump could
> > be dangerous on preemptible and SMP kernels, because we never know if a thread
> > has an IP in any of its contexts that would return exactly at the middle of the
> > jump. 
> 
> No: on x86 it is the *same* case for all of these even writing an int3.
> One byte or a megabyte,
> 
> You MUST ensure that every CPU executes a serializing instruction before
> it hits code that was modified by another processor. Otherwise you get
> CPU errata and the CPU produces results which vendors like to describe
> as "undefined".
> 
> Thus you have to serialize, and if you are serializing it really doesn't
> matter if you write a byte, a paragraph or a page.
> 
Hi Alan,

What I am trying to address is not "code patching with INT3", but "code patching
with a 5 bytes JMP". The errata you point to applies to both and kprobes
mechanism already takes care of this with the serialization method you describe.

However, there is a supplemental problem with the fact that a JMP is 5 bytes,
not 1. You are right about saying that overwriting code with any amount of
*int3* does not matter, but what happens when you put one or more 5 bytes long
jumps instead ?

Think about it : if you are replacing 1-2-3 or 4 bytes long instruction and,
unluckily, on any stack of any thread preempted from any CPU, you have a
current instruction pointer pointing at the middle of the region where you want
to put the 5 bytes JMP, the processor will likely trigger an illegal
instruction fault when this particular thread is scheduled back.

Mathieu

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
