Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262158AbVC2CxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262158AbVC2CxG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 21:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbVC2CxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 21:53:05 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:39819 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262158AbVC2Cw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 21:52:59 -0500
Subject: Re: [PATCH] no need to check for NULL before calling kfree()
	-fs/ext2/
From: Lee Revell <rlrevell@joe-job.com>
To: Dave Jones <davej@redhat.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050327174026.GA708@redhat.com>
References: <Pine.LNX.4.62.0503252307010.2498@dragon.hyggekrogen.localhost>
	 <Pine.LNX.4.61.0503251726010.6354@chaos.analogic.com>
	 <1111825958.6293.28.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.61.0503261811001.9945@chaos.analogic.com>
	 <Pine.LNX.4.62.0503270044350.3719@dragon.hyggekrogen.localhost>
	 <1111881955.957.11.camel@mindpipe>
	 <Pine.LNX.4.62.0503271246420.2443@dragon.hyggekrogen.localhost>
	 <20050327065655.6474d5d6.pj@engr.sgi.com>
	 <Pine.LNX.4.61.0503271708350.20909@yvahk01.tjqt.qr>
	 <20050327174026.GA708@redhat.com>
Content-Type: text/plain
Date: Mon, 28 Mar 2005 21:52:57 -0500
Message-Id: <1112064777.19014.17.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-03-27 at 12:40 -0500, Dave Jones wrote:
> On Sun, Mar 27, 2005 at 05:12:58PM +0200, Jan Engelhardt wrote:
> 
>  > Well, kfree inlined was already mentioned but forgotten again.
>  > What if this was used:
>  > 
>  > inline static void kfree_WRAP(void *addr) {
>  >     if(likely(addr != NULL)) {
>  >         kfree_real(addr);
>  >     }
>  >     return;
>  > }
>  > 
>  > And remove the NULL-test in kfree_real()? Then we would have:
> 
> Am I the only person who is completely fascinated by the
> effort being spent here micro-optimising something thats
> almost never in a path that needs optimising ?
> I'd be amazed if any of this masturbation showed the tiniest
> blip on a real workload, or even on a benchmark other than
> one crafted specifically to test kfree in a loop.
> 

I see kfree used in several hot paths.  Check out
this /proc/latency_trace excerpt:

(T1/#147)      ksoftirqd/0     2 0 2 00000002 00000093 [0038603486826120] 0.133ms (+0.000ms): preempt_schedule+0x11/0x80 <c02b5181> (rpc_wake_up_task+0x6c/0x80 <c02a802c>)
(T1/#148)      ksoftirqd/0     2 0 2 00000001 00000094 [0038603486826375] 0.133ms (+0.000ms): preempt_schedule+0x11/0x80 <c02b5181> (udp_data_ready+0x1ca/0x270 <c02a5b8a>)
(T1/#149)      ksoftirqd/0     2 0 2 00000001 00000095 [0038603486826527] 0.133ms (+0.000ms): skb_free_datagram+0xb/0x30 <c0257ecb> (udp_data_ready+0x19c/0x270 <c02a5b5c>)
(T1/#150)      ksoftirqd/0     2 0 2 00000001 00000096 [0038603486826686] 0.133ms (+0.000ms): __kfree_skb+0xe/0xf0 <c0255bce> (udp_data_ready+0x19c/0x270 <c02a5b5c>)
(T1/#151)      ksoftirqd/0     2 0 2 00000001 00000097 [0038603486826924] 0.133ms (+0.000ms): sock_rfree+0x8/0x20 <c0254648> (__kfree_skb+0x6b/0xf0 <c0255c2b>)
(T1/#152)      ksoftirqd/0     2 0 2 00000001 00000098 [0038603486827082] 0.134ms (+0.000ms): kfree_skbmem+0xe/0x30 <c0255b9e> (__kfree_skb+0x76/0xf0 <c0255c36>)
(T1/#153)      ksoftirqd/0     2 0 2 00000001 00000099 [0038603486827189] 0.134ms (+0.000ms): skb_release_data+0xd/0xd0 <c0255acd> (kfree_skbmem+0x19/0x30 <c0255ba9>)
(T1/#154)      ksoftirqd/0     2 0 2 00000001 0000009a [0038603486827444] 0.134ms (+0.000ms): skb_drop_fraglist+0xc/0x50 <c0255a4c> (skb_release_data+0xa3/0xd0 <c0255b63>)
(T1/#155)      ksoftirqd/0     2 0 2 00000001 0000009b [0038603486827573] 0.134ms (+0.000ms): __kfree_skb+0xe/0xf0 <c0255bce> (skb_drop_fraglist+0x35/0x50 <c0255a75>)
(T1/#156)      ksoftirqd/0     2 0 2 00000001 0000009c [0038603486827733] 0.134ms (+0.000ms): kfree_skbmem+0xe/0x30 <c0255b9e> (__kfree_skb+0x76/0xf0 <c0255c36>)
(T1/#157)      ksoftirqd/0     2 0 2 00000001 0000009d [0038603486827861] 0.134ms (+0.000ms): skb_release_data+0xd/0xd0 <c0255acd> (kfree_skbmem+0x19/0x30 <c0255ba9>)
(T1/#158)      ksoftirqd/0     2 0 2 00000001 0000009e [0038603486828121] 0.134ms (+0.000ms): kfree+0x14/0x70 <c0143514> (kfree_skbmem+0x19/0x30 <c0255ba9>)
(T1/#159)      ksoftirqd/0     2 0 2 00000001 0000009f [0038603486828671] 0.135ms (+0.000ms): kmem_cache_free+0x14/0x60 <c0143444> (kfree_skbmem+0x2a/0x30 <c0255bba>)
(T1/#160)      ksoftirqd/0     2 0 2 00000001 000000a0 [0038603486829127] 0.135ms (+0.000ms): __kfree_skb+0xe/0xf0 <c0255bce> (skb_drop_fraglist+0x35/0x50 <c0255a75>)
(T1/#161)      ksoftirqd/0     2 0 2 00000001 000000a1 [0038603486829341] 0.135ms (+0.000ms): kfree_skbmem+0xe/0x30 <c0255b9e> (__kfree_skb+0x76/0xf0 <c0255c36>)
(T1/#162)      ksoftirqd/0     2 0 2 00000001 000000a2 [0038603486829469] 0.135ms (+0.000ms): skb_release_data+0xd/0xd0 <c0255acd> (kfree_skbmem+0x19/0x30 <c0255ba9>)
(T1/#163)      ksoftirqd/0     2 0 2 00000001 000000a3 [0038603486829644] 0.135ms (+0.000ms): kfree+0x14/0x70 <c0143514> (kfree_skbmem+0x19/0x30 <c0255ba9>)
(T1/#164)      ksoftirqd/0     2 0 2 00000001 000000a4 [0038603486829944] 0.136ms (+0.000ms): kmem_cache_free+0x14/0x60 <c0143444> (kfree_skbmem+0x2a/0x30 <c0255bba>)
(T1/#165)      ksoftirqd/0     2 0 2 00000001 000000a5 [0038603486830243] 0.136ms (+0.000ms): __kfree_skb+0xe/0xf0 <c0255bce> (skb_drop_fraglist+0x35/0x50 <c0255a75>)
(T1/#166)      ksoftirqd/0     2 0 2 00000001 000000a6 [0038603486830463] 0.136ms (+0.000ms): kfree_skbmem+0xe/0x30 <c0255b9e> (__kfree_skb+0x76/0xf0 <c0255c36>)
(T1/#167)      ksoftirqd/0     2 0 2 00000001 000000a7 [0038603486830589] 0.136ms (+0.000ms): skb_release_data+0xd/0xd0 <c0255acd> (kfree_skbmem+0x19/0x30 <c0255ba9>)
(T1/#168)      ksoftirqd/0     2 0 2 00000001 000000a8 [0038603486830800] 0.136ms (+0.000ms): kfree+0x14/0x70 <c0143514> (kfree_skbmem+0x19/0x30 <c0255ba9>)
(T1/#169)      ksoftirqd/0     2 0 2 00000001 000000a9 [0038603486831083] 0.137ms (+0.000ms): kmem_cache_free+0x14/0x60 <c0143444> (kfree_skbmem+0x2a/0x30 <c0255bba>)
(T1/#170)      ksoftirqd/0     2 0 2 00000001 000000aa [0038603486831394] 0.137ms (+0.000ms): __kfree_skb+0xe/0xf0 <c0255bce> (skb_drop_fraglist+0x35/0x50 <c0255a75>)
(T1/#171)      ksoftirqd/0     2 0 2 00000001 000000ab [0038603486831608] 0.137ms (+0.000ms): kfree_skbmem+0xe/0x30 <c0255b9e> (__kfree_skb+0x76/0xf0 <c0255c36>)
(T1/#172)      ksoftirqd/0     2 0 2 00000001 000000ac [0038603486831736] 0.137ms (+0.000ms): skb_release_data+0xd/0xd0 <c0255acd> (kfree_skbmem+0x19/0x30 <c0255ba9>)
(T1/#173)      ksoftirqd/0     2 0 2 00000001 000000ad [0038603486831985] 0.137ms (+0.000ms): kfree+0x14/0x70 <c0143514> (kfree_skbmem+0x19/0x30 <c0255ba9>)
(T1/#174)      ksoftirqd/0     2 0 2 00000001 000000ae [0038603486832443] 0.138ms (+0.000ms): kmem_cache_free+0x14/0x60 <c0143444> (kfree_skbmem+0x2a/0x30 <c0255bba>)
(T1/#175)      ksoftirqd/0     2 0 2 00000001 000000af [0038603486832744] 0.138ms (+0.000ms): __kfree_skb+0xe/0xf0 <c0255bce> (skb_drop_fraglist+0x35/0x50 <c0255a75>)
(T1/#176)      ksoftirqd/0     2 0 2 00000001 000000b0 [0038603486832880] 0.138ms (+0.000ms): kfree_skbmem+0xe/0x30 <c0255b9e> (__kfree_skb+0x76/0xf0 <c0255c36>)

Lee

