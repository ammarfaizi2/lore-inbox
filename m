Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbWDRQyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbWDRQyg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 12:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbWDRQyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 12:54:35 -0400
Received: from codepoet.org ([166.70.99.138]:8165 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S1751113AbWDRQyf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 12:54:35 -0400
Date: Tue, 18 Apr 2006 10:54:34 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Zinx Verituse <zinx@epicsol.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: Re: ide-cd.c, "MEDIUM_ERROR" handling
Message-ID: <20060418165434.GA27182@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: andersen@codepoet.org,
	Zinx Verituse <zinx@epicsol.org>,
	lkml <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
References: <20060418011839.GA10619@atlantis.chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060418011839.GA10619@atlantis.chaos>
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Apr 17, 2006 at 08:18:39PM -0500, Zinx Verituse wrote:
> I recently bought a DVD drive which appears to not retry enough when it's
> having trouble reading a disc - I'm requesting an option (or changing the
> default behavior) so that this drive is actually usable with the Linux
> ide-cd drivers - specificly, the code:
> 	} else if (sense_key == MEDIUM_ERROR) {
> 		/* No point in re-trying a zillion times on a bad
> 		 * sector...  If we got here the error is not correctable */
> 		ide_dump_status (drive, "media error (bad sector)", stat);
> 		do_end_request = 1;
> 	}
> needs to be disabled for my drive to read CDs properly.

When I originally added this code, the problem I was seeing was
the ide layer was doing 8 retires before it returned to ide-cd,
which then did 8 retries itself.  Thus processing a bad sector
caused no less than 64 reads of the bad sector, all of which
failed, and each of which took a fair amount of time, thereby
keeping user space stuck in D state for over 10 minutes on a
single syscall, which seemed rather bad form...

When I added this code, I was relying on the ide layer to
continue to do its ritualistic 8 retries, after which I assumed
that no further retries would be likely to help and there was no
reason for ide-cd to keep thrashing on the already proven to be
dead sector.  For my purposes, this helped considerably reduce
the amount of time stuck in D state while processing CDs with bad
sectors (such as trying to recover the data off my kid's
massively scratched up game CDs).

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
