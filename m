Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319115AbSIDJ12>; Wed, 4 Sep 2002 05:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319116AbSIDJ12>; Wed, 4 Sep 2002 05:27:28 -0400
Received: from www.southpole.se ([213.212.2.2]:9878 "EHLO www.southpole.se")
	by vger.kernel.org with ESMTP id <S319115AbSIDJ11>;
	Wed, 4 Sep 2002 05:27:27 -0400
Date: Wed, 4 Sep 2002 11:32:00 +0200
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 --> 2.4.19. Ramdisk requires floppy?
Message-ID: <20020904093200.GA15698@southpole.se>
Mail-Followup-To: jakob@southpole.se,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <20020903165133.GA8726@southpole.se> <al3qe6$lvl$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <al3qe6$lvl$1@cesium.transmeta.com>
User-Agent: Mutt/1.3.28i
From: jakob@southpole.se (Jakob Sandgren)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2002 at 07:16:38PM -0700, H. Peter Anvin wrote:
> Followup to:  <20020903165133.GA8726@southpole.se>
> By author:    jakob@southpole.se (Jakob Sandgren)
> In newsgroup: linux.dev.kernel
> >
> > Hi,
> > 
> > I've noticed that the 2.4.19 version of "prepare_namespace"
> > (init/do_mounts.c) not allows you to mount a non floppy as a
> > ramdisk(?). This has changed since 2.4.18 (split of main.c ->
> > {do_mounts,main}.c).
> > 


> > 
> > however, in 2.4.19 it just tries to load a ramdisk if it's on a
> > floppy. Why? There may still be a ramdisk on an other device, NOT
> > using initrd. 
> > 
> 
> You can't search every device hunting for a ramdisk.  rd_load() is
> ancient cruft that should be nuked, and will be pushed into userspace
> as part of the initramfs/early userspace work.


I agree, but why is there such a check for mounting the root file 
system during startup. After removing the check from
prepare_namespace(), rd_load_image() will still get called with
"/dev/root" as argument and "/dev/root" should allready be pointing to
ROOT_DEV.  The target I'm working on is using a ramdisk for it's root
file system, however, it's not using initrd.



--- do_mounts.c-orig	Wed Sep  4 11:01:15 2002
+++ do_mounts.c	Wed Sep  4 11:02:11 2002
@@ -828,7 +828,6 @@
  */
 void prepare_namespace(void)
 {
-	int is_floppy = MAJOR(ROOT_DEV) == FLOPPY_MAJOR;
 #ifdef CONFIG_ALL_PPC
 	extern void arch_discover_root(void);
 	arch_discover_root();
@@ -852,7 +851,7 @@
 			handle_initrd();
 			goto out;
 		}
-	} else if (is_floppy && rd_doload && rd_load_disk(0))
+	} else if (rd_doload && rd_load_disk(0))
 		ROOT_DEV = MKDEV(RAMDISK_MAJOR, 0);
 	mount_root();
 out:





Best Regards,
Jakob Sandgren
South Pole AB

-- 
Jakob Sandgren                  South Pole AB
Phone:  +46 8 51420420          Gelbjutarvägen 5
Fax:    +46 8 51420429          SE - 17148 Solna 
e-mail: jakob@southpole.se      www.southpole.se
