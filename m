Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932645AbVJCTLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932645AbVJCTLZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 15:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932642AbVJCTLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 15:11:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47840 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932626AbVJCTLX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 15:11:23 -0400
Message-ID: <43418238.1030000@cs.wisc.edu>
Date: Mon, 03 Oct 2005 14:10:48 -0500
From: Mike Christie <michaelc@cs.wisc.edu>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Luben Tuikov <luben_tuikov@adaptec.com>
CC: Jeff Garzik <jgarzik@pobox.com>, Andre Hedrick <andre@linux-ide.org>,
       "David S. Miller" <davem@davemloft.net>, willy@w.ods.org,
       patmans@us.ibm.com, ltuikov@yahoo.com, linux-kernel@vger.kernel.org,
       akpm@osdl.org, torvalds@osdl.org, linux-scsi@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <Pine.LNX.4.10.10509300015100.27623-100000@master.linux-ide.org> <433D8542.1010601@adaptec.com> <433DD0F8.4000501@pobox.com> <43413CE8.1090306@adaptec.com>
In-Reply-To: <43413CE8.1090306@adaptec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luben Tuikov wrote:
> On 09/30/05 19:57, Jeff Garzik wrote:
> 
>>Luben Tuikov wrote:
>>
>>
>>>MPT-based drivers + James Bottomley's "transport attributes"
>>
>>
>>You continue to fail to see that a transport class is more than just 
>>transport attributes.
>>
>>You continue to fail to see that working on transport class support IS a 
>>transport layer, that includes management.
>>
>>Is you don't understand this fundamental stuff, how can we expect you to 
>>get it right?
> 
> 
>>From what I see, because of its *layering* position
> JB's "transport attributes" cannot satisfy open transport.
> 
> The reason is that MPT-based drivers indeed do need host template
> in the LLDD.
> 
> Open Transport (SBP/USB/SAS) do not, since the chip is only
> an interface to the transport.
> 
> The host template is implemented by a transport layer,
> say USB Storage or the SAS Transport Layer.
> 

I think I can understand some of Luben's reasons for the layering. We 
are facing similar problems with software iscsi and hw iscsi. For 
software iscsi it would be nice to consolodate some of the common 
software iscsi code into a layer or lib. Following Luben's path for 
example our queuecommand would be:

scsi-ml -> scsi_host_template->queuecommand -> iscsi transport common 
queuecommand (do things like check session state, that we are not in 
session level recovery, scsi to iscsi pdu prep like setting the data 
direction, and other iSCSI PDU prep) -> iscsi_transport module -> 
iscsi_transport->queuepdu (you can probably reccomend a better name) -> 
tcp, sctp, iwarp, or some iSCSI HW that exposes a iSCSI interface rather 
than SCSI (note that qla4xxx would use its own 
scsi_host_template->queuecommand since it does not expose enough iSCSI 
internals for it to be useful to plug in here).

However, HW iscsi cards and software/partial-software iscsi solutions 
can share code for things like session and connection creation where we 
would have transport class lib functions: 
iscsi_add_session/iscsi_remove_session which both the HW iscsi cards 
like qla4xxx and software/partial-software iscsi drivers could use to 
setup things like a common sysfs representation. 
iscsi_add_session/iscsi_remove_session would work similar to the 
fc_rport code where the midlayer doesn't really know they exist (this is 
similar to our session and connection code today but it is bound to the 
scsi host which prevents qla4xxx from using it).

Is the direction we are going where iscsi would have to put the "iscsi 
transport common queuecommand" code into something similar to libata? Or 
  is it that Luben's transport layer code is performing something 
different than software/partial-software iscsi?
