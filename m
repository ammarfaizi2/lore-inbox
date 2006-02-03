Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbWBCRQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbWBCRQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 12:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWBCRQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 12:16:27 -0500
Received: from smtp.osdl.org ([65.172.181.4]:27521 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751250AbWBCRQ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 12:16:27 -0500
Date: Fri, 3 Feb 2006 09:15:19 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Kirill Korotaev <dev@openvz.org>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       frankeh@watson.ibm.com, clg@fr.ibm.com, haveblue@us.ibm.com,
       greg@kroah.com, alan@lxorguk.ukuu.org.uk, serue@us.ibm.com,
       arjan@infradead.org, Rik van Riel <riel@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, devel@openvz.org
Subject: Re: [RFC][PATCH 1/5] Virtualization/containers: startup
In-Reply-To: <43E38BD1.4070707@openvz.org>
Message-ID: <Pine.LNX.4.64.0602030905380.4630@g5.osdl.org>
References: <43E38BD1.4070707@openvz.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 3 Feb 2006, Kirill Korotaev wrote:
>
> This patch introduces some abstract container/VPS kernel structure and tiny
> amount of operations on it.

Please don't use things like "vps_t".

It's a _mistake_ to use typedef for structures and pointers. When you see 
a

	vps_t a;

in the source, what does it mean?

In contrast, if it says

	struct virtual_container *a;

you can actually tell what "a" is. 

Lots of people think that typedefs "help readability". Not so. They are 
useful only for 

 (a) totally opaque objects (where the typedef is actively used to _hide_
     what the object is). 

     Example: "pte_t" etc opaque objects that you can only access using 
     the proper accessor functions.

     NOTE! Opaqueness and "accessor functions" are not good in themselves. 
     The reason we have them for things like pte_t etc is that there 
     really is absolutely _zero_ portably accessible information there.

 (b) Clear integer types, where the abstraction _helps_ avoid confusion 
     whether it is "int" or "long".

     u8/u16/u32 are perfectly fine typedefs. 

     NOTE! Again - there needs to be a _reason_ for this. If something is 
     "unsigned long", then there's no reason to do

	typedef long myflags_t;

     but if there is a clear reason for why it under certain circumstances 
     might be an "unsigned int" and under other configurations might be 
     "unsigned long", then by all means go ahead and use a typedef.

 (c) when you use sparse to literally create a _new_ type for 
     type-checking.

Maybe there are other cases too, but the rule should basically be to NEVER 
EVER use a typedef unless you can clearly match one of those rules.

In general, a pointer, or a struct that has elements that can reasonably 
be directly accessed should _never_ be a typedef.

		Linus
