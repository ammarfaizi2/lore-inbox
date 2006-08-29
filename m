Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750940AbWH2Bgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbWH2Bgu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 21:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbWH2Bgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 21:36:50 -0400
Received: from terminus.zytor.com ([192.83.249.54]:63173 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750936AbWH2Bgt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 21:36:49 -0400
Message-ID: <44F39A23.4000409@zytor.com>
Date: Mon, 28 Aug 2006 18:36:35 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Petr Vandrovec <vandrove@vc.cvut.cz>
CC: Matt Domsch <Matt_Domsch@dell.com>, Alon Bar-Lev <alon.barlev@gmail.com>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, johninsd@san.rr.com
Subject: Re: [PATCH] Fix the EDD code misparsing the command line
References: <445B5524.2090001@gmail.com> <200608272116.23498.ak@suse.de> <44F1F356.5030105@zytor.com> <200608272254.13871.ak@suse.de> <44F21122.3030505@zytor.com> <44F286E8.1000100@gmail.com> <44F2902B.5050304@gmail.com> <44F29BCD.3080408@zytor.com> <9e0cf0bf0608280519y7a9afcb9od29494b9cacb8852@mail.gmail.com> <44F335C8.7020108@zytor.com> <20060828184637.GD13464@lists.us.dell.com> <44F386B8.8000209@zytor.com> <44F3974B.6060501@vc.cvut.cz>
In-Reply-To: <44F3974B.6060501@vc.cvut.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec wrote:
>> +
>> +# Old-style boot protocol?
>> +old_cl:
>> +    push    %ds            # aka INITSEG
>> +    pop    %fs
>> +
>> +    cmpw    $0xa33f, (0x20)
>> +    jne    done_cl            # No command line at all?
>> +    movw    (0x22), %si        # Pointer relative to INITSEG
> 
> Perhaps you should convert ds:si to flat pointer and then this flat 
> pointer to fs:si using method above, to avoid problems with dword access 
> with si > 0xfffc or word access with si > 0xfffe ?
> 
>> +
>> +# fs:si has the pointer to the command line now
>> +have_cl_pointer:
>> +   
>>  # loop through kernel command line one byte at a time
>> -cl_loop:
>> -    cmpl    $EDD_CL_EQUALS, (%si)
>> +cl_atspace:
>> +    movl    %fs:(%si), %eax
> 
> This looks fine for new boot protocol, but what if old boot protocol 
> puts command line so that its last byte is at INITSEG:0xffff ?  You get 
> #GP here, then, although command line is correctly zero terminated and 
> does not overflow segment.
> 

With the old protocol, the command line is supposed to fit inside the 
64K segment, so I don't think that's an issue.  Putting "Hail Mary" 
break at 0xfffd isn't a bad idea, though (especially since even if that 
is legitimate, we can't fit "edd=" into that one.)

> If si is 0xfffb here, bad things happen.  I know, things I've pointed 
> out should not be problem in real world, and new code is definitely 
> better than old one, but if you already have code to avoid endless loop 
> if command line points to 64KB array of 0xFF let's do that right, no?

Agreed.  I'll update the patch shortly.

	-hpa
