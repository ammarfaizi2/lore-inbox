Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932501AbWBXVRG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501AbWBXVRG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 16:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932502AbWBXVRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 16:17:06 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:60709 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932501AbWBXVRE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 16:17:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=o/P1qXNaBsRaHPnhtA2dkkKBrjMCaIFaTi+cdEBh97u3LxEV2pLie6FmBzfTNyegRwa6HmNGBXIFTKyeUZWG2geHY9/N71+1g7tM4B7vL1HJFfPBacvlYdJviq7oMboMDbwUwoar9dU10QRUY4XraVmG+Yw4PKqPnKhGD1aardk=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Zach Brown <zab@zabbo.net>
Subject: Re: [PATCH 07/13] maestro3 vfree NULL check fixup
Date: Fri, 24 Feb 2006 22:17:21 +0100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200602242148.27855.jesper.juhl@gmail.com> <43FF7615.8020504@zabbo.net>
In-Reply-To: <43FF7615.8020504@zabbo.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602242217.21180.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 February 2006 22:09, Zach Brown wrote:
> Jesper Juhl wrote:
> > vfree() checks for NULL, no need to do it explicitly.
> 
> >  static void free_dsp_suspendmem(struct m3_card *card)
> >  {
> > -   if(card->suspend_mem)
> > -       vfree(card->suspend_mem);
> > +    vfree(card->suspend_mem);
> >  }
> 
> eh, I'd just get rid of the helper and call vfree() from both sites.
> 
makes perfect sense, I just looked for vfree use - should have checked more 
in-depth.

Here's an updated patch : 



Don't check pointers for NULL before calling vfree and get rid
of pointless helper function in sound/oss/maestro3.c


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 sound/oss/maestro3.c |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

--- linux-2.6.16-rc4-mm2-orig/sound/oss/maestro3.c	2006-02-24 19:25:49.000000000 +0100
+++ linux-2.6.16-rc4-mm2/sound/oss/maestro3.c	2006-02-24 22:12:27.000000000 +0100
@@ -2582,15 +2582,9 @@ static int alloc_dsp_suspendmem(struct m
 
     return 0;
 }
-static void free_dsp_suspendmem(struct m3_card *card)
-{
-   if(card->suspend_mem)
-       vfree(card->suspend_mem);
-}
 
 #else
 #define alloc_dsp_suspendmem(args...) 0
-#define free_dsp_suspendmem(args...) 
 #endif
 
 /*
@@ -2717,7 +2711,7 @@ out:
     if(ret) {
         if(card->iobase)
             release_region(pci_resource_start(pci_dev, 0), pci_resource_len(pci_dev, 0));
-        free_dsp_suspendmem(card);
+        vfree(card);
         if(card->ac97) {
             unregister_sound_mixer(card->ac97->dev_mixer);
             kfree(card->ac97);
@@ -2760,7 +2754,7 @@ static void m3_remove(struct pci_dev *pc
         }
 
         release_region(card->iobase, 256);
-        free_dsp_suspendmem(card);
+        vfree(card);
         kfree(card);
     }
     devs = NULL;



