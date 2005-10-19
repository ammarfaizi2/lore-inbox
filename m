Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932465AbVJSCNR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbVJSCNR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 22:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932466AbVJSCNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 22:13:17 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:53651 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932465AbVJSCNQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 22:13:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=W86p7DvIdb8SCw9fsw9PmOXZkspIEA0Xc2FG3HhgOigzsD7Nz1T06KCIIlexVZMVvUwmRoM4xVjGMbUkPKxMg4wrG8MMQe+lsISWXsG3RVaT0HqMFlp7aFd5M1HTW5TWcLwliQCHJOOANWcwCPDKDkW/yb5GlbdxafApsifv+9g=
Message-ID: <922692180510181913m3cce9b4bm8378552ec63cf08f@mail.gmail.com>
Date: Tue, 18 Oct 2005 22:13:15 -0400
From: Joseph Murawski <dzoster@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: Sparc64 U60: no iptables
Cc: debian-sparc@lists.debian.org, netfilter-devel@lists.netfilter.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051010.111611.106200571.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4349614F.1010408@frankengul.org>
	 <20051009.202646.70198053.davem@davemloft.net>
	 <20051010082507.GA5157@frankengul.org>
	 <20051010.111611.106200571.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello -

I would like to confirm this problem and reverting the patch provided
does fix the problem!

I have an ultra 60, dual processor.
gentoo linux   gentoo-sources 2.6.13-gentoo-r2

Whenever i would enable the iptables modules (ip_tables)
(ip_conntrack), execute the two commands iptables -X iptables -F and 
Ping any address ( including the loopback address)
i would get an oops.

I would just like to throw out my encounter with the problem and
confirm that the reversion of the below patch, fixes the problem and i
am able to use iptables with an smp kernel.

if i am commiting a mailing list no no by posting this please let me
know, but i thought it would be helpful to confirm this event.

Also is there a bugzilla type system for the linux kernel?

Thank you all for all your work!

any questions please let me know, i am also willing to report a bug
report if there is such a system in place.

--- a/net/ipv4/netfilter/ip_tables.c    2005-03-17 17:35:05 -08:00
+++ b/net/ipv4/netfilter/ip_tables.c    2005-03-17 17:35:05 -08:00
@@ -923,7 +923,7 @@
       }

       /* And one copy for every other CPU */
-       for (i = 1; i < NR_CPUS; i++) {
+       for (i = 1; i < num_possible_cpus(); i++) {
               memcpy(newinfo->entries + SMP_ALIGN(newinfo->size)*i,
                      newinfo->entries,
                      SMP_ALIGN(newinfo->size));
@@ -945,7 +945,7 @@
               struct ipt_entry *table_base;
               unsigned int i;

-               for (i = 0; i < NR_CPUS; i++) {
+               for (i = 0; i < num_possible_cpus(); i++) {
                       table_base =
                               (void *)newinfo->entries
                               + TABLE_OFFSET(newinfo, i);
@@ -992,7 +992,7 @@
       unsigned int cpu;
       unsigned int i;

-       for (cpu = 0; cpu < NR_CPUS; cpu++) {
+       for (cpu = 0; cpu < num_possible_cpus(); cpu++) {
               i = 0;
               IPT_ENTRY_ITERATE(t->entries + TABLE_OFFSET(t, cpu),
                                 t->size,
@@ -1130,7 +1130,7 @@
               return -ENOMEM;

       newinfo = vmalloc(sizeof(struct ipt_table_info)
-                         + SMP_ALIGN(tmp.size) * NR_CPUS);
+                         + SMP_ALIGN(tmp.size) * num_possible_cpus());
       if (!newinfo)
               return -ENOMEM;

@@ -1460,7 +1460,7 @@
               = { 0, 0, 0, { 0 }, { 0 }, { } };

       newinfo = vmalloc(sizeof(struct ipt_table_info)
-                         + SMP_ALIGN(repl->size) * NR_CPUS);
+                         + SMP_ALIGN(repl->size) * num_possible_cpus());
       if (!newinfo)
               return -ENOMEM;



On 10/10/05, David S. Miller <davem@davemloft.net> wrote:
> From: seb@frankengul.org
> Date: Mon, 10 Oct 2005 10:25:07 +0200
>
> > Indeed they are. Does the patch assume that cpus are numbered in a
> > row ?
>
> Yes, and that assumption is incorrect.
>
> > Now, I reverted the patch for ip_tables.c, ip6_tables.c and ebtables.c.
> > Everything is working ok (11h uptime).
>
> Right.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


--
Joseph Murawski
Hartford, CT
