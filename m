Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262707AbTELVYU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 17:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262718AbTELVYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 17:24:20 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:2861 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S262707AbTELVYS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 17:24:18 -0400
Subject: PCMCIA 2.5.X sleeping from illegal context
From: Paul Fulghum <paulkf@microgate.com>
To: David Hinds <dahinds@users.sourceforge.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1052775331.1995.49.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 12 May 2003 16:35:32 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 2.5.X PCMCIA kernel support seems to have a problem
with drivers/pcmcia/rsrc_mgr.c in function undo_irq().

This function is called from pcmcia_release_irq() in
drivers/pcmcia/cs.c

pcmcia_release_irq() is called by individual drivers
when releasing resources.

When a device gets a CS_EVENT_CARD_REMOVAL event from
cs.c, the device sets a timer to call the release
function defined in the device driver to release resources.
This is the convention used with all PCMCIA drivers I
can see.

The release timer function is running in a context where it
is illegal to call a sleeping function.

undo_irq() has added semaphore calls down(rsrc_sem)/up(rsrc_sem)
in 2.5.X which generates the kernel 'sleeping function called
from illegal context at include/asm/semaphore.h' message.

So, are all the PCMCIA drivers supposed to be changed to not
release resources in the timer context? And if so, what
is the new convention?

Or should the synchronization used in undo_irq() be
changed to something that is legal from a timer context.


Thanks,
Paul

-- 
Paul Fulghum, paulkf@microgate.com
Microgate Corporation, http://www.microgate.com


