Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161336AbWJSGbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161336AbWJSGbu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 02:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161339AbWJSGbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 02:31:49 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:15332
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1161336AbWJSGbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 02:31:48 -0400
Date: Wed, 18 Oct 2006 23:31:02 -0700 (PDT)
Message-Id: <20061018.233102.74754142.davem@davemloft.net>
To: eiichiro.oiwa.nm@hitachi.com
CC: alan@redhat.com, jesse.barnes@intel.com, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: pci_fixup_video change blows up on sparc64
From: David Miller <davem@davemloft.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This change in 2.6.19-GIT:

commit b5e4efe7e061ff52ac97b9fa45acca529d8daeea
Author: eiichiro.oiwa.nm@hitachi.com <eiichiro.oiwa.nm@hitachi.com>
Date:   Thu Sep 28 13:55:47 2006 +0900

    PCI: Turn pci_fixup_video into generic for embedded VGA

breaks sparc64 with ATI Radeon and ATY128 cards.

The problem is that there is no system rom at 0xc0000 on sparc64, and
therefore nothing copies the VGA bios of the graphics card there on
bootup.  Therefore all of this code is bogus and will just result in
bus errors when the Radeon or ATY128 driver tries to pci_map_rom() and
read the graphics card ROM.  Nothing will respond to accesses at the
0xc0000 region on sparc64.

The existence of a primary video ROM at 0xc0000 is quite platform
specific.  If some non-x86 systems have this too, that's great.
However, assuming all systems do is not correct.
