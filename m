Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbVLNPX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbVLNPX2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 10:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbVLNPX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 10:23:28 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:28390 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932161AbVLNPX2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 10:23:28 -0500
Subject: Serial: bug in 8250.c when handling PCI or other level triggers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 14 Dec 2005 15:23:23 +0000
Message-Id: <1134573803.25663.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The receive_chars function is designed to handle the case where the port
is jammed full on by aborting after 256 characters in one IRQ.
Unfortunately the author of this code forgot that some systems are level
triggered. On these systems the IRQ simply gets invoked again and the
count loop just makes the problem take longer to clear.

In the non level case it appears that a jam could leave the IRQ jammed
forever and ignored - the remaining bytes never appearing.

As far as I can see the code would actually need to clear the interrupt
enable and then restore it on a timer event or similar in order to get
the intended effect.

Alan

