Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751146AbVIGR1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbVIGR1p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 13:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbVIGR1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 13:27:44 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:13246 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751146AbVIGR1o convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 13:27:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=daN76KhoPAbGSFhHE080LsUYAKcYP48d4uZkad/5m54bRpf9BghKEgmNNsulb3D99CIkT+BjKlbLTdBLeXWU97KndWb7kW18SJ6o6qHbz1KuyoDurF1/TTDQYT2Q/7ySuSF3tlFWsBhSwJhPvg91egmgCiYNU7mB+CR24NPQaGQ=
Message-ID: <29495f1d05090710276d64a3de@mail.gmail.com>
Date: Wed, 7 Sep 2005 10:27:43 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: nish.aravamudan@gmail.com
To: vatsa@in.ibm.com
Subject: Re: [PATCH 1/3] dynticks - implement no idle hz for x86
Cc: Bill Davidsen <davidsen@tmr.com>, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       ck list <ck@vds.kolivas.org>, rmk+lkml@arm.linux.org.uk
In-Reply-To: <20050907171756.GB28387@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200509031801.09069.kernel@kolivas.org>
	 <200509031814.49666.kernel@kolivas.org>
	 <20050904201054.GA4495@us.ibm.com>
	 <20050904212616.B11265@flint.arm.linux.org.uk>
	 <20050905053225.GA4294@in.ibm.com> <20050905054813.GC25856@us.ibm.com>
	 <20050905063229.GB4294@in.ibm.com> <431F11FF.2000704@tmr.com>
	 <29495f1d0509070942688059a6@mail.gmail.com>
	 <20050907171756.GB28387@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/05, Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:
> On Wed, Sep 07, 2005 at 09:42:24AM -0700, Nish Aravamudan wrote:
> > Hrm, got dropped from the Cc... :) Yes, the dynamic-tick generic
> > infrastructure being proposed, with the idle CPU mask and the
> > set_all_cpus_idle() tick_source hook, would allow exactly this in
> > arch-specific code.
> 
> I think Bill is referring to the "resume" interface i.e an
> unset_all_cpus_idle() interface, which is missing (set/unset
> probably are not good prefixes maybe?). I feel we can
> add one.

Yes, can be added.

enter_all_cpus_idle() and exit_all_cpus_idle() would be better?

> > Is there a generic location where the all-idle state is entered?
> 
> Should be from the place where the last cpu is set in the bitmap
> and bitmap is found equal to cpu_online_map.

Yes, this is what I said.

> > Currently, I think we can do it via the generic reprogram() routine
> > checking the mask and then calling set_all_cpus_idle(), if
> > appropriate, after reprogramming the last idle CPU.
> 
> So are you saying that setting of the CPU in the bitmap will be done
> inside reprogram_timer routine? If we consider that reprogram_timer can
> directly point to a routine in a interrupt source file (like apic.c/timer_pit.c)
> I dont think that it is the right place to set bits in the nohz_cpu_mask.
> It can be done by the callee of reprogram_timer itself.

No, I was saying what you were, if a little unclearly, so the caller
does something like:

current_dyn_tick_timer->reprogram();
check_cpu_mask(nohz_cpu_mask);
if (we_are_last_idle)
  enter_all_cpus_idle();

Thanks,
Nish
