Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751899AbWISRyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751899AbWISRyJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 13:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751900AbWISRyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 13:54:09 -0400
Received: from tomts13-srv.bellnexxia.net ([209.226.175.34]:14516 "EHLO
	tomts13-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751899AbWISRyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 13:54:07 -0400
Date: Tue, 19 Sep 2006 13:54:05 -0400
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Martin Bligh <mbligh@google.com>
Cc: prasanna@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       "Frank Ch. Eigler" <fche@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Linux Kernel Markers
Message-ID: <20060919175405.GC26339@Krystal>
References: <20060918234502.GA197@Krystal> <20060919081124.GA30394@elte.hu> <451008AC.6030006@google.com> <20060919154612.GU3951@redhat.com> <4510151B.5070304@google.com> <20060919093935.4ddcefc3.akpm@osdl.org> <45101DBA.7000901@google.com> <20060919063821.GB23836@in.ibm.com> <45102641.7000101@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <45102641.7000101@google.com>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 13:50:16 up 27 days, 14:58,  4 users,  load average: 0.41, 0.35, 0.28
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Martin Bligh (mbligh@google.com) wrote:
> How about we combine all three ideas together ...
> 
> 1. Load modified copy of the function in question.
> 2. overwrite the first instruction of the routine with an int3 that
> does what you say (atomically)
> 3. Then overwrite the second instruction with a jump that's faster
> 4. Now atomically overwrite the int3 with a nop, and let the jump
> take over.
> 

Very good idea.. However, overwriting the second instruction with a jump could
be dangerous on preemptible and SMP kernels, because we never know if a thread
has an IP in any of its contexts that would return exactly at the middle of the
jump. I think it would be doable to overwrite a 5+ bytes instruction with a NOP
non-atomically in all cases, but as the instructions nin the prologue seems to
be smaller :

prologue on x86
   0:   55                      push   %ebp
   1:   89 e5                   mov    %esp,%ebp
epilogue on x86
   3:   5d                      pop    %ebp
   4:   c3                      ret

Then is can be a problem. Ideas are welcome.

Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
