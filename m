Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbWAZWyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbWAZWyn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 17:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbWAZWym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 17:54:42 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:3335 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751432AbWAZWyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 17:54:41 -0500
Date: Thu, 26 Jan 2006 23:54:40 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com, netdev@vger.kernel.org
Subject: [7/10] remove ISA legacy functions: drivers/net/lance.c
Message-ID: <20060126225439.GL3668@stusta.de>
References: <20060126223126.GD3668@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060126223126.GD3668@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

switch to ioremap()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/lance.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

aadde842b4976445ac101c6ed04986382988d035
diff --git a/drivers/net/lance.c b/drivers/net/lance.c
--- a/drivers/net/lance.c
+++ b/drivers/net/lance.c
@@ -464,20 +464,25 @@ static int __init lance_probe1(struct ne
 	static int did_version;			/* Already printed version info. */
 	unsigned long flags;
 	int err = -ENOMEM;
+	void __iomem *bios;
 
 	/* First we look for special cases.
 	   Check for HP's on-board ethernet by looking for 'HP' in the BIOS.
 	   There are two HP versions, check the BIOS for the configuration port.
 	   This method provided by L. Julliard, Laurent_Julliard@grenoble.hp.com.
 	   */
-	if (isa_readw(0x000f0102) == 0x5048)  {
+	bios = ioremap(0xf00f0, 0x14);
+	if (!bios)
+		return -ENOMEM;
+	if (readw(bios + 0x12) == 0x5048)  {
 		static const short ioaddr_table[] = { 0x300, 0x320, 0x340, 0x360};
-		int hp_port = (isa_readl(0x000f00f1) & 1)  ? 0x499 : 0x99;
+		int hp_port = (readl(bios + 1) & 1)  ? 0x499 : 0x99;
 		/* We can have boards other than the built-in!  Verify this is on-board. */
 		if ((inb(hp_port) & 0xc0) == 0x80
 			&& ioaddr_table[inb(hp_port) & 3] == ioaddr)
 			hp_builtin = hp_port;
 	}
+	iounmap(bios);
 	/* We also recognize the HP Vectra on-board here, but check below. */
 	hpJ2405A = (inb(ioaddr) == 0x08 && inb(ioaddr+1) == 0x00
 				&& inb(ioaddr+2) == 0x09);

