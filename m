Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266471AbUBRBf4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 20:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266494AbUBRBf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 20:35:56 -0500
Received: from hibernia.jakma.org ([212.17.55.49]:9095 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S266471AbUBRBfy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 20:35:54 -0500
Date: Wed, 18 Feb 2004 01:33:44 +0000 (GMT)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Hasso Tepper <hasso@estpak.ee>
Subject: raw sockets and blocking
Message-ID: <Pine.LNX.4.58.0402180106150.1071@fogarty.jakma.org>
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm curious, is it good for raw sockets to block for writes because a 
cable of one interface has been pulled? 

We're seeing a problem with ospfd (www.zebra.org/www.quagga.net) 
which uses a single raw, AF_INET/OSPF socket and manages it's own IP 
headers, to send/receive OSPF packets to/from a number of interfaces.

The problem we see is that:

- a cable is pulled from an interface
- the application tests the file descriptor to see if it ready for 
  writing, and finds it is.
- the application constructs a packet to send out that interface
  and sends it with sendmsg(), no error is posted.
- the file descriptor never becomes available for writing again
- hence, all OSPF adjacencies are lost, because we can no longer 
write out packets to the file descriptor.

we havnt yet tested if it becomes writeable again if we put cable
back in, however if we detect absence of IFF_RUNNING and hence
manually avoid constructing packets to be sent via link-down
interfaces, we avoid this problem. However, this leaves us with a
race.

Is this proper behaviour? I'm guessing the driver or network layer is 
blocking the socket because it is waiting for the link to come back, 
however would it not be better to discard the packet, especially a 
raw packet?

(if it is "proper" behaviour that's fine, we can work with that, we 
were just surprised sendmsg() is trying to be /that/ reliable :) .)

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
	warning: do not ever send email to spam@dishone.st
Fortune:
How much net work could a network work, if a network could net work?
