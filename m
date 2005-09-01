Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964778AbVIAKSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbVIAKSN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 06:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964780AbVIAKSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 06:18:13 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:36529 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964778AbVIAKSN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 06:18:13 -0400
Subject: Re: [patch] drivers/ide/pci/alim15x3.c SMP fix
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Rui Nuno Capela <rncbc@rncbc.org>
In-Reply-To: <20050901072430.GA6213@elte.hu>
References: <20050901072430.GA6213@elte.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 01 Sep 2005 11:42:15 +0100
Message-Id: <1125571335.15768.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-09-01 at 09:24 +0200, Ingo Molnar wrote:
> is this the right way to fix the UP assumption below?

Probably not. The ide_lock may already be held (randomly depending on
the code path) at the point we retune a drive on error. Actually you
probably crash before this anyway.

The ALi code in question was written knowing the system would be
uniprocessor and making various related assumptions. You also have to
get this locking right just to make it more fun - loading the timings
for one channel while another is doing I/O corrupts your data silently
in some cases. Fixing the ide_lock to be consistent in usage when the
tuning calls are made (ie fix the reset path and other offenders) might
be possible and would make using ide_lock ok, but it would still be
wrong with pre-emption and/or SMP.

There is currently no sane locking mechanism to enforce or implement
this in the IDE layer.  Welcome to hell, please leave your brain at the
door.

Alan

