Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290289AbSFJLfG>; Mon, 10 Jun 2002 07:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293203AbSFJLfB>; Mon, 10 Jun 2002 07:35:01 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:8631 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S290289AbSFJLfB>; Mon, 10 Jun 2002 07:35:01 -0400
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: External compilation
Date: 10 Jun 2002 11:15:49 GMT
Organization: SuSE Labs, =?ISO-8859-1?Q?Au=DFenstelle?= Berlin
Message-ID: <slrnag92j5.90a.kraxel@bytesex.org>
In-Reply-To: <20020609142602.GA77496@compsoc.man.ac.uk>
NNTP-Posting-Host: localhost
X-Trace: bytesex.org 1023707749 9227 127.0.0.1 (10 Jun 2002 11:15:49 GMT)
User-Agent: slrn/0.9.7.1 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Levon wrote:
>  
>  Is there any good example code for compiling a kernel module
>  externally, that works for modversions etc. on 2.2, 2.4, and 2.5,
>  and does the right thing (including Rules.make) ?
>  
>  I'm having an awful time working out the exact incantations.

Here is a stripped down version of what I use for bttv currently.

  Gerd

==============================[ Makefile ]==============================
# where the kernel sources are located
KDIR := /lib/modules/$(shell uname -r)/build
#KDIR := /work/bk/2.5/build

# kernel version
KVER := $(shell ./uts-release $(KDIR))
MDIR := /lib/modules/$(KVER)/kernel/drivers/media/video

export-objs	:= bttv-if.o video-buf.o
list-multi	:= bttv.o
bttv-objs	:= bttv-driver.o bttv-cards.o bttv-risc.o bttv-if.o bttv-vbi.o

obj-m		:= video-buf.o bttv.o

multi-m		:= $(filter $(list-multi), $(obj-m))
int-m		:= $(sort $(foreach m, $(multi-m), $($(basename $(m))-objs)))

EXTRA_CFLAGS=-g -Wmissing-prototypes -Wstrict-prototypes

here:
	DIR=`pwd`; (cd $(KDIR); make SUBDIRS=$$DIR modules)

include $(KDIR)/Rules.make

bttv.o: $(bttv-objs)
	$(LD) -r -o $@ $(bttv-objs)

==============================[ uts-release ]==============================
#! /bin/sh
cat <<-EOF | cpp -P -I$1/include | grep '"' | cut -d'"' -f2
	#include <linux/version.h>
	UTS_RELEASE
EOF
