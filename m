Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272232AbTHIAnL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 20:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272229AbTHIAmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 20:42:49 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:65255 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S272226AbTHIAkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 20:40:08 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Andrew Morton <akpm@osdl.org>
Date: Sat, 9 Aug 2003 10:39:43 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16180.17103.360112.493943@gargle.gargle.HOWL>
Cc: dan@debian.org, linux-kernel@vger.kernel.org, ext3-users@redhat.com
Subject: Re: ext3 badness in 2.6.0-test2
In-Reply-To: message from Andrew Morton on Thursday August 7
References: <20030804142245.GA1627@nevyn.them.org>
	<20030804132219.2e0c53b4.akpm@osdl.org>
	<16176.41431.279477.273718@gargle.gargle.HOWL>
	<20030805235735.4c180fa4.akpm@osdl.org>
	<16178.63046.43567.551323@gargle.gargle.HOWL>
	<20030807181631.2962dfca.akpm@osdl.org>
X-Mailer: VM 7.17 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday August 7, akpm@osdl.org wrote:
> Neil Brown <neilb@cse.unsw.edu.au> wrote:
> 
> > So I guess the finger points generally in the direction of raid5.
> > Now I've just got to figure if it is a bug in r5, or some assumption
> > that it makes that is no longer valid (I was briefly suspicious of
> > PF_READAHEAD which could have made a real mess of raid5, but that
> > wouldn't have this symptom)
> 
> The PF_READAHEAD things was a huge bug.  Make sure that it is fixed before
> proceeding.  Linus's tree has the fix.

I found it. It was read-ahead related, but nothing to do with
PF_READAHEAD.

With this patch, my test ran to completion instead of dying at about
th 20% mark.

NeilBrown

=================================================================
Disable raid5 handling of read-ahead

raid5 trys to honour RWA_MASK, but messes it up and can return bad data.
Just ignore RWA_MASK for now.


 ----------- Diffstat output ------------
 ./drivers/md/raid5.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff ./drivers/md/raid5.c~current~ ./drivers/md/raid5.c
--- ./drivers/md/raid5.c~current~	2003-08-08 14:37:00.000000000 +1000
+++ ./drivers/md/raid5.c	2003-08-08 14:37:19.000000000 +1000
@@ -1326,7 +1326,7 @@ static int make_request (request_queue_t
 			(unsigned long long)new_sector, 
 			(unsigned long long)logical_sector);
 
-		sh = get_active_stripe(conf, new_sector, pd_idx, (bi->bi_rw&RWA_MASK));
+		sh = get_active_stripe(conf, new_sector, pd_idx, 0/*(bi->bi_rw&RWA_MASK)*/);
 		if (sh) {
 
 			add_stripe_bio(sh, bi, dd_idx, (bi->bi_rw&RW_MASK));


