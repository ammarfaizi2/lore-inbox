Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261307AbVHAWKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbVHAWKT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 18:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbVHAWHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 18:07:46 -0400
Received: from mf00.sitadelle.com ([212.94.174.67]:22371 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S261313AbVHAWH3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 18:07:29 -0400
Message-ID: <42EE9D1B.108@cosmosbay.com>
Date: Tue, 02 Aug 2005 00:07:23 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] MM, NUMA : sys_set_mempolicy() doesnt check if mode < 0
References: <20050728011540.GA23923@localhost.localdomain> <20050727182445.52be6000.akpm@osdl.org> <20050729074647.GC3726@bragg.suse.de>
In-Reply-To: <20050729074647.GC3726@bragg.suse.de>
Content-Type: multipart/mixed;
 boundary="------------020705040400030702020401"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020705040400030702020401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

MM, NUMA : sys_set_mempolicy() doesnt check if mode < 0

A kernel BUG() is triggered by a call to set_mempolicy() with a negative first argument.
This is because the mode is declared as an int, and the validity check doesnt check < 0 values.
Alternatively, mode could be declared as unsigned int or unsigned long.

Thank you
Eric
---------------------------------
Test program for x86_64:
---------------------------------
#include <unistd.h>
#include <stdio.h>
#include <errno.h>
#include <linux/unistd.h>

#define __NR_set_mempolicy      238
#define __sys_set_mempolicy(mode, nmask, maxnode) _syscall3(int, set_mempolicy, int, mode, unsigned long *, nmask, unsigned long, maxnode)
static __sys_set_mempolicy(mode, nmask, maxnode)

unsigned long nodes = 3;

int main()
{
int ret = set_mempolicy(-6, &nodes, 2);
printf("result=%d errno=%d\n", ret, errno);
return 0;
}


Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>


--------------020705040400030702020401
Content-Type: text/plain;
 name="mempolicy.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mempolicy.patch"

--- linux-2.6.13-rc4/mm/mempolicy.c	2005-07-29 00:44:44.000000000 +0200
+++ linux-2.6.13-rc4-ed/mm/mempolicy.c	2005-08-01 23:52:43.000000000 +0200
@@ -443,7 +443,7 @@
 	struct mempolicy *new;
 	DECLARE_BITMAP(nodes, MAX_NUMNODES);
 
-	if (mode > MPOL_MAX)
+	if ((unsigned int)mode > MPOL_MAX)
 		return -EINVAL;
 	err = get_nodes(nodes, nmask, maxnode, mode);
 	if (err)

--------------020705040400030702020401--
