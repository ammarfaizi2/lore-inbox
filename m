Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267430AbUBSRab (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 12:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267244AbUBSRab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 12:30:31 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:11490 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S267433AbUBSRaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 12:30:08 -0500
Date: Fri, 20 Feb 2004 01:37:39 +0800
To: "Pavel Machek" <pavel@suse.cz>
Subject: Re: Reserved page flaging of 2.4 kernel memory changed recently?
Cc: "Andrea Arcangeli" <andrea@suse.de>,
       "Nigel Cunningham" <ncunningham@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
References: <200402050941.34155.mhf@linuxmail.org> <20040208020624.GG31926@dualathlon.random> <200402100625.41288.mhf@linuxmail.org> <20040219072629.GB467@openzaurus.ucw.cz> <opr3l0mfdw4evsfm@smtp.pacific.net.th> <20040219161455.GC259@elf.ucw.cz>
From: "Michael Frank" <mhf@linuxmail.org>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opr3mok1ko4evsfm@smtp.pacific.net.th>
In-Reply-To: <20040219161455.GC259@elf.ucw.cz>
User-Agent: Opera M2/7.50 (Linux, build 600)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Feb 2004 17:14:55 +0100, Pavel Machek <pavel@suse.cz> wrote:

> Hi!
>
>> >>I actually would like to rename the bit PG_nosave to PG_donttouch ;)
>>
>> to make a point with regard to:
>>
>> 	no transfer of page contents during suspend/resume
>> 	no netdump
>> 	no debugger access without override
>>
>> ... but the name does not matter and we do not have to change it.
>>
>> >Its used for swsusp internal data, too...
>>
>> Yes of course - how else would swsusp run, but these data are also not
>> "touched"
>> during suspend and resume wrt transfer of page content.
>
> Yes. But I still want to be able to access swsusp internal data
> through debugger, and I want them in the netdump.
>
> That means that PG_nosave | PG_reserved indeed is "PG_donttouch", but
> PG_nosave has slightly different meaning.

Makes sense, but PG_reserved is used to keep VM out of these pages.

Can we have a seperate bit PG_donttouch which is set with PG_nosave
| PG_reserved in reserved/video/BIOS/Broken CPU areas?

This way

- debugger and netdump use PG_donttouch to prevent accesses
   which might result in MCE's and CPU crashes.

- Swsusp uses PG_nosave.

- VM continues to use PG_reserved.	

This is also a safe provision for hardware/driver changes.

As an example of using PG_nosave and PG_reserved Here are the actual
pageflags of a running 2.4.24 kernel using PG_nosave for
video/BIOS shown using crash utility:

Flags 4000 is PG_reserved
Flags 20000 is PG_nosave

By my proposal we would set PG_dontouch as well where PG_reserved
&& PG_nosave are set right now.

crash> kmem -p

   PAGE    PHYSICAL   MAPPING    INDEX CNT FLAGS

Interrupt vectors

c100001c         0         0         0  0 4000
c1000048      1000         0         0  0 4000
c1000074      2000         0         0  0 4000
c10000a0      3000         0         0  0 4000

Main memory

c10000cc      4000  deb641c4      3862  2 c8
c10000f8      5000  deb641c4      3861  2 c8
c1000124      6000  deb641c4      3860  2 c8
c1000150      7000  deb641c4      3859  2 c8
c100017c      8000         0         1  2 4c
[]
c1000ca8     49000         0         4  2 4c
c1000cd4     4a000         0        15  2 4c
c1000d00     4b000         0         0  2 4c
c1000d2c     4c000         0         4  2 4c
c1000d58     4d000         0         3  2 4c
c1000d84     4e000         0         7  2 4c
c1000db0     4f000         0         6  2 4c
c1000ddc     50000  cb35b6a4       669  2 4c
c1000e08     51000  cb35b6a4       668  2 4c
c1000e34     52000  cb35b6a4       667  2 4c
c1000e60     53000  cb35b6a4       666  2 4c
c1000e8c     54000  dee6e564   7085941  2 c0
c1000eb8     55000  cb35b6a4       604  2 4c
c1000ee4     56000         0     25308  1 108
c1000f10     57000  cb35b6a4       605  2 4c
c1000f3c     58000  cb35b6a4       606  2 4c
c1000f68     59000         0         0  2 4c
c1000f94     5a000  cb35b6a4       615  2 4c
[]
c1001a94     9a000  deb641c4      3818  2 c8
c1001ac0     9b000  deb641c4      3817  2 c8
c1001aec     9c000  deb641c4      3826  2 c8
c1001b18     9d000  deb641c4      3825  2 c8
c1001b44     9e000  cb35b8a4         1  2 4c

Donttouch reserved/video/BIOS area

c1001b70     9f000         0         0  0 24000
c1001b9c     a0000         0         0  0 24000
c1001bc8     a1000         0         0  0 24000
c1001bf4     a2000         0         0  0 24000
c1001c20     a3000         0         0  0 24000
c1001c4c     a4000         0         0  0 24000
c1001c78     a5000         0         0  0 24000
c1001ca4     a6000         0         0  0 24000
c1001cd0     a7000         0         0  0 24000
c1001cfc     a8000         0         0  0 24000
c1001d28     a9000         0         0  0 24000
[]
c1002b14     fa000         0         0  0 24000
c1002b40     fb000         0         0  0 24000
c1002b6c     fc000         0         0  0 24000
c1002b98     fd000         0         0  0 24000
c1002bc4     fe000         0         0  0 24000
c1002bf0     ff000         0         0  0 24000

Kernel

c1002c1c    100000         0         0  0 4000
c1002c48    101000         0         0  0 4000
c1002c74    102000         0         0  0 4000
c1002ca0    103000         0         0  0 4000
c1002ccc    104000         0         0 11875 4000
[]
c100b360    413000         0         0  0 4000
c100b38c    414000         0         0  0 4000
c100b3b8    415000         0         0  0 4000

Here is 120K ex init memory

c100b3e4    416000  deb641c4      3820  2 c8
c100b410    417000  deb641c4      3819  2 c8
c100b43c    418000  deb641c4      3866  2 c8
c100b468    419000  deb641c4      3865  2 c8
c100b494    41a000  deb641c4      3864  2 c8
c100b4c0    41b000  deb641c4      3863  2 c8
c100b4ec    41c000  deb641c4      3828  2 c8
c100b518    41d000  deb641c4      3827  2 c8
c100b544    41e000         0         0  1 100
c100b570    41f000  deb641c4      3807  2 c8
c100b59c    420000  cb35b6a4      3652  2 c8
c100b5c8    421000  cb35b6a4      3651  2 c8
c100b5f4    422000  cb35b6a4      3650  2 c8
c100b620    423000  cb35b6a4      3649  2 c8
c100b64c    424000  cb35b6a4       113  2 cc
c100b678    425000         0         0  1 100
c100b6a4    426000         0         0  1 5c
c100b6d0    427000         0         1  1 5c
c100b6fc    428000         0     25405  1 108
c100b728    429000  cb35b6a4       498  2 cc
c100b754    42a000  cb35b6a4       543  2 cc
c100b780    42b000  cb35b6a4       542  2 cc
c100b7ac    42c000  cb35b6a4       365  2 cc
c100b7d8    42d000  cb35b6a4       364  2 cc
c100b804    42e000  cb35b6a4       484  2 cc
c100b830    42f000  dee6e564   7077953  2 c0
c100b85c    430000  dee6e564   7078648  2 c0
c100b888    431000  cb35b6a4       508  2 cc
c100b8b4    432000  cb35b6a4       561  2 4c
c100b8e0    433000  cb35b6a4       560  2 4c

swsusp nosave area - 1 page

c100b90c    434000         0         0  0 24000

some more kernel data

c100b938    435000         0         0  0 4000
c100b964    436000         0         0  0 4000
c100b990    437000         0         0  0 4000
c100b9bc    438000         0         0  0 4000
c100b9e8    439000         0         0  0 4000
[]
c100c800    48b000         0         0  0 4000
c100c82c    48c000         0         0  0 4000

End of kernel data / main memory

c100c858    48d000  cb35b6a4       116  2 cc
c100c884    48e000  deb641c4      3822  2 c8
c100c8b0    48f000  deb641c4      3821  2 c8
c100c8dc    490000  cb35b6a4       117  2 cc
...

Regards
Michael
