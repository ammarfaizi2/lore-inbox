Return-Path: <linux-kernel-owner+w=401wt.eu-S1762904AbWLKN0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762904AbWLKN0k (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 08:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762910AbWLKN0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 08:26:39 -0500
Received: from nz-out-0506.google.com ([64.233.162.229]:8443 "EHLO
	nz-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1762907AbWLKN0i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 08:26:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=d6T+xbHYPwdS1QkNYfGDDZ1pyWO6z6vkJ2Ajz/lthJOkWhASuDVZLsGqK9WExe58mrbkVQ9x6NV+srHNJLpnuFyhOzS6F5Z2cNoF+m2V5klyV2NYkpXP54IRz5uI98PPE6bXLTPkwXTMJpc0gPiP8KL0jbTrMc+lE4YwGccpyoE=
Date: Mon, 11 Dec 2006 22:26:25 +0900
From: Tejun Heo <htejun@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       Catalin Marinas <catalin.marinas@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] ata_piix: use piix_host_stop() in ich_pata_ops
Message-ID: <20061211132625.GA18947@htj.dyndns.org>
References: <b0943d9e0612091454j6df1fb0ej2fa006c3fa33abae@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0943d9e0612091454j6df1fb0ej2fa006c3fa33abae@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

piix_init_one() allocates host private data which should be freed by
piix_host_stop().  ich_pata_ops wasn't converted to piix_host_stop()
while merging, leaking 4 bytes on driver detach.  Fix it.

This was spotted using Kmemleak by Catalin Marinas.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Catalin Marinas <catalin.marinas@gmail.com>
---
diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index c7de0bb..dfe17e1 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -330,7 +330,7 @@ static const struct ata_port_operations ich_pata_ops = {
 
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
-	.host_stop		= ata_host_stop,
+	.host_stop		= piix_host_stop,
 };
 
 static const struct ata_port_operations piix_sata_ops = {
