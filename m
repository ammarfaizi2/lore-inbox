Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262557AbREVDol>; Mon, 21 May 2001 23:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262558AbREVDob>; Mon, 21 May 2001 23:44:31 -0400
Received: from acura.Stanford.EDU ([128.12.55.25]:21936 "EHLO acura")
	by vger.kernel.org with ESMTP id <S262557AbREVDoS>;
	Mon, 21 May 2001 23:44:18 -0400
Date: Mon, 21 May 2001 20:48:44 -0700
To: su.class.cs99q@nntp.stanford.edu, torvalds@transmeta.com,
        alan@the.3c501.cabal.tm, linux-kernel@vger.kernel.org
Subject: [PATCH]drivers/net/wan/lmc/lmc_main.c
Message-ID: <20010521204844.A2399@acura.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: Akash Jain <aki51@acura.stanford.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey All,
I am working with Dawson Engler's meta-compillation group @ stanford.
Sorry if this is reposted, previous one seemed to get tied up.
Here is a patch to the drivers/net/wan/lmc/lmc_main.c file.

On line 503, the authors use the GFP_KERNEL argument to kmalloc, how
ever
they are holding a spin lock during this period.  They should use
GFP_ATOMIC here.

On line 510, the authors rely on a macro, LMC_COPY_FROM_USER which is
designed to work with stack memory, not heap memory.  In all other cases
it is fine, here however, the memory must be deallocated before -EFAULT
can be returned.  Note that this is a potential security hole as it is
leaking memory and can be exploited by passing bogus pointers to
copy_to_user - thus creating a DOS situation.

--- drivers/net/wan/lmc/lmc_main.c.orig	Thu May 17 12:03:49 2001
+++ drivers/net/wan/lmc/lmc_main.c	Mon May 21 20:13:49 2001
@@ -500,14 +500,17 @@
                             break;
                     }
 
-                    data = kmalloc(xc.len, GFP_KERNEL);
+                    data = kmalloc(xc.len, GFP_ATOMIC);
                     if(data == 0x0){
                             printk(KERN_WARNING "%s: Failed to allocate memory for copy\n", dev->name);
                             ret = -ENOMEM;
                             break;
                     }
                     
-                    LMC_COPY_FROM_USER(data, xc.data, xc.len);
+		    if(copy_from_user(data, xc.data, xc.len)){
+		            kfree(data);
+		            return -EFAULT;
+		    }
 
                     printk("%s: Starting load of data Len: %d at 0x%p == 0x%p\n", dev->name, xc.len, xc.data, data)

Thanks!
-Akash Jain
