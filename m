Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267168AbUGMWUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267168AbUGMWUx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 18:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267171AbUGMWUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 18:20:53 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:42675 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S267168AbUGMWUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 18:20:32 -0400
From: jmerkey@comcast.net
To: linux-kernel@vger.kernel.org
Cc: jmerkey@drdos.com
Subject: af_packet.c -ERRMSGSIZE logic error for VLAN Support
Date: Tue, 13 Jul 2004 22:20:27 +0000
Message-Id: <071320042220.5497.40F4602B0006FC4B000015792200758942970A059D0A0306@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Jun 24 2004)
X-Authenticated-Sender: am1lcmtleUBjb21jYXN0Lm5ldA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I guess a RAW packet interface needs to really be just that.  The af_packet.c logic is broken
with VLAN tagging.  When I attempt to regenerate packets through ethernet with 
AF_PACKET calls via sockaddr_ll request structures, the calculation being performed in
af_packet of:

err = -ERRMSGSIZE
if (len > (dev->mtu + dev->hard_header_len))
    goto out_unlock;

...
..

return err;

This is busted with VLAN tags.  I am sending packets out of the max length of 1514 with the
additional 4 bytes of VLAN info attached.  I am received packets of this size from the 
e1000 adapters (1518) from one side of the system and when I attempt to resend them 
via af_packet.c through another e1000 adapter with the ame driver code, it bombs since the packet is larger than the mtu (1500) + dev->hard_header_len (14).  A RAW packet interface needs to really be raw, and this includes taking into account the size of a VLAN header.  I realize this is a driver error since the driver returns these fields from the net_device structure, but it doesn't make much sense for a driver to enforce these limits in raw mode.  

manipulation of VLAN tags should be allowed through a raw interface, and the logic in 
af_packet.c is what is creating the error.  If this an error in the logic or is there some other
method recommended for dealing with the VLAN tagging info.

I would assume for IP and other types of sockets, some sort of sideband is ok for tagging 
the packets, but a raw interface should allow raw packet construction and transmission.

Jeff




