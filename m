Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262339AbVCXAmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262339AbVCXAmH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 19:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262397AbVCXAmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 19:42:07 -0500
Received: from smtp808.mail.sc5.yahoo.com ([66.163.168.187]:1635 "HELO
	smtp808.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262339AbVCXAmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 19:42:00 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: drivers/input/touchscreen/gunze.c: gunze_process_packet: invalid array access
Date: Wed, 23 Mar 2005 19:41:57 -0500
User-Agent: KMail/1.7.2
Cc: vojtech@suse.cz, linux-input@atrey.karlin.mff.cuni,
       linux-kernel@vger.kernel.org
References: <20050323012613.GY1948@stusta.de>
In-Reply-To: <20050323012613.GY1948@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503231941.57991.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 March 2005 20:26, Adrian Bunk wrote:
> The Coverity checker found the following bug in the function 
> gunze_process_packet in drivers/input/touchscreen/gunze.c:
> 
> 
> <--  snip  -->
> 
> ...
> #define GUNZE_MAX_LENGTH        10
> ...
> struct gunze {
> ...
>         unsigned char data[GUNZE_MAX_LENGTH];
> ...
> };
> ...
> static void gunze_process_packet(struct gunze* gunze, struct pt_regs *regs)
> ...
>                 gunze->data[10] = 0;
> ...
> 
> <--  snip  -->
> 
> 
> The bug is obvious, but for a correct solution someone should know this 
> code better than I do.
> 

Ahh, it looks like it was just an attempt to null-terminate packet for
printk. The patch below should do the trick. 

-- 
Dmitry

===================================================================

Input: gunze - fix out-of-bound array access reported by Adrian Bunk.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 gunze.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

Index: dtor/drivers/input/touchscreen/gunze.c
===================================================================
--- dtor.orig/drivers/input/touchscreen/gunze.c
+++ dtor/drivers/input/touchscreen/gunze.c
@@ -68,8 +68,7 @@ static void gunze_process_packet(struct 
 
 	if (gunze->idx != GUNZE_MAX_LENGTH || gunze->data[5] != ',' ||
 		(gunze->data[0] != 'T' && gunze->data[0] != 'R')) {
-		gunze->data[10] = 0;
-		printk(KERN_WARNING "gunze.c: bad packet: >%s<\n", gunze->data);
+		printk(KERN_WARNING "gunze.c: bad packet: >%.*s<\n", GUNZE_MAX_LENGTH, gunze->data);
 		return;
 	}
 
