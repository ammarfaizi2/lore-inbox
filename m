Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267436AbTCEPsW>; Wed, 5 Mar 2003 10:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267433AbTCEPsU>; Wed, 5 Mar 2003 10:48:20 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:15502 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S267431AbTCEPsP>; Wed, 5 Mar 2003 10:48:15 -0500
Date: Wed, 5 Mar 2003 09:58:40 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: chas williams <chas@locutus.cmf.nrl.navy.mil>
cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][ATM] make atm (and clip) modular + try_module_get() 
In-Reply-To: <200303051443.h25EhlGi006161@locutus.cmf.nrl.navy.mil>
Message-ID: <Pine.LNX.4.44.0303050952010.31461-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Mar 2003, chas williams wrote:

> In message <Pine.LNX.4.44.0303031825240.16397-100000@chaos.physics.uiowa.edu>,K
> ai Germaschewski writes:
> >Not terribly important, but you can write this as:
> >obj-$(CONFIG_ATM)	+= atm.o
> >atm-y			+= addr.o pvc.o signaling.o svc.o ...
> >atm-$(CONFIG_PROC_FS)	+= proc.o
> 
> after looking at some other examples, i guess i like this even better:
> 
> 
> ipcommon-obj-$(subst m,y,$(CONFIG_ATM_CLIP)) := ipcommon.o
> ipcommon-obj-$(subst m,y,$(CONFIG_NET_SCH_ATM)) := ipcommon.o
> 
> atm-objs        := addr.o pvc.o signaling.o svc.o common.o atm_misc.o raw.o resources.o $(ipcommon-obj-y)
> 
> obj-$(CONFIG_ATM) += atm.o
> atm-$(CONFIG_PROC_FS) += proc.o

Well, this is IMO confusing since now you're using two different ways to 
add to atm.o in the same Makefile.

The preferred way would be:

obj-$(CONFIG_ATM) += atm.o

atm-y := addr.o pvc.o signaling.o svc.o common.o atm_misc.o raw.o resources.o
atm-$(subst m,y,$(CONFIG_ATM_CLIP))	+= ipcommon.o
atm-$(subst m,y,$(CONFIG_NET_SCH_ATM))	+= ipcommon.o
atm-$(CONFIG_PROC_FS)			+= proc.o

You could write this as

obj-$(CONFIG_ATM) += atm.o

atm-obj-$(subst m,y,$(CONFIG_ATM_CLIP))		+= ipcommon.o
atm-obj-$(subst m,y,$(CONFIG_NET_SCH_ATM))	+= ipcommon.o
atm-obj-$(CONFIG_PROC_FS)			+= proc.o
atm-objs := addr.o pvc.o signaling.o svc.o common.o atm_misc.o raw.o \
	 resources.o $(atm-obj-y)

But I'd really like you to use the former. I know this is currently 
handled inconsistently throughout the Makefiles, at some point I'll 
hopefully get around to converting things to the "new-style" above.

--Kai


