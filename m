Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285203AbRLXSNw>; Mon, 24 Dec 2001 13:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285196AbRLXSNn>; Mon, 24 Dec 2001 13:13:43 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:51644 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S285185AbRLXSNd>; Mon, 24 Dec 2001 13:13:33 -0500
Message-ID: <3C277049.3070000@redhat.com>
Date: Mon, 24 Dec 2001 13:13:29 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011217
X-Accept-Language: en-us
MIME-Version: 1.0
To: David Lang <david.lang@digitalinsight.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Keith Owens <kaos@ocs.com.au>,
        Benjamin LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Assigning syscall numbers for testing
In-Reply-To: <Pine.LNX.4.40.0112240933110.24605-100000@dlang.diginsite.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:

> you miss the point, the syscall numbers will not nessasarily be consistant
> from boot to boot so if your code does not check for them it's seriously
> broken (and remember this is only for stuff in experimental status). The
> hope is that most if not all of the real checking can end up being done in
> glibc


No, I'm not missing the point.  Try to follow with me here, this isn't 
rocket science.  *NOT* *ALL* *SOFTWARE* *IS* *OR* *WILL* *BE* *USING* 
*DYNAMIC* *SYSCALLS*.  Your scenario is fine if you want to convert all 
existing software to dynamic syscalls.  However, my scenario specifically 
dealt with software that *DOES* *NOT* use dynamic syscalls (and which 
doesn't need to because the syscalls it *does* use have been allocated).

Since people are having such a hard time with this, let me spell it out in 
more detail.  Assume the following scenario:

Linux 2.4.17 + dynamic syscall patch.  Dynamic syscalls start at 240.

Linux 2.4.18 comes out, and now there are two *new* *official* *statically* 
*allocated* syscalls at 240 and 241 (they are SYSGETAMIBLKHEAD and 
SYSSETAMIBLKHEAD).

A new piece of software (or an existing one, doesn't matter) is written to 
take advantage of the new syscalls.  It uses the *predefined* syscall 
numbers and is compiled against 2.4.18.  It relies upon -ENOSYS (as is 
typical for non-dynamic syscalls) to indicate if the kernel doesn't support 
the intended syscalls.

Now, someone without realizing the implications of what's going on, runs 
this new program on a machine running the 2.4.17 + dynamic syscall patch.

BOOM!

So, to reiterate my points.  This *IS* *NOT* *SAFE* unless either A) the 
dynamic syscall number range is officially allocated *before* the patch goes 
into use to avoid these collisions later or B) you switch *all* software to 
using dynamic syscalls (which does have a performance impact on the software 
and which would also require lots of work).


> David Lang
> 
> 
> 
>  On Mon, 24 Dec 2001, Doug Ledford wrote:
> 
> 
>>Date: Mon, 24 Dec 2001 12:06:19 -0500
>>From: Doug Ledford <dledford@redhat.com>
>>To: Alan Cox <alan@lxorguk.ukuu.org.uk>
>>Cc: Keith Owens <kaos@ocs.com.au>, Benjamin LaHaise <bcrl@redhat.com>,
>>     linux-kernel@vger.kernel.org
>>Subject: Re: [patch] Assigning syscall numbers for testing
>>
>>Alan Cox wrote:
>>
>>
>>>>Well, I'm not going to mess with code, but here's the example.  Say you
>>>>start at syscall 240 for dynamic registration.  Someone then submits a patch
>>>>
>>>>
>>>The number you start at depends on the kernel you run.
>>>
>>>
>>>
>>>>modify the base of your patch, but if it has been accepted into any real
>>>>kernels anywhere, then someone could inadvertently end up running a user
>>>>space app compiled against Linus' new kernel and that uses the newly
>>>>allocated syscalls 240 and 241.  If that's run on an older kernel with your
>>>>
>>>>
>>>The code on execution will read the syscall numbers from procfs. It will
>>>find new numbers and call those. Its a very simple implementation of lazy
>>>binding. It only breaks if you actually run out of syscalls, and then it
>>>fails safe.
>>>
>>>Alan
>>>
>>>
>>>
>>No it doesn't.  You are *assuming* that *all* code will check the lazy
>>syscall bindings.  My example was about code using the predefined syscall
>>number for new functions on an older kernel where those functions don't
>>exist, but where they overlap with the older dynamic syscall numbers.  In
>>short, the patch is safe for code that uses the lazy binding, but it can
>>still overlap with future syscall numbers and code that doesn't use the lazy
>>binding but instead uses predefined numbers.
>>
>>--
>>
>>  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
>>       Please check my web site for aic7xxx updates/answers before
>>                       e-mailing me about problems
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>>
>>
> 



-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

