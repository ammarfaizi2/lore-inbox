Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbVJSC7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbVJSC7w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 22:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbVJSC7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 22:59:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:23242 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932435AbVJSC7v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 22:59:51 -0400
From: Neil Brown <neilb@suse.de>
To: stable@kernel.org, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org
Date: Wed, 19 Oct 2005 12:59:43 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17237.46751.709647.269732@cse.unsw.edu.au>
Subject: [PATCH-STABLE] Fix data-corruption bug in md when delayed recovery is interrupted.
X-Mailer: VM 7.19 under Emacs 21.4.1
  X-face:	v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	  LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	  8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
  --text follows this line--
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  There is a bug in md/raid which is fixed by this patch.
  The patch should apply to almost any 2.6 kernel.
  A fix has already been submitted to akpm/linus for 2.6.14.
  This patch should be included in 2.6.13.5 (if there is one).

  The problem occurs if:
     two or more raid arrays share a physical device and
     two or more of them require recovery (onto a spare) and
     one or more is 'DELAYED' waiting for another to finish and
     the -resync thread receives SIGKILL, as can happen during
       shutdown (init send SIGKILL to everything) if the arrays are not
       first stopped with 'mdadm -Ss' or 'raidstop -a'.

   The problem is that the recovery will appear to be complete, but no
   data will have been copied onto the 'spare' drive that is now a
   full part of the array.  Naturally this can result in data
   corruption.

   To avoid this problem (until the patch is applied), do not shutdown
   a computer will any array that reports "resync=DELAYED" in
   /proc/mdstat - stop the array first with 'mdadm -Ss'.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/md.c |    1 +
 1 file changed, 1 insertion(+)

diff ./drivers/md/md.c~current~ ./drivers/md/md.c
--- ./drivers/md/md.c~current~	2005-10-19 12:48:59.000000000 +1000
+++ ./drivers/md/md.c	2005-10-19 12:49:04.000000000 +1000
@@ -3486,6 +3486,7 @@ static void md_do_sync(mddev_t *mddev)
 	try_again:
 		if (signal_pending(current)) {
 			flush_signals(current);
+			set_bit(MD_RECOVERY_INTR, &mddev->recovery);
 			goto skip;
 		}
 		ITERATE_MDDEV(mddev2,tmp) {
