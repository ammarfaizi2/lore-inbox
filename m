Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751520AbWHMVd3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520AbWHMVd3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 17:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751517AbWHMVd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 17:33:29 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:27556 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751503AbWHMVd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 17:33:28 -0400
Date: Sun, 13 Aug 2006 23:34:44 +0200
From: Jan Kara <jack@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to lock current->signal->tty
Message-ID: <20060813213444.GC11528@atrey.karlin.mff.cuni.cz>
References: <1155050242.5729.88.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <1155050242.5729.88.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> The biggest crawly horror I've found so far in auditing the tty locking
> is current->signal->tty. The tty layer currently and explicitly protects
> this using tty_mutex. The core kernel likewise knows about this.
> 
> Unfortunately:
> 	SELinux doesn't do any locking at all
> 	Dquot passes the tty to tty_write_message without locking
  Ok, is something like attached patch fine?

								Honza

--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="quota-2.6.17-1-tty_fix.diff"

Add proper locking when using current->signal->tty.

Signed-off-by: Jan Kara <jack@suse.cz>

diff -rupX /home/jack/.kerndiffexclude linux-2.6.17/fs/dquot.c linux-2.6.17-1-quota_tty_fix/fs/dquot.c
--- linux-2.6.17/fs/dquot.c	2006-08-14 09:11:29.000000000 +0200
+++ linux-2.6.17-1-quota_tty_fix/fs/dquot.c	2006-08-14 09:29:32.000000000 +0200
@@ -834,6 +834,9 @@ static void print_warning(struct dquot *
 	if (!need_print_warning(dquot) || (flag && test_and_set_bit(flag, &dquot->dq_flags)))
 		return;
 
+	mutex_lock(&tty_mutex);
+	if (!current->signal->tty)
+		goto out_lock;
 	tty_write_message(current->signal->tty, dquot->dq_sb->s_id);
 	if (warntype == ISOFTWARN || warntype == BSOFTWARN)
 		tty_write_message(current->signal->tty, ": warning, ");
@@ -861,6 +864,8 @@ static void print_warning(struct dquot *
 			break;
 	}
 	tty_write_message(current->signal->tty, msg);
+out_lock:
+	mutex_unlock(&tty_mutex);
 }
 
 static inline void flush_warnings(struct dquot **dquots, char *warntype)

--tKW2IUtsqtDRztdT--
