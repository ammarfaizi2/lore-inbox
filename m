Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315942AbSFDANs>; Mon, 3 Jun 2002 20:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315946AbSFDANs>; Mon, 3 Jun 2002 20:13:48 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:36344 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S315942AbSFDANq>; Mon, 3 Jun 2002 20:13:46 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Mon, 3 Jun 2002 18:10:28 -0600
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Pawel Kot <pkot@linuxnews.pl>, lkml <linux-kernel@vger.kernel.org>,
        Andre Hedrick <andre@serialata.org>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: Another -pre
Message-ID: <20020604001028.GI18668@turbolinux.com>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Pawel Kot <pkot@linuxnews.pl>, lkml <linux-kernel@vger.kernel.org>,
	Andre Hedrick <andre@serialata.org>,
	Neil Brown <neilb@cse.unsw.edu.au>,
	"Stephen C. Tweedie" <sct@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0206031155200.4146-100000@freak.distro.conectiva> <1023149710.6773.82.camel@irongate.swansea.linux.org.uk> <20020603232707.GI6062@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 03, 2002  20:27 -0300, Arnaldo Carvalho de Melo wrote:
> > 1 Weird corruption report with AMD chipset in PIO mode
> 
> Oh, I'm not alone ;) Well, up to now it _seems_ that ext3 is saving my day,
> but it only happened two time after I upgraded to 2.4.19-pre8-ac5, none after
> I upgraded to 2.4.19-pre9-ac3, but I can't manage to make 'hdparm -X68 /dev/hdd'
> to work :( I have already sent detailed information to Andre and discussed
> and tried several things sugested in a irc chat.
> 
> Short description: I use ext3 over raid0, using /dev/hda4 and /dev/hdd1,
> /dev/hdc has a CDRW drive, mostly unused, /dev/hdb has nothing, two times
> /dev/hda stopped responding, not reproducible AFAIT.

Well, there was some corruption in ext3 if you used it over MD RAID with
data=journal mode that was discussed recently on ext3-users.  There was
a patch posted by Neil Brown which I resend here (full thread archived
at https://listman.redhat.com/pipermail/ext3-users/).

According to Stephen Tweedie, the patch will not correctly handle
filesystems with 1kB or 2kB block sizes, but those are rare these days
(only 1kB blocks are created by default for small filesystems, < 500MB
in size).

This may or may not fix your problem (don't know the details), but it
can't hurt to try.  It definitely is not a "/dev/hda stopped responding"
kind of fix, but it _is_ a "weird corruption with ext3 and MD RAID" kind
of fix.

Cheers, Andreas
============================================================================
--- ./fs/jbd/commit.c	2002/05/28 04:15:18	1.1
+++ ./fs/jbd/commit.c	2002/05/28 22:44:48
@@ -663,12 +663,13 @@
 		 * there's no point in keeping a checkpoint record for
 		 * it. */
 		bh = jh2bh(jh);
-		if (buffer_jdirty(bh)) {
+		if (buffer_jdirty(bh) && !__buffer_state(bh, Freed)) {
 			JBUFFER_TRACE(jh, "add to new checkpointing trans");
 			__journal_insert_checkpoint(jh, commit_transaction);
 			JBUFFER_TRACE(jh, "refile for checkpoint writeback");
 			__journal_refile_buffer(jh);
 		} else {
+			clear_bit(BH_Freed, &bh->b_state);
 			J_ASSERT_BH(bh, !buffer_dirty(bh));
 			J_ASSERT_JH(jh, jh->b_next_transaction == NULL);
 			__journal_unfile_buffer(jh);
--- ./fs/jbd/transaction.c	2002/05/26 23:13:05	1.2
+++ ./fs/jbd/transaction.c	2002/05/28 09:24:45
@@ -1834,6 +1834,7 @@
 		 * running transaction if that is set, but nothing
 		 * else. */
 		JBUFFER_TRACE(jh, "on committing transaction");
+		set_bit(BH_Freed, &bh->b_state);
 		if (jh->b_next_transaction) {
 			J_ASSERT(jh->b_next_transaction ==
 					journal->j_running_transaction);



_______________________________________________
Ext3-users mailing list
Ext3-users@redhat.com
https://listman.redhat.com/mailman/listinfo/ext3-users

--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

