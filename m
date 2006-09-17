Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964914AbWIQPgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964914AbWIQPgi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 11:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964915AbWIQPgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 11:36:38 -0400
Received: from tomts43-srv.bellnexxia.net ([209.226.175.110]:35223 "EHLO
	tomts43-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S964914AbWIQPgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 11:36:37 -0400
Date: Sun, 17 Sep 2006 11:36:33 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Ingo Molnar <mingo@elte.hu>
Cc: Paul Mundt <lethal@linux-sh.org>, Karim Yaghmour <karim@opersys.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: tracepoint maintainance models
Message-ID: <20060917153633.GA29987@Krystal>
References: <450D182B.9060300@opersys.com> <20060917112128.GA3170@localhost.usen.ad.jp> <20060917143623.GB15534@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20060917143623.GB15534@elte.hu>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 11:06:25 up 25 days, 12:15,  3 users,  load average: 1.75, 1.68, 1.51
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Ingo Molnar (mingo@elte.hu) wrote:
>   - model #2: we could have the least intrusive markers in the main
>     kernel source, while the more intrusive ones would still be in the
>     upstream kernel, but in scripts/instrumentation/.
> 

Please define : marker intrusiveness. I think that this is not a sole concept.
First, I think we have to look at intrusiveness under three different angles :

- Visual intrusiveness (hurts visually in the code)
- Compiled-in, but inactive intrusiveness
  - Modifies compiler optimisations when the marker is compiled in but no
    tracing is active.
  - Wastes a few cycles because it adds NOPs, jump, etc in a critical path
    when tracing is not active.
- Active tracing intrusiveness
  - Wastes too many cycles in a critical path when tracing is active.

The problem is that a static marker will speed up the active tracing while a
dynamic probe will speed up the case where tracing is inactive. The problem is
that the dynamic probe cost can get so big that it modifies the traced system
often more than acceptable. Under this angle, I would be tempted to say that the
most intrusive instrumentation should be helped by marker, which means accepting
a very small performance impact (NOPs on modern CPUs are quite fast) when
tracing is not active in order to enable fast tracing of some very high event
rate kernel code paths.


>   - model #3: we could have the 'hardest' markups in the source, and the 
>     'easy' ones as dynamic markups in scripts/instrumentation/.
> 
By "hardest", do you mean : where the data that is to be extracted is not easily
available due to compiler optimisations ?

> So my argument isnt "dynamic markup vs. static markup", my argument is: 
> "we shouldnt force the kernel to carry a 100% set of static markups 
> forever". We should allow maintainers to decide the 'mix' of static vs. 
> dynamic markups that they prefer in their subsystem.
> 
We completely agree on this last paragraph.

> i agree, as long as it's lightweight markers for _dynamic tracers_, so 
> that we keep our options open - as per the arguments above.

But I also think that a marker mechanism should not only mark the code location
where the instrumentation is to be made, but also the information the probe is
interested into (provide compile-time data type verification and address at
runtime). Doing otherwise would limit what could be provided to static markup
users.

Mathieu

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
