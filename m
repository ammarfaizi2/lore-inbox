Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbWAYUz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbWAYUz0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 15:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWAYUz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 15:55:26 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45451 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751124AbWAYUzZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 15:55:25 -0500
Date: Wed, 25 Jan 2006 20:55:10 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Lars Marowsky-Bree <lmb@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] device-mapper snapshot: barriers not supported
Message-ID: <20060125205510.GW4280@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, Lars Marowsky-Bree <lmb@suse.de>,
	linux-kernel@vger.kernel.org
References: <20060120211759.GG4724@agk.surrey.redhat.com> <20060122214111.11170cdc.akpm@osdl.org> <20060123155605.GP2366@marowsky-bree.de> <20060123131446.3cfc0c1e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060123131446.3cfc0c1e.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2006 at 01:14:46PM -0800, Andrew Morton wrote:
> Lars Marowsky-Bree <lmb@suse.de> wrote:
> > Now the interesting question is what happens when barriers are suddenly
> > verboten on a stack which used to support them - because the new mapping
> > doesn't support it _anymore_. Hrm. _Should_ work, but probably not
> > tested much ;-)

> I don't understand that, sorry.
 
> My concern is: has the above change any potential to cause
> currently-working setups to stop working?
 
I trust not.  Various things don't support barriers yet, so code 
shouldn't assume that they are supported.  Where they are supported,
they allow for optimisation.


For example, jbd detects the error and retries without them.

  fs/jbd/commit.c: static int journal_write_commit_record(

        if (ret == -EOPNOTSUPP && barrier_done) {
		... 
                printk(KERN_WARNING
                        "JBD: barrier-based sync failed on %s - "
                        "disabling barriers\n",
                        bdevname(journal->j_dev, b));
		...
		/* And try again, without the barrier */
		...

Alasdair
-- 
agk@redhat.com
