Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290084AbSAQRuR>; Thu, 17 Jan 2002 12:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290095AbSAQRuJ>; Thu, 17 Jan 2002 12:50:09 -0500
Received: from ns.suse.de ([213.95.15.193]:1805 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S290084AbSAQRtz>;
	Thu, 17 Jan 2002 12:49:55 -0500
To: Rainer Krienke <krienke@uni-koblenz.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17:Increase number of anonymous filesystems beyond 256?
In-Reply-To: <200201171351.g0HDpdK05456@bliss.uni-koblenz.de.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 17 Jan 2002 18:49:53 +0100
In-Reply-To: Rainer Krienke's message of "17 Jan 2002 14:57:44 +0100"
Message-ID: <p737kqgx3y6.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rainer Krienke <krienke@uni-koblenz.de> writes:

> Hello,
> 
> I have to increase the number of anonymous filesystems the kernel can handle  
> and found the array unnamed_dev_in_use fs/super.c and changed the array size 
> from the default of 256 to 1024. Testing this patch by mounting more and more 
> NFS-filesystems I found that still no more than 800 NFS mounts are possible. 
> One more mount results in the kernel saying:
> 
> Jan 17 14:03:11 gl kernel: RPC: Can't bind to reserved port (98).

Some NFS servers only accept connections from 'secure ports' < 1024. 
You need one local port per connections. Some Ports <1024 are already
used by other services. This a natural limit with secure ports.

If you can configure your NFS server to not insist on secure ports
(it's usually an export option, unfortunately defaulting to on with
many OS) you can just use any ports. With the appended patch it should
work
[should be probably a sysctl instead of an #ifdef, but I'm too lazy
for that right now] 

Another way if you wanted to avoid source patching would be to make
sure that different connections go via different source IP addresses;
e.g. by defining multiple IP aliases on the server and the client and 
defining different routes for the server aliases with different local
ip addresses as prefered from address (=from option in iproute2). 
This way the ports would be unique again because they're for multiple local 
IP addresses; you would have 800 ports per local IP. Using the patch is 
probably cleaner though. 

Hope this helps,
-Andi

--- linux-work/net/sunrpc/xprt.c-o	Mon Oct  8 21:36:07 2001
+++ linux-work/net/sunrpc/xprt.c	Thu Jan 17 18:44:05 2002
@@ -1507,6 +1507,13 @@
 
 	memset(&myaddr, 0, sizeof(myaddr));
 	myaddr.sin_family = AF_INET;
+#define SUNRPC_NONSECURE_PORT 1
+#ifdef SUNRPC_NONSECURE_PORT
+	err =  sock->ops->bind(sock, (struct sockaddr *) &myaddr,
+						sizeof(myaddr));
+	if (err < 0) 
+		printk("RPC: cannot bind to a port\n"); 
+#else 
 	port = 800;
 	do {
 		myaddr.sin_port = htons(port);
@@ -1516,6 +1523,9 @@
 
 	if (err < 0)
 		printk("RPC: Can't bind to reserved port (%d).\n", -err);
+
+#endif
+
 
 	return err;
 }


-Andi

