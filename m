Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964813AbWJ1U36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbWJ1U36 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 16:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbWJ1U36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 16:29:58 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:19885 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751392AbWJ1U35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 16:29:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=ramBngBXNBJMT3MiKCbYeCx8BoU9JsF3+2094B7DnJ2c8M+P2ztVgxQB0T7z5WpDhf8hW3vLplkLGsQ6x90d6oxgPkFtM6MQIOcXs/OA2t9N9Gb5ij3p2WvVhBwxn98C+d2YpmRZ4hQdW25VDWdUxGbUT+J4yS2k5zx2aJa25nE=
Date: Sat, 28 Oct 2006 22:30:14 +0200
From: Luca Tettamanti <kronos.it@gmail.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: why "probe_kernel_address()", not "probe_user_address()"?
Message-ID: <20061028203014.GA7183@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610281258060.2652@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert P. J. Day <rpjday@mindspring.com> ha scritto:
> On Sat, 28 Oct 2006, Andrew Morton wrote:
> 
>> On Sat, 28 Oct 2006 11:56:24 -0400 (EDT)
>> "Robert P. J. Day" <rpjday@mindspring.com> wrote:
>>
>> >
>> >   it seems odd that the purpose of the "probe_kernel_address()" macro
>> > is, in fact, to probe a *user* address (from linux/uaccess.h):
>> >
>> > #define probe_kernel_address(addr, retval)              \
>> >         ({                                              \
>> >                 long ret;                               \
>> >                                                         \
>> >                 inc_preempt_count();                    \
>> >                 ret = __get_user(retval, addr);         \
>> >                 dec_preempt_count();                    \
>> >                 ret;                                    \
>> >         })
>> >
>> >   given that that routine is referenced only 5 places in the entire
>> > source tree, wouldn't it be more meaningful to use a more appropriate
>> > name?
>> >
>>
>> You'll notice that all callers are indeed probing kernel addresses.
>> The function _could_ be used for user addresses and could perhaps be
>> called probe_address().
>>
>> One of the reasons this wrapper exists is to communicate that the
>> __get_user() it is in fact not being used to access user memory.
> 
> one quick addition to this.  in arch/i386/kernel/traps.c, we have the
> code snippet:
> 
>        if (eip < PAGE_OFFSET)
>                return;
>        if (probe_kernel_address((unsigned short __user *)eip, ud2))
>                return;
>        if (ud2 != 0x0b0f)
>                return;
> 
>        printk(KERN_EMERG "------------[ cut here ]------------\n");
> 
> #ifdef CONFIG_DEBUG_BUGVERBOSE
>        do {
>                unsigned short line;
>                char *file;
>                char c;
> 
>                if (probe_kernel_address((unsigned short __user *)(eip + 2),
>                                        line))
> ... etc etc ...
> 

I agree that it may be confusing. The whole point in using __get_user()
is that it ensures that the source address is valid.

When handle_BUG() is called the kernel is no more in a "sane" state,
blindly using the content of the registers may lead to a page fault in
kernel mode. So the code extract filename and line of the BUG checking
that the line number is indeed readable, the address of the string (file
name) is readable and it points to a readable memory location.

probe_kernel_address wrapper is used to "hide" the fact that we are
re-using the infrastructure provided by a function with a confusing name
;) The cast to __user is needed to keep sparse quiet.

>  if those pointers qualified by "__user" *aren't* actually addresses
> into user space, that would seem to violate what i read in the book
> "linux device drivers (3rd ed)", p. 50:
> 
> "This [__user] annotation is a form of documentation, noting that a
> pointer is a user-space address that cannot be directly dereferenced.
> For normal compilation, __user has no effect, but it can be used by
> external checking software to find misuse of user-space addresses."
> 
>  under the circumstances, wouldn't this show up as one of those
> misuses?

No, __user annotation ensure that sparse will notice things like:

int random_pointer_from_userspace __user *data;
...
my_data = *data; /* <-- sparse will complain */

In this scenario 'data' is a pointer provided by userspace application
and *cannot* be trusted; it shall be used only with functions that do
check the address before using it, like __get_user(). (get_user() also
checks that the address is a *userspace* address, it can't be used to
read kernel memory).

Luca
-- 
Se alla sera, dopo una strepitosa vittoria, guardandoti allo
specchio dovessi notare un secondo paio di palle, che il tuo 
cuore non si riempia d'orgoglio, perche` vuol dire che ti 
stanno inculando -- Saggio Cinese
