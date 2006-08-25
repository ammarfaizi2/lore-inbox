Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbWHYNnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbWHYNnq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 09:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbWHYNnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 09:43:46 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:38636 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932176AbWHYNnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 09:43:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lzh76DR/mLJ/TPuzfpQWnwF35QP5kLInG8Vb3uxew5S5iSUkxBKktCUPFALZfu8u++idtvG+H/Ls+YF0BgJtySP8ShXZtgllO1AkQDzJ8AjY9hcVBN20GMOjRJAmsMokYzo6DiBrSRFDSRIuVnvml3wv7/MVsBEvSSEn7/lcZaU=
Message-ID: <58d0dbf10608250643v1bb19d0ci99ae30243125a962@mail.gmail.com>
Date: Fri, 25 Aug 2006 15:43:44 +0200
From: "Jan Kiszka" <jan.kiszka@googlemail.com>
To: "Arjan van de Ven" <arjan@linux.intel.com>
Subject: Re: [RFC] maximum latency tracking infrastructure (version 2)
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com, mingo@elte.hu,
       akpm@osdl.org, jbarnes@virtuousgeek.org, dwalker@mvista.com,
       nickpiggin@yahoo.com.au, rpm@xenomai.org
In-Reply-To: <1156504939.3032.26.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1156504939.3032.26.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/8/25, Arjan van de Ven <arjan@linux.intel.com>:
> New in this version:
> * implemented the various comments on the code
> * implemented a notifier mechanism so that code can serialize on latency (Nick)
> * put the max latency in the ACPI C states file
>
> One open question is if the sysreq key is considered useful or only a bad hack..
>
>
>
> Subject: [RFC] maximum latency tracking infrastructure
> From: Arjan van de Ven <arjan@linux.intel.com>
>
> The patch below adds infrastructure to track "maximum allowable latency" for
> power saving policies.

Very interesting approach. I wonder if it could be used to cover
another problematic source of latencies as well: asynchronous SMIs.
They quickly cause delays reaching from a few 100 us up to
milliseconds.

Hard-RT extension like Xenomai work around this on several Intel
chipsets by disabling SMI unconditionally (compile-time configurable).
But maybe this could be done in a smarter fashion in mainline
directly. It would likely take some practical boundary (SMI latencies
are fairly board / bios dependent) and a place to put the simple check

    if (system_latency_constraint() < SMI_LATENCY) disable_smi();

Maybe vendors will provide more information on SMI-related latencies,
how to avoid them, and what side effects exist once an infrastrure is
there.

If there is some common interest in this direction, I would try to
spend time on working out a patch based on your infrastructure and our
current material in Xenomai. Or is there already something planned in
this direction?

>
> The reason for adding this infrastructure is that power management in the
> idle loop needs to make a tradeoff between latency and power savings (deeper
> power save modes have a longer latency to running code again).  The code
> that today makes this tradeoff just does a rather simple algorithm; however
> this is not good enough: There are devices and use cases where a lower
> latency is required than that the higher power saving states provide. An
> example would be audio playback, but another example is the ipw2100 wireless
> driver that right now has a very direct and ugly acpi hook to disable some
> higher power states randomly when it gets certain types of error.
>
> The proposed solution is to have an interface where drivers can
> * announce the maximum latency (in microseconds) that they can deal with
> * modify this latency
> * give up their constraint
> and a function where the code that decides on power saving strategy can query
> the current global desired maximum.

I guess an interface to let also applications / the sysadmin specifiy
a latency constraint would be useful as well. sysfs?

Jan
