Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265011AbUFCPyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265011AbUFCPyE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 11:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264851AbUFCPxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 11:53:17 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:43388 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S264908AbUFCPuq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 11:50:46 -0400
Date: Thu, 3 Jun 2004 08:49:36 -0700
From: Paul Jackson <pj@sgi.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de, greg@kroah.com
Subject: Re: [PATCH] fix sys cpumap for > 352 NR_CPUS
Message-Id: <20040603084936.532c6c81.pj@sgi.com>
In-Reply-To: <1086243997.29390.527.camel@bach>
References: <20040602161115.1340f698.pj@sgi.com>
	<1086222156.29391.337.camel@bach>
	<20040602212547.448c7cc7.pj@sgi.com>
	<1086243997.29390.527.camel@bach>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch (fix-sys-cpumap-for-352-nr_cpus) doesn't work.  Passing -1UL
to cpumask_scnprintf() suppresses all of the requested output, because
of the following code in lib/vsprintf.c vsnprintf():

        /* Reject out-of-range values early */
        if (unlikely((int) size < 0)) {
                /* There can be only one.. */
                static int warn = 1;
                WARN_ON(warn);
                warn = 0;
                return 0;
        }

Using PAGE_SIZE works ok.  Well, lets throw in a -1 to leave a slot for
the newline, while we're here.

Signed-off-by: Paul Jackson <pj@sgi.com>

Index: 2.6.7-rc2-mm2/drivers/base/node.c
===================================================================
--- 2.6.7-rc2-mm2.orig/drivers/base/node.c	2004-06-03 08:24:19.000000000 -0700
+++ 2.6.7-rc2-mm2/drivers/base/node.c	2004-06-03 08:26:12.000000000 -0700
@@ -24,7 +24,7 @@ static ssize_t node_read_cpumap(struct s
 	/* 2004/06/03: buf currently PAGE_SIZE, need > 1 char per 4 bits. */
 	BUILD_BUG_ON(NR_CPUS/4 > PAGE_SIZE/2);
 
-	len = cpumask_scnprintf(buf, -1UL, mask);
+	len = cpumask_scnprintf(buf, PAGE_SIZE-1, mask);
 	len += sprintf(buf + len, "\n");
 	return len;
 }


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
