Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262257AbSIZLJc>; Thu, 26 Sep 2002 07:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262303AbSIZLJc>; Thu, 26 Sep 2002 07:09:32 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:51946
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S262257AbSIZLJa>; Thu, 26 Sep 2002 07:09:30 -0400
Date: Thu, 26 Sep 2002 07:18:47 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Marco Schwarz <marco.schwarz@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Serious Problems with diskless clients
Message-ID: <20020926071847.A12878@animx.eu.org>
References: <20020926095957.GC42048@niksula.cs.hut.fi> <3489.1033036000@www51.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <3489.1033036000@www51.gmx.net>; from Marco Schwarz on Thu, Sep 26, 2002 at 12:26:40PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> my diskless clients have some severe problems on one of my servers.
> Sometimes (right now most of the time) everything just hangs at the same place when
> starting up the kernel. Here are the last messages I get (right before this
> IP-Config is running and looks OK):
> 
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0
> ds: no socket drivers loaded !
> Looking up port of RPC 100003/2 on 192.168.0.235
> portmap: server 192.168.0.235 mot responding, timed out !
> Root-NFS: Unable to get nfsd port number from server, using default
> Looking up port of RPC 100005/1 on 192.168.0.235
> portmap: server 192.168.0.235 mot responding, timed out !
> Root-NFS: Unable to get mountd port number from server, using default
> mount: server 192.168.0.235 not responding, timed out
> Root-NFS: Server returned error -5 while mounting /netclients/192.168.0.87
> VFS: Unable to mount root fs via NFS, trying floppy
> VFS: Insert root floppy and press ENTER
> 
> I am thinking right now that we have some problems with network hardware,
> but maybe its a Software problem. Could someone tell me what the 'Looking up
> port of RPC 100003/2 on 192.168.0.235' in kernel startup is doing an why it
> could fail ?
> 
> We have Kernel 2.4.10 on both server and clients (I also tried 2.4.19, but
> it changed nothing).

I have 2 diskless machines both tftping the kernel from the network and they
work just fine.  Both are using kernel 2.4.19 vanalla with a small patch to
force ip=auto if nfs=/dev/nfs

[wakko@gohan:/] uname -a
Linux gohan 2.4.19 #1 SMP Tue Sep 3 13:02:36 EDT 2002 i686 unknown
[wakko@gohan:/] mount
rod:/tftpboot/gohan on / type nfs
(rw,intr,hard,rsize=8192,wsize=8192,intr,hard,rsize=8192,wsize=8192)
/proc on /proc type proc (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
[wakko@gohan:/] 

It's a very small patch to make that work w/o saying ip=auto on the command
line (I did this originally because I used a kernel disk w/o a boot loader
on some boxes at work)

--- net/ipv4/ipconfig-orig.c	2001-11-19 20:48:35.000000000 -0500
+++ net/ipv4/ipconfig.c	2001-11-19 20:56:21.000000000 -0500
@@ -1105,7 +1105,11 @@
        proc_net_create("pnp", 0, pnp_get_info);
 #endif /* CONFIG_PROC_FS */
 
-	if (!ic_enable)
+	if (!ic_enable
+#if defined(IPCONFIG_DYNAMIC) && defined(CONFIG_ROOT_NFS)
+	    && ROOT_DEV != MKDEV(UNNAMED_MAJOR, 255)
+#endif
+	   )
		return 0;

I did a cut'n'paste so I don't know if it will apply correctly but you get
the idea.

One thing I had problems with was using USB to mount the rootfs (usb hdd
actually) and I suspect the same with a USB nic (loading the kernel from
floppy).

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
