Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319006AbSHFHnt>; Tue, 6 Aug 2002 03:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319008AbSHFHnt>; Tue, 6 Aug 2002 03:43:49 -0400
Received: from www.phroid.net ([212.239.60.154]:58128 "HELO
	earth-sky-water-fire.org") by vger.kernel.org with SMTP
	id <S319006AbSHFHns>; Tue, 6 Aug 2002 03:43:48 -0400
Message-ID: <20020806075108.13589.qmail@earth-sky-water-fire.org>
From: linuxkernel@fonso.it
To: linux-kernel@vger.kernel.org
Subject: request for explaination about nestea: kernel 2.0.33
Date: Tue, 06 Aug 2002 09:51:08 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear kernel gurus (as in: "I need help...") 

Ready to timewarp? 

I'm having really hard time in understanding how nestea (off-by-one vuln in 
kernel 2.0.33) works, so I'd really appreciate some help. 

As far as I get, nestea sends three fragments.
First fragment starts with 0x45 (so has 20 bytes IP header), it's 38 bytes 
long (IPH + UDPH + 10), has offset 0 and MF set.
Second fragment starts with 0x45, it's 136 bytes long (IPH + UPDH + 108), 
has offset 6 (48 bytes), and no flag set.
Third fragment starts with 0x4F (60 bytes IP header), it's 324 bytes long 
(IPH (60) + UDPH + 256),
has offset 0 and MF set. 

All packets being sent share the same ID. 

The aforementioned packets get sent in a loop for variable number of times 
(500 by default). 

The buggy line in ip_fragment.c was:
if (fp->len < 0 || count+fp->len > skb->len) 

That line was replaced by:
if (fp->len < 0 || fp->offset+qp->ihlen+fp->len > skb->len) 

you can see nestea.c at 
http://www.insecure.org/sploits/linux.PalmOS.nestea.html
and patched ip_fragment.c at 
http://lxr.linux.no/source/net/ipv4/ip_fragment.c?v=2.0.39#L325 

Here's what I fail to grasp:
skb->len is (qp->ihlen + qp->len) so it already takes into account IP header 
length when allocating memory.
fp->len is just the length of the fragment.
How does the "wrong" line fail? How can you memcpy more stuff than you 
should? The only thing I can think of is that qp->ihlen changes its value 
from 20 to 60 bytes along the way, so you allocate 20 and try to copy 60 
bytes. But this is just an idea, I can't find it in the code. 

The author of nestea describe the problem in this terms: 

<PROBLEM>
There is a certain function (ip_glue) in the linux kernel that attempts to
reassemble a fragmented datagram before passing it up to the upper layers of
the ip stack. This function will determine if any particular fragment goes 
past
the allocated memory for the total buffer or has been miscalculated due to
errors or oversights in the initial assembly code. The comparison statement 
in
the linux kernels forgot to take into account the size of the ip header. 
Since an
ip header can reach up to 60 bytes, an attacker is able to write over 60 
bytes
in the kernel, and probably cause a system crash.
</PROBLEM> 


For some stupid hardware problem I can't install 2.0.33 myself and 
printk-ing it. 

Note: please do CC me in your reply (if you reply!), I'm not a subscriber. 
Thank you for understanding. 

Thank you for your time, 

 alfonso 

