Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261750AbVAYAN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261750AbVAYAN5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 19:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbVAYAMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 19:12:32 -0500
Received: from [83.102.214.158] ([83.102.214.158]:17567 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S261703AbVAYAKF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 19:10:05 -0500
X-Comment-To: "Stephen C. Tweedie"
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Alex Tomas <alex@clusterfs.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       <ext2-devel@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>
Subject: Re: [Ext2-devel] [PATCH] JBD: journal_release_buffer()
References: <m3wtu9v3il.fsf@bzzz.home.net>
	<1106604342.2103.395.camel@sisko.sctweedie.blueyonder.co.uk>
	<m3brbebh43.fsf@bzzz.home.net>
	<1106609725.2103.616.camel@sisko.sctweedie.blueyonder.co.uk>
From: Alex Tomas <alex@clusterfs.com>
Organization: HOME
Date: Tue, 25 Jan 2005 03:08:51 +0300
Message-ID: <m3brbe9xpo.fsf@bzzz.home.net>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Stephen C Tweedie (SCT) writes:

 >> +	/* return credit back to the handle if it was really spent */
 >> +	if (credits) {
 >> +		handle->h_buffer_credits++; 
 >> +              spin_lock(&handle->h_transaction->t_handle_lock);
 >> +              handle->h_transaction->t_outstanding_credits++;
 >> +              spin_lock(&handle->h_transaction->t_handle_lock);
 >> +      }

 SCT> That returns the credit to A (satisfying ext3), but you just grew
 SCT> t_outstanding_credits, thus growing the journal commitments without
 SCT> checking if it's safe to do so or being able to handle failure.  So it
 SCT> just reintroduces the original bug.

incremented h_buffer_credits will be subtracted from incremented
t_outstanding_credits in journal_stop(). so, there is no imbalance
at this point. 

then, if (b_tcount == 0) we can correct t_outstanind_credits or
h_buffer_credits. wrong?

let's try another way ... we have two processes: P1 and P2. they
access block B.

the code is:
    if (credits != 0) {
       handle->h_buffer_credits++;
       transaction->t_outstanding_credits++;
    }
    if (jh->b_tcount == 0)
       transcation->t_outstanding_credits--;

case 1:
     P1 accesses B (*credits=1)
     P1 releases B

        (credits != 0) h1->h_buffer_credits++;
        (credits != 0) transaction->t_outstanding_credits++;
        (b_tcount == 0) transaction->t_outstanding_credits--;

    OUTPUT: transaction->t_outstanding_credits -= 1


case 2:
     P1 accesses B (*credits=1)
     P2 accesses B (*credits=0)
     P1 releases B
     P2 modifies B

        (credits != 0) h1->h_buffer_credits++;
        (credits != 0) transaction->t_outstainding_credits++;
        (b_tcount != 0)

     OUTPUT: journal_stop() will subtract incremented h_buffer_credits
             from incremented t_outstading_credits => no changes


case 3:
     P1 accesses B (*credits=1)
     P2 accesses B (*credits=0)
     P2 releases B
     P1 modifies B

        (credits != 0)
        (credits != 0)
        (b_tcount == 0)

     OUTPUT: no changes        


case 4:
     P1 accesses B (*credits=1)
     P2 accesses B (*credits=0)
     P2 releases B
     P1 releases B

        (credits != 0) 
        (credits != 0)
        (b_tcount == 0)

        (credits != 0) h1->h_buffer_credits++;
        (credits != 0) transaction->t_outstanding_credits++;
        (b_tcount == 0) transaction->t_outstanding_credits--;

     OUTPUT: P2 will change nothing, P1 will drop the buffer and
             correct t_outstanding_credits


case 5:
     P1 accesses B (*credits=1)
     P2 accesses B (*credits=0)
     P1 releases B
     P2 releases B

        (credits != 0) h1->h_buffer_credits++;
        (credits != 0) transaction->t_outstanding_credits++;
        (b_tcount == 0)

        (credits != 0)
        (credits != 0)
        (b_tcount == 0) transaction->t_outstanding_credits--;

     OUTPUT: P1 will change own credits, P2 will drop the buffer
             and correct t_outstanding_credits



thanks, Alex

