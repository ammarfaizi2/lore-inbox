Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264403AbTFKMiL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 08:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264412AbTFKMiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 08:38:11 -0400
Received: from pop.gmx.net ([213.165.64.20]:31661 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264403AbTFKMiK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 08:38:10 -0400
Message-ID: <3EE725E2.C1261794@gmx.de>
Date: Wed, 11 Jun 2003 14:51:46 +0200
From: Edgar Toernig <froese@gmx.de>
MIME-Version: 1.0
To: Krzysztof Halasa <khc@pm.waw.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: select for UNIX sockets?
References: <MDEHLPKNGKAHNMBLJOLKOEKFDIAA.davids@webmaster.com>
		<m3isredh4e.fsf@defiant.pm.waw.pl> <3EE5DE7E.4090800@techsource.com> <m3k7buxbbr.fsf@defiant.pm.waw.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa wrote:
> 
> Timothy Miller <miller@techsource.com> writes:
> 
> > If you were to use blocking writes, and you sent too much data, then
> > you would block.  If you were to use non-blocking writes, then the
> > socket would take as much data as it could, then return from write()
> > with an indication of how much data actually got sent.  Then you call
> > select() again so as to wait for your next opportunity to send some
> > more of your data.
> 
> This is all true in general but in this particular case of unix datagram
> sockets select (poll) is just buggy.

Do you want to install a magic crystal ball in the kernel? :-)

For select to properly block on write it has to know the destination of
the write.  For unconnected sockets you haven't told the destination.
There's know way for the kernel to know at select time which receiver
to check for free space.

You were talking about a "send queue".  I guess you think it should
work like: if destination has enough room move data to destination
else queue it in the send queue.  Then select would check whether the
*send queue* has enough space for another packet.  But that would mean
that a single slow receiver would block all others.  I.e. /tmp/a is
slow; you fill the queue; select blocks even when you actually want to
send to /tmp/b which has plenty of space.

Ciao, ET.
