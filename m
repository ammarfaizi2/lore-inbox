Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314085AbSFBUrC>; Sun, 2 Jun 2002 16:47:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314096AbSFBUrC>; Sun, 2 Jun 2002 16:47:02 -0400
Received: from pD9E239B5.dip.t-dialin.net ([217.226.57.181]:60634 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S314085AbSFBUrA>; Sun, 2 Jun 2002 16:47:00 -0400
Date: Sun, 2 Jun 2002 14:46:39 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Paul Stoeber <paul.stoeber@stud.tu-ilmenau.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: patch to have root fs on USB device (please CC)
In-Reply-To: <20020602201322.GA85820@gogh.RZ.TU-Ilmenau.DE>
Message-ID: <Pine.LNX.4.44.0206021420370.29405-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 2 Jun 2002, Paul Stoeber wrote:
> --- init/do_mounts.c.orig	Sat May 25 18:11:45 2002
> +++ init/do_mounts.c	Sat May 25 18:15:22 2002
> @@ -311,9 +311,13 @@
>  }
>  static void __init mount_block_root(char *name, int flags)
>  {
> -	char *fs_names = __getname();
> +	char *fs_names;
>  	char *p;
>  
> +	set_current_state(TASK_UNINTERRUPTIBLE);
> +	schedule_timeout(10*HZ);
> +
> +	fs_names = __getname();
>  	get_fs_names(fs_names);
>  retry:
>  	for (p = fs_names; *p; p += strlen(p)+1) {

I think we shouldn't bind it on time but rather on whether the device is 
available. Maybe check that instead of schedule_timeout(10*HZ)?

BTW, we stay in TASK_UNINTERRUPTIBLE here!

+       int i;
+
+       if (!(flags & SOMETHING_SAYING_WE_SHALL_NOT_INTERRUPT)) {
+           while (!path_lookup(name, LOOKUP_FOLLOW, &dummy)) {
+               i++;
+               printk(KERN_NOTICE "Root FS not yet available!\n");
+               if (i > 10)
+                   break;
+
+               schedule_timeout(HZ/2);
+           }
+       }

or whatever.

Regards,
Thunder
-- 
ship is leaving right on time	|	Thunder from the hill at ngforever
empty harbour, wave goodbye	|
evacuation of the isle		|	free inhabitant not directly
caveman's paintings drowning	|	belonging anywhere


