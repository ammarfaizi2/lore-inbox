Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992682AbWKARJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992682AbWKARJN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 12:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992677AbWKARJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 12:09:13 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:9616 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1752148AbWKARJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 12:09:11 -0500
Message-ID: <4548D478.2080704@sgi.com>
Date: Wed, 01 Nov 2006 11:08:08 -0600
From: John Partridge <johnip@sgi.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Macintosh/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: Roland Dreier <rdreier@cisco.com>,
       "Richard B. Johnson" <jmodem@AbominableFirebug.com>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, jeff@garzik.org, openib-general@openib.org,
       linux-pci@atrey.karlin.mff.cuni.cz, David Miller <davem@davemloft.net>
Subject: Re: Ordering between PCI config space writes and MMIO reads?
References: <adar6wxbcwt.fsf@cisco.com> <20061024223631.GT25210@parisc-linux.org> <20061024.154347.77057163.davem@davemloft.net> <aday7r4a3d7.fsf@cisco.com> <adad588tijq.fsf@cisco.com> <20061031195312.GD5950@mellanox.co.il> <019301c6fd2c$044d7010$0732700a@djlaptop> <20061031204717.GG26964@parisc-linux.org> <ada4ptkt8y2.fsf@cisco.com> <4548CAE7.8010300@sgi.com> <20061101164643.GH11399@parisc-linux.org>
In-Reply-To: <20061101164643.GH11399@parisc-linux.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew,

So, if I understand correctly, you are saying because we cannot guarantee
the "flush" a config write even by doing a config read of the same register
(because the PPB can re-order) we have to make sure we block or spin on the
config write completion at the lowest level of the config write ?

Thanks
John

Matthew Wilcox wrote:
> On Wed, Nov 01, 2006 at 10:27:19AM -0600, John Partridge wrote:
> 
>>Sorry, but I find this change a bit puzzling. The problem is particular to
>>the PPB on the HCA and not Altix.
> 
> 
> That's not true; it's more likely on Altix, but it's not unique.  *any*
> PCI-PCI bridge can reorder pci config reads and writes.  Apparently the
> normal PCI host bridge implementation avoids this problem by blocking
> until the completion comes back.  If you put a quad-port tulip card into
> an Altix, you could experience the same problem (but it would be
> massively unlikely.  You'd probably have to bring up three interfaces,
> saturate them with traffic, then bring up the fourth to see it.  And
> even then it would be rare).
> 
> 
>>I can't see anywhere that a PCI Config 
>>Write
>>is required to block until completion, it is the driver and the HCA ,not the
>>Altix hardware that requires the Config Write to have completed before we
>>leave mthca_reset()
> 
> 
> There's several places in the PCI midlayer that require the config write
> to have completed before we do a config read.  The MWI code relies on
> this to see if the device supports MWI.  If it gets out of order, we'll
> think that the device doesn't support MWI when it thinks it's been told
> to use MWI.  Data corruption could result.
> 
> 
>>Changing pci_write_config_xxx() will change the behavior
>>for ALL drivers and the possibility of breaking something else. The fix was
>>very low risk in mthca_reset(), changing the PCI code to fix this is much
>>more onerous.
> 
> 
> I really don't think so.  At worst you'll be changing the timing.


-- 
John Partridge

Silicon Graphics Inc
Tel:	651-683-3428
Vnet:	233-3428
E-Mail:	johnip@sgi.com
