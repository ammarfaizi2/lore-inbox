Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270997AbTGPRVj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 13:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270991AbTGPRUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 13:20:22 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:7845 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S270997AbTGPRTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 13:19:12 -0400
Message-ID: <3F158C5F.1000300@myrealbox.com>
Date: Thu, 17 Jul 2003 01:33:19 +0800
From: Romit Dasgupta <romit@myrealbox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Trivial Change (E820map) : arch/i386/boot/setup.S
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
      After reading the e820 method from Ralf Brown's interrupt list(
http://www.ctyme.com/intr/rb-1741.htm)
it seems that the es register wont get thrashed. So there is no need to 
repatedly execute (for getting each map entry) the following two lines 
inside jmpe820: of seutp.S and thus can be moved out as below.  Is there 
any reason to do it inside?


        pushw   %ds
        popw    %es

jmpe820:
        movl    $0x0000e820, %eax               # e820, upper word zeroed
        movl    $SMAP, %edx                     # ascii 'SMAP'
        movl    $20, %ecx                       # size of the e820rec
#       pushw   %ds                             # data record.
#       popw    %es


Diff
-------

===== setup.S 1.22 vs edited =====
318a319,320
 >       pushw   %ds
 >       popw    %es
324,325c326,327
<       pushw   %ds                             # data record.
<       popw    %es
---
 > #       pushw %ds                             # data record.
 > #       popw  %es
1156d1157
<


Tested in my i386 machine and here is the relevant portion of dmesg 
after boot.

> Linux version 2.6.0-test1 (root@feynman) (gcc version 3.2 20020903 
> (Red Hat Linux 8.0 3.2-7)) #14 Thu Jul 17 01:05:15 SGT 2003
> Video mode to be used for restore is f00
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
>  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 0000000017ff0000 (usable)
>  BIOS-e820: 0000000017ff0000 - 0000000017ffec00 (ACPI data)
>  BIOS-e820: 0000000017ffec00 - 0000000018000000 (ACPI NVS)
>  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
> 0MB HIGHMEM available.
> 383MB LOWMEM available.
> On node 0 totalpages: 98288


Regards,
-Romit

