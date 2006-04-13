Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbWDMPDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbWDMPDc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 11:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbWDMPDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 11:03:32 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:33436 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1750750AbWDMPDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 11:03:31 -0400
Subject: Re: [PATCH 1/2] aic7xxx: deinline large functions, save 80k of text
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: Andrew Morton <akpm@osdl.org>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, arjan@infradead.org, hare@suse.de,
       gibbs@scsiguy.com, eike-kernel@sf-tec.de, stefanr@s5r6.in-berlin.de
In-Reply-To: <200604120945.34419.vda@ilport.com.ua>
References: <200604120945.34419.vda@ilport.com.ua>
Content-Type: text/plain
Date: Thu, 13 Apr 2006 10:02:36 -0500
Message-Id: <1144940556.3474.10.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-12 at 09:45 +0300, Denis Vlasenko wrote:
> This patch
> 
> moves big inlines into aic79xx_core.c and aic7xxx_core.c
> makes ahd_delay just a wrapper around udelay
> marks a few functions static
> fixes spelling fix in error message

There are two things that really spring to mind here

1. This alters the Adaptec HIM layer (the machine independent bit).  I
think no one cares about this anymore, so that's fine.  However, if
you're going to do this, do it properly, so get rid of the superfluous
HIM layer abstractions like this:

#define ahd_timer_init init_timer
#define ahd_timer_stop del_timer_sync
typedef void ahd_linux_callback_t (u_long);  

Just make it use the linux types natively.

2. There's no actual code content to this, which always makes me
reluctant to accept changes.  However, I notice this alters the inb/outb
abstractions, so what you could do, if you were feeling brave is
eliminate the Adaptec implementation of ioread8/iowrite8 and replace it
with the linux one (i.e. use ioport_map if the card really wants port
I/O).  This has been on my Todo list for a long time; even if you
haven't got the hardware, Hannes and I can test it for you.

Note that you can't use ioread16 or any of the longer reads or writes.
The adaptec cards have terrible problems with write combining, so
everything needs to still be done in terms of ioread8/iowrite8

James


