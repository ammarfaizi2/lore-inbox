Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261613AbUJXXCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbUJXXCI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 19:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbUJXXBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 19:01:55 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:62614 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261612AbUJXXBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 19:01:50 -0400
Subject: Re: [PATCH] SCSI: Replace semaphores with wait_even
From: James Bottomley <James.Bottomley@SteelEye.com>
To: tglx@linutronix.de
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <1098648414.22387.46.camel@thomas>
References: <1098300579.20821.65.camel@thomas>
	<1098647869.10824.247.camel@mulgrave>  <1098648414.22387.46.camel@thomas>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 24 Oct 2004 19:01:23 -0400
Message-Id: <1098658889.10906.361.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-10-24 at 16:06, Thomas Gleixner wrote:
> Hmm, strange. It works on two systems here and others using this
> modification had no problem either. 
> I will check again.

Yes, very strange given what the mistake is:

-               down_interruptible(&sem);
+               wait_event_interruptible(eh_wait, shost->eh_kill ||
+                               (shost->host_busy ==
shost->host_failed));

This condition is always true when the eh thread first starts because
the default quiescent state of a scsi host is

shost->host_busy = shost->host_failed = 0

so your change makes the eh_thread spin forever locking everything else
off the CPU.  On a UP system, this is a complete hang.

James


