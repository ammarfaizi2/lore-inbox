Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbWDSOzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbWDSOzh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 10:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWDSOzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 10:55:37 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:30224 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1750820AbWDSOzg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 10:55:36 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
in-reply-to: <963E9E15184E2648A8BBE83CF91F5FAF43619A@titanium.secgo.net>
x-originalarrivaltime: 19 Apr 2006 14:55:35.0363 (UTC) FILETIME=[504BF130:01C663C1]
Content-class: urn:content-classes:message
Subject: RE: searching exported symbols from modules
Date: Wed, 19 Apr 2006 10:55:35 -0400
Message-ID: <Pine.LNX.4.61.0604191020530.27688@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: searching exported symbols from modules
Thread-Index: AcZjwVBTziJb6bXETpWkQ3zSEGzsGg==
References: <963E9E15184E2648A8BBE83CF91F5FAF43619A@titanium.secgo.net>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Antti Halonen" <antti.halonen@secgo.com>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 19 Apr 2006, Antti Halonen wrote:

>
> Hi Dick,
>
> Thanks for your response.
>
>> `insmod` (or modprobe) does all this automatically. Anything that's
>> 'extern' will get resolved. You don't do anything special. You can
>> also use `depmod` to verify that you won't have any problems loading.
>> `man depmod`.
>
> Yes, I know insmod and herein the problem lies. I have a module where
> I want to use functions provided by another module, _if_ it is present,
> otherwise use modules internal functions.
>
> So if I hardcode the function calls statically in my module, the insmod
> goes trough of course, if the service module is present. But, it fails
> if it's not.

/proc/kallsyms contains the offset and names of all the global kernel
symbols. This is not supposed to be accessed from inside the kernel,
but it could tell a program loader, that you write, if the required
symbols exist. If not, you can link in the required procedures
before you load your module. Note that 'module.ko' is just an
object file and you can use `ld` to link in other objects.

You could even do this with a shell-script (not tested):

SYMS="printk foo bar"
BASE="mymodule.ko"
FINAL="final.ko"

for x in $SYMS ; do if ! grep $x /proc/kallsyms>/dev/null ;
  then echo $x ; ld -o tmp.o mymodule.ko $x.o ; mv tmp.o mymodule.ko;
  fi;
  done

>
> So, I want to load up, check if the service module is present, and use
> it's servides.
>

Another thing you may be able to use are 'weak' symbols. I don't
know if the new `insmod` handles these. Weak symbols are used in
linking if globals are not found (which is what you want). You can
try "# pragma weak" or __attribute__((weak)) for all functions you
want to use if globals are not found. You can see if that works.
If it works, you are home free, if not you can contact the module-
tools people and see if they could add handling weak symbols.

 	Rusty Russell <rusty@rustcorp.com.au>
 	Adam J. Richter <adam@yggdrasil.com>


>> If you are accessing functions or other objects that are not exported
>> anymore, how do you know that they even exist?
>
> I meant that in previous kernel version, some module symbol searching
> functions were available.
>


Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.53 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
