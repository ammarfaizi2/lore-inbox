Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030196AbWEEMUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030196AbWEEMUd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 08:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751540AbWEEMUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 08:20:33 -0400
Received: from CPE-144-136-172-108.sa.bigpond.net.au ([144.136.172.108]:10838
	"EHLO grove.modra.org") by vger.kernel.org with ESMTP
	id S1751534AbWEEMUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 08:20:32 -0400
Date: Fri, 5 May 2006 21:50:29 +0930
From: Alan Modra <amodra@bigpond.net.au>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: binutils@sourceware.org, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, Gerd Hoffmann <kraxel@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Chuck Ebbert <76306.1226@compuserve.com>, binutils@sources.redhat.com
Subject: Re: as bug (was: Re: smp/up alternatives crash when CONFIG_HOTPLUG_CPU)
Message-ID: <20060505122029.GB11597@bubble.grove.modra.org>
Mail-Followup-To: Denis Vlasenko <vda@ilport.com.ua>,
	binutils@sourceware.org, Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@osdl.org>, Gerd Hoffmann <kraxel@suse.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Chuck Ebbert <76306.1226@compuserve.com>, binutils@sources.redhat.com
References: <20060419094630.GA14800@elte.hu> <20060421074858.GA28858@elte.hu> <200605051140.22005.vda@ilport.com.ua> <200605051145.54643.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605051145.54643.vda@ilport.com.ua>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2006 at 11:45:54AM +0300, Denis Vlasenko wrote:
> 
> .section .smp_altinstr_replacement,"awx"
> .section        .sched.text,"ax",@progbits
>         call    _spin_unlock    #
> 661:
> 2:      jle 2b  #
> 662:
> .section .smp_altinstr_replacement,"awx"
>         .fill 662b-661b,1,0x42

gas should give a better error message here, but really, gas shouldn't
be expected to assemble this.  In essence, you have forward references
in that expression for the .fill length..

Some background:  Gas is a single pass assembler.  It emits code and
data into "frags", buffers containing some fixed number of bytes and
possibly a variable length tail.  The variable length part allows
various features, notably that of variable length instructions.  Symbols
are defined relative to their frags.  Until the frag addresses are
finalized, an expresion involving subtraction of two symbols in
different frags cannot be evaluated correctly.  With the testcase above
you have exactly that situation.  The x86 "jle" instruction can be two
sizes, either 6 bytes or 2 bytes depending on the offset needed, and gas
doesn't have the smarts to recognize that the "jle" above is just 2
bytes.  Instead, it assumes a variable size, putting the "jle" in its
own frag.  This means that label "661" and "662" are in separate frags
with "661" at offset 5 in its frag, and "662" at offset 0.

Since you define the ".smp_altinstr_replacement" section before the
".sched.text section", gas tries to finalize ".smp_altinstr_replacement"
first.  When it tries to calculate the fill size using
   (<base addr "662" frag>+<offset "662">)
    - (<base addr "661" frag>+<offset "661">)
the frag base addresses have not yet been set, and zero is used.  ie.
gas tries to assemble ".fill -5,1,0x42".

A workaround is to ensure that the ".sched.text" section is defined
before ".smp_altinst_replacement".

-- 
Alan Modra
IBM OzLabs - Linux Technology Centre
