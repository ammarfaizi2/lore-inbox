Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268751AbUIGXRO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268751AbUIGXRO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 19:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268749AbUIGXRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 19:17:13 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:65474
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S268751AbUIGXOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 19:14:38 -0400
Date: Tue, 7 Sep 2004 16:11:40 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: willy@debian.org, jbarnes@engr.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: multi-domain PCI and sysfs
Message-Id: <20040907161140.29fbfccc.davem@davemloft.net>
In-Reply-To: <9e47339104090715585fa4f8af@mail.gmail.com>
References: <9e4733910409041300139dabe0@mail.gmail.com>
	<200409041527.50136.jbarnes@engr.sgi.com>
	<9e47339104090415451c1f454f@mail.gmail.com>
	<200409041603.56324.jbarnes@engr.sgi.com>
	<20040905230425.GU642@parcelfarce.linux.theplanet.co.uk>
	<9e473391040905165048798741@mail.gmail.com>
	<20040906014058.GV642@parcelfarce.linux.theplanet.co.uk>
	<9e47339104090715585fa4f8af@mail.gmail.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Sep 2004 18:58:53 -0400
Jon Smirl <jonsmirl@gmail.com> wrote:

> > $ ls -1 /sys/devices/
> > pci0000:00
> > pci0000:80
> > pci0000:a0
> > pci0000:c0
> > platform
> > system
> 
> How many active VGA devices can I have in this system 1 or 4? If the
> answer is 4, how do I independently address each VGA card? If the
> answer is one, you can see why I want a pci0000 node to hold the
> attribute for turning it off and on.

I don't know about the above but for a multi-domain system the
way it works is that the I/O ports are accessed using a different
base address for each domain.

On my box I/O space looks like:

7ffed000000-7ffedffffff : SCHIZO0 PBMA
  7ffed000300-7ffed0003ff : 0000:00:04.0
    7ffed000300-7ffed0003fe : qlogicfc
7ffef000000-7ffefffffff : SCHIZO0 PBMB
  7ffef000300-7ffef0003ff : 0001:00:06.0
    7ffef000300-7ffef0003ff : sym53c8xx
  7ffef000400-7ffef0004ff : 0001:00:06.1
    7ffef000400-7ffef0004ff : sym53c8xx

SCHIZO is the PCI controller name, there are two PCI segments.

davem@nuts:~$ ls /sys/devices/pci*
/sys/devices/pci0000:00:
0000:00:00.0  0000:00:01.0  0000:00:04.0  detach_state

/sys/devices/pci0001:00:
0001:00:00.0  0001:00:03.0  0001:00:05.2  0001:00:06.1
0001:00:01.0  0001:00:05.0  0001:00:05.3  detach_state
0001:00:02.0  0001:00:05.1  0001:00:06.0
davem@nuts:~$ 

So to access some VGA port on domain zero the
address would likely end up being:

	0x7ffed000000 + VGA_FOO

This is a real touchy area btw, because if there is no
VGA card, such I/O port accesses are going to trap and
we need to have a common way to handle that somehow.

