Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318735AbSICHxl>; Tue, 3 Sep 2002 03:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318730AbSICHxl>; Tue, 3 Sep 2002 03:53:41 -0400
Received: from pizda.ninka.net ([216.101.162.242]:26834 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318726AbSICHxj>;
	Tue, 3 Sep 2002 03:53:39 -0400
Date: Tue, 03 Sep 2002 00:51:19 -0700 (PDT)
Message-Id: <20020903.005119.50342945.davem@redhat.com>
To: taka@valinux.co.jp
Cc: kuznet@ms2.inr.ac.ru, scott.feldman@intel.com,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       haveblue@us.ibm.com, Manand@us.ibm.com, christopher.leech@intel.com
Subject: Re: TCP Segmentation Offloading (TSO)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020903.164243.21934772.taka@valinux.co.jp>
References: <288F9BF66CD9D5118DF400508B68C4460283E564@orsmsx113.jf.intel.com>
	<200209021858.WAA00388@sex.inr.ac.ru>
	<20020903.164243.21934772.taka@valinux.co.jp>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Hirokazu Takahashi <taka@valinux.co.jp>
   Date: Tue, 03 Sep 2002 16:42:43 +0900 (JST)

   I guess it may also depend on bad implementations of csum_partial().
   It's wrong that some architecture assume every data in a skbuff are
   aligned on a 2byte boundary so that it would access a byte next to
   the the last byte where no pages might be there.
   
It is real requirement, x86 works because unaligned
access is handled transparently by cpu.

But on every non-x86 csum_partial I have examined, worse than
2-byte aligned data start is totally not handled.  It is not difficult
to figure out why this is the case, everyone has copied by example. :-)

So we must make a decision, either make every csum_partial
implementation eat 1 byte alignment or enforce 2-byte
alignment at call sites.

I think for 2.4.x it is unreasonable to force everyone to change their
csum_partial, especially since handling byte aligned buffer requires
holding onto state across the whole checksum from beginning to the
last fold.  Many RISC implementation are using registers to the max
and may not easily be able to obtain a temporary.

I dealt with a bug in this area recently, pppoe can cause ppp_input to
send byte aligned data in packets to TCP input, this crashes just
about every non-x86 system so my "fix" was to copy byte aligned SKBs
in ppp_input.
