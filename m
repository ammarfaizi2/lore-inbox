Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbWHKMyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbWHKMyu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 08:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbWHKMyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 08:54:50 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:58116 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S932217AbWHKMyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 08:54:49 -0400
Message-ID: <44DC7D99.4040109@shadowen.org>
Date: Fri, 11 Aug 2006 13:52:41 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: moreau francis <francis_moreau2000@yahoo.fr>
CC: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Re : Re : Re : sparsemem usage
References: <20060811124638.99233.qmail@web25812.mail.ukl.yahoo.com>
In-Reply-To: <20060811124638.99233.qmail@web25812.mail.ukl.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

moreau francis wrote:
> Andy Whitcroft wrote:
>> It does produce real numbers, it tells you how many reserved pages you
>> have.  The places that this is triggered we are interested in why we
>> have no memory left.  We are not interested in how many pages are known
>> but reserved as against how many pages are backed by page*'s but are
>> really holes; they are mearly pages we can't use out of the total we are
>> tracking.  We care about how many are not reserved, and how many of
>> those are available.
>>
>> It would be 'as simple' as adding a PG_real page bit except for two things:
>>
>> 1) page flags bits are seriously short supply; there are some 24
>> available of which 22 are in use.  Any new user of a bit would have to
>> be an extremely valuable change with major benefit to the kernel, and
>>
> 
> It's indeed an issue. Could we instead use a combination of flags
> that can't happen together. For example PG_Free|PG_Reserved ?
> 

You'd need to audit all other users of the bits you wanted to borrow to 
check they would understand.  Like if you used PG_buddy (which I assume 
is what you are referring to above) then you'd get non-real memory 
getting merged into your buddies.  Badness.

>> 2) if you were to try and populate a PG_real flag it would need to be
>> populated for _all_ architectures (and there are a lot) for it to be of
>> any use.  As you have already noted there is no consistent way to find
>> out whether a page is ram so it would be major exercise to get these
>> bits setup during boot.
>>
>> I think we should take (2) as a hint here.  If we don't have a
>> consistent interface for finding whether a page is real or not, we
>> obviously have no general need of that information in the kernel.
>>
> 
> or maybe _because_ we don't have a consistent interface for finding 
> whether a page is real or not, we end up with a strange thing called
> page_is_ram() which could be the same for all arch and be implemented
> very simply.
> 
> BTW, can you try in a linux tree:
> 
> $ grep -r page_is_ram arch/
> 
> and see how it's implemented...

Well it depends how you look at it.  You are going to need to know which 
pages are ram in each architecture to set the bits in the page*'s to 
tell us later.  So the problem is the same problem.  We don't 
necessarily have the information for all architectures.  As we don't use 
this for anything its questionable whether we need it.

Feel free to try and figure it out for all these architectures :).

-apw
