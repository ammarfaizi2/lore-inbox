Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbVIXN41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbVIXN41 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 09:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbVIXN41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 09:56:27 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:11926
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1750749AbVIXN40
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 09:56:26 -0400
Subject: Re: [ANNOUNCE] ktimers subsystem
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Ingo Molnar <mingo@elte.hu>, Christopher Friesen <cfriesen@nortel.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, george@mvista.com,
       johnstul@us.ibm.com, paulmck@us.ibm.com
In-Reply-To: <Pine.LNX.4.61.0509241212170.3728@scrub.home>
References: <20050919184834.1.patchmail@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0509201247190.3743@scrub.home>
	 <1127342485.24044.600.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0509221816030.3728@scrub.home> <43333EBA.5030506@nortel.com>
	 <Pine.LNX.4.61.0509230151080.3743@scrub.home>
	 <1127458197.24044.726.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0509240443440.3728@scrub.home>
	 <20050924051643.GB29052@elte.hu>
	 <Pine.LNX.4.61.0509241212170.3728@scrub.home>
Content-Type: text/plain
Organization: linutronix
Date: Sat, 24 Sep 2005 15:56:52 +0200
Message-Id: <1127570212.15115.77.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-09-24 at 12:35 +0200, Roman Zippel wrote:
> Hi,
> 
> On Sat, 24 Sep 2005, Ingo Molnar wrote:
> 
> > > Anyway, the biggest cost is the conversion from/to the 64bit ns value 
> > > [...]
> > 
> > Where do you get that notion from? Have you personally measured the 
> > performance and code size impact of it? If yes, would you mind to share 
> > the resulting data with us?
> > 
> > Our data is that the use of 64-bit nsec_t significantly reduces the size 
> > of a representative piece of code (object size in bytes):
> > 
> >                 AMD64    I386        ARM          PPC32       M68K
> >    nsec_t_ops   226      284         252          428         206
> >    timespec_ops 412      324         448          640         342
> > 
> > i.e. a ~40% size reduction when going to nsec_t on m68k, in that 
> > particular function. Even larger, ~45% code size reduction on a true 
> > 64-bit platform.
> 
> Without any source these numbers are not verifiable. You don't even 
> mention here what that "representative piece of code" is...

struct base {
        nsec_t now;
        struct ktimer *timers[16];
        struct ktimer *running;
};

void nsec_t_ops(struct base *base, struct ktimer *next,
                  nsec_t *tim, int mode)
{
        int i;
        nsec_t now = base->now;

        for (i = 0; i < 16; i++) {

                void (*fn)(void *);
                void *data;
                struct ktimer *timer = base->timers[i];

                if (timer->expires > now)
                        break;
                timer->expired = now;
                fn = timer->function;
                data = timer->data;
                base->running = timer;
                fn(data);
                base->running = NULL;
        }

        switch(mode) {
        case 0:
                next->expires = *tim;
                break;
        case 1:
                next->expires = now + *tim;
                break;
        case 2:
                next->expires += *tim;
                break;
        case 3:
                while (next->expires > now) {
                        next->expires += *tim;
                }
                break;
        }
        base->timers[0] = next;
}


versus:

#define NSEC_PER_SEC 1000000000
struct base {
        struct timespec now;
        struct ktimer *timers[16];
        struct ktimer *running;
};

#define timespec_gt(a,b)                       	\
        (((a).tv_sec > (b).tv_sec) ? 1 :        \
        (((a).tv_sec < (b).tv_sec) ? 0 :        \
        ((a).tv_nsec > (b).tv_nsec)))

#define timespec_addptr(a,b)                            \
        (a)->tv_sec = ((a)->tv_sec + (b)->tv_sec);      \
        (a)->tv_nsec = ((a)->tv_nsec + (b)->tv_nsec);   \
        if ((a)->tv_nsec >= NSEC_PER_SEC){               \
                (a)->tv_nsec -= NSEC_PER_SEC;           \
                (a)->tv_sec++;                          \
        }

#define timespec_addppp(c,a,b)                          \
        (c)->tv_sec = ((a)->tv_sec + (b)->tv_sec);      \
        (c)->tv_nsec = ((a)->tv_nsec + (b)->tv_nsec);   \
        if ((c)->tv_nsec >= NSEC_PER_SEC){               \
                (c)->tv_nsec -= NSEC_PER_SEC;           \
                (c)->tv_sec++;                          \
        }


void timespec_ops(struct base *base, struct ktimer *next,
                  struct timespec *tim, int mode)
{
        int i;
        struct timespec now = base->now;

        for (i = 0; i < 16; i++) {

                void (*fn)(void *);
                void *data;
                struct ktimer *timer = base->timers[i];

                if (timespec_gt(timer->expires, now))
                        break;
                timer->expired = now;
                fn = timer->function;
                data = timer->data;
                base->running = timer;
                fn(data);
                base->running = NULL;
        }

        switch(mode) {
        case 0:
                next->expires = *tim;
                break;
        case 1:
                timespec_addppp(&next->expires, &now, tim);
                break;
        case 2:
                timespec_addptr(&next->expires, tim);
                break;
        case 3:
                while (timespec_gt(now, next->expires)) {
                        timespec_addptr(&next->expires, tim);
                }
                break;
        }
        base->timers[0] = next;
}


> Anyway, Thomas mentioned that this would be from the insert/remove code 
> and here you omitted the most important part of my mail:
> 
> typedef union {
> 	u64 tv64;
> 	struct {
> #ifdef __BIG_ENDIAN
> 		u32 sec, nsec;
> #else
> 		u32 nsec, sec;
> #endif
> 	} tv;
> } ktimespec;
> 
> IOW this would allow to keep the time value in timespec format and use 
> your nsec_t_ops for sorting.

Yes, it works for comparisons. 

But for any other operation this construct has the same problem than
struct timespec itself. You need at least an add function which is
always an add and a comparison / correction vs. nsec >= NSEC_PER_SEC. 

The 64 bit nsec_t value can just be used as is without inventing a
wrapper macro for each operation.

The only point, where (k)timespec has an advantage is that the userspace
value must not be converted to nsec_t, but deducing therefor this is the
better overall solution is a fallacy.

nsec_t				ktimespec

syscall:
32x32 mul
64bit add			2 x 32bit move

arm timer:
64 bit add			2 x 32 bit add
				  32 bit compare
				  32 bit sub
				  32 bit add

The 3 operation compensate for the 32x32 
multiplication.

For interval timers you have the 
				  32 bit compare
				  32 bit sub
				  32 bit add
additional overhead for each rearm.

The backward conversion from nsec_t to timespec is almost a non issue.
The vast majority of callers dont provide the second argument to
nanosleep(), setitimer(), set_timer() which makes the conversion
necessary and I think we optimize for the common use case.

Besides that the representation of time in nsec_t values is much
clearer. 

I know that we have to deal with timespecs vs. userspace, but keeping
this representation for kernel internal usage reminds me on the BCD
calculations which were a similar 2^x vs 10^x oddity in the early days
of microprocessors. Of course they were obstinate and survived a
surprisingly long time.

tglx


