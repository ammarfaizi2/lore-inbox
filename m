Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264779AbSJaIj5>; Thu, 31 Oct 2002 03:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264784AbSJaIj5>; Thu, 31 Oct 2002 03:39:57 -0500
Received: from mail1.ics.ntts.co.jp ([202.32.24.45]:53430 "EHLO
	mail1.ics.ntts.co.jp") by vger.kernel.org with ESMTP
	id <S264779AbSJaIjz>; Thu, 31 Oct 2002 03:39:55 -0500
Date: Thu, 31 Oct 2002 17:44:42 +0900 (JST)
Message-Id: <20021031.174442.846937513.takamiya@po.ntts.co.jp>
To: ajtuomin@morphine.tml.hut.fi
Cc: davem@redhat.com, kuznet@ms2.inr.ac.ru, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org, yoshfuji@wide.ad.jp, pekkas@netcore.fi,
       torvalds@transmeta.com, jagana@us.ibm.com
Subject: Re: [PATCHSET] Mobile IPv6 for 2.5.43
From: Noriaki Takamiya <takamiya@po.ntts.co.jp>
In-Reply-To: <20021017162624.GC16370@morphine.tml.hut.fi>
References: <20021017162624.GC16370@morphine.tml.hut.fi>
X-Mailer: Mew version 3.0.55 on XEmacs 21.4.8 (Honest Recruiter)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  This is Takamiya, a member of USAGI Project.
  Your work is very cool.  However, we believe there are several
  issues on direction / design and behavior in your implementation.

  Please note that we're preparing for checking to what extent this
  patch is compliant to the Internet draft of MIPv6.  

  So we may comment other things later.

(1) About MIPV6CALLFUNC and MIPV6CALLPROC
	It is reasonable to use these macros for modularized
	functions. But the current your implementation needs to select
	HA or MN when compiling the kernel. So, it doesn't seems to be
	needed this macros, and the real function may be called
	directly. How about this?

	Rather, how about using sysctl and so on to switch the
	functionality?

(2) Avoiding Netfilter Hooks
	In your imprementation HA uses netfilter to intercept packets
	sent to MN. We think it is costy so we have a suggestion to
	use FIB structure to forward packets to MN. Bacause we think
	forwarding packets from HA to MN is FORWARDING, not FILTERING.
	We think the kernel maintainers may prefer such a manner using
	FIB structure for forwarding.

(3) Binding Cache
	We think it is reasonable way to use FIB structure to holding
	Binding Cache Entries if you us FIB structure for forwarding
	packets from HA to MN as we suggested (4).

(4) Processing Mobility Header
	How about using ip6_txoptions and hdrproc_lst?
	Because Mobility header is an extension header, we think it is
	reasonable way to handle it in ipv6_parse_exthdrs().

(5) How about using CryptoAPI?
	CryptoAPI is merged to mainline.
	We believe we can use the CryptoAPI for caluculating cookies 
	of RR.  How do you think about this?

(6) Order of HAO and Routing header
	When MN acts also as CN, the order doesn't seems to be
	compliant to ID-18 in the implementation. The order will be
	the following:

	[IPv6][HAO][RT2]

	I-D says:

	[IPv6][RT2][HAO]

(7) Source Address Selection of MN
	When host acts as MN, your implementation always select HoA as the
	source address. The source address should be a CoA. 

  Regards,
--
Noriaki Takamiya
