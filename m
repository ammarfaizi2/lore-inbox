Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWC3Cvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWC3Cvl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 21:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbWC3Cvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 21:51:41 -0500
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:59726 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751459AbWC3Cvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 21:51:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=kdnGwTC8YLExv1OTzvFn25h6YKUvxrPNsILKeMVfwekbA/pzccAE31Qgp1EfBSgqse30MOTOPpN5mC9bwpZcg3mgmI0ZlYUIeBptU6QRqRN4RxYBZa1b1BJzdGpDF72tynBAlVnLxMmWGCsLkMpRvomirgKBVSp76Sa1y6lzoc0=  ;
Message-ID: <442B3619.8070502@yahoo.com.au>
Date: Thu, 30 Mar 2006 12:36:25 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
CC: Christoph Lameter <clameter@sgi.com>, akpm@osdl.org,
       Zoltan.Menyhart@free.fr, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: Fix unlock_buffer() to work the same way as bit_unlock()
References: <200603290649.k2T6ntg03758@unix-os.sc.intel.com>
In-Reply-To: <200603290649.k2T6ntg03758@unix-os.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chen, Kenneth W wrote:

>Nick Piggin wrote on Tuesday, March 28, 2006 12:11 AM
>
>>OK, that's fair enough and I guess you do need a barrier there.
>>However, should the mb__after barrier still remain? The comment
>>in wake_up_bit suggests yes, and there is similar code in
>>unlock_page.
>>
>
>Question on unlock_page:
>
>void fastcall unlock_page(struct page *page)
>{
>        smp_mb__before_clear_bit();
>        if (!TestClearPageLocked(page))
>                BUG();
>        smp_mb__after_clear_bit();
>        wake_up_page(page, PG_locked);
>}
>
>Assuming test_and_clear_bit() on all arch does what the API is
>called for with full memory fence around the atomic op, why do
>you need smp_mb__before_clear_bit and smp_mb__after_clear_bit?
>Aren't they redundant?
>
>

Yep. I pointed this out earlier.

I'd say it may have initially just been a ClearPageLocked, and
was changed for debugging reasons.

We could instead change it to

BUG_ON(!PageLocked(page);
ClearPageLocked(page); /* this does clear_bit_for_unlock */
smp_mb__after_clear_bit_unlock();
wake_up_page

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
