Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbWEOTYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbWEOTYF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 15:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750880AbWEOTYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 15:24:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39830 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751214AbWEOTYC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 15:24:02 -0400
Date: Mon, 15 May 2006 12:26:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de,
       Jean Delvare <khali@linux-fr.org>,
       Kumar Gala <galak@kernel.crashing.org>
Subject: Re: 2.6.17-rc4-mm1
Message-Id: <20060515122613.32661c02.akpm@osdl.org>
In-Reply-To: <6bffcb0e0605151210x21eb0d24g96366ce9c121c26c@mail.gmail.com>
References: <20060515005637.00b54560.akpm@osdl.org>
	<6bffcb0e0605151137v25496700k39b15a40fa02a375@mail.gmail.com>
	<20060515115302.5abe7e7e.akpm@osdl.org>
	<6bffcb0e0605151210x21eb0d24g96366ce9c121c26c@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:
>
> On 15/05/06, Andrew Morton <akpm@osdl.org> wrote:
> > "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:
> > >
> > > Hi,
> > >
> > > On 15/05/06, Andrew Morton <akpm@osdl.org> wrote:
> > > >
> > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc4/2.6.17-rc4-mm1/
> > > >
> > >
> > > When I try to "modprobe -r i2c_i801" modprobe hangs
> > >
> > > [michal@ltg01-fedora ~]$ ps aux | grep mod
> > > root      5943  0.0  0.0   1648   432 tty1     D+   20:15   0:00
> > > modprobe -r i2c_i801
> > > michal   15499  0.0  0.0   1836   496 pts/4    S+   20:33   0:00 grep mod
> > >
> > > Here is strace log
> > > http://www.stardust.webpages.pl/files/mm/2.6.17-rc4-mm1/strace.txt
> > > Here is config http://www.stardust.webpages.pl/files/mm/2.6.17-rc4-mm1/mm-config
> > >
> > > 2.6.17-rc3-mm1 was fine. I don't see nothing abnormal in dmesg.
> > >
> >
> > Are you able to get a sysrq-P and/or sysrq-T trace out of it?
> >
> 
> Something like
> echo "t" > /proc/sysrq-trigger
> modprobe -r i2c_i801
> echo "t" > /proc/sysrq-trigger
> ?
> http://www.stardust.webpages.pl/files/mm/2.6.17-rc4-mm1/mm-dmesg2

Great, thanks.   Here's the relevant part:

modprobe      D 00000019  2740  2163   2129                     (NOTLB)
       f0915e60 f1d7b694 8422805f 00000019 f0915e08 c10819a3 f1d7b694 f0915e18 
       00000007 f7e5f374 f7e5f250 f7f0f110 c741cf00 8429b934 00000019 000738d5 
       00000001 f1e6ac54 c101732e f0915e48 c10168d4 f887dba0 00000246 00000001 
Call Trace:
 <c11d768e> wait_for_completion+0x8e/0x108   <c1180fae> i2c_del_adapter_nolock+0x255/0x277
 <c1180fe7> i2c_del_adapter+0x17/0x28   <f887c023> i801_remove+0xd/0x2f [i2c_i801]
 <c10eeb69> pci_device_remove+0x19/0x2c   <c11395a7> __device_release_driver+0x63/0x79
 <c1139889> driver_detach+0x94/0xc4   <c1138d58> bus_remove_driver+0x5d/0x79
 <c11399a2> driver_unregister+0xb/0x18   <c10eecd4> pci_unregister_driver+0x13/0xa5
 <f887c9a5> i2c_i801_exit+0xd/0xf [i2c_i801]   <c103d3a8> sys_delete_module+0x19e/0x1d6
 <c11dab67> sysenter_past_esp+0x54/0x75  

I'd assume that Kumar's i2c-add-support-for-virtual-i2c-adapters.patch is
the culprit.

> I'm not sure why when I do "echo "p" > /proc/sysrq-trigger" I get only this
> [root@ltg01-fedora ~]# echo "p" > /proc/sysrq-trigger
> SysRq : Show Regs
> 
> selinux?

The `p' command isn't effective when using /proc/sysrq-trigger.  `p' will
show the backtrace of the currently-running process (on the current cpu). 
That task is always "echo".  Boring.  So `p' is really only useful when
invoked from interrupt context, via sysrq-p.
