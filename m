Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317343AbSFGUV1>; Fri, 7 Jun 2002 16:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317345AbSFGUV0>; Fri, 7 Jun 2002 16:21:26 -0400
Received: from war.OCF.Berkeley.EDU ([128.32.191.89]:25250 "EHLO
	war.OCF.Berkeley.EDU") by vger.kernel.org with ESMTP
	id <S317343AbSFGUVU>; Fri, 7 Jun 2002 16:21:20 -0400
Date: Fri, 7 Jun 2002 13:21:19 -0700 (PDT)
Message-Id: <200206072021.g57KLJU04835@war.OCF.Berkeley.EDU>
Content-Disposition: inline
Mime-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: gettimeofday clock jump bug
From: ashieh@OCF.Berkeley.EDU
Reply-To: ashieh@OCF.Berkeley.EDU
Content-Type: text/plain; charset=us-ascii
X-Mailer: acmemail <URL:http://www.astray.com/acmemail/>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

time() occasionally returns a bogus value (>1 hour jump forward, and a few microseconds later jumps back to the right time) on my box (Thunderbird 750, Asus K7V (KX133) kernel 2.4.17). This behavior sets in after the box is up for some period of time. I don't think this is related to the 686a configuration reset bug.

I suspect that somehow the either do_gettimeoffset() or xtime.tv_usec in do_gettimeofday is returning a ridiculously large value. I would like to get to the bottom of this problem, but am not familiar with this part of the timing infrastructure. Has anyone seen this bug before? Would using a different locking mode (SMP  vs none SMP, or wahtever) possibly help this problem? Is there a document online describing how this works in Linux?  

In the meantime, I want to hack up a patch to fix this on my box. I'm thinking I could give up a few seconds of clock precision in exchange for monotonic clock behavior, and so I want to comment out the adjustments to usec. What are the possible ramifications of this hack?

Alan

Original do_gettimeofday:

void do_gettimeofday(struct timeval *tv)
{
        unsigned long flags;
        unsigned long usec, sec;

        read_lock_irqsave(&xtime_lock, flags);
        usec = do_gettimeoffset();
        {
                unsigned long lost = jiffies - wall_jiffies;
                if (lost)
                        usec += lost * (1000000 / HZ);
        }
        sec = xtime.tv_sec;
        usec += xtime.tv_usec;
        read_unlock_irqrestore(&xtime_lock, flags);

        while (usec >= 1000000) {
                usec -= 1000000;
                sec++;
        }

        tv->tv_sec = sec;
        tv->tv_usec = usec;
}

My proposed hack (for my system):

void do_gettimeofday(struct timeval *tv)
{
        unsigned long flags;
        unsigned long usec, sec;

        read_lock_irqsave(&xtime_lock, flags);
        usec = do_gettimeoffset();
        /* {
                unsigned long lost = jiffies - wall_jiffies;
                if (lost)
                        usec += lost * (1000000 / HZ);
        } */
        sec = xtime.tv_sec;
        usec = xtime.tv_usec;
        read_unlock_irqrestore(&xtime_lock, flags);

        while (usec >= 1000000) {
                usec -= 1000000;
                sec++;
        }

        tv->tv_sec = sec;
        tv->tv_usec = usec;
}
