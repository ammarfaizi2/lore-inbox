Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131791AbQLZRWx>; Tue, 26 Dec 2000 12:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131706AbQLZRWo>; Tue, 26 Dec 2000 12:22:44 -0500
Received: from blackdog.wirespeed.com ([208.170.106.25]:21774 "EHLO
	blackdog.wirespeed.com") by vger.kernel.org with ESMTP
	id <S131791AbQLZRW3>; Tue, 26 Dec 2000 12:22:29 -0500
Message-ID: <3A48CC1D.9000204@redhat.com>
Date: Tue, 26 Dec 2000 10:49:33 -0600
From: Joe deBlaquiere <jadb@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22 i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@uni-koblenz.de>
CC: the list <linux-kernel@vger.kernel.org>, linux-mips@oss.sgi.com,
        linux-mips@fnet.fr
Subject: Re: sysmips call and glibc atomic set
In-Reply-To: <3A46F4D8.9060605@redhat.com> <20001226140204.D894@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralf, firstly, thank you for the answers :)

Ralf Baechle wrote:

> 
> Ok, but since the kernel disables MIPS III you're limited to MIPS II anyway ...
> 

This makes sense...

> 
> 
> Read the ISA manual; sc will fail if the LL-bit in c0_status is cleared
> which will be cleared when the interrupt returns using the eret instruction.
> 

I tried to find a MIPSIII manual from mips.com but all I could find was 
mips32 and mips64 (which are not the same as MIPSII/MIPSIII/MIPSIV).

> 
> 
> Not having swap doesn't mean you're safe.  Think of any kind of previously
> unmapped page.
> 

Is there a reason why it doesn't just force that page to be mapped first?

> 
>> QUESTION 2) Wouldn't it be better to pass back the initial value of 
>> *arg1 in *arg3 and return zero or negative error code?
> 
> 
> The semantics of this syscall were previously defined by Risc/OS and later
> on continued to be used by IRIX.
> 
> 
>> 	case MIPS_ATOMIC_SET: {
>> 		/* This is broken in case of page faults and SMP ...
>> 		    Risc/OS faults after maximum 20 tries with EAGAIN.  */
>> 		unsigned int tmp;
>> 
>> 		p = (int *) arg1;
>> 		errno = verify_area(VERIFY_WRITE, p, sizeof(*p));
>> 		if (errno)
>> 			return errno;
>> 		errno = 0;
>> 		save_and_cli(flags);
>> 		errno |= __get_user(tmp, p);
>> 		errno |= __put_user(arg2, p);
>> 		restore_flags(flags);
>> 
>> 		if (errno)
>> 			return tmp;
>> 
>> 		return tmp;             /* This is broken ...  */
>>          }
>> 
>> QUESTION 3) I notice that the code for this particular case of sysmips 
>> has changed recently. The old code looked more like the 'll/sc' version 
>> of glibc above. I would think that the 'll/sc' code would be better on 
>> SMP systems.
> 
> 
> Don't think about SMP without ll/sc.  There's algorithems available for
> that but their complexity leaves them a unpractical, theoretical construct.
> 
> 
>> Is there a good reason why this reverted?
> 

Looking at 2.4.0-test5 I see the ll/sc code, but -test12 doesn't use it. 
I was just curious at why it was taken out.

> 
> Above code will break if the old content of memory has bit 31 set or you take
> pagefaults.  The latter problem is a problem even on UP - think multi-
> threading.
> 
> Finally, post such things to one of the MIPS-related mailing lists.  If
> you're unlucky nobody of the MIPS'ers might see your posting on l-k.
> 
>   Ralf


-- 
Joe deBlaquiere
Red Hat, Inc.
307 Wynn Drive
Huntsville AL, 35805
voice : (256)-704-9200
fax   : (256)-837-3839

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
