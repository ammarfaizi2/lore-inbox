Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264125AbVBDXmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264125AbVBDXmG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 18:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263139AbVBDXmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 18:42:05 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:58588 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261718AbVBDXlR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 18:41:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Opc2de0IsikwSz4e39NbE0qeWNfesq8Jw6c0oEvrgP5Cvl9ndRMaChv5MGNr6UAeTv/WS0m1VsN8QQugszHrrrptAEkNYk7dL2Utyz++RoVtCmzDo+j2GnsILujyRK0QDoB3n4zkaDjTeNZJXFczJu6vEzthDMYUtwth8n+n3hU=
Message-ID: <58cb370e050204154155cafb20@mail.gmail.com>
Date: Sat, 5 Feb 2005 00:41:11 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: 2.6.11-rc3-bk1: ide1: failed to initialize IDE interface
Cc: LKML <linux-kernel@vger.kernel.org>, Prarit Bhargava <prarit@sgi.com>
In-Reply-To: <20050204234422.4a9c6fd0.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050204234422.4a9c6fd0.khali@linux-fr.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Feb 2005 23:44:22 +0100, Jean Delvare <khali@linux-fr.org> wrote:
> Hi all,
> 
> I just gave a quick try to 2.6.11-rc3-bk1, and noticed the following
> new message in dmesg:
> ide1: failed to initialize IDE interface
> 
> This seems to be new in 2.6.11-rc3-bk1. I could find the relevant
> changeset in bk:
> http://linux.bkbits.net:8080/linux-2.5/cset@1.1992.9.16
> 
> My (admittedly quick) analysis of the code (drivers/ide/ide-probe.c) is
> that init_hwif() can return 0 in two cases: either because the IDE
> interface is somehow not really there (!hwif->present) or because
> something wrong happened while initializing the IDE interface. My
> system's ide1 happens to be enabled (BIOS settings) but no IDE device is
> connected to it. I traced the code and it unsurprisingly happens that I
> am in the first "error" case - init_hwif() exits immediately because
> !hwif->present.
> 
> I would tend to think that this is *not* an error, so we shouldn't
> display an error message in this case. Maybe init_hwif() should return 1

Yep this is the simplest fix - interface without a drives should
return success value.  Care to make a patch?

> instead of 0 in this case. Or maybe it should return -1, 0 and 1 for
> error, no interface and success, respectively. I'm not certain I
> understand the semantics behind the returned value, does it mean
> error/success or interface absent/present (or a bit of each)? Or maybe

Return value currently means only error/success
and till the latest patch this value was ignored completely.

> we could move the error message into init_hwif() itself, but that would
> require some error path changes.
> 
> I do not propose a patch because I'm not exactly sure what has to be
> done, but I still believe something has to be done. Insight anyone?
> 
> Thanks,
> --
> Jean Delvare
>
