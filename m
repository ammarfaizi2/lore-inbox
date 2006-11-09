Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423822AbWKIOwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423822AbWKIOwo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 09:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423846AbWKIOwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 09:52:44 -0500
Received: from il.qumranet.com ([62.219.232.206]:38083 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1423822AbWKIOwm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 09:52:42 -0500
Message-ID: <455340B8.2080206@qumranet.com>
Date: Thu, 09 Nov 2006 16:52:40 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: kvm-devel@lists.sourceforge.net, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [kvm-devel] [PATCH] KVM: Avoid using vmx instruction directly
References: <20061109110852.A6B712500F7@cleopatra.q> <200611091429.42040.arnd@arndb.de> <45532EE3.4000104@qumranet.com> <200611091542.31101.arnd@arndb.de>
In-Reply-To: <200611091542.31101.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
> On Thursday 09 November 2006 14:36, Avi Kivity wrote:
>   
>>> I'm not an expert on inline assembly, but don't you need an extra
>>> '"m" (phys_addr)' to make sure that gcc actually puts the variable
>>> on the stack instead of passing a NULL pointer as '"a"(&phys_addr)'?
>>>       
>> Taking a variable's address should force its contents into memory (like 
>> calling an uninlined function with &var).
>>     
>
> No it doesn't. You're not telling gcc that the inline assembly cares
> about the contents of the variable, so it could be a reference to
> a stack slot while the contents are still in a register. 

Wouldn't that make inline assembly useless?  Suppose the contents is 
itself a pointer.  What about the pointed-to contents?

e.g.

    int x = 3;
    int *y = &x;
    int z;

    asm ("mov %1, %%rax; movl (%%rax), %0" : "=r"(z) : "g"(y) : "rax");
    assert(z == 3);

> Or gcc
> might move the assignment of phys_addr to after the inline assembly.
>   
"asm volatile" prevents that (and I'm not 100% sure it's necessary).


-- 
error compiling committee.c: too many arguments to function

