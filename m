Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269613AbUI3XQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269613AbUI3XQn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 19:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269611AbUI3XQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 19:16:37 -0400
Received: from smtp06.auna.com ([62.81.186.16]:9884 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S269610AbUI3XQa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 19:16:30 -0400
Date: Thu, 30 Sep 2004 23:16:29 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: Stack traces in 2.6.9-rc2-mm4
To: linux-kernel@vger.kernel.org
References: <6.1.2.0.2.20040927184123.019b48b8@tornado.reub.net>
	<20040927085744.GA32407@elte.hu> <1096326753l.5222l.2l@werewolf.able.es>
	<20040928072123.GA15177@elte.hu> <1096581484l.9853l.0l@werewolf.able.es>
	<20040930225640.GA6441@elte.hu>
In-Reply-To: <20040930225640.GA6441@elte.hu> (from mingo@elte.hu on Fri Oct 
	1 00:56:40 2004)
X-Mailer: Balsa 2.2.4
Message-Id: <1096586189l.5206l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004.10.01, Ingo Molnar wrote:
> 
> * J.A. Magallon <jamagallon@able.es> wrote:
> 
> > Sep 30 23:54:41 werewolf pumpd[9843]: intf: broadcast: 255.255.255.255
> > Sep 30 23:54:41 werewolf pumpd[9843]: intf: network: 82.198.40.0
> > Sep 30 23:54:41 werewolf kernel: using smp_processor_id() in preemptible 
> > code: pump/9843
> > Sep 30 23:54:41 werewolf kernel:  [smp_processor_id+135/141] 
> > smp_processor_id+0x87/0x8d
> > Sep 30 23:54:41 werewolf kernel:  [<b011bc8f>] smp_processor_id+0x87/0x8d
> > Sep 30 23:54:41 werewolf kernel:  [pg0+1079594592/1337930752] 
> > death_by_timeout+0x11/0x65 [ip_conntrack]
> > Sep 30 23:54:41 werewolf kernel:  [<f099fe60>] death_by_timeout+0x11/0x65 
> > [ip_conntrack]
> 
> does the patch below fix these for you?
> 
> 	Ingo
> 
> --- include/linux/netfilter_ipv4/ip_conntrack.h.orig
> +++ include/linux/netfilter_ipv4/ip_conntrack.h
> @@ -311,7 +311,7 @@ struct ip_conntrack_stat
>  	unsigned int expect_delete;
>  };
>  
> -#define CONNTRACK_STAT_INC(count) (__get_cpu_var(ip_conntrack_stat).count++)
> +#define CONNTRACK_STAT_INC(count) (per_cpu(ip_conntrack_stat, _smp_processor_id()).count++)
>  
>  /* eg. PROVIDES_CONNTRACK(ftp); */
>  #define PROVIDES_CONNTRACK(name)                        \

Yes, It has killed the stack trace.
But this messa from ACPI (I suspect it is unrelated) stays:

Oct  1 01:14:33 werewolf pumpd[5813]: intf: numDns: 2
Oct  1 01:14:33 werewolf pumpd[5813]: intf: broadcast: 255.255.255.255
Oct  1 01:14:33 werewolf pumpd[5813]: intf: network: 82.198.40.0
Oct  1 01:14:33 werewolf kernel: ACPI: PCI interrupt 0000:03:0a.0[A] -> GSI 22 (level, low) -> IRQ 22
Oct  1 01:14:33 werewolf pumpd[5813]: configured interface eth0
Oct  1 01:14:33 werewolf ifup:  done.

Thanks.

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.1 (Community) for i586
Linux 2.6.9-rc2-mm4 (gcc 3.4.1 (Mandrakelinux (Alpha 3.4.1-3mdk)) #1


