Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265283AbUENNq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265283AbUENNq3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 09:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265281AbUENNq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 09:46:29 -0400
Received: from legolas.drinsama.de ([62.91.17.164]:13729 "EHLO
	legolas.drinsama.de") by vger.kernel.org with ESMTP id S265283AbUENNqX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 09:46:23 -0400
Subject: Bug in bridge interface removal?
From: Erich Schubert <erich@debian.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Debian GNU/Linux Developers
Message-Id: <1084542378.17594.12.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.7 
Date: Fri, 14 May 2004 15:46:19 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, on an embedded system i had a crash when doing the following
(invalid) sequence of commands:
Note that this is an outdated kernel, 2.4.19-uc1 with some
modifications; i'm not sure if this is maybe already fixed.

brctl addbr br0
brctl addbr br1
brctl addif br0 eth0
brctl delif br1 eth0
(causing a kernel crash after a second)

yes, i'm deleting the interface from the wrong bridge. Since this
requires root privileges, this isn't much of an "exploit" or so. But it
takes down the system reliably here (but it is an MMUless ARM, you can
take that one down really easy...)

Having a short look at the source i didn't see any safety measure in
http://lxr.linux.no/source/net/bridge/br_if.c#L254
(Neither in 2.4.x, nor in 2.6.x)

I'd suggest adding the following line to the beginning of br_del_if:

if (dev->br_port->br != br) return -EINVAL;

After adding this line i get
  device eth1 is not a slave of br0
instead of the reboot.

Greetings,
Erich

