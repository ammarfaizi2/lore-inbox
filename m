Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264178AbTDJVoH (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 17:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264185AbTDJVoH (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 17:44:07 -0400
Received: from watch.techsource.com ([209.208.48.130]:20208 "EHLO
	techsource.com") by vger.kernel.org with ESMTP id S264178AbTDJVoC (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 17:44:02 -0400
Message-ID: <3E95EB6D.4020004@techsource.com>
Date: Thu, 10 Apr 2003 18:08:45 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Painlessly shrinking kernel messages (Re: kernel support for non-english
 user messages)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I took the liberty of reading the FAQ (yeah, I saw 9.16) and joining the 
list after reading an interesting recent discussion on i18n of kernel 
messages.  In short, the primary maintainers of the kernel don't want 
it, and I agree with them.

HOWEVER, the discussion inspired me to think about ways of reducing some 
of the unfortunate but necessary bloat caused by keeping all of those 
strings in RAM.  Naturally, any way to do this must be absolutely 
painless, so I came up with the following set of restrictions:

- Absolutely no requirement to change existing strings, unless you feel 
like it
- Must be easy to use
- Must actually shrink the kernel
- The impact on the way kernel messages appear should be minimized

To be brief, the idea I came up with was to identify the 128 most common 
words in kernel messages and replace them with single character values 
above 127 which printk would decode on the way out.  Once the list was 
determined, there would be a header file people could use, at their 
leisure, to make stubstitutions.  So, for instance, instead of having this:

    printk("invalid: ...");

We would have this:

    #define MSG_INVALID "\200"
    ...
    prink(MSG_INVALID "...");


To judge the practicality of this, I used 'strings' on an uncompressed 
kernel image (2.4.20, IIRC) and then ran it through this:

tr '[:lower:]' '[:upper:]' | tr '[:blank:]' '\n' | sort | uniq -c | tr ' ' 0

This gave me a list of all words found in the kernel along with their 
counts.  Then I ran it through a positively awful little C program which 
I wrote to determine not the 128 most frequent, but rather, the 128 that 
would result in the maximum shrinkage (maximize count * (length-1)). 
 The results of that run are given below.  The results of the test are 
that this approach might save up to 62424 bytes of kernel space which is 
only about 3% of the kernel image size I got the strings from, but it's 
nearly 27% of the total output I got from 'strings'.  Is it worth it? 
 Maybe not yet, but then again, there may be an even more intelligent 
approach to this compression that we could use, hopefully one which 
wouldn't require any more effort to use.

Here's are the results:

   count string
-------- --------
      37 GIGABIT
     102 BLOCK
      62 NULL
     871 [^_]
      26 INTERFACE
      23 MICROSYSTEMS
      75 RAGE
     338 SE
     226 TECH
     113 DEVICE
     214 <3>
     838 PC
      19 <3>INIT_MODULE:
      35 REGISTER
      41 <3>EXT3-FS
     656 UWVS
      57 NETWORK
      32 SUPPORT
      97 COMPUTER
     878 [^_
     137 NET
     198 MODE
     534 INC
      33 INTERNATIONAL
      59 CARDBUS
     203 TECHNO
     119 TECHNOLOGY
      46 CORP.
      31 EXT2-FS
     290 CONTROLLER
      64 ASSERTION
      83 DATA/FAX
     249 DATA
      60 KERNEL:
     304 CONTROL
      33 INVALID
     322 %D
     486 PCI
     185 INC.
      61 ERROR
      80 PORT
     154 IDE
      74 INODE
     102 <4>
      88 KERNEL
      52 ELECTRONICS
      44 <3>EXT3
     117 FAILED
      70 AUDIO
      83 HOST
      27 SEMICONDUCTOR
      50 CHIPS
      63 DEVFS
     117 ETHERNET
     299 ID
     291 COM
      46 CANNOT
      24 TRANSACTION
     238 TO
      79 TECHNOLOGIES
      63 %08X
      98 D$$
      37 PROCESS
     288 CORP
      56 DATA/FAX/VOICE
      39 COMMUNICATIONS
      44 10/100
      38 SERIAL
     146 CORPORATION
     236 TEC
     107 MICRO
      26 MICROSYSTEM
      95 ADAPTER
     324 NO
      50 POWER
     121 56K
      27 ACCELERATOR
      33 RESEARCH
      21 INTEGRATED
     271 PRO
      19 TECHNOLOGIES,
     237 LT
      43 CHIPSET
      28 NETWORKS
     317 L$
      40 <3>EXT3-FS:
    1665 CO
     192 BRIDGE
      13 MICROELECTRONICS
     157 JOURNAL
     147 FOR
      91 9D$
      18 CYBERSERIAL
      54 CYBER
      56 MEMORY
      34 DATA/FAX/VOICE/SPKP
      49 SMART
     207 LTD
     137 TCP
      57 CACHE
     407 T$
     160 <6>
      26 GRAPHICS
     888 D$
     140 SYSTEMS
     249 AT
       6 JOURNAL->J_COMMITTING_TRANSACTION
     142 MODEM
      32 CHANNEL
     131 %S:
     394 %S
      14 COMMIT_TRANSACTION
      63 FILE
      28 SMARTDAA)
      67 CHIP
      30 WINMODEM
     113 NOT
     139 ETH
     331 DEV
     197 FO
      52 VIDEO
      73 ELECTRONIC
      67 EXT3
      99 CARD
    1336 IN
     222 SYSTEM
     197 AD
      53 COMMUNICATION
Total reduction: 62424

Comments?

NOTE:  I realize that some of those words probably aren't actually 
"strings" in the kernel.  This is a feasibility test, not a suggested list.


