Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbUBRFiT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 00:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264446AbUBRFiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 00:38:19 -0500
Received: from mail1.webmaster.com ([216.152.64.168]:6406 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S262353AbUBRFiQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 00:38:16 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
Cc: "Hasso Tepper" <hasso@estpak.ee>
Subject: RE: raw sockets and blocking
Date: Tue, 17 Feb 2004 21:37:37 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKIEMGKHAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.58.0402180106150.1071@fogarty.jakma.org>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2055
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Tue, 17 Feb 2004 21:16:26 -0800
	(not processed: message from valid local sender)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> - a cable is pulled from an interface
> - the application tests the file descriptor to see if it ready for
>   writing, and finds it is.
> - the application constructs a packet to send out that interface
>   and sends it with sendmsg(), no error is posted.
> - the file descriptor never becomes available for writing again
> - hence, all OSPF adjacencies are lost, because we can no longer
> write out packets to the file descriptor.

	This is rational behavior.

> we havnt yet tested if it becomes writeable again if we put cable
> back in, however if we detect absence of IFF_RUNNING and hence
> manually avoid constructing packets to be sent via link-down
> interfaces, we avoid this problem. However, this leaves us with a
> race.

	I'm not sure I understand what the problem is. If the network cable is
disconnected, you couldn't usefully send anything if the socket was ready
anyway.

> Is this proper behaviour?

	Certainly.

> I'm guessing the driver or network layer is
> blocking the socket because it is waiting for the link to come back,
> however would it not be better to discard the packet, especially a
> raw packet?

	If you want to discard the packet, you do it. Why should the kernel accept
a packet just to discard it if it's smart enough to not accept it?

> (if it is "proper" behaviour that's fine, we can work with that, we
> were just surprised sendmsg() is trying to be /that/ reliable :) .)

	It is proper. Being always ready and dropping the packet is proper as well
but inferior.

	If you want the behavior you say you expect, consider the packet always
ready and if it's really not ready, drop the packet on the floor yourself.
This will get you the (inferior) behavior you want. How would it help you to
find the packet ready and send data the system will just drop on the floor?
Won't you lose your adjacencies anyway -- they'll time out either way).

	DS


