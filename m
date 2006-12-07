Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031879AbWLGJX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031879AbWLGJX5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 04:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968824AbWLGJX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 04:23:57 -0500
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:44263 "HELO
	smtp104.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S968825AbWLGJXz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 04:23:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=aGQoahK7n9j43ypFcURerYfrCxmJeQMY8Aigl9AADWdFUDGUd/dLLFtvzEU04J6todR88NDU1Lxv0xD8zAC0XMSURyay74oVoBxdvQlvg2s3neN1UYQKwr/qUPe76v2FNoGG0i6lFWtuGeVEZmSB1ahae0R+xj8AaPD7QvmaI2Y=  ;
X-YMail-OSG: pPBSdb0VM1kEcn7vAQd3oJcpu88A_M9w5ZUjUbhhI222R5Wia9xM7SU8UAUBEHnvDJkLORmiP.uupi6MLDEPFFkVaj0kq5Sj_LX7yJ9kONGwhIWdFQTknW61GIQ.GyD7rg51Zh_Gdz2uSom7FUI1Q27oKCX4P4RnoA--
Message-ID: <4577DD75.50907@yahoo.com.au>
Date: Thu, 07 Dec 2006 20:23:01 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Roman Zippel <zippel@linux-m68k.org>, Matthew Wilcox <matthew@wil.cx>,
       Christoph Lameter <clameter@sgi.com>,
       David Howells <dhowells@redhat.com>, akpm@osdl.org,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch
 doesn't support it
References: <20061206164314.19870.33519.stgit@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0612061054360.27047@schroedinger.engr.sgi.com> <20061206190025.GC9959@flint.arm.linux.org.uk> <Pine.LNX.4.64.0612061111130.27263@schroedinger.engr.sgi.com> <20061206195820.GA15281@flint.arm.linux.org.uk> <20061206213626.GE3013@parisc-linux.org> <Pine.LNX.4.64.0612061345160.28672@schroedinger.engr.sgi.com> <20061206220532.GF3013@parisc-linux.org> <Pine.LNX.4.64.0612070130240.1868@scrub.home> <Pine.LNX.4.64.0612061650240.3542@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612061650240.3542@woody.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 7 Dec 2006, Roman Zippel wrote:
> 
>>On Wed, 6 Dec 2006, Matthew Wilcox wrote:
>>
>>
>>>To be honest, it'd be much easier if we only defined these operations on
>>>atomic_t's.  We have all the infrastructure in place for them, and
>>>they're fairly well understood.  If you need different sizes, I'm OK
>>>with an atomic_pointer_t, or whatever.
>>
>>FWIW Seconded.
> 
> 
> I disagree.
> 
> Any _real_ CPU will simply never care about _anything_ else than just the 
> size of the datum in question. There's absolutely no point to only allow 
> it on certain types, especially as we _know_ those certain types are 
> already going to be more than one, and we also know that they are going to 
> be different sizes. In other words, in reality, we have to handle a 
> sizeable subset of the whole generic situation, and the "on certain types 
> only" situation is only going to be awkward and irritating.
> 
> For example, would we have a different "cmpxchg_ptr()" function for the 
> atomic pointer thing? With any reasonable CPU just depending on the _size_ 
> of the type, I don't see what the problem is with just doing the 
> bog-standard "cmpxchg_8/16/32/64" and having the bog-standard case- 
> statement in a header file to do it all automatically for you, and then we 
> don't need to worry about it.

What's wrong with using atomic_cmpxchg? For unsigned long / pointers,
there is a patch to implement atomic_long_cmpxchg.

Some architectures simply can't implement cmpxchg on memory that may
be modified in arbitrary ways. If you add some more conditions to use
cmpxchg, then you weaken it (ie. can't use it for synchronisation
with userspace) and on top of that you don't get the easy static
checking that atomic_t gives you.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
