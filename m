Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261969AbRFLPf0>; Tue, 12 Jun 2001 11:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261988AbRFLPfR>; Tue, 12 Jun 2001 11:35:17 -0400
Received: from firewall.ocs.com.au ([203.34.97.9]:13043 "EHLO ocs4.ocs-net")
	by vger.kernel.org with ESMTP id <S261969AbRFLPfO>;
	Tue, 12 Jun 2001 11:35:14 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "David S. Miller" <davem@redhat.com>
cc: DJBARROW@de.ibm.com, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: bug in /net/core/dev.c 
In-Reply-To: Your message of "Tue, 12 Jun 2001 07:57:56 MST."
             <15142.11764.844524.381111@pizda.ninka.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 13 Jun 2001 01:34:19 +1000
Message-ID: <9802.992360059@ocs4.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jun 2001 07:57:56 -0700 (PDT), 
"David S. Miller" <davem@redhat.com> wrote:
>You need to find a way to link in the S390 network drivers after the
>net/ module so that the drivers run their init after net_dev_init()
>runs.

Tricky.

net_dev_init() is in net/core/dev.c which is linked into
net/core/core.o which is linked into net/network.o which is linked into
vmlinux as part of $(NETWORKS).

drivers/s390/net creates drivers/s390/net/s390-net.o which is linked
into drivers/s390/io.o which is part of $(CORE_FILES), not $(DRIVERS).

$(NETWORKS) is linked _after_ both $(CORE_FILES) and $(DRIVERS).

Have I mentioned recently how much I hate the "link order depends on
Makefile compile order, except where fudged by special case Makefiles"
method?

David, how do any network drivers that need net_dev_init() work when
all $(DRIVERS) come before $(NETWORKS)?  This is a generic problem, not
s390 specific.

AFAICT net_dev_init() needs to be promoted ahead of $(DRIVERS), either
as minimal code or by moving all of $(NETWORKS).  Then moving
drivers/s390/io.o to $(DRIVERS) instead of $(CORE_FILES) will fix the
problem.

