Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030309AbWBTQXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030309AbWBTQXw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 11:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030307AbWBTQXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 11:23:51 -0500
Received: from relay01.roc.ny.frontiernet.net ([66.133.182.164]:10149 "EHLO
	relay01.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S1030304AbWBTQXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 11:23:50 -0500
Reply-To: <jbowler@acm.org>
From: John Bowler <jbowler@acm.org>
To: "'Adrian Bunk'" <bunk@stusta.de>
Cc: "'Martin Michlmayr'" <tbm@cyrius.com>,
       "'Alessandro Zummo'" <alessandro.zummo@towertech.it>,
       <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: RE: [RFC] [PATCH 1/2] Driver to remember ethernet MAC values: maclist
Date: Mon, 20 Feb 2006 08:23:41 -0800
Message-ID: <000201c6363a$042a1e30$1001a8c0@kalmiopsis>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
Importance: Normal
In-Reply-To: <20060220023900.GE4971@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk [mailto:bunk@stusta.de]
>Why can't setting MAC addresses be done from initramfs?

The submitted version of this code is actually an old version,
which has some potential locking problems and doesn't document
how to solve the problem of different drivers getting different
MAC ids.

This stuff *should* be done in the board level code, that should
load the MAC (somehow) and then set it into Ethernet driver resources
so that the (necessarily later) init of the Ethernet device can
pick up the correct address.

Unfortunately on some systems this (the use of machine level
resources in the board init code) is not possible because the
ethernet driver is in a module.  The *same* driver may be in kernel
on other systems.

This creates a combinatorial problem - dealing with *all* the
possibilities creates an enormous mess.  It doesn't matter where
the solution happens - boot loader, initramfs or kernel init - the
combinatorial problem is still there because there must be handling
for every combination which occurs in practice.

The problem is very much one of embedded systems.  In such systems
a generic board will have a specific manufacturing implementation
which stores the MAC in an implementation specific way.  E.g. a
vendor may drop the EEPROM from the Gateworks GW2348 board (that
EEPROM costs real money!) and put the MAC in somewhere else.  Gateworks
doesn't *document* a specific place to put the MAC (though they *do*
put it in the EEPROM).  The lack of documentation and the certainty of
variation in particular IHV uses of the board creates the problem.

maclist simply breaks the problem into two pieces:

1) store this MAC in a linked list.
2) read a MAC from a linked list.

It's a classic "Gordian Knot" problem...

I thought a linked list was pretty simple ;-)

The locking in this version of the code is *wrong*, my assumptions
were bogus and I don't think the code will work correctly on SMP
systems.

The latest version of the code includes significantly more 
documentation in the header file and makes the whole thing fail
safe.  Again this is an embedded system problem - the ethernet
may be the only thing on the system!  The newer code returns an
appropriate 'random' MAC if there isn't one available.  This makes
debugging into a tractable problem on systems with just the
ethernet.

The implementation is still a linked list, but insertion is locked
and checking is done to deal with the unavailable MAC case.  As in
the simple case the advantage is that common code is in just one
place, not replicated across multiple instances of board/driver
code.

John Bowler <jbowler@acm.org>

