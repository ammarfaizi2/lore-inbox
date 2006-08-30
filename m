Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751324AbWH3TGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbWH3TGF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 15:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWH3TGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 15:06:05 -0400
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:31178 "EHLO
	taverner.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S1751324AbWH3TGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 15:06:02 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [S390] cio: kernel stack overflow.
Date: Wed, 30 Aug 2006 19:05:54 +0000 (UTC)
Organization: University of California, Berkeley
Message-ID: <ed4nih$gb0$2@taverner.cs.berkeley.edu>
References: <20060830124047.GA22276@skybase>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: taverner.cs.berkeley.edu 1156964754 16736 128.32.168.222 (30 Aug 2006 19:05:54 GMT)
X-Complaints-To: news@taverner.cs.berkeley.edu
NNTP-Posting-Date: Wed, 30 Aug 2006 19:05:54 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for pointing out that in most cases there was immediately
preceding code that zeroes out the whole struct using kzalloc() or
memset(.., 0, ..).  Sorry that I overlooked that; my mistake.  That
takes care of all but one of these.  But in the interests of caution,
let me ask about the following one:

Martin Schwidefsky  wrote:
>-		cdev->id = (struct ccw_device_id) {
>-			.cu_type   = cdev->private->senseid.cu_type,
>-			.cu_model  = cdev->private->senseid.cu_model,
>-			.dev_type  = cdev->private->senseid.dev_type,
>-			.dev_model = cdev->private->senseid.dev_model,
>-		};
>+		cdev->id.cu_type   = cdev->private->senseid.cu_type;
>+		cdev->id.cu_model  = cdev->private->senseid.cu_model;
>+		cdev->id.dev_type  = cdev->private->senseid.dev_type;
>+		cdev->id.dev_model = cdev->private->senseid.dev_model;

I don't see any obvious place that zeroes out cdev->id.
In particular, it looks like cdev->id.match_flags and .driver_info
are never cleared (i.e., they retain whatever old garbage they had
before).  More importantly, if anyone ever adds any more fields to
struct ccw_device_id, then they will also be retain old garbage values,
which is a maintenance pitfall.  Is this right, or did I miss something
again?
