Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262835AbRFMKge>; Wed, 13 Jun 2001 06:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263080AbRFMKgW>; Wed, 13 Jun 2001 06:36:22 -0400
Received: from ns.suse.de ([213.95.15.193]:15635 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S262835AbRFMKgJ>;
	Wed, 13 Jun 2001 06:36:09 -0400
To: Mark Hayden <mark@northforknet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux networking and disk IO issues
In-Reply-To: <3B1BB85B.360CE0F6@northforknet.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
In-Reply-To: Mark Hayden's message of "4 Jun 2001 20:17:03 +0200"
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
Date: 13 Jun 2001 12:36:06 +0200
Message-ID: <oupelsoll9l.fsf@pigdrop.muc.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[this time with l-k cc]

Mark Hayden <mark@northforknet.com> writes:

> * The Linux networking stack requires all skbuff buffers to be
>   contiguous.  As far as I can tell, this makes it impossible to
>   write high-bandwidth UDP applications on Linux.  For instance, the
>   kernel will drop a fragmented 8KB message if it cannot allocate 8KB
>   of contiguous memory to reassemble it into.  I have found that it
>   is relatively easy to enter regimes where this can cause massive
>   packet loss.

2.4.4+ supports fragmented packets and packet lists.

You're probably seeing the 8K allocation problem for incoming packets which need to be
allocated by the driver on interrupt time with GFP_ATOMIC. GFP_ATOMIC memory is limited.
The 2.4 VM unfortunately has no way to keep more GFP_ATOMIC free ATM and tune for heavy
interrupt load (2.2 allowed this by increasing the freepages sysctl). Hopefully this VM bug 
will be fixed in the not too far future.

A workaround in the driver would be to use the 2.4.4 fragmented buffers 
(of course you'll still run into GFP_ATOMIC limits without manual tuning)
or allocate RX memory from a thread with GFP_KERNEL.



-Andi
