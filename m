Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264238AbTKKDsY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 22:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264240AbTKKDsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 22:48:24 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:59404 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S264238AbTKKDsW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 22:48:22 -0500
Date: Mon, 10 Nov 2003 19:48:15 -0800
From: jw schultz <jw@pegasys.ws>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel.bkbits.net off the air
Message-ID: <20031111034815.GA17240@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3FAFD1E5.5070309@zytor.com> <Pine.LNX.4.44.0311101004150.2097-100000@bigblue.dev.mdolabs.com> <20031110183722.GE6834@x30.random> <3FAFE22B.3030108@zytor.com> <20031110193101.GF6834@x30.random> <3FAFEA34.7090005@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FAFEA34.7090005@zytor.com>
User-Agent: Mutt/1.3.27i
X-Message-Flag: This message is may contain confidential information.  Unauthorised disclosure will be prosecuted to the fullest extent of the law.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 10, 2003 at 11:42:44AM -0800, H. Peter Anvin wrote:
> Andrea Arcangeli wrote:
> > 
> > we've to start rsync three times to get them in order, 3 tcp
> > connections, there's no way to specify the order in the rsync command
> > line, infact those two sequence files can be as well outside the tree
> > and we can fetch temporarily in a /tmp/ directory or similar. However we
> > can probably hack the rsync client to be able to specify the two
> > sequence numbers on the command line.
> > 
> > It maybe also cleaner to use a slightly more complicated but more
> > compact algorithm, this would make a potential new rsync command line
> > option cleaner since only 1 sequence file would need to be specified:
> > 
> > 	do {
> > 		seq = fetch(sequence-file);
> > 		if (seq & 1)
> > 			break;
> > 		rsync
> > 		if (seq != fetch(sequence-file))
> > 			seq = 1;
> > 	} while (seq & 1 && sleep 10 /* ideally exponential backoff */)
> > 
> > this way only 1 sequence-file is needed for each repository that we want
> > to checkout. the server side only has to increase twice the same file
> > before and after each update of the repository, so the server side is
> > even simpler (with the only additional requirement that the sequence
> > number has to start "even"), only the client side is a bit more complicated.
> >
> 
> Good grief.  This is messy as hell, and really interferes rather badly
> with the whole kernel.org mirror setup.
> 
> I guess the "best" solution is to use LVM atomic snapshots, and only
> allow rsync off the atomic snapshot.  That way any particular rsync
> session would always be consistent.  That's a *HUGE* amount of work,
> though, and still doesn't solve the mirrors issue -- I don't control
> what the mirrors run.  On the other hand, I don't know how many mirror
> sites actually mirror /pub/scm since it's not a requirement.

The LVM snapshots would provide the guarantee of consistancy
which would be nice for those who aren't setting it up as
part of their infrastructure but it isn't all that messy.
The issue came up recently on the rsync list of syncing CVS
repositories.  The discussion concluded with:

If the history file (or another single file) is enough:

        starthist=`ls -l $CVSROOT/CVSROOT/history`
        curhist=""

        while [ "$Starthist" != "$curhist" ]
        do
		starthist=`ls -l $CVSROOT/CVSROOT/history`
                rsync .....
                curhist=`ls -l $CVSROOT/CVSROOT/history`
        done

If not you can test the directory.

        ls -l $CVSROOT/CVSROOT >$TMPFILE.start
        touch $TMPFILE.test

        until diff -q $TMPFILE.start $TMPFILE.test >/dev/null
        do
		ls -l $CVSROOT/CVSROOT >$TMPFILE.start
                rsync .....
                ls -l $CVSROOT/CVSROOT >$TMPFILE.test
        done
        rm -f $TMPFILE.start $TMPFILE.test


-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
