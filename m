Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316025AbSENUP1>; Tue, 14 May 2002 16:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316022AbSENUP0>; Tue, 14 May 2002 16:15:26 -0400
Received: from code.and.org ([63.113.167.33]:32140 "EHLO mail.and.org")
	by vger.kernel.org with ESMTP id <S316023AbSENUPZ>;
	Tue, 14 May 2002 16:15:25 -0400
To: Ben Greear <greearb@candelatech.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        linux-net <linux-net@vger.kernel.org>
Subject: Re: OT:  problem with select() and RH 7.3
In-Reply-To: <3CDDC194.7000405@candelatech.com>
From: James Antill <james@and.org>
Date: 14 May 2002 16:15:16 -0400
Message-ID: <m3vg9qcwq3.fsf@code.and.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear <greearb@candelatech.com> writes:

> Appologies for an OT post, but I am hoping someone here will
> have an answer.
> 
> It appears that the select() call as found in RH 7.3 waits too
> long before it returns.  I come to this conclusion because I
> was dropping a large number of UDP packets when I allowed the
> select timeout to be > 0.   However, if I force the timeout to
> be zero in all cases, almost no packets are dropped (but the
> packet generator/receiver uses all of the CPU)  My traffic pattern
> is 10Mbps send + 10Mbps receive on 4 ports (of a DFE-570tx 4-port
> NIC, tulip driver), pkt size of 1200 to 1514.
> 
> If I understand select() correctly, it should work equally fast
> with a timeout of zero or 10 minutes, as long as the file descriptors
> are ready to be read from or written to.

 You don't understand select()/poll() correctly.
 If you call select()/poll() with a timeout then every "event" has to
be added to a kernel wait queue, and then removed from the wait queue
when any of those events happen or the timeout occurs.

[snip ... ]

> If anyone has any ideas or suggestions, I'd love to hear them!

 Do a double poll() call, Eg. this code uses socket_poll and timer_q
from http://www.and.org/ ...

static int mypoll(void)
{
  const struct timeval *tv = timer_q_first_timeval();
  int ret = 0;
  int msecs = -1;
  
  if (tv)
  {
    long diff = 0;
    struct timeval now_timeval;
    
    gettimeofday(&now_timeval, NULL);
    
    diff = timer_q_timeval_diff_msecs(tv, &now_timeval);
    
    if (diff > 0)
    {
      if (diff >= INT_MAX)
        msecs = INT_MAX - 1;
      else
        msecs = diff;
    }
    else
      msecs = 0;
  }

  if (!(ret = socket_poll_update_all(0)) && msecs)
    return (socket_poll_update_all(msecs));

  return (ret);
}

-- 
# James Antill -- james@and.org
:0:
* ^From: .*james@and\.org
/dev/null
