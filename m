Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262354AbSKHU1A>; Fri, 8 Nov 2002 15:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262358AbSKHU1A>; Fri, 8 Nov 2002 15:27:00 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:58034 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S262354AbSKHU07>;
	Fri, 8 Nov 2002 15:26:59 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Andrew Morton <akpm@digeo.com>
Date: Fri, 8 Nov 2002 21:33:24 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.5.46-bk3: BUG in skbuff.c:178
Cc: linux-kernel@vger.kernel.org, bwindle@fint.org, acme@conectiva.com.br
X-mailer: Pegasus Mail v3.50
Message-ID: <6F45EB551A2@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  8 Nov 02 at 12:01, Andrew Morton wrote:
> > Single-CPU system, running 2.5.46-bk3. Whiling compiling bk4, and running
> > a script that was pinging every host on my subnet (I was running arp -a
> > to see what was in the arp table at the time), I hit this BUG.
> 
> I'd be suspecting the seq_file conversion in arp.c.  The read_lock_bh()
> stuff in there looks, umm, unclear ;)

Yes, see my emails from 23th Oct, 25th Oct (2.5.44: Strange oopses from 
userspace), from Nov 6th + Nov 7th: Preempt count check when leaving
IRQ.

But while yesterday I had no idea, today I have one (it looks like that
nobody else is going to fix it for me :-( ) :
seq subsystem can call arp_seq_start/next/stop several times, but
state->is_pneigh is set to 0 only once, by memset in arp_seq_open :-(

I think that arp_seq_start should do

  {
+   struct arp_iter_state* state = seq->private;
+   seq->is_pneigh = 0;
+   seq->bucket = 0;
    read_lock_bh(&arp_tbl.lock);
    return *pos ? arp_get_bucket(seq, pos) : (void *)1;
  }

and we can drop memset from arp_seq_open. I'll try it, and if it will
survive my tests, I'll send real patch.  
  
                                        Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
