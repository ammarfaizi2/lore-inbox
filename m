Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750888AbWDTOda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbWDTOda (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 10:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbWDTOda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 10:33:30 -0400
Received: from emulex.emulex.com ([138.239.112.1]:52710 "EHLO
	emulex.emulex.com") by vger.kernel.org with ESMTP id S1750726AbWDTOd3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 10:33:29 -0400
Message-ID: <44479BA8.1000405@emulex.com>
Date: Thu, 20 Apr 2006 10:33:12 -0400
From: James Smart <James.Smart@Emulex.Com>
Reply-To: James.Smart@Emulex.Com
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Mike Christie <michaelc@cs.wisc.edu>
CC: linux-scsi@vger.kernel.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Netlink and user-space buffer pointers
References: <1145306661.4151.0.camel@localhost.localdomain> <20060418160121.GA2707@us.ibm.com> <444633B5.5030208@emulex.com> <4446AC80.6040604@cs.wisc.edu>
In-Reply-To: <4446AC80.6040604@cs.wisc.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Apr 2006 14:33:13.0338 (UTC) FILETIME=[5ACCEDA0:01C66487]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mike Christie wrote:
> For the tasks you want to do for the fc class is performance critical?

No, it should not be.

> If not, you could do what the iscsi class (for the netdev people this is
> drivers/scsi/scsi_transport_iscsi.c) does and just suffer a couple
> copies. For iscsi we do this in userspace to send down a login pdu:
> 
> 	/*
> 	 * xmitbuf is a buffer that is large enough for the iscsi_event,
> 	 * iscsi pdu (hdr_size) and iscsi pdu data (data_size)
> 	 */

Well, the real difference is that the payload of the "message" is actually
the payload of the SCSI command or ELS/CT Request. Thus, the payload may
range in size from a few hundred bytes to several kbytes (> 1 page) to
Mbyte's in size. Rather than buffer all of this, and push it over the socket,
thus the extra copies - it would best to have the LLDD simply DMA the
payload like on a typical SCSI command.  Additionally, there will be
response data that can be several kbytes in length.

> ... I think there may be issues with packing structs or 32 bit
> userspace and 64 bit kernels and other fun things like this so the iscsi
> pdu and iscsi event have to be defined correctly and I guess we are back
> to some of the problems with ioctls :(

Agreed. In this use of netlink, there's not a lot of wins for netlink over
ioctls. It all comes down to 2 things: a) proper portable message definition;
and b) what do you do with that non-portable user space buffer pointer ?

-- james s
