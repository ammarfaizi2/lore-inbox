Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751164AbWH3RJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbWH3RJU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 13:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbWH3RJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 13:09:20 -0400
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:52973 "EHLO
	taverner.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S1751164AbWH3RJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 13:09:19 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [S390] cio: kernel stack overflow.
Date: Wed, 30 Aug 2006 17:09:12 +0000 (UTC)
Organization: University of California, Berkeley
Message-ID: <ed4gno$d29$1@taverner.cs.berkeley.edu>
References: <20060830124047.GA22276@skybase>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: taverner.cs.berkeley.edu 1156957752 13385 128.32.168.222 (30 Aug 2006 17:09:12 GMT)
X-Complaints-To: news@taverner.cs.berkeley.edu
NNTP-Posting-Date: Wed, 30 Aug 2006 17:09:12 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Have you checked that in all cases all fields of the struct have
been overwritten?  For instance, look at this:

Martin Schwidefsky  wrote:
>-	chp->dev = (struct device) {
>-		.parent  = &css[0]->device,
>-		.release = chp_release,
>-	};
>+	chp->dev.parent = &css[0]->device;
>+	chp->dev.release = chp_release;

Doesn't this leave chp->dev.bus still holding whatever old value it
had laying around before?  Unless I'm missing something, it looks to
me like this diff causes a change in the semantics of the code.

Perhaps it would be better to memset() the entire struct (chp->dev, in
this case) to zero, before assigning to individual fields, so there is
no possibility of old remnant data still being left laying around?
