Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279686AbRJYC63>; Wed, 24 Oct 2001 22:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279690AbRJYC6U>; Wed, 24 Oct 2001 22:58:20 -0400
Received: from [202.135.142.195] ([202.135.142.195]:63502 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S279688AbRJYC6O>; Wed, 24 Oct 2001 22:58:14 -0400
Date: Thu, 25 Oct 2001 11:59:42 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ken Ashcraft <kash@stanford.edu>
Cc: linux-kernel@vger.kernel.org, mc@cs.Stanford.EDU, laforge@gnumonks.org
Subject: Re: [CHECKER] Probable Security Errors in 2.4.12-ac3
Message-Id: <20011025115942.31d3fdbf.rusty@rustcorp.com.au>
In-Reply-To: <Pine.GSO.4.33.0110202220470.963-100000@saga5.Stanford.EDU>
In-Reply-To: <Pine.GSO.4.33.0110202220470.963-100000@saga5.Stanford.EDU>
X-Mailer: Sylpheed version 0.5.3 (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Oct 2001 22:28:50 -0700 (PDT)
Ken Ashcraft <kash@stanford.edu> wrote:

> Hi All,

Hi Ken,

	I'm prepared to live with the iptables ones: 

> ---------------------------------------------------------
> [BUG] MINOR checked indirectly.
> /home/kash/linux/2.4.12/net/ipv6/netfilter/ip6_tables.c:1111:do_replace: ERROR:RANGE:1106:1111: Using user length "size" as argument to "copy_from_user" [type=LOCAL] [state = need_ub] set by 'copy_from_user':1106 [distance=13]
> 
> 	if (copy_from_user(&tmp, user, sizeof(tmp)) != 0)
> 		return -EFAULT;
> 
> 	newinfo = vmalloc(sizeof(struct ip6t_table_info)
> Start --->
> 			  + SMP_ALIGN(tmp.size) * smp_num_cpus);
> 	if (!newinfo)
> 		return -ENOMEM;
> 
> 	if (copy_from_user(newinfo->entries, user + sizeof(tmp),
> Error --->
> 			   tmp.size) != 0) {
> 		ret = -EFAULT;
> 		goto free_newinfo;
> 	}

Yes, if a malicious user has CAP_NET_ADMIN they can hit the BUG() in vmalloc().
Of course, we have other problems then, too...

Still, here is the fix, if only to stop you guys complaining 8)

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.12-official/net/ipv4/netfilter/ip_tables.c working-2.4.12-nfsize/net/ipv4/netfilter/ip_tables.c
--- linux-2.4.12-official/net/ipv4/netfilter/ip_tables.c	Wed Oct 10 17:37:58 2001
+++ working-2.4.12-nfsize/net/ipv4/netfilter/ip_tables.c	Thu Oct 25 11:56:01 2001
@@ -1059,6 +1059,10 @@
 	if (len != sizeof(tmp) + tmp.size)
 		return -ENOPROTOOPT;
 
+	/* Pedantry: prevent them from hitting BUG() in vmalloc.c --RR */
+	if ((SMP_ALIGN(tmp.size) >> PAGE_SHIFT) + 2 > num_physpages)
+		return -ENOMEM;
+
 	newinfo = vmalloc(sizeof(struct ipt_table_info)
 			  + SMP_ALIGN(tmp.size) * smp_num_cpus);
 	if (!newinfo)
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.12-official/net/ipv6/netfilter/ip6_tables.c working-2.4.12-nfsize/net/ipv6/netfilter/ip6_tables.c
--- linux-2.4.12-official/net/ipv6/netfilter/ip6_tables.c	Wed Oct 10 17:37:58 2001
+++ working-2.4.12-nfsize/net/ipv6/netfilter/ip6_tables.c	Thu Oct 25 11:56:27 2001
@@ -1102,6 +1102,10 @@
 	if (copy_from_user(&tmp, user, sizeof(tmp)) != 0)
 		return -EFAULT;
 
+	/* Pedantry: prevent them from hitting BUG() in vmalloc.c --RR */
+	if ((SMP_ALIGN(tmp.size) >> PAGE_SHIFT) + 2 > num_physpages)
+		return -ENOMEM;
+
 	newinfo = vmalloc(sizeof(struct ip6t_table_info)
 			  + SMP_ALIGN(tmp.size) * smp_num_cpus);
 	if (!newinfo)

Rusty.
