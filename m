Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752370AbWAFEny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752370AbWAFEny (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 23:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752372AbWAFEny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 23:43:54 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:16396 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752367AbWAFEnx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 23:43:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AHrGIAA2blIjs3/QNKhIkOuahek+/CH05/dkwuSpmuzzuRoWS4DRXn2NnRFqaEC5lVsfkgeWr6g1uUO9k+Wri/R4fvE2Qyj5ofhmOIGnIW+CV6L/OcPOeQqUPGWLA8EcFMe75NvGrLDuQTGZ5FBciQ9xRkmfDIFMpt3l6mOPSeU=
Message-ID: <d4757e600601052043u647658f1yaa15b0f396b4ad3c@mail.gmail.com>
Date: Thu, 5 Jan 2006 23:43:52 -0500
From: Joe <joecool1029@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] fix ipvs compilation
Cc: wensong@linux-vs.org, horms@verge.net.au, ja@ssi.bg,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060105135943.GA3831@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060105135943.GA3831@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/06, Adrian Bunk <bunk@stusta.de> wrote:
> I don't know which change broke it, but I'm getting the following
> compile error in Linus' tree:
>
> <--  snip  -->
>
> ...
>   CC      net/ipv4/ipvs/ip_vs_sched.o
> net/ipv4/ipvs/ip_vs_sched.c: In function 'ip_vs_sched_getbyname':
> net/ipv4/ipvs/ip_vs_sched.c:110: warning: implicit declaration of function 'local_bh_disable'
> net/ipv4/ipvs/ip_vs_sched.c:124: warning: implicit declaration of function 'local_bh_enable'
> ...
>   CC      net/ipv4/ipvs/ip_vs_est.o
> net/ipv4/ipvs/ip_vs_est.c: In function 'ip_vs_new_estimator':
> net/ipv4/ipvs/ip_vs_est.c:147: warning: implicit declaration of function 'local_bh_disable'
> net/ipv4/ipvs/ip_vs_est.c:156: warning: implicit declaration of function 'local_bh_enable'
> ...
>   LD      .tmp_vmlinux1
> net/built-in.o: In function `ip_vs_sched_getbyname':ip_vs_sched.c:(.text+0x99cfa): undefined reference to `local_bh_disable'
> net/built-in.o: In function `register_ip_vs_scheduler': undefined reference to `local_bh_disable'
> net/built-in.o: In function `unregister_ip_vs_scheduler': undefined reference to `local_bh_disable'
> net/built-in.o: In function `ip_vs_new_estimator': undefined reference to `local_bh_disable'
> net/built-in.o: In function `ip_vs_kill_estimator': undefined reference to `local_bh_disable'
> net/built-in.o: more undefined references to `local_bh_disable' follow
> make: *** [.tmp_vmlinux1] Error 1
>
> <--  snip  -->
>
>
> This patch fixes them by #include'ing linux/interrupt.h.
>
>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>
> --- linux-git/net/ipv4/ipvs/ip_vs_sched.c.old   2006-01-05 14:56:44.000000000 +0100
> +++ linux-git/net/ipv4/ipvs/ip_vs_sched.c       2006-01-05 14:56:59.000000000 +0100
> @@ -22,6 +22,7 @@
>  #include <linux/module.h>
>  #include <linux/sched.h>
>  #include <linux/spinlock.h>
> +#include <linux/interrupt.h>
>  #include <asm/string.h>
>  #include <linux/kmod.h>
>
> --- linux-git/net/ipv4/ipvs/ip_vs_est.c.old     2006-01-05 14:57:15.000000000 +0100
> +++ linux-git/net/ipv4/ipvs/ip_vs_est.c 2006-01-05 14:57:27.000000000 +0100
> @@ -18,6 +18,7 @@
>  #include <linux/jiffies.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
> +#include <linux/interrupt.h>
>
>  #include <net/ip_vs.h>
>
>

Thats not all either,  ./net/ipv4/netfilter/ipt_helper.c has the same
error and the same fix.

Here's the patch for this one.  Sorry for the dupe.. i sent the last
as html by accident.

--- linux/net/ipv4/netfilter/ipt_helper.c.old        2006-01-05
19:38:32.498991515 -0500
+++ linux/net/ipv4/netfilter/ipt_helper.c    2006-01-05 19:40:30.047057859 -0500
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/skbuff.h>
 #include <linux/netfilter.h>
+#include <linux/interrupt.h>
 #if defined(CONFIG_IP_NF_CONNTRACK) || defined(CONFIG_IP_NF_CONNTRACK_MODULE)
 #include <linux/netfilter_ipv4/ip_conntrack.h>
 #include <linux/netfilter_ipv4/ip_conntrack_core.h>
