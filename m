Return-Path: <linux-kernel-owner+w=401wt.eu-S1751229AbXALNUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbXALNUQ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 08:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbXALNUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 08:20:16 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:28765 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229AbXALNUO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 08:20:14 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=MrDJARviokGllotKY8q/17PSji/K0A5JylkG5GaAyiFAUiH1zbXDT8fNHFIW9XyaTM0YEZqm7kSUMNxGDpMx08yExYuIMeN3UT9AoPctVHjbSPrKxXCR2imE0h3dbY2WFPS7rNjAD0hjMrwQnCsMsOl5ixrUhl/sdmiA5NMlu1c=
Date: Fri, 12 Jan 2007 13:18:00 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       drzeus@drzeus.cx
Subject: Re: 2.6.20-rc4-mm1
Message-ID: <20070112131800.GE5941@slug>
References: <20070111222627.66bb75ab.akpm@osdl.org> <200701121125.58794.m.kozlowski@tuxland.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701121125.58794.m.kozlowski@tuxland.pl>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2007 at 11:25:58AM +0100, Mariusz Kozlowski wrote:
> Hello,
> 
> 	Doesn't build on my laptop.
> 
> drivers/mmc/mmc.c: In function 'mmc_lock_unlock':
> drivers/mmc/mmc.c:1527: error: dereferencing pointer to incomplete type
> drivers/mmc/mmc.c:1527: warning: type defaults to 'int' in declaration of '_________p1'
> drivers/mmc/mmc.c:1527: error: dereferencing pointer to incomplete type
> drivers/mmc/mmc.c:1527: warning: assignment makes pointer from integer without a cast
> make[2]: *** [drivers/mmc/mmc.o] Error 1
> make[1]: *** [drivers/mmc] Error 2
> make: *** [drivers] Error 2
> 
Hi,

That's because mmc_lock_unlock should depend on CONFIG_KEYS, it uses struct key.
Could you try the following patch (compile tested)?

Regards,
Frederik

Signed-off-by: Frederik Deweerdt <frederik.deweerdt@gmail.com>

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index 3956023..c1fe01d 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -1503,6 +1503,8 @@ static void mmc_setup(struct mmc_host *h
 		mmc_process_ext_csds(host);
 }
 
+#ifdef CONFIG_MMC_PASSWORDS
+
 /**
  *	mmc_lock_unlock - send LOCK_UNLOCK command to a specific card.
  *	@card: card to which the LOCK_UNLOCK command should be sent
@@ -1617,6 +1619,8 @@ out:
 	return err;
 }
 
+#endif /* CONFIG_MMC_PASSWORDS */
+
 /**
  *	mmc_detect_change - process change of state on a MMC socket
  *	@host: host which changed state.
