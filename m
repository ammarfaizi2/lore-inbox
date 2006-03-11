Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbWCKV5V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbWCKV5V (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 16:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbWCKV5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 16:57:21 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:8621
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1750713AbWCKV5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 16:57:19 -0500
Message-ID: <441347BA.5050408@microgate.com>
Date: Sat, 11 Mar 2006 15:57:14 -0600
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bob Copeland <email@bobcopeland.com>
CC: paulus@samba.org, Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.16-rc5 pppd oops on disconnects
References: <b6c5339f0603100625k3410897fy3515d93fa1918c9@mail.gmail.com>	 <1142011340.3220.4.camel@amdx2.microgate.com>	 <b6c5339f0603101048l1c362582xc4d2570bc9d569b@mail.gmail.com>	 <1142018709.26063.5.camel@amdx2.microgate.com>	 <20060311150908.GA4872@hash.localnet>	 <1142099765.3241.3.camel@x2.pipehead.org> <b6c5339f0603111221k2d0afce5hcfd485713ba17338@mail.gmail.com>
In-Reply-To: <b6c5339f0603111221k2d0afce5hcfd485713ba17338@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bob Copeland wrote:

 > dmesg follows...
 >
 > usb 1-2: USB disconnect, address 6
 > acm_disconnect intf=ce99f720 acm=ce24eca0 usb_dev=ce24f4b8
 > acm_disconnect acm->used=1 acm->dev=ce24f4b8 acm->tty=cd254af8
 > acm_disconnect intf=cefb6760 acm=00000000 usb_dev=ce24f4b8
 > acm_tty_close tty=cd254af8 filp=ce96511c acm=ce24eca0
 > acm_tty_close acm->used=1 acm->dev=00000000
 > Unable to handle kernel paging request at virtual address 6b6b6bfb

 > ...

 >  [<c017585e>] sysfs_hash_and_remove+0x34/0x10a


OK, the cdc-acm driver disconnect/close seems to behave correctly
as I first thought. tty_unregister_device is only called once. The reference
counting is correct. acm->tty still needs to be set to NULL on the final
close, but that is not the problem you are seeing.

I'm looking again at the sysfs stuff as both acm_disconnect
and tty_unregister_device (called from acm_tty_close) remove sysfs entries.
There may be some interaction of entries (name space
collision?) such that acm_disconnect releases a sysfs entry
that tty_unregister_device tries to release again (hence the slab poisoning
flagging a reference to already released memory). I'm not
familiar with this so it may take me a while.

Feel free to bug others about this, I don't mean to interfere
if someone else has a better idea.

Thanks for your persistence,
Paul








