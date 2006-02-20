Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161088AbWBTR5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161088AbWBTR5s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 12:57:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161089AbWBTR5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 12:57:48 -0500
Received: from ccerelbas01.cce.hp.com ([161.114.21.104]:22669 "EHLO
	ccerelbas01.cce.hp.com") by vger.kernel.org with ESMTP
	id S1161088AbWBTR5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 12:57:47 -0500
Date: Mon, 20 Feb 2006 09:54:09 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: Philip Mucci <mucci@cs.utk.edu>
Cc: "Bryan O'Sullivan" <bos@serpentine.com>, perfmon@napali.hpl.hp.com,
       perfctr-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: perfmon2 code review: 32-bit ABI on 64-bit OS
Message-ID: <20060220175409.GB1436@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <20060125222844.GB10451@frankl.hpl.hp.com> <1138649612.4077.50.camel@localhost.localdomain> <1138651545.4487.13.camel@camp4.serpentine.com> <1139155731.4279.0.camel@localhost.localdomain> <1139245253.27739.8.camel@camp4.serpentine.com> <20060210153608.GC28311@frankl.hpl.hp.com> <1139596023.9646.111.camel@serpentine.pathscale.com> <1139681785.4316.33.camel@localhost.localdomain> <20060211223354.GA30327@frankl.hpl.hp.com> <1139857076.4342.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1139857076.4342.10.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

So I worked some more on these 32bit vs 64bit ABI issues. I came
to the conclusion that the only way to make this work cleanly
without any special compilation flags or runtime support is
to simply ensure that all data structures exchanged/shared between
the monitoring tool  and the kernel use only fixed size types.
This way, the sizeof struct  and fields offset remains constant
in ILP32 or LP64 mode. As a consequence I now have:
	- all bitmasks use u64
	- all size_t are replaced with u64
	- the default format IP (instruction pointer) is u64

For the IP, the most significant bits contain all zeroes in
ILP32 mode. With the default sampling buffer format, you add
4 bytes to the sample header but then you have nothing special
to do with user level code. I think this is also inline with
the fact that 64-bit computing is becoming widely available
for desktop and laptop computers.

As an example, I can now compile a tool for P4 in 32-bit and
run it on my 32-bit Xeon. But I can also run the same *binary*
on my EM64T and it works as expected including for the sampling
buffer. I believe the same would be possible with Opteron, although
I have not tried.

I hope this closes another sticking point about the interface.


On Tue, Feb 14, 2006 at 12:57:55AM +0600, Philip Mucci wrote:
> 
> I know this is ugly, but what about in the user code checking the arch?
> Is it not true that if a kernel is running 64 bit, it has the 64 tagged
> on the the end of the arch? i.e. mips64, ppc64, x86_64?
> 
> The other solution would be to add am information call to the API, like
> perfctr has. This would export the processor type along with other
> feature bits, including the number of bits of the IP. 
> 
> Either of these combined with compile time ABI/bitness constants should
> cover the cases no?
> 
> Phil
> 
> 
> > The problem is in the user level header file for the sampling buffer.
> > We would need a data type that is 64-bit for IP if the host OS is 64-bit
> > (regardless of the ABI used by the tool, i.e., the compiler). And a data
> > type that is 32-bit on 32-bit OS. The problem is that there is no compiler
> > flag or header flag somewhere that could guide the compiler. In the case
> > of MIPS, we have defined a libpfm compile flags that indicates we want
> > the 64-bit OS definition when compiling for a 32-bit application.
> > 
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
> _______________________________________________
> Perfctr-devel mailing list
> Perfctr-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/perfctr-devel

-- 

-Stephane
