Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311574AbSCNJyn>; Thu, 14 Mar 2002 04:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311575AbSCNJye>; Thu, 14 Mar 2002 04:54:34 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52231 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S311574AbSCNJyR>;
	Thu, 14 Mar 2002 04:54:17 -0500
Message-ID: <3C90733B.4020205@mandrakesoft.com>
Date: Thu, 14 Mar 2002 04:54:03 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@redhat.com>
CC: "David S. Miller" <davem@redhat.com>, whitney@math.berkeley.edu,
        rgooch@ras.ucalgary.ca, linux-kernel@vger.kernel.org,
        marcelo@conectiva.com.br
Subject: Re: [patch] ns83820 0.17 (Re: Broadcom 5700/5701 Gigabit Ethernet Adapters)
In-Reply-To: <200203110205.g2B25Ar05044@adsl-209-76-109-63.dsl.snfc21.pacbell.net> <20020310.180456.91344522.davem@redhat.com> <20020310212210.A27870@redhat.com> <20020310.183033.67792009.davem@redhat.com> <20020312004036.A3441@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:

>A day's tweaking later, and I'm getting 810mbit/s with netperf between 
>two Athlons with default settings (1500 byte packets).  What I've found 
>is that increasing the size of the RX/TX rings or the max sizes of the 
>tcp r/wmem backlogs really slows things down, so I'm not doing that 
>anymore.  The pair of P3s shows 262mbit/s (up from 67).
>
>Interrupt mitigation is now pretty stupid, but it helped: the irq 
>handler disables the rx interrupt and then triggers a tasklet to run 
>through the rx ring.  The tasklet later enables rx interrupts again.  
>More tweaking tomorrow...
>
>Marcelo, please apply the patch below to the next 2.4 prepatch: it 
>also has a fix for a tx hang problem, and a few other nasties.  Thanks!
>

Comments:

1) What were the test conditions leading to your decision to decrease 
the RX/TX ring count?  I'm not questioning the decision, but looking to 
be better informed...  other gigabit drivers normally have larger rings. 
 I also wonder if the slowdown you see could be related to a small-sized 
FIFO on the natsemi chips, that would probably not be present on other 
gigabit chips.

2) PCI latency timer is set with pci_set_master(), as in:  if it's not 
correctly set, fix it up.  If it's correctly set, leave it alone and let 
the user tune in BIOS Setup.

3) Seeing "volatile" in your code.  Cruft?  volatile's meaning change in 
recent gcc versions implies to me that your code may need some addition 
rmb/wmb calls perhaps, which are getting hidden via the driver's 
dependency on a compiler-version-specific implementation of "volatile."

4) Do you really mean to allocate memory for "REAL_RX_BUF_SIZE + 16"? 
 Why not plain old REAL_RX_BUF_SIZE?

5) Random question, do you call netif_carrier_{on,off,ok} for link 
status manipulation?  (if not, you should...)

6) skb_mangle_for_davem is pretty gross...  curious: what sort of NIC 
alignment restrictions are there on rx and tx buffers (not descriptors)? 
 None? 32-bit?  Ignore CPU alignment for a moment here...

7) What are the criteria for netif_wake_queue?  If you are waking when 
the TX is still "mostly full" you probably generate excessive wakeups...

8) There is no cabal.


