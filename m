Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161495AbWATE1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161495AbWATE1F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 23:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161494AbWATE1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 23:27:04 -0500
Received: from ns2.lanforge.com ([66.165.47.211]:29378 "EHLO ns2.lanforge.com")
	by vger.kernel.org with ESMTP id S1161495AbWATE1E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 23:27:04 -0500
Message-ID: <43D06687.2050108@candelatech.com>
Date: Thu, 19 Jan 2006 20:26:47 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Can you specify a local IP or Interface to be used on a per NFS
 mount basis?
References: <43CECB00.40405@candelatech.com>	 <1137631728.13076.1.camel@lade.trondhjem.org>	 <43CEF7A6.30802@candelatech.com>	 <1137641084.8864.3.camel@lade.trondhjem.org>	 <43CF0768.60703@candelatech.com> <1137644698.8864.8.camel@lade.trondhjem.org>
In-Reply-To: <1137644698.8864.8.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> On Wed, 2006-01-18 at 19:28 -0800, Ben Greear wrote:
> 
> 
>>>As David said, the place to fix it is in xs_bindresvport(), but there is
>>>no support for passing this sort of information through the current NFS
>>>binary mount structure. You would have to hack that up yourself.
>>
>>I can think of some horrible hacks to grab info out of a text file based
>>on the mount point or some other available info...but if I actually
>>attempted to do it right..would you consider the patch for kernel
>>inclusion?  Is it OK to modify the binary mount structure?
> 
> 
> It is possible, yes: the binary structure carries a version number that
> allows the kernel to distinguish the various revisions that the userland
> mount program supports.
> 
> That said, the concensus at the moment appears to be that we should move
> towards a text-based mount structure for NFS (like most of the other
> filesystems have, and like NFSroot has) so I'd be reluctant to take
> patches that define new binary structures.

Ok.  This patch does extend the binary struct, and to do it really right,
we should probably pass in some sort of in_addr struct instead of the
single 'u32' for the IP address.

So, please just consider this a proof of concept.  That said, with a
patched 'mount' binary (diff available if anyone cares), this does
do exactly what I want:  allows binding an nfs client to a particular
local IP address.

If/when you get the text based interface working, I will try to cook
up an official patch worthy of inclusion if you have not already
done so.

This patch was inspired by a patch sent to me by:  Dimitris Michailidis

Thanks,
Ben


diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -407,6 +407,12 @@ nfs_create_client(struct nfs_server *ser
                                 __FUNCTION__, PTR_ERR(xprt));
                 return (struct rpc_clnt *)xprt;
         }
+
+       if (data->local_ip != 0) {
+               printk("nfs: Configuring local ip address as: 0x%x\n",
+                      data->local_ip);
+       }
+       xprt->local_address = data->local_ip; /* specify local IP address */
         clnt = rpc_create_client(xprt, server->hostname, &nfs_program,
                                  server->rpc_ops->version, data->pseudoflavor);
         if (IS_ERR(clnt)) {
@@ -1663,6 +1669,7 @@ static struct super_block *nfs_get_sb(st
                 deactivate_super(s);
                 return ERR_PTR(error);
         }
+
         s->s_flags |= MS_ACTIVE;
         return s;
  out_rpciod_down:
diff --git a/fs/super.c b/fs/super.c
diff --git a/include/linux/nfs_mount.h b/include/linux/nfs_mount.h
--- a/include/linux/nfs_mount.h
+++ b/include/linux/nfs_mount.h
@@ -20,7 +20,7 @@
   * mount-to-kernel version compatibility.  Some of these aren't used yet
   * but here they are anyway.
   */
-#define NFS_MOUNT_VERSION      6
+#define NFS_MOUNT_VERSION      7
  #define NFS_MAX_CONTEXT_LEN    256

  struct nfs_mount_data {
@@ -43,6 +43,8 @@ struct nfs_mount_data {
         struct nfs3_fh  root;                   /* 4 */
         int             pseudoflavor;           /* 5 */
         char            context[NFS_MAX_CONTEXT_LEN + 1];       /* 6 */
+       char            pad[3];                 /* 7  Align the context above */
+       unsigned int    local_ip;               /* 7 */
  };

  /* bits in the flags field */
diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
--- a/include/linux/sunrpc/xprt.h
+++ b/include/linux/sunrpc/xprt.h
@@ -168,7 +168,8 @@ struct rpc_xprt {
                                 reestablish_timeout;
         struct work_struct      connect_worker;
         unsigned short          port;
-
+       u32                     local_address; /* local IP address to bind to */+
         /*
          * Disconnection of idle transports
          */
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -928,6 +928,8 @@ static int xs_bindresvport(struct rpc_xp
         int err;
         unsigned short port = xprt->port;

+       myaddr.sin_addr.s_addr = xprt->local_address;
+
         do {
                 myaddr.sin_port = htons(port);
                 err = sock->ops->bind(sock, (struct sockaddr *) &myaddr,

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

