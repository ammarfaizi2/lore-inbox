Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbVEFK0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbVEFK0i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 06:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbVEFK0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 06:26:38 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:4309 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261156AbVEFK0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 06:26:34 -0400
Date: Fri, 6 May 2005 12:26:33 +0200
From: Jan Kara <jack@suse.cz>
To: Alexander Nyberg <alexn@telia.com>
Cc: cron <cron@artstyle.ru>, akpm@osdl.org, sct@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: Assertion failure in log_do_checkpoint(): "drop_count != 0 || cleanup_ret != 0"
Message-ID: <20050506102633.GD25677@atrey.karlin.mff.cuni.cz>
References: <20050504174350.GA2498@ns> <1115312290.2095.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="TiqCXmo5T1hvSQQg"
Content-Disposition: inline
In-Reply-To: <1115312290.2095.12.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TiqCXmo5T1hvSQQg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> ons 2005-05-04 klockan 21:43 +0400 skrev cron:
> > Got a 2.6.12-rc3 spontaneous reboot on i386 SMP after about 20h of 
> > moderate web serving. 2.6.11-rc1-bk6 works well for a week or more but
> > leaks memory at about 16 Mb/day and needs reboot thereafter. :(
> > 
> > Can you please give advice how to interpret this log:
> 
> I'm quite certain I've hit this twice today. Can't be 100% sure but the
> bottom of the traces looked just like this and RIP was at
> log_do_checkpoint(). Once sporadically and another time trying to hit
> it. The workload both times was having two separate kernel trees, both
> were 2.6.12-rc2-mm something and then in both of the trees I did ketchup
> 2.6.12-rc3-mm3 in both trees more or less at the same time.
  Could you please try the attached patch? It should fix the bug.
Stephen has thought off a better long-term fix but was busy with other
things last weeks so I didn't get to coding it yet...

> So then I ran two concurrent while loops ketchuping trees. Something
> like:
> #!/bin/sh
> 
> while true
> do
>         ~/bin/ketchup 2.6.11-rc3-mm2
>         ~/bin/ketchup 2.6-mm
>         ~/bin/ketchup 2.6.11
>         ~/bin/ketchup 2.6.11-rc1
> done
> 
> 
> It took less than an hour to purposefully hit the bug with this here. No
> guarantees it will happen consistently however...
> 
> This is a dual cpu x64 with preempt running 2.6.12-rc3. I'm
> attaching .config if it is of interest to anyone.

									Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

--TiqCXmo5T1hvSQQg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="jbd-2.6.12-rc2-checkpoint.diff"

Fix possible false assertion failure in JBD checkpointing code.

Signed-off-by: Jan Kara <jack@suse.cz>

diff -rupX /home/jack/.kerndiffexclude linux-2.6.12-rc2/fs/jbd/checkpoint.c linux-2.6.12-rc2-checkpoint/fs/jbd/checkpoint.c
--- linux-2.6.12-rc2/fs/jbd/checkpoint.c	2005-03-03 18:58:29.000000000 +0100
+++ linux-2.6.12-rc2-checkpoint/fs/jbd/checkpoint.c	2005-04-05 13:26:42.000000000 +0200
@@ -339,8 +339,10 @@ int log_do_checkpoint(journal_t *journal
 			}
 		} while (jh != last_jh && !retry);
 
-		if (batch_count)
+		if (batch_count) {
 			__flush_batch(journal, bhs, &batch_count);
+			retry = 1;
+		}
 
 		/*
 		 * If someone cleaned up this transaction while we slept, we're

--TiqCXmo5T1hvSQQg--
