Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292534AbSCDRFP>; Mon, 4 Mar 2002 12:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292535AbSCDRFH>; Mon, 4 Mar 2002 12:05:07 -0500
Received: from pc-80-195-34-57-ed.blueyonder.co.uk ([80.195.34.57]:36226 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S292533AbSCDRFB>; Mon, 4 Mar 2002 12:05:01 -0500
Date: Mon, 4 Mar 2002 17:04:34 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>, Chris Mason <mason@suse.com>,
        "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3)
Message-ID: <20020304170434.B1444@redhat.com>
In-Reply-To: <phillips@bonn-fries.net> <200203041503.g24F3WU01722@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200203041503.g24F3WU01722@localhost.localdomain>; from James.Bottomley@steeleye.com on Mon, Mar 04, 2002 at 09:03:31AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Mar 04, 2002 at 09:03:31AM -0600, James Bottomley wrote:
> phillips@bonn-fries.net said:
> > But chances are, almost all the IOs ahead of the journal commit belong
> > to your same filesystem anyway, so you may be worrying too much about
> > possibly waiting for something on another partition. 
> 
> My impression is that most modern JFS can work on multiple transactions 
> simultaneously.  All you really care about, I believe, is I/O ordering within 
> the transaction.  However, separate transactions have no I/O ordering 
> requirements with respect to each other (unless they actually overlap).

Generally, that may be true but it's irrelevant.  Internally, the fs
may keep transactions as independent, but as soon as IO is scheduled,
those transactions become serialised.  Given that pure sequential IO
is so much more efficient than random IO, we usually expect
performance to be improved, not degraded, by such serialisation.

I don't know of any filesystems which will be able to recover a
transaction X+1 if transaction X is not complete in the log.  Once you
start writing, the transactions lose their independence.

> Using 
> ordered tags imposes a global ordering, not just a local transaction ordering, 
Actually, ordered tags are in many cases not global enough.  LVM, for
example.

Basically, as far as journal writes are concerned, you just want
things sequential for performance, so serialisation isn't a problem
(and it typically happens anyway).  After the journal write, the
eventual proper writeback of the dirty data to disk has no internal
ordering requirement at all --- it just needs to start strictly after
the commit, and end before the journal records get reused.  Beyond
that, the write order for the writeback data is irrelevant.

Cheers,
 Stephen
