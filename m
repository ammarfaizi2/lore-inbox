Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290304AbSAXVTl>; Thu, 24 Jan 2002 16:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290308AbSAXVTb>; Thu, 24 Jan 2002 16:19:31 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:35333 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S290304AbSAXVTR>; Thu, 24 Jan 2002 16:19:17 -0500
Message-ID: <3C5073FF.E9A2806@zip.com.au>
Date: Thu, 24 Jan 2002 12:52:15 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: vda@port.imtp.ilyichevsk.odessa.ua
CC: Ken <koehlekr@ucrwcu.rwc.uc.edu>, linux-kernel@vger.kernel.org,
        bugs@linux-ide.org
Subject: Re: 2.4.17 multiple Oops and file corruption on I845 MB
In-Reply-To: <3C4EE4C8.6FF3B2AF@ucrwcu.rwc.uc.edu>,
		<3C4EE4C8.6FF3B2AF@ucrwcu.rwc.uc.edu> <200201241454.g0OEsIE11368@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> 
> Hmm... what about de-inlining __wake_up_common? It is called in several places,
> 

The kernel inlines stuff too much, and we're sloshing
vast amounts of stuff across the memory bus needlessly.
I suspect this is a  more important issue than all the
stupid FASTCALL, likely() and `goto out_of_line' crud.

I chose to inline __wake_up_common() when I did the
try_to_wake_up() stuff because __wake_up_sync() is almost
never used, and the only other call site was __wake_up().

But now complete() is there too, Its main use will be in
disk driver calls - things like IDE CDROM where `ide_wait'
is used.  Also SCSI uses complete() for synchronous operations
such as ioctls, disk spin-up, etc.  I don't think scsi
uses complete() on a common path.

So __wake_up() remains the single main user of
__wake_up_common(), so __wake_up_common() should remain inline.

-
