Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbWDSVc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbWDSVc4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 17:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWDSVc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 17:32:56 -0400
Received: from sabe.cs.wisc.edu ([128.105.6.20]:6027 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S1751166AbWDSVcx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 17:32:53 -0400
Message-ID: <4446AC80.6040604@cs.wisc.edu>
Date: Wed, 19 Apr 2006 16:32:48 -0500
From: Mike Christie <michaelc@cs.wisc.edu>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: James.Smart@Emulex.Com
CC: linux-scsi@vger.kernel.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Netlink and user-space buffer pointers
References: <1145306661.4151.0.camel@localhost.localdomain> <20060418160121.GA2707@us.ibm.com> <444633B5.5030208@emulex.com>
In-Reply-To: <444633B5.5030208@emulex.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Smart wrote:
> Folks,
> 
> To take netlink to where we want to use it within the SCSI subsystem (as
> the mechanism of choice to replace ioctls), we're going to need to pass
> user-space buffer pointers.
> 
> What is the best, portable manner to pass a pointer between user and kernel
> space within a netlink message ?  The example I've seen is in the iscsi
> target code - and it's passed between user-kernel space as a u64, then
> typecast to a void *, and later within the bio_map_xxx functions, as an
> unsigned long. I assume we are going to continue with this method ?
> 

I do not know if it is needed. For the target code, we use the
bio_map_xxx to avoid having to copy the command data which is needed for
decent performance. We have also been trying to figure out ways of
getting out of using netlink to send the command info (cdb, tag info,
etc) around, because in some of Tomo's tests using mmaped packet sockets
he was able to imporove performance by removing that copy from the
kernel to userspace. We had problems with that though and other nice
interfaces like relayfs only allowed us to pass data from the kernel to
userspace so we still need another interface to pass things from
userspace to the kernel. Still working on this though. If someone knows
a interface please let us know.

For the tasks you want to do for the fc class is performance critical?
If not, you could do what the iscsi class (for the netdev people this is
drivers/scsi/scsi_transport_iscsi.c) does and just suffer a couple
copies. For iscsi we do this in userspace to send down a login pdu:

	/*
	 * xmitbuf is a buffer that is large enough for the iscsi_event,
	 * iscsi pdu (hdr_size) and iscsi pdu data (data_size)
	 */
        memset(xmitbuf, 0, sizeof(*ev) + hdr_size + data_size);
        xmitlen = sizeof(*ev);
        ev = xmitbuf;
        ev->type = ISCSI_UEVENT_SEND_PDU;
        ev->transport_handle = transport_handle;
        ev->u.send_pdu.sid = sid;
        ev->u.send_pdu.cid = cid;
        ev->u.send_pdu.hdr_size = hdr_size;
        ev->u.send_pdu.data_size = data_size;

then later we do sendmsg()to send down the xmitbuf to the kernel iscsi
driver. I think there may be issues with packing structs or 32 bit
userspace and 64 bit kernels and other fun things like this so the iscsi
pdu and iscsi event have to be defined correctly and I guess we are back
to some of the problems with ioctls :(
