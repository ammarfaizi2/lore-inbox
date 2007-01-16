Return-Path: <linux-kernel-owner+w=401wt.eu-S1751462AbXAPJqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbXAPJqc (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 04:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbXAPJqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 04:46:32 -0500
Received: from mx1.suse.de ([195.135.220.2]:44748 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751462AbXAPJqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 04:46:31 -0500
From: Oliver Neukum <oneukum@suse.de>
Organization: Novell
To: "Jerome Lacoste" <jerome.lacoste@gmail.com>
Subject: Re: khubd taking 100% CPU after unproperly removing USB webcam
Date: Tue, 16 Jan 2007 10:46:29 +0100
User-Agent: KMail/1.9.1
Cc: lkml <linux-kernel@vger.kernel.org>
References: <5a2cf1f60701160110v68342cf5lbc364ffae568cd1@mail.gmail.com>
In-Reply-To: <5a2cf1f60701160110v68342cf5lbc364ffae568cd1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701161046.29262.oneukum@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 16. Januar 2007 10:10 schrieb Jerome Lacoste:
> Hi,
> 
> I unplugged my (second) webcam, forgotting to stop ekiga, and khubd is
> now taking 100% CPU.
> 
> - lsusb doesn't return
> - /etc/init.d/udev restart didn't resolve the problem.
> 
> Is that a problem one may want to investigate or should I just forget
> about it (problem being cause by a user error)?

If your are using this driver
http://mxhaard.free.fr/download.html

then it appears that it most likely hanging here:

	for (n = 0; n < SPCA50X_NUMFRAMES; n++)
		if (waitqueue_active(&spca50x->frame[n].wq))
			wake_up_interruptible(&spca50x->frame[n].wq);
	if (waitqueue_active(&spca50x->wq))
		wake_up_interruptible(&spca50x->wq);
	gspca_kill_transfert(spca50x);
	PDEBUG(3, "Disconnect Kill isoc done");
	up(&spca50x->lock);
	while (spca50x->user)
		schedule();

This driver's disconnect handling is buggy. As this is an out of tree
driver, please contact the original author.

	Regards
		Oliver
