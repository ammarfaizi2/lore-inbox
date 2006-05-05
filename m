Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbWEEWTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbWEEWTw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 18:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751796AbWEEWTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 18:19:52 -0400
Received: from mx.freeshell.ORG ([192.94.73.18]:16836 "EHLO sdf.lonestar.org")
	by vger.kernel.org with ESMTP id S1751223AbWEEWTv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 18:19:51 -0400
Date: Fri, 5 May 2006 22:19:32 +0000 (UTC)
From: Alexey Toptygin <alexeyt@freeshell.org>
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org, tony.luck@intel.com
Subject: Re: [PATCH] sendfile compat functions on x86_64 and ia64
In-Reply-To: <200605052328.21370.ak@suse.de>
Message-ID: <Pine.NEB.4.62.0605052145140.25706@ukato.freeshell.org>
References: <Pine.NEB.4.62.0605050030200.18795@norge.freeshell.org>
 <200605052238.26834.ak@suse.de> <Pine.NEB.4.62.0605052040250.27826@ukato.freeshell.org>
 <200605052328.21370.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 May 2006, Andi Kleen wrote:

>> On a 32 bit kernel (and on a 64 bit kernel using the native interface),
>> count is passed to sendfile as unsigned. rw_verify_area explicitly casts
>> to signed
>
> To a 64bit signed.
>
>> before checking for negativeness. The only place anywhere in the
>> kernel that count is signed (other than where rw_verify area explicitly
>> casts it for one test) is in the declaration of sys32_sendfile in the
>> x86_64 compat code. I'm pretty sure it's supposed to be unsigned there
>> too, and the current code is a typo.
>
> It's a 32bit signed.
>
> Somehow the 32bit signed has to become a 64bit signed to be caught
> by rw_verify_area(). The only place that can do that is the compat
> layer.

I still think you misunderstand.

According to 32 bit libc, count is an unsigned 32 bit value. This unsigned 
32 bit value is given to x86_64's sys32_sendfile, which _thinks_ it's a 
signed 32 bit value. sys32_sendfile is passing it to sys_sendfile, which 
expects an unsigned 64 bit value, so the compiler sign-extends it to 64 
bits, then gives it to sys_sendfile as unsigned 64 bits. sys_sendfile 
passes it to do_sendfile with the same type, so it goes there unchanged. 
do_sendfile passes it to rw_verify_area with the same type, so it goes 
there unchanged. rw_verify_area then does this:

         if (unlikely((ssize_t) count < 0))
                 goto Einval;

I agree that this test will pass if we change the declaration of count to 
u32 in sys32_sendfile, but it should pass: this test isn't meant to catch 
values that shouldn't be passed by a 32 bit program, it is only protecting 
against math involving count wrapping later on in rw_verify_area. The test 
agains MAX_NON_LFS (passed via max from sys_sendfile) later in do_sendfile 
will still fail and reject values greater than ((1<<31)-1) passed in from 
32 bit libc.

The ia64 compat path declares count to be unsigned, and presumably this is 
working fine. That path is identical to the above, except sign extension 
doesn't happen: a u32 value is just placed in a u64 variable.

As a result, the x86_64 and ia64 compat paths are inconsistent, so I think 
one of them needs to change. Since every other path from userland into a 
sendfile function has an unsigned count (and none of them appear to be 
broken), I think the change needs to be in x86_64 sys32_sendfile. I think 
the sign extension that is going on there now is completely unnecessary 
and confusing; I think it's a happy accident that it didn't break 
anything.

The only thing my patch does other than changing the signedness of count 
in the declaration of x86_64 sys32_sendfile is relabelling the types of 
offset and count to compat_off_t and compat_size_t. The underlying types 
shouldn't change as a result, but I think this way what is going on is 
much clearer: the compat_ types were defined for exactly this scenario of 
64 bit kernel functions getting off_t and size_t values from a 32 bit 
userland, no?

 			Alexey
