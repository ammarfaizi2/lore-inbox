Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318762AbSICL0X>; Tue, 3 Sep 2002 07:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318758AbSICL0W>; Tue, 3 Sep 2002 07:26:22 -0400
Received: from dp.samba.org ([66.70.73.150]:42145 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S318757AbSICL0V>;
	Tue, 3 Sep 2002 07:26:21 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15732.40127.600622.881235@argo.ozlabs.ibm.com>
Date: Tue, 3 Sep 2002 21:27:59 +1000 (EST)
To: "David S. Miller" <davem@redhat.com>
Cc: taka@valinux.co.jp, kuznet@ms2.inr.ac.ru, scott.feldman@intel.com,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       haveblue@us.ibm.com, Manand@us.ibm.com, christopher.leech@intel.com
Subject: Re: TCP Segmentation Offloading (TSO)
In-Reply-To: <20020903.005119.50342945.davem@redhat.com>
References: <288F9BF66CD9D5118DF400508B68C4460283E564@orsmsx113.jf.intel.com>
	<200209021858.WAA00388@sex.inr.ac.ru>
	<20020903.164243.21934772.taka@valinux.co.jp>
	<20020903.005119.50342945.davem@redhat.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller writes:

> It is real requirement, x86 works because unaligned
> access is handled transparently by cpu.
> 
> But on every non-x86 csum_partial I have examined, worse than
> 2-byte aligned data start is totally not handled.  It is not difficult
> to figure out why this is the case, everyone has copied by example. :-)

PPC and PPC64 are OK, I believe, since the CPU handles (almost) all
unaligned accesses in hardware.  (Some PowerPC implementations trap if
the access crosses a page boundary but the newer ones even handle that
case in hardware, and if we do get the trap we fix it up.)

I notice though that if the length is odd, we (PPC) put the last byte
in the left-hand (most significant) byte of a 16-bit halfword, with
zero in the other byte, and add it in, whereas i386 puts the last byte
in the least-significant position.  Hmmm... should be OK though since
I presume the result will be reduced and then converted to network
byte order before being put in the packet.  And since there is an
end-around carry we should end up with the same bytes that i386 does.

Paul.
