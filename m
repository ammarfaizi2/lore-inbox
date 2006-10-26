Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422775AbWJZCU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422775AbWJZCU7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 22:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965294AbWJZCTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 22:19:11 -0400
Received: from isilmar.linta.de ([213.239.214.66]:32223 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S965289AbWJZCTE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 22:19:04 -0400
Date: Wed, 25 Oct 2006 22:13:22 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-pcmcia@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, kaustav.majumdar@wipro.com
Subject: [RFC PATCH 3/11] pcmcia: update alloc_io_space for conflict checking for multifunction PC card
Message-ID: <20061026021322.GD20473@dominikbrodowski.de>
Mail-Followup-To: linux-pcmcia@lists.infradead.org,
	linux-kernel@vger.kernel.org, kaustav.majumdar@wipro.com
References: <20061026021027.GA20473@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061026021027.GA20473@dominikbrodowski.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaustav Majumdar <kaustav.majumdar@wipro.com>
Date: Fri, 20 Oct 2006 14:44:09 -0700
Subject: [PATCH] pcmcia: update alloc_io_space for conflict checking for multifunction PC card

Some PCMCIA cards do not mention specific IO addresses in the CIS.  In that
case, inside the alloc_io_space function, conflicts are detected (the
function returns 1) for the second function of a multifunction card unless
the length of IO address range required is greater than 0x100.

The following patch will remove this conflict checking for a PCMCIA
function which had not mentioned any specific IO address to be mapped from.

The patch is tested for Linux kernel 2.6.15.4 and works fine in the above
case and is as suggested by Dave Hinds.

Signed-off-by: Kaustav Majumdar <kaustav.majumdar@wipro.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/pcmcia/pcmcia_resource.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pcmcia/pcmcia_resource.c b/drivers/pcmcia/pcmcia_resource.c
index 74cebd4..b9201c2 100644
--- a/drivers/pcmcia/pcmcia_resource.c
+++ b/drivers/pcmcia/pcmcia_resource.c
@@ -95,7 +95,7 @@ static int alloc_io_space(struct pcmcia_
 	 * potential conflicts, just the most obvious ones.
 	 */
 	for (i = 0; i < MAX_IO_WIN; i++)
-		if ((s->io[i].res) &&
+		if ((s->io[i].res) && *base &&
 		    ((s->io[i].res->start & (align-1)) == *base))
 			return 1;
 	for (i = 0; i < MAX_IO_WIN; i++) {
-- 
1.4.3

