Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262260AbSIZJQJ>; Thu, 26 Sep 2002 05:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262262AbSIZJQJ>; Thu, 26 Sep 2002 05:16:09 -0400
Received: from [217.167.51.129] ([217.167.51.129]:49405 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S262260AbSIZJQI>;
	Thu, 26 Sep 2002 05:16:08 -0400
From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: "Pete Zaitcev" <zaitcev@redhat.com>
Cc: <andre@linux-ide.org>, <linux-kernel@vger.kernel.org>, <axboe@suse.de>,
       <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] fix ide-iops for big endian archs
Date: Thu, 26 Sep 2002 00:48:39 +0200
Message-Id: <20020925224839.24517@192.168.4.1>
In-Reply-To: <20020925141946.A14230@devserv.devel.redhat.com>
References: <20020925141946.A14230@devserv.devel.redhat.com>
X-Mailer: CTM PowerMail 4.0.1 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Curently in 2.5 (afaik in -ac too), the ide-iops "s" routines used
>> to transfer datas in/out the data port are incorrect for big endian
>> machines. They are implemented with a loop of inw/outw which are
>> byteswapping, but a fifo transfer like that mustn't be swapped.
>
>Dunno about ppc, but sparc works just fine as it is in 2.4.
>When was the last time you examined include/asm-sparc/ide.h?

I'm talking about 2.4-ac with the new IDE code, not Marcelo
2.4.

>IDE uses ide_insw instead of plain insw specifically to
>resolve this kind of issue, and you are trying to defeat
>the mechanism designed to help you. I smell a fish here.

Again, I'm talking about the new layer. In this, the iops
functions are no longer macros defined by include/asm*/ide.h,
but are now function pointers inside the hwif structure
(so we can now deal with real MMIO or CPU register based IDE
without playing macro tricks in asm*/ide.h).

The problem resides in the default implementation of those
iops in the new ide-iops.c file, which currently re-implements
insw as a loop of IN_WORD, which usually translates to inw,
and thus would cause incorrect endianness.

My patch fixes that. Ultimately, we want to completely get
rid of the uppercase {IN,OUT}{BYTE,WORD,LONG} macros though.

The principle is that ide-iops.c will provide reasonable
"default" ops for PIO (and MMIO if my next patch gets in),
any "different" interface can provide it's own ops, and you
keep the ability to mix different kind of interfaces on the
same machine (like an embeded CPU-register based interface
_and_ a PCI based interface using different iops).

Ben.

