Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264919AbUBSGYS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 01:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267281AbUBSGYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 01:24:18 -0500
Received: from hibernia.jakma.org ([212.17.55.49]:64660 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S264919AbUBSGYJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 01:24:09 -0500
Date: Thu, 19 Feb 2004 06:20:11 +0000 (GMT)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: David Schwartz <davids@webmaster.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Hasso Tepper <hasso@estpak.ee>
Subject: RE: raw sockets and blocking
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKIEMGKHAA.davids@webmaster.com>
Message-ID: <Pine.LNX.4.58.0402190557470.25392@fogarty.jakma.org>
References: <MDEHLPKNGKAHNMBLJOLKIEMGKHAA.davids@webmaster.com>
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Tue, 17 Feb 2004, David Schwartz wrote:

> 
> > - a cable is pulled from an interface
> > - the application tests the file descriptor to see if it ready for
> >   writing, and finds it is.
> > - the application constructs a packet to send out that interface
> >   and sends it with sendmsg(), no error is posted.
> > - the file descriptor never becomes available for writing again
> > - hence, all OSPF adjacencies are lost, because we can no longer
> > write out packets to the file descriptor.
> 
> 	This is rational behavior.

It might be yes. We're trying to determine this.

> 	I'm not sure I understand what the problem is. If the network cable is
> disconnected, you couldn't usefully send anything if the socket was ready
> anyway.

We could, the down interface is but one of many. Yet, the raw socket 
becomes write-blocked because of a packet sent destined to be sent 
out a down interface, for ever.

While I appreciate the kernel's best efforts, I feel it's possibly 
counter-productive to be so persistent for raw sockets :)

To work around this behaviour, we'll have to move from one single 
global file descriptor to one file descriptor per interface. Which is 
potentially a scaling overhead for the case of thousands of 
interfaces.

> If you want to discard the packet, you do it. Why should the kernel
> accept a packet just to discard it if it's smart enough to not
> accept it?

How can we discard it? It's sitting queued somewhere in the socket 
layer, and we're blocked from sending from /any/ interface simply 
because of a cable pull on one interface. 

We could set a 'write blocked' timer I guess, and close() and reopen 
our raw socket if we find our raw socket write-blocked for too long, 
but that would be a gross hack.

If the socket buffer were fill, fine, write-block for that. But
surely otherwise, for a _raw socket_ which specifically makes no
reliability, the socket should not get held up because a driver is
throttling the socket due to no-link.

This isnt a TCP socket, it's a raw socket - it's up to the process 
using the raw socket to implement it's own reliability and/or flow 
control, that's the precise point. Hence, the kernel should _not_.

> It is proper. Being always ready and dropping the packet is proper
> as well but inferior.

For a raw socket?

Surely the correct behaviour is to either return an error from
sendmsg() or else drop the packet if the driver is link-down?

> If you want the behavior you say you expect, consider the packet
> always ready and if it's really not ready, drop the packet on the
> floor yourself. This will get you the (inferior) behavior you want.

We cant drop it unfortunately. How do we do this? SO_SNDTIMEO is not 
settable on linux.

> How would it help you to find the packet ready and send data the
> system will just drop on the floor? Won't you lose your adjacencies
> anyway -- they'll time out either way).

We multiplex adjacencies on many interfaces via one file-descriptor.  
We're dropping adjencies on all interfaces because we sent a packet
destined to go out a link-down interface, which the kernel accepted 
_without_ returning an error[1].

1. Hasso will correct me if i'm wrong here I hope - Hasso, no error 
is reported from ospf_write() from sendmsg() is there?

> 	DS

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
	warning: do not ever send email to spam@dishone.st
Fortune:
Man invented language to satisfy his deep need to complain.
		-- Lily Tomlin
