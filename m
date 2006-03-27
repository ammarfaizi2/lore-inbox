Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbWC0ANP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbWC0ANP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 19:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbWC0ANP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 19:13:15 -0500
Received: from smtpout.mac.com ([17.250.248.87]:31479 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932258AbWC0ANO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 19:13:14 -0500
In-Reply-To: <200603261555.51504.rob@landley.net>
References: <200603141619.36609.mmazur@kernel.pl> <1143376008.3064.0.camel@laptopd505.fenrus.org> <F31089B5-0915-439D-B218-009384E2148F@mac.com> <200603261555.51504.rob@landley.net>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8DB7FF04-813B-4573-B1BD-A9276B4F83BE@mac.com>
Cc: Arjan van de Ven <arjan@infradead.org>, nix@esperi.org.uk,
       mmazur@kernel.pl, linux-kernel@vger.kernel.org,
       llh-discuss@lists.pld-linux.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC][PATCH 0/2] KABI example conversion and cleanup
Date: Sun, 26 Mar 2006 19:12:44 -0500
To: Rob Landley <rob@landley.net>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 26, 2006, at 15:55:51, Rob Landley wrote:
> On Sunday 26 March 2006 7:34 am, Kyle Moffett wrote:
>> Well I guess you could call it UABI, but that might also imply  
>> that it's _userspace_ that defines the interface, instead of the  
>> kernel. Since the headers themselves are rather tightly coupled  
>> with the kernel, I think I'll stick with the KABI name for now  
>> (unless somebody can come up with a better one, of course :-D).
>
> Ok, question, using an example I'm familiar with.  What's affected  
> by the prefix?
>
> We eventually got it all untangled.  Now we check if we're on 2.6  
> and if so use the 64 bit API (which is stable on 2.6), and  
> otherwise use a copy of the 32 bit structure that predates  
> __kernel_dev_t being renamed.  And we trust the darn kernel headers  
> to supply the types for us, because there's just no alternative.
>
> My question is: will your new approach work with our existing code,  
> or are you saying we need another #ifdef to check for yet another  
> gratuitously incompatible name, ala _kabi__kernel_dev_t?

No, no need for a new #ifdef, at least not for a long time if you  
don't want to.  My plans for the immediate future are only to touch  
files that are currently broken with respect to !__KERNEL__, and  
linux/loop.h isn't.  When I do get to it, my plan is to bring the  
parts that userspace needs into kabi/loop.h, named as __kabi_*,  
however linux/loop.h will define the new symbols to their old names  
for compatibility with linux code and userspace code that happens to  
be using those interfaces, so you still won't need to change  
anything.  Hopefully this would also mean that if the shipped linux/ 
loop.h is currently broken for your uses, I would be able to fix it  
so you don't need a customized copy at all.

If you _did_ decide to switch busybox to use the __kabi_ symbols, you  
would be able to take advantage of the fact that the same set of kabi  
headers (which don't include kernelversion.h) would work unmodified  
for kernels all the way back to 0.99, as long as you base your  
decisions of what features are available on either a dynamically- 
detected version or a pre-configured minimum version from the user.   
I'm assuming here that it's possible to compile a busybox that works  
on a 2.2 or 2.4 kernel even using linux-libc-headers 2.6.*, as long  
as the user indicates such.

> This is just an example.  There is currently no existing program  
> out in userspace that is tries to talk to the kernel using names  
> with _kabi_ prepended to them, that I am aware of.  If you're  
> adding this prefix, you're writing a brand new interface which  
> currently has exactly zero users.  Is this the intent?

I'd like this project to have a twofold purpose.  First, in the short  
term I want to fix up the general __KERNEL__ vs !__KERNEL__  
brokenness in include/linux and clean up and document which APIs are  
userspace ABI by moving them to include/kabi.  If that first part  
works, then in the very _long_ term, (on the order of a couple years  
or so) I would like to encourage larger projects like klibc and GLIBC  
to migrate to using *only* the include/kabi headers to avoid  
namespace pollution and allow kernel devs to rearrange and adjust the  
linux/* headers as they see fit without caring about breaking  
external programs.

Once the libcs are using kabi/*, GLIBC can pick up a set of linux/*.h  
"emulation" files based on kabi/*.h that provide all of the old  
source-APIs for as long as anybody cares, and Linux can go back to  
screwing around with its header files in any way that it pleases  
(just as long as it keeps ABI stuff all in kabi).  One of my major  
goals for this rework is to ensure that the kabi/*.h header files  
actually define the _ABI_ going back to the very early releases of  
Linux.  As Linus said, it's an ABI, which means that adding new  
features is OK, but removing them is bad, so I'll try to make sure  
it's _perfectly_ _ok_ to use a 2.6 kabi/ on a 2.0 kernel.  It should  
also be perfectly ok to use a 2.6 kabi/ on a 5-years-down-the-road  
2.8 kernel as long as you restrict yourself to the subset of features  
that were available in 2.6.

Cheers,
Kyle Moffett

