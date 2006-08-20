Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbWHTKtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWHTKtD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 06:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbWHTKtB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 06:49:01 -0400
Received: from yue.linux-ipv6.org ([203.178.140.15]:46353 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S1750734AbWHTKtA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 06:49:00 -0400
Date: Sun, 20 Aug 2006 19:50:44 +0900 (JST)
Message-Id: <20060820.195044.84187776.yoshfuji@linux-ipv6.org>
To: w@1wt.eu
Cc: ak@suse.de, solar@openwall.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: Re: [PATCH] getsockopt() early argument sanity checking
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20060820101528.GE602@1wt.eu>
References: <20060819230532.GA16442@openwall.com>
	<200608201034.43588.ak@suse.de>
	<20060820101528.GE602@1wt.eu>
Organization: USAGI/WIDE Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

In article <20060820101528.GE602@1wt.eu> (at Sun, 20 Aug 2006 12:15:28 +0200), Willy Tarreau <w@1wt.eu> says:

> But I don't want to induce such large changes in this kernel. The goal of
> this test is a preventive measure to catch easily exploitable errors that
> might have remained undetected. For instance, a quick glance shows this
> portion of code in net/ipv4/raw.c (both 2.4 and 2.6) :
> 
> static int raw_seticmpfilter(struct sock *sk, char *optval, int optlen)
> {
>         if (optlen > sizeof(struct icmp_filter))
>                 optlen = sizeof(struct icmp_filter);
>         if (copy_from_user(&sk->tp_pinfo.tp_raw4.filter, optval, optlen))
>                 return -EFAULT;
>         return 0;
> }
> 
> It only relies on sock_setsockopt() refusing optlen values < sizeof(int),
> and this is not documented. Having part of this code being copied for use
> in another code path would open a breach for optlen < 0.
:
> There are two tests in this patch :
> 
>   - one on the validity of the optlen address. This one is race-free and
>     should be conserved anyway.
> 
>   - one on the optlen range which is valid for most cases but which is
>     subject to a race condition and which might be circumvented by
>     carefully written code and with some luck as in all race conditions
>     issues.

Don't mix getsockopt() and setsockopt() code paths.

For setsockopt(), optlen < 0 is checked in net/socket.c:sys_setsockopt().

For getsockopt(), optlen and *optlen < 0 is (and should be) checked
(or handled) in each getsockopt function; e.g. do_ip_getsockopt(),
raw_geticmpfilter() etc.

--yoshfuji
