Return-Path: <linux-kernel-owner+w=401wt.eu-S1753724AbWLRKUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753724AbWLRKUz (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 05:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753701AbWLRKUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 05:20:55 -0500
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:34467 "HELO
	smtp107.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753724AbWLRKUy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 05:20:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=1Q5odG5h5hVL91HR2CaOgs5pad4Zx/m+T5QAwNLVhNJnx+THOzIwE4cTnvWqc1BDtIYjIaUn2sirNSu7BjG4j7uMx5RN4/SKx28Ge+bU5zEpyXd12KllKlRDGATI19zkg0Agv0dWxdaaCxSyMzjbygu/Gfni0roDj39mjaCYlNU=  ;
X-YMail-OSG: fxOgjj0VM1lFkJ7USQx26HMl6gvtw92BUqHjawGwYVc_KXLrFj5g1JGE2oFZMGlAJa2tYb7sAKNSGZRIzprZD3O18zRQDCafXU7C8BTLIId8xGHhLcPSWA2NnDveQEKE.DJjRlvSiXXSC2I-
Message-ID: <45865FA4.1030301@yahoo.com.au>
Date: Mon, 18 Dec 2006 20:30:12 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linus Torvalds <torvalds@osdl.org>, andrei.popa@i-neo.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
References: <1166314399.7018.6.camel@localhost>	<20061217040620.91dac272.akpm@osdl.org>	<1166362772.8593.2.camel@localhost>	<20061217154026.219b294f.akpm@osdl.org>	<Pine.LNX.4.64.0612171716510.3479@woody.osdl.org>	<Pine.LNX.4.64.0612171725110.3479@woody.osdl.org>	<Pine.LNX.4.64.0612171744360.3479@woody.osdl.org>	<45861E68.3060403@yahoo.com.au>	<Pine.LNX.4.64.0612172145250.3479@woody.osdl.org> <20061217231617.0726b97f.akpm@osdl.org>
In-Reply-To: <20061217231617.0726b97f.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Sun, 17 Dec 2006 21:50:43 -0800 (PST)
> Linus Torvalds <torvalds@osdl.org> wrote:
> 
> 
>>
>>On Mon, 18 Dec 2006, Nick Piggin wrote:
>>
>>>I can't see how that's exactly a problem -- so long as the page does not
>>>get reclaimed (it won't, because we have a ref on it) then all that matters
>>>is that the page eventually gets marked dirty.
>>
>>But the point being that "try_to_free_buffers()" marks it clean 
>>AFTERWARDS.
>>
>>So yes, the page gets marked dirty in the pte's - the hardware generally 
>>does that for us, so we don't have to worry about that part going on.
>>
>>But "try_to_free_buffers()" seems to clear those dirty bits without 
>>serializing it really any way. It just says "ok, I will now clear them". 
>>Without knowing whether the dirty bits got set before the IO that cleared 
>>the buffer head dirty bits or not.
> 
> 
> Yes, I can't see anything correct about the current behaviour.
> 
> But I'm going blue in the face here trying to feed try_to_free_buffers() a
> page_mapped(page), without success.  pagevec_strip() presumably isn't
> triggering.

I can trigger it here, with a kernel patch to call pagevec_strip
unconditionally. I am seeing it clearing pte dirty bits, which is surely
a dataloss bug.

BUG: warning at mm/page-writeback.c:862/clear_page_dirty_warn()
  [<c013f65a>] clear_page_dirty_warn+0xdb/0xdd
  [<c0174309>] try_to_free_buffers+0x6b/0x7e
  [<c01937ec>] ext3_releasepage+0x0/0x74
  [<c013bb48>] try_to_release_page+0x2c/0x40
  [<c0140925>] pagevec_strip+0x52/0x54
  [<c0141580>] shrink_active_list+0x2a0/0x3c8
  [<c0142100>] shrink_zone+0xcd/0xea
  [<c014266d>] kswapd+0x311/0x41e
  [<c012c6aa>] autoremove_wake_function+0x0/0x37
  [<c014235c>] kswapd+0x0/0x41e
  [<c012c527>] kthread+0xde/0xe2
  [<c012c449>] kthread+0x0/0xe2
  [<c010395b>] kernel_thread_helper+0x7/0x1c
  =======================

(clear_page_dirty_warn() is test_clear_page_dirty which WARN_ON()s the
result of page_mkclean)


> This will (at least) cause truncate to do peculiar things. 
> do_invalidatepage() runs discard_buffer() against the dirty page and will
> then expect try_to_free_buffers() to remove those buffers and then clean
> the page.  truncate_complete_page() will clean the page, but it still has
> those invalidated buffers.  We'll end up with a large number of clean,
> unused pages on the LRU, with attached buffers.  These should eventually
> get reaped, but it'll change the page aging dynamics.

This isn't so nice. I wonder if you could just ClearPageDirty before
calling try_to_free_buffers in this case, or is that too much of a
hack? Ideally I guess you want a variant that is happy to discard
dirtiness (alternatively, my proposal to redirty the page if we find
a dirty pte should also handle this).

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
