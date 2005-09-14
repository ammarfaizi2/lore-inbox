Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932703AbVINKdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932703AbVINKdJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 06:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932705AbVINKdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 06:33:08 -0400
Received: from s1.mailresponder.info ([193.24.237.10]:7692 "EHLO
	s1.mailresponder.info") by vger.kernel.org with ESMTP
	id S932703AbVINKdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 06:33:07 -0400
Subject: Re: 2.6.13 brings buffer underruns when recording DVDs in 16x (was
	Re: "Read my lips: no more merges" - aka Linux 2.6.14-rc1)
From: Mathieu Fluhr <mfluhr@nero.com>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050914013053.0c2b302c.akpm@osdl.org>
References: <Pine.LNX.4.58.0509122019560.3351@g5.osdl.org>
	 <1126608030.3455.23.camel@localhost.localdomain>
	 <1126630878.2066.6.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0509131010010.3351@g5.osdl.org>
	 <1126635160.2183.6.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0509131210090.3351@g5.osdl.org>
	 <1126685479.2010.14.camel@localhost.localdomain>
	 <20050914013053.0c2b302c.akpm@osdl.org>
Content-Type: text/plain
Organization: Nero AG
Date: Wed, 14 Sep 2005 12:32:40 +0200
Message-Id: <1126693960.2061.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-14 at 01:30 -0700, Andrew Morton wrote:
> Mathieu Fluhr <mfluhr@nero.com> wrote:
> >
> > According to the MMC documentation, you can thoeriticaly send at most
> >  65535 (16 bits int) blocks in one WRITE(10) CDB. This would means
> >  sending a buffer of ~127 MB on case of writing a mode 1 data track (2048
> >  bytes per block)...
> > 
> >  Now, practically, it is really not safe to send more than 64 KB per CDB
> >  (Mostly device related). And with such values, you have the following:
> >   - at 100 Hz  -> 64 KB * 100  = 6400 KB/s  <=> ~4.62x  DVD 
> >   - at 250 Hz  -> 64 KB * 250  = 16000 KB/s <=> ~11.55x DVD 
> >   - at 1000 Hz -> 64 KB * 1000 = 64000 KB/s <=> ~46.20x DVD
> 
> But that implies that there's some piece of code somewhere (could be
> userspace, could be kernel) which is doing a timer-based sleep() in between
> each CDB.  It shouldn't do that - it should be using the disk
> controller's completion interrupt for synchronisation.
> 

Hummm... you are definitly right. So forget my calculations. I does not
mean anything. Honestly, I was just trying to find an explanation why it
was working with HZ set to 1000 and not with HZ set to 250 or 100.

> What userspace application are you using to write the DVDs, and is it
> possible to test a different one?

I am using NeroLINUX to make my tests. I also tried out
cdrecord/growisofs, but I was not even able to burn at 16x (I get some
error message that max speed is 10x... and nothing more).

But there seems to be somehow some I/O limitation: I configured a pure
2.6.13.1 to have HZ set to 100. I then made a 3 GB compilation with
small files (about 3 to 5 MB each).
 - If you burn this directly without creating a temp ISO image in 4x
(5440 KB/s), you will get buffer underruns soon or later... (about 2%)
 - If you create an ISO image out of the compilation (using mkisofs or
other tool), and then burn this image, then no buffer underruns occurs.

After that, you speed up your recorder with this image (for example at
8x), you will have these buffer underruns back again.
And as I tell you, no such stuff is happening when HZ is set to 1000.

> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

