Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbTGZSRB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 14:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266985AbTGZSRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 14:17:00 -0400
Received: from p4-7036.uk2net.com ([213.232.95.37]:33954 "EHLO
	uptime.churchillrandoms.co.uk") by vger.kernel.org with ESMTP
	id S261773AbTGZSQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 14:16:57 -0400
Subject: [2.6.0-test1] yenta_socket.c:yenta_get_status returns bad value
	compared to 2.4
From: Stefan Jones <cretin@gentoo.org>
To: linux-kernel@vger.kernel.org
Cc: Dominik Brodowski <linux@brodo.de>
Content-Type: text/plain
Organization: Gentoo Linux
Message-Id: <1059244318.3400.17.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 26 Jul 2003 19:31:59 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

It seems the the change from 2.4 to 2.6 made the state read from 
yenta_get_status change it's return value. It reads it from hardware.

The change in value has an effect later on which causes CB_CBCARD not to
be set, and thus SOCKET_CARDBUS not being set, this memory reads are
from the wrong ioport, locking up the machine.

Hardware:
00:0a.0 CardBus bridge: O2 Micro, Inc. OZ6912 Cardbus Controller
with a Netgear wireless card for testing.

see http://www.ussg.iu.edu/hypermail/linux/kernel/0307.3/0166.html 
for more info.

I added 

printk(KERN_DEBUG "yenta_get_status: status=%04x\n",state);

after the call 
u32 state = cb_readl(socket, CB_SOCKET_STATE);
in 
static int yenta_get_status(struct pcmcia_socket *sock, unsigned int
*value)
in drivers/pcmcia/yenta_socket.c

in both 2.4.21 and 2.6.0-test1

2.6.0-test1 gives: 30000411
2.4.21 gives:      30000419

I wonder why the values are different, and yet fairly close. It is
enough to give hard lockups ( I debugged this one with printk's and
commenting out code )

I have added 

state |= CB_CBCARD;

to the 2.6 kernel and that stops lockups, but I haven't yet tried
forcing the complete value.

What should I do, who should I contact, please advise. ( I am not a
kernel developer )

Stefan

