Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751184AbVLLUuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbVLLUuY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 15:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbVLLUuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 15:50:24 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:9607 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S1751184AbVLLUuX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 15:50:23 -0500
Date: Mon, 12 Dec 2005 21:50:19 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Carlos Munoz <carlos@kenati.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can't build loadable module for 2.6.kernel
Message-ID: <20051212205019.GB7656@mars.ravnborg.org>
References: <439DD4F8.3040709@kenati.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <439DD4F8.3040709@kenati.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2005 at 11:52:24AM -0800, Carlos Munoz wrote:
> Hi all,
> 
> I hope this is the right forum for this question.
Yes.

> The makefile has the following rule to build apicnt.o:
> apicnt.o: apicnt.o.shipped
>    cp apicnt.o.shipped apicnt.o

This is wrong. kbuild has knowledge how to copy a file named:
apicnt.o_shippd to apicnt.o
So you renamed the supplied .o fiel to apicnt.o_shipped and delte your
own rule.


> #
> # Makefile for the phone_mrvl driver loadable module
> #
> TARGET = phone_mrvl.o
> 
> obj-$(CONFIG_PHONE_MARVELL) = phone_mrvl.o
> 
> ifeq ($(CONFIG_PHONE_LEGERITY),y)
> phone_mrvl-objs = mrvphone.o slic.o legerity.o vp_hal.o sys_service.o apicnt.o apiinit.o apiquery.o vp_api.o vp_api_common.o mvutils.o
> endif
Please do:
phone_mrvl-$(CONFIG_PHONE_LEGERITY) := mrvphone.o slic.o legerity.o 
phone_mrvl-$(CONFIG_PHONE_LEGERITY) += vp_hal.o sys_service.o apicnt.o 
phone_mrvl-$(CONFIG_PHONE_LEGERITY) += apiinit.o apiquery.o vp_api.o
phone_mrvl-$(CONFIG_PHONE_LEGERITY) += vp_api_common.o mvutils.o

> 
> ifeq ($(CONFIG_PHONE_PROSLIC),y)
> phone_mrvl-objs = mrvphone.o proslic.o
> endif
phone_mrvl-$(CONFIG_PHONE_PROSLIC) += mrvphone.o proslic.o

> 
> CFLAGS += -D__linux__
> EXTRA_CFLAGS += -Idrivers/telephony/mrvphone
> EXTRA_CFLAGS += -DNDEBUG -Dlinux -D__linux__ -Dunix -DEMBED -DLINUX -DHOST_LE
> 
> ifeq ($(CONFIG_PHONE_LEGERITY),y)
> EXTRA_CFLAGS += -D__LEGERITY__
> endif
> ifeq ($(CONFIG_PHONE_PROSLIC),y)
> EXTRA_CFLAGS += -D__PROSLIC__
> endif
Here you could do:
extra-cflags-$(CONFIG_PHONE_LEGERITY) += -D__LEGERITY__
extra-cflags-$(CONFIG_PHONE_PROSLIC)  += -D__PROSLIC__
EXTRA_CFLAGS += $(extra-cflags-y)

Please delete the rest - it is not needed.
> all: $(TARGET)
> 
> $(TARGET): $(OBJS)
> 	$(LD) -r $(OBJS) -o $(TARGET)
> 
> clean:
> 	-rm -f $(TARGET) *.elf *.gdb *.o
> 
> apicnt.o: apicnt.o.shipped
> 	cp apicnt.o.shipped apicnt.o

When you build your module use:
make -C $PATH_TO_COMPILED_KERNEL M=`pwd`

See also Documentation/kbuild/modules.txt for further reference.

	Sam
