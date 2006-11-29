Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967179AbWK2N7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967179AbWK2N7G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 08:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967185AbWK2N7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 08:59:06 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:10040
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S967179AbWK2N7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 08:59:04 -0500
Message-Id: <456DA099.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Wed, 29 Nov 2006 14:00:41 +0000
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] more sanity checks in Dwarf2 unwinder
References: <456D7985.76E4.0078.0@novell.com>
 <200611291414.56268.ak@suse.de>
In-Reply-To: <200611291414.56268.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>  	while (unwind(info) == 0 && UNW_PC(info)) {
>>  		n++;
>>  		oad->ops->address(oad->data, UNW_PC(info));
>>  		if (arch_unw_user_mode(info))
>>  			break;
>> +		if ((sp & ~(PAGE_SIZE - 1)) == (UNW_SP(info) & ~(PAGE_SIZE - 1))
>> +		    && sp > UNW_SP(info))
>> +			break;
>
>Hmm, but that wouldn't catch the case when the SP is completely
>corrupted for some reason.
>Maybe it would be better to just run a brute force check here like 
>the old in_exception_stack(). Similar on x86-64.

Correct. Even though I know Linus disagrees here, I'm not sure
I want to do this, as my ultimate goal would be to eliminate the
hand-crafted linking (which we know got broken a few times on
x86-64, because it's so easy to forget about).
Not the least of the reasons for this is that this increases the
chances of stucks.

>> +	if (UNW_PC(frame) % state.codeAlign
>> +	    || UNW_SP(frame) % sleb128abs(state.dataAlign)
>> +	    || (pc == UNW_PC(frame) && sp == UNW_SP(frame)))
>> +		return -EIO;
>
>Would it be possible to add printks for the EIOs? We want to know 
>when dwarf2 is corrupted.

Certainly, will be a follow-up patch.

Jan
