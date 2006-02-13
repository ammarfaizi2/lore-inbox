Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964852AbWBMUej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbWBMUej (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 15:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbWBMUej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 15:34:39 -0500
Received: from tayrelbas04.tay.hp.com ([161.114.80.247]:712 "EHLO
	tayrelbas04.tay.hp.com") by vger.kernel.org with ESMTP
	id S964852AbWBMUei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 15:34:38 -0500
Date: Mon, 13 Feb 2006 12:31:20 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: Eric Gouriou <eric.gouriou@hp.com>
Cc: David Gibson <david@gibson.dropbear.id.au>,
       "Bryan O'Sullivan" <bos@serpentine.com>, perfmon@napali.hpl.hp.com,
       perfctr-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [perfmon] perfmon2 code review: 32-bit ABI on	64-bit OS
Message-ID: <20060213203120.GJ11285@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <1138649612.4077.50.camel@localhost.localdomain> <1138651545.4487.13.camel@camp4.serpentine.com> <1139155731.4279.0.camel@localhost.localdomain> <1139245253.27739.8.camel@camp4.serpentine.com> <20060210153608.GC28311@frankl.hpl.hp.com> <1139596023.9646.111.camel@serpentine.pathscale.com> <1139681785.4316.33.camel@localhost.localdomain> <20060211223354.GA30327@frankl.hpl.hp.com> <20060212234606.GC24291@localhost.localdomain> <43EFCCE0.3090004@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43EFCCE0.3090004@hp.com>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,

On Sun, Feb 12, 2006 at 04:03:44PM -0800, Eric Gouriou wrote:
> David Gibson wrote:
> >On Sat, Feb 11, 2006 at 02:33:54PM -0800, Stephane Eranian wrote:
> [...]
> >>The most challenging piece is the IP (program pointer) that is in every
> >>sample. Today it is defined as unsigned long because this is fairly
> >>natural for a code address. The 64bit OS captures addresses as 64-bit,
> >>the 32-bit monitoring tool running on top has to consume them as 64-bit
> >>addresses, so u64 would be fine. 
> >>
> >>But not on a 32-bit kernel with a 32-bit tool, addresses exported as u64
> >>would certainly work but consume double to buffer space, and that is a
> >>more serious issue in my mind.
> >
> >Hmm.. does the sampling buffer collect on userspace PC values, or
> >kernel ones as well?
> 
>  Either, or both, depending on the measurement settings.
> 
>  I live in a 64-bit world, so my take on this issue would be to expose
> the PC as a uint64_t, always. There is already so much overhead in the
> default per-sample header that I wouldn't worry about it.
> 
Eric is right, on many architectures, incl. PPC64 I am sure, you can easily
configure a counter to measure at any priv levels including at the kernel level.
As such a 32-bt monitoring tool could see 64-bit generated samples. Similarly,
I don't think it would be unreasonable to have a 32-bit tool monitor 64-bit
applications.

The question is whether hardcoding the IP to always be u64 is a valid choice.
Eric's comment about overhead is based on the current default sampling format
which systematically adds a fixed size header to each sample. That header
contains the IP. So adding 4 bytes to this header is not a big deal.

However, because we can define virtual PMDs that map to software resources, it
is likely that the default format will evolve to allow an application to specify
everything it needs for each sample. For instance, you can have a PMD
that maps to the current PID, another one that maps to the interrupt IP. Then
you can chose to include those into the sample and you would nto need a fixed size
header anymore.

-- 
-Stephane
