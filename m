Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266938AbTB0U0k>; Thu, 27 Feb 2003 15:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266932AbTB0U0Z>; Thu, 27 Feb 2003 15:26:25 -0500
Received: from blowme.phunnypharm.org ([65.207.35.140]:39941 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S266981AbTB0UYz>; Thu, 27 Feb 2003 15:24:55 -0500
Date: Thu, 27 Feb 2003 15:34:40 -0500
From: Ben Collins <bcollins@debian.org>
To: "David S. Miller" <davem@redhat.com>
Cc: pavel@suse.cz, linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com,
       ak@suse.de, arnd@bergmann-dalldorf.de
Subject: Re: ioctl32 consolidation -- call for testing
Message-ID: <20030227203440.GP21100@phunnypharm.org>
References: <20030226222606.GA9144@elf.ucw.cz> <20030227195135.GN21100@phunnypharm.org> <20030227202739.GO21100@phunnypharm.org> <20030227.121302.86023203.davem@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="K8nIJk4ghYZn606h"
Content-Disposition: inline
In-Reply-To: <20030227.121302.86023203.davem@redhat.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 27, 2003 at 12:13:02PM -0800, David S. Miller wrote:
>    From: Ben Collins <bcollins@debian.org>
>    Date: Thu, 27 Feb 2003 15:27:39 -0500
>    
>    Here it is. Sparc64's macros for ioctl32's assumed that cmd was u_int
>    instead of u_long. This look ok to you, Dave?
> 
> We would love to see that patch :-)

It was real small...so small that it slipped through mutt's open() call
and never got attached :)



-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/

--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sparc64-ioctl32.diff"

--- arch/sparc64/kernel/ioctl32.c~	2003-02-27 14:54:49.000000000 -0500
+++ arch/sparc64/kernel/ioctl32.c	2003-02-27 15:19:29.000000000 -0500
@@ -11,6 +11,7 @@
 #include <linux/config.h>
 #include <linux/types.h>
 #include <linux/compat.h>
+#include <linux/ioctl32.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/smp.h>
@@ -4274,10 +4275,14 @@
 #define BNEPGETCONNLIST	_IOR('B', 210, int)
 #define BNEPGETCONNINFO	_IOR('B', 211, int)
 
-#define COMPATIBLE_IOCTL(cmd) asm volatile(".word %0, sys_ioctl, 0" : : "i" (cmd));
-#define HANDLE_IOCTL(cmd,handler) asm volatile(".word %0, %1, 0" : : "i" (cmd), "i" (handler));
-#define IOCTL_TABLE_START void ioctl32_foo(void) { asm volatile(".data\n.global ioctl_start\nioctl_start:");
-#define IOCTL_TABLE_END asm volatile("\n.global ioctl_end\nioctl_end:\n\t.previous"); }
+typedef int (* ioctl32_handler_t)(unsigned int, unsigned int, unsigned long, struct file *);
+
+#define COMPATIBLE_IOCTL(cmd)		HANDLE_IOCTL((cmd),sys_ioctl)
+#define HANDLE_IOCTL(cmd,handler)	{ (cmd), (ioctl32_handler_t)(handler), NULL },
+#define IOCTL_TABLE_START \
+	struct ioctl_trans ioctl_start[] = {
+#define IOCTL_TABLE_END \
+	}; struct ioctl_trans ioctl_end[0];
 
 IOCTL_TABLE_START
 /* List here exlicitly which ioctl's are known to have

--K8nIJk4ghYZn606h--
