Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbWEENNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbWEENNv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 09:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbWEENNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 09:13:51 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:38887 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1751105AbWEENNv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 09:13:51 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Alan Modra <amodra@bigpond.net.au>
Subject: Re: as bug (was: Re: smp/up alternatives crash when CONFIG_HOTPLUG_CPU)
Date: Fri, 5 May 2006 16:13:24 +0300
User-Agent: KMail/1.8.2
Cc: binutils@sourceware.org, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, Gerd Hoffmann <kraxel@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Chuck Ebbert <76306.1226@compuserve.com>, binutils@sources.redhat.com
References: <20060419094630.GA14800@elte.hu> <200605051145.54643.vda@ilport.com.ua> <20060505122029.GB11597@bubble.grove.modra.org>
In-Reply-To: <20060505122029.GB11597@bubble.grove.modra.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605051613.24704.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 May 2006 15:20, Alan Modra wrote:
> On Fri, May 05, 2006 at 11:45:54AM +0300, Denis Vlasenko wrote:
> > 
> > .section .smp_altinstr_replacement,"awx"
> > .section        .sched.text,"ax",@progbits
> >         call    _spin_unlock    #
> > 661:
> > 2:      jle 2b  #
> > 662:
> > .section .smp_altinstr_replacement,"awx"
> >         .fill 662b-661b,1,0x42
> 
> gas should give a better error message here, but really, gas shouldn't
> be expected to assemble this.  In essence, you have forward references
> in that expression for the .fill length..

Yes, this should be an error, not warning. It produces miscompiled
object modules.
 
> Some background:  Gas is a single pass assembler.  It emits code and
> data into "frags", buffers containing some fixed number of bytes and
> possibly a variable length tail.  The variable length part allows
> various features, notably that of variable length instructions.  Symbols
> are defined relative to their frags.  Until the frag addresses are
> finalized, an expresion involving subtraction of two symbols in
> different frags cannot be evaluated correctly.  With the testcase above
> you have exactly that situation.  The x86 "jle" instruction can be two
> sizes, either 6 bytes or 2 bytes depending on the offset needed, and gas
> doesn't have the smarts to recognize that the "jle" above is just 2
> bytes.  Instead, it assumes a variable size, putting the "jle" in its
> own frag.  This means that label "661" and "662" are in separate frags
> with "661" at offset 5 in its frag, and "662" at offset 0.
> 
> Since you define the ".smp_altinstr_replacement" section before the
> ".sched.text section", gas tries to finalize ".smp_altinstr_replacement"
> first.  When it tries to calculate the fill size using
>    (<base addr "662" frag>+<offset "662">)
>     - (<base addr "661" frag>+<offset "661">)
> the frag base addresses have not yet been set, and zero is used.  ie.
> gas tries to assemble ".fill -5,1,0x42".

Thanks for the explanation.
--
vda
