Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422822AbWBNXoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422822AbWBNXoo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 18:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422853AbWBNXoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 18:44:44 -0500
Received: from palrel10.hp.com ([156.153.255.245]:16025 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S1422822AbWBNXon (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 18:44:43 -0500
Date: Tue, 14 Feb 2006 15:41:24 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: Philip Mucci <mucci@cs.utk.edu>
Cc: perfmon@napali.hpl.hp.com, "Bryan O'Sullivan" <bos@serpentine.com>,
       perfctr-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Perfctr-devel] Re: [perfmon] perfmon2 code review: 32-bit ABI on 64-bit OS
Message-ID: <20060214234124.GH13532@frankl.hpl.hp.com>
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

Phil,

On Tue, Feb 14, 2006 at 12:57:55AM +0600, Philip Mucci wrote:
> Stefane,
> 
> I know this is ugly, but what about in the user code checking the arch?
> Is it not true that if a kernel is running 64 bit, it has the 64 tagged
> on the the end of the arch? i.e. mips64, ppc64, x86_64?
> 
> The other solution would be to add am information call to the API, like
> perfctr has. This would export the processor type along with other
> feature bits, including the number of bits of the IP. 
> 

The problem is at compile time and not so much at runtime.
Take a kernel struct that is shared with user (i.e., passed through syscall)
that has the following layout:

	struct foo {
		unsigned long bar;
		int dummy;
	};

For a 64-bit app on a 64-bit OS OR a 32-bit app on a 32-bit OS, this works
perfectly.

For a 32-bit on a 64-bit OS, there is a problem, the 32-bit app must be compiled
with the following definition instead:
	struct foo {
		unsigned long long bar;
		int dummy;
	};

to share the struct with the 64-bit OS. An application compile with the above
struct, would not work when run on a 32-bit OS.

So I think that we need to replace all unsigned long, size_t, void * by uint64_t
to make sure this works either way. It is overkill on pure 32-bit but ensures
that the application can be migrated over to a 64-bit OS without the need for
special recompilation.

-- 
-Stephane
