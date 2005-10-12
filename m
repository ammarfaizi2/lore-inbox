Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbVJLOj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbVJLOj2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 10:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964798AbVJLOj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 10:39:27 -0400
Received: from pat.uio.no ([129.240.130.16]:58752 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S964797AbVJLOj1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 10:39:27 -0400
Subject: Re: blocking file lock functions (lockf,flock,fcntl) do not return
	after timer signal
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Alex Riesen <raa.lkml@gmail.com>
Cc: boi@boi.at, linux-kernel@vger.kernel.org
In-Reply-To: <81b0412b0510120548k3464d355ne75cce4e5edcce1a@mail.gmail.com>
References: <434CC144.6000504@boi.at>
	 <81b0412b0510120548k3464d355ne75cce4e5edcce1a@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Date: Wed, 12 Oct 2005 10:39:07 -0400
Message-Id: <1129127947.8561.44.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 8BIT
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.727, required 12,
	autolearn=disabled, AWL 2.09, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on den 12.10.2005 Klokka 14:48 (+0200) skreiv Alex Riesen:
> On 10/12/05, "Dieter Müller (BOI GmbH)" <dieter.mueller@boi.at> wrote:
> > bug description:
> >
> > flock, lockf, fcntl do not return even after the signal SIGALRM  has
> > been raised and the signal handler function has been executed
> > the functions should return with a return value EWOULDBLOCK as described
> > in the man pages

Works for me on a local filesystem.

Desktop$ ./gnurr gnarg
locking...
timeout
timeout
timeout
timeout
timeout

However it is true that it doesn't work over NFSv2/v3. The latter is
probably because we use the synchronous NLM calls which block all
signals during the wait in order to avoid state consistency problems (if
the lock gets granted on server after the client was interrupted, then
the administrator gets to clean up the lock).

We can probably relax this requirement a bit, and rely on the CANCEL
call to get us out of trouble.

Cheers,
 Trond

