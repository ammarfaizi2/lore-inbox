Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbWEMVna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbWEMVna (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 17:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbWEMVna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 17:43:30 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:1337 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932309AbWEMVna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 17:43:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=tj4NBpcu/cxJnpf3r1yOv7yh+t+q5Uur5CzJjcrgbaymVPRmX0mzWi1G+Rt0UgVYivn/agtS3NpofK5stjmZmN3QNJgqFS24+lgv2bnvdPpLZBwOLFTdD0T7jCD8kJOmb2bL6MHQOUzGkpogPCA2GhX1ZQ45SiMJHQZZ9hVAFgM=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Jaroslav Kysela <perex@suse.cz>
Subject: [PATCH] Fix a memory leak in pdaudiocf
Date: Sat, 13 May 2006 23:44:25 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605132344.25862.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's a potential memory leak in 
sound/pcmcia/pdaudiocf/pdaudiocf.c::pdacf_config()

If we leave via one of the *failed: labels we may leak 'parse', so add a 
kfree(parse) to the end of the function and also make sure to set 'parse' 
to NULL after the kfree() call a little further up so we don't do a 
double-free of the pointer if we hit one of the *failed: labels after the 
first kfree().

Since I don't have the hardware I can't test the patch beyond making sure 
it compiles cleanly, but I feel pretty confident that it is correct.

Please consider for inclusion.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 sound/pcmcia/pdaudiocf/pdaudiocf.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

--- linux-2.6.17-rc4-git2-orig/sound/pcmcia/pdaudiocf/pdaudiocf.c	2006-05-13 21:28:55.000000000 +0200
+++ linux-2.6.17-rc4-git2/sound/pcmcia/pdaudiocf/pdaudiocf.c	2006-05-13 23:27:46.000000000 +0200
@@ -226,7 +226,7 @@ static int pdacf_config(struct pcmcia_de
 
 	snd_printdd(KERN_DEBUG "pdacf_config called\n");
 	parse = kmalloc(sizeof(*parse), GFP_KERNEL);
-	if (! parse) {
+	if (!parse) {
 		snd_printk(KERN_ERR "pdacf_config: cannot allocate\n");
 		return -ENOMEM;
 	}
@@ -242,6 +242,7 @@ static int pdacf_config(struct pcmcia_de
 	link->conf.ConfigBase = parse->config.base;
 	link->conf.ConfigIndex = 0x5;
 	kfree(parse);
+	parse = NULL;
 
 	CS_CHECK(RequestIO, pcmcia_request_io(link, &link->io));
 	CS_CHECK(RequestIRQ, pcmcia_request_irq(link, &link->irq));
@@ -257,6 +258,7 @@ cs_failed:
 	cs_error(link, last_fn, last_ret);
 failed:
 	pcmcia_disable_device(link);
+	kfree(parse);
 	return -ENODEV;
 }
 





PS. Please keep me on Cc when replying since I'm not subscribed to alsa-devel.

