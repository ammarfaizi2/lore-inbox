Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267047AbSLXGnr>; Tue, 24 Dec 2002 01:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267048AbSLXGnr>; Tue, 24 Dec 2002 01:43:47 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:48278 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267047AbSLXGnn>; Tue, 24 Dec 2002 01:43:43 -0500
Date: Tue, 24 Dec 2002 12:18:52 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: "David S. Miller" <davem@redhat.com>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] Convert sockets_in_use to use per_cpu areas
Message-ID: <20021224121852.H23413@in.ibm.com>
References: <20021223190847.G23413@in.ibm.com> <20021223.121632.105420794.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021223.121632.105420794.davem@redhat.com>; from davem@redhat.com on Mon, Dec 23, 2002 at 12:16:32PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 23, 2002 at 12:16:32PM -0800, David S. Miller wrote:
>...     
>    -static union {
>    -	int	counter;
>    -	char	__pad[SMP_CACHE_BYTES];
>    -} sockets_in_use[NR_CPUS] __cacheline_aligned = {{0}};
>    +static DEFINE_PER_CPU(int, sockets_in_use);
> 
> You have to provide an explicit initializer for DEFINE_PER_CPU
> declarations or you break some platforms with older GCC's which
> otherwise won't put it into the proper section.
> 

Ok, here's the modified patch...

Thanks,
Kiran


diff -ruN -X dontdiff linux-2.5.52/net/socket.c sockets_in_use-2.5.52/net/socket.c
--- linux-2.5.52/net/socket.c	Mon Dec 16 07:37:53 2002
+++ sockets_in_use-2.5.52/net/socket.c	Tue Dec 24 05:11:36 2002
@@ -189,10 +189,7 @@
  *	Statistics counters of the socket lists
  */
 
-static union {
-	int	counter;
-	char	__pad[SMP_CACHE_BYTES];
-} sockets_in_use[NR_CPUS] __cacheline_aligned = {{0}};
+static DEFINE_PER_CPU(int, sockets_in_use) = 0;
 
 /*
  *	Support routines. Move socket addresses back and forth across the kernel/user
@@ -475,7 +472,8 @@
 	inode->i_uid = current->fsuid;
 	inode->i_gid = current->fsgid;
 
-	sockets_in_use[smp_processor_id()].counter++;
+	get_cpu_var(sockets_in_use)++;
+	put_cpu_var(sockets_in_use);
 	return sock;
 }
 
@@ -511,7 +509,8 @@
 	if (sock->fasync_list)
 		printk(KERN_ERR "sock_release: fasync list not empty!\n");
 
-	sockets_in_use[smp_processor_id()].counter--;
+	get_cpu_var(sockets_in_use)--;
+	put_cpu_var(sockets_in_use);
 	if (!sock->file) {
 		iput(SOCK_INODE(sock));
 		return;
@@ -1851,7 +1850,7 @@
 	int counter = 0;
 
 	for (cpu = 0; cpu < NR_CPUS; cpu++)
-		counter += sockets_in_use[cpu].counter;
+		counter += per_cpu(sockets_in_use, cpu);
 
 	/* It can be negative, by the way. 8) */
 	if (counter < 0)
