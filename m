Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266101AbTLaDuq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 22:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266103AbTLaDuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 22:50:46 -0500
Received: from [61.49.124.136] ([61.49.124.136]:4091 "EHLO kapok.exavio.com.cn")
	by vger.kernel.org with ESMTP id S266101AbTLaDun (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 22:50:43 -0500
Date: Wed, 31 Dec 2003 11:53:25 +0800
From: Isaac Claymore <clay@exavio.com.cn>
To: linux-kernel@vger.kernel.org
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: 2.6.0 kernel panic
Message-ID: <20031231035325.GA15138@exavio.com.cn>
Mail-Followup-To: Isaac Claymore <clay@exavio.com.cn>,
	linux-kernel@vger.kernel.org,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>
References: <20031228020759.GA2158@Master.Wizards> <20031230033036.GA2158@Master.Wizards> <Pine.LNX.4.58.0312292238390.4176@home.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312292238390.4176@home.osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 29, 2003 at 10:42:06PM -0800, Linus Torvalds wrote:
> 
> 
> On Mon, 29 Dec 2003, Murray J. Root wrote:
> > On Sat, Dec 27, 2003 at 09:07:59PM -0500, Murray J. Root wrote:
> > > P4 2GHz
> > > ASUS P4S533 mainboard
> > > 1G PC2700 RAM
> > > GF2 GTS video using nv driver
> > > 2.6.0 compiled with gcc 3.3.2
> > > 
> > > At boot kernel gets:
> > >    INIT: cannot execute "/etc/rc.d/rc.sysinit"
> > > then panic.
> > > 
> > > Same configuration for 2.6.0-test11 and earlier works fine.
> > > 
> > 
> > To answer myself, I did a diff between 2.6.0-test11 and 2.6.0. Found this:
> 
> Sounds like one of the partitions that has the executable script loader is
> mounted with "noexec". 
> 
> On most systems, /etc/rc.d/rc.sysinit is a bash script, and explicitly
> points to /bin/bash. Check "ldd /bin/bash", and verify that all the
> libraries (and /bin itself, of course) are mounted on executable
> filesystems.
> 
> That would be a bug that 2.6.0 uncovers. 

I've noticed that 2.4.23 lacks this additional check, and included a
patch against it.

Marcelo, does this trivial stuff look good enough to be applied?


-Isaac

> 
> 		Linus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 

Regards, Isaac
()  ascii ribbon campaign - against html e-mail
/\                        - against microsoft attachments

--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mmap.do_mmap_pgoff.diff"

--- mmap.c	2003-12-05 09:39:09.000000000 +0800
+++ mmap.c.execproto	2003-12-31 11:25:12.000000000 +0800
@@ -17,6 +17,7 @@
 
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
+#include <linux/mount.h>
 
 /*
  * WARNING: the debugging will use recursive algorithms so never enable this
@@ -400,8 +401,13 @@ unsigned long do_mmap_pgoff(struct file 
 	int error;
 	rb_node_t ** rb_link, * rb_parent;
 
-	if (file && (!file->f_op || !file->f_op->mmap))
-		return -ENODEV;
+	if (file) {
+		if (!file->f_op || !file->f_op->mmap)
+			return -ENODEV;
+
+		if ((prot & PROT_EXEC) && (file->f_vfsmnt->mnt_flags & MNT_NOEXEC))
+			return -EPERM;
+	}
 
 	if (!len)
 		return addr;

--ZGiS0Q5IWpPtfppv--
