Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262576AbTHaKkK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 06:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262610AbTHaKkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 06:40:10 -0400
Received: from AMontsouris-108-1-27-240.w81-49.abo.wanadoo.fr ([81.49.162.240]:42112
	"EHLO paldrick.research.newtrade.nl") by vger.kernel.org with ESMTP
	id S262576AbTHaKkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 06:40:04 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: Fredrik Noring <noring@nocrew.org>
Subject: Re: 2.6.0-test4: uhci-hcd.c: "host controller process error", slab call trace
Date: Sun, 31 Aug 2003 12:40:55 +0200
User-Agent: KMail/1.5.1
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Alan Stern <stern@rowland.harvard.edu>,
       Johannes Erdfelt <johannes@erdfelt.com>,
       linux-usb-devel@lists.sourceforge.net
References: <1062281812.3378.50.camel@h9n1fls20o980.bredband.comhem.se> <200308310136.02093.baldrick@wanadoo.fr> <1062323761.3036.31.camel@h9n1fls20o980.bredband.comhem.se>
In-Reply-To: <1062323761.3036.31.camel@h9n1fls20o980.bredband.comhem.se>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200308311240.55716.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 31 August 2003 11:56, Fredrik Noring wrote:
> sön 2003-08-31 klockan 01.36 skrev Duncan Sands:
> > Does the attached patch help?
>
> Yes, I did some quick tests and the "host controller" error appears to
> be gone. Thanks! There are a few other problems, probably unrelated to
> this patch:

Yes, they seem unrelated.  I don't know anything about bluetooth, sorry.

By the way, let me explain what the problem was with uhci-hcd.  The usb
hardware directly accesses your computers memory.  The bug is that it
could still be accessing a bit of memory after uhci-hcd thought it had
finished with it and freed up the memory.  This bug has always existed,
and I guess led to occasional mysterious data corruption, when some
other part of the kernel started using that bit of memory while the usb
hardware was still playing with it.  You turned on the "slab debugging"
option, right?  With this turned on, when uhci-hcd frees the memory it
gets filled with some garbage values.  The usb hardware reads this
garbage and barfs, giving a "process error".  In short, you can also
get rid of the process error messages by turning off slab debugging,
then the data corruption will be silent again!

> 1. Broadcom Bluetooth USB device initialization is unreliable. When it
>    fails, the following is logged. Rebooting the system and trying again
>    helps.
>
>  /etc/hotplug/usb.agent: Setup bluefw for USB product a5c/2033/a0
>  /etc/hotplug/usb.agent: Module setup bluefw for USB product a5c/2033/a0
>  bluefw[3079]: Loading firmware to usb device 0a5c:2033
>  kernel: usb 1-2: bulk timeout on ep1in
>  bluefw[3079]: Intr read #1 failed. Connection timed out (110)
>  usbfs: USBDEVFS_BULK failed dev 3 ep 0x81 len 10 ret -110
>
> 2. The system sometimes locks up in a complete freeze when an external
>    Bluetooth device tries to connect. I'm not sure what happens and the
>    only message I've seen is this and it might be unrelated:
>
>  dund[3932]: MSDUN failed. Protocol error(71)
>
> 3. The following messages are still logged:
>
>  kernel: l2cap_recv_acldata: Frame is too short (len 1)
>  kernel: l2cap_recv_acldata: Unexpected continuation frame (len 124)
>  kernel: l2cap_recv_acldata: Unexpected continuation frame (len 102)
>
> 	Fredrik

Duncan.
