Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316683AbSIALdV>; Sun, 1 Sep 2002 07:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316684AbSIALdV>; Sun, 1 Sep 2002 07:33:21 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:49929 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S316683AbSIALdU>; Sun, 1 Sep 2002 07:33:20 -0400
Date: Sun, 1 Sep 2002 13:37:42 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: "David S. Miller" <davem@redhat.com>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] warnkill trivia 2/2
Message-ID: <20020901113741.GM32122@louise.pinerecords.com>
References: <20020901105643.GH32122@louise.pinerecords.com> <20020901.035749.37156689.davem@redhat.com> <20020901112856.GL32122@louise.pinerecords.com> <20020901.042539.63049493.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020901.042539.63049493.davem@redhat.com>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.20-pre1/sparc SMP
X-Uptime: 5 days, 8:49
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    From: Tomas Szepe <szepe@pinerecords.com>
>    Date: Sun, 1 Sep 2002 13:28:56 +0200
> 
>    > I think you mean something like "atomic_t const * v" which means the
>    > pointer is constant, not the value.
>    
>    Precisely.
> 
> BTW who even passes around const atomic_t's?  Ie. what
> genrated the warning and made you even edit this to begin with?

fs/reiserfs/buffer2.c, line ~28:
atomic_t gets the const quality on account of being a member
of a const struct buffer_head instance.

void wait_buffer_until_released (const struct buffer_head * bh)
{
  int repeat_counter = 0;

  while (atomic_read (&(bh->b_count)) > 1) {

    if ( !(++repeat_counter % 30000000) ) {
      reiserfs_warning ("vs-3050: wait_buffer_until_released: nobody releases buffer (%b). Still waiting (%d) %cJDIRTY %cJWAIT\n",
			bh, repeat_counter, buffer_journaled(bh) ? ' ' : '!',
			buffer_journal_dirty(bh) ? ' ' : '!');
    }
    run_task_queue(&tq_disk);
    yield();
  }
  if (repeat_counter > 30000000) {
    reiserfs_warning("vs-3051: done waiting, ignore vs-3050 messages for (%b)\n", bh) ;
  }
}
