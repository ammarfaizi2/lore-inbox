Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932763AbVINVRt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932763AbVINVRt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 17:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932767AbVINVRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 17:17:49 -0400
Received: from mf01.sitadelle.com ([212.94.174.68]:55465 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S932763AbVINVRt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 17:17:49 -0400
Message-ID: <43289376.7050205@cosmosbay.com>
Date: Wed, 14 Sep 2005 23:17:42 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: dipankar@in.ibm.com
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, akpm@osdl.org
Subject: [PATCH] reorder struct files_struct
References: <20050914191842.GA6315@in.ibm.com>	<20050914.125750.05416211.davem@davemloft.net>	<20050914201550.GB6315@in.ibm.com> <20050914.132936.105214487.davem@davemloft.net>
In-Reply-To: <20050914.132936.105214487.davem@davemloft.net>
Content-Type: multipart/mixed;
 boundary="------------040805020609080409060308"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040805020609080409060308
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi

Browsing (and using) the excellent RCU infrastructure for files that was 
adopted for 2.6.14-rc1, I noticed that the file_lock spinlock sit close to 
mostly read fields of 'struct files_struct'

In SMP (and NUMA) environnements, each time a thread wants to open or close a 
file, it has to acquire the spinlock, thus invalidating the cache line 
containing this spinlock on other CPUS. So other threads doing 
read()/write()/... calls that use RCU to access the file table are going to 
ask further memory (possibly NUMA) transactions to read again this memory line.

Please consider applying this patch. It moves the spinlock to another cache 
line, so that concurrent threads can share the cache line containing 'count' 
and 'fdt' fields.


Thank you

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>



--------------040805020609080409060308
Content-Type: text/plain;
 name="reorder_files_struct"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="reorder_files_struct"

--- linux-2.6.14-rc1/include/linux/file.h	2005-09-13 05:12:09.000000000 +0200
+++ linux-2.6.14-rc1-ed/include/linux/file.h	2005-09-15 01:09:13.000000000 +0200
@@ -34,12 +34,12 @@
  */
 struct files_struct {
         atomic_t count;
-        spinlock_t file_lock;     /* Protects all the below members.  Nests inside tsk->alloc_lock */
 	struct fdtable *fdt;
 	struct fdtable fdtab;
         fd_set close_on_exec_init;
         fd_set open_fds_init;
         struct file * fd_array[NR_OPEN_DEFAULT];
+	spinlock_t file_lock;     /* Protects concurrent writers.  Nests inside tsk->alloc_lock */
 };
 
 #define files_fdtable(files) (rcu_dereference((files)->fdt))

--------------040805020609080409060308--
