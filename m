Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992675AbWJTQsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992675AbWJTQsF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 12:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992676AbWJTQsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 12:48:05 -0400
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:9074 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S2992675AbWJTQsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 12:48:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=H9vEStYFLDonsTEyJKwblEYPBEmm5N7aD4w1fXBa5Qs7gdMyeUQ6EvMgbmlhHFQ9DgT1E6g2AE1ZWnJGFWWn27zUSRBpnlN+qagH7dH5XpbvwKyayCsI1Sdr319UK3MfeEa+kH8ByNxFCr/6PuYzJw891OMBAWp1615MgFiDPeo=  ;
Message-ID: <4538FDBC.6070301@yahoo.com.au>
Date: Sat, 21 Oct 2006 02:47:56 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: David Miller <davem@davemloft.net>, ralf@linux-mips.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, anemo@mba.ocn.ne.jp
Subject: Re: [PATCH 1/3] Fix COW D-cache aliasing on fork
References: <1161275748231-git-send-email-ralf@linux-mips.org> <4537B9FB.7050303@yahoo.com.au> <20061019181346.GA5421@linux-mips.org> <20061019.155939.48528489.davem@davemloft.net> <4538DFAC.1090206@yahoo.com.au> <Pine.LNX.4.64.0610200846260.3962@g5.osdl.org> <4538F1EC.1020806@yahoo.com.au> <Pine.LNX.4.64.0610200935290.3962@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610200935290.3962@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sat, 21 Oct 2006, Nick Piggin wrote:
> 
>>I didn't think that would work if there is no TLB. But if the writeback
>>can cause a TLB reload, and then bypass the readonly protection, then
>>yes would close all races.
> 
> 
> On the other hand, doing the cache flush at COW time is "kind of 
> equivalent" to just doing it after the TLB flush. It's now just _much_ 
> after the flush ;)
> 
> So maybe the COW D$ aliasing patch-series is just the right thing to do. 
> Not worry about D$ at _all_ when doing the actual fork, and only worry 
> about it on an actual COW event. Hmm?

Well if we have the calls in there, we should at least make them work
right for the architectures there now. At the moment the flush_cache_mm
before the copy_page_range wouldn't seem to do anything if you can still
have threads dirty the cache again through existing TLB entries.

I don't think that flushing on COW is exactly right though, because dirty
data can remain invisible if you're only doing reads (no write, no flush).
And if that cache gets written back at some point, you're going to see
supposedly RO data change underneath you. I think?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
