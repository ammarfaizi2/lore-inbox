Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271763AbRHURqj>; Tue, 21 Aug 2001 13:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271764AbRHURq3>; Tue, 21 Aug 2001 13:46:29 -0400
Received: from codepoet.org ([166.70.14.212]:5719 "HELO winder.codepoet.org")
	by vger.kernel.org with SMTP id <S271763AbRHURq0>;
	Tue, 21 Aug 2001 13:46:26 -0400
Date: Tue, 21 Aug 2001 11:46:41 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Christoph Rohland <cr@sap.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] sysinfo compatibility
Message-ID: <20010821114640.A25151@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Christoph Rohland <cr@sap.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0108211137340.1320-100000@localhost.localdomain> <m34rr12ueb.fsf@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m34rr12ueb.fsf@linux.local>
User-Agent: Mutt/1.3.20i
X-Operating-System: Linux 2.4.7-rmk2, Rebel-NetWinder(Intel sa110 rev 3), 262.14 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Aug 21, 2001 at 07:30:04PM +0200, Christoph Rohland wrote:
> And I have somewhat harder feelings since we get a lot of bug reports
> that our installer only detects 0M RAM when running on a 2.4 machine
> while it works with the 2.2 kernel. We are talking about an ABI which
> is directly imported into user space programs.

Its your lucky day.  Put something like this in your installer,
and your problems will go away:

/* Include our own copy of struct sysinfo to avoid binary compatibility
 * problems with Linux 2.4, which changed things.  Grumble, grumble. */
struct sysinfo {
    long uptime;            /* Seconds since boot */
    unsigned long loads[3];     /* 1, 5, and 15 minute load averages */
    unsigned long totalram;     /* Total usable main memory size */
    unsigned long freeram;      /* Available memory size */
    unsigned long sharedram;    /* Amount of shared memory */
    unsigned long bufferram;    /* Memory used by buffers */
    unsigned long totalswap;    /* Total swap space size */
    unsigned long freeswap;     /* swap space still available */
    unsigned short procs;       /* Number of current processes */
    unsigned short pad;         /* Padding needed for m68k */
    unsigned long totalhigh;    /* Total high memory size */
    unsigned long freehigh;     /* Available high memory size */
    unsigned int mem_unit;      /* Memory unit size in bytes */
    char _f[20-2*sizeof(long)-sizeof(int)]; /* Padding: libc5 uses this.. */
};
extern int sysinfo (struct sysinfo* info);


/* How much memory does this machine have?
   Units are kBytes to avoid overflow on 4GB machines */
static int check_free_memory()
{
    struct sysinfo info;
    unsigned int result, u, s=10;

    if (sysinfo(&info) != 0) {
        fprintf(stderr,"Error checking free memory");
        return -1;
    }

    /* Kernels 2.0.x and 2.2.x return info.mem_unit==0 with values in bytes.
     * Kernels 2.4.0 return info.mem_unit in bytes. */
    u = info.mem_unit;
    if (u==0) u=1;
    while ( (u&1) == 0 && s > 0 ) { u>>=1; s--; }
    result = (info.totalram>>s) + (info.totalswap>>s);
    result = result*u;
    if (result < 0) result = INT_MAX;
    return result;
}

 -Erik

--
Erik B. Andersen   email:  andersee@debian.org, andersen@lineo.com
--This message was written using 73% post-consumer electrons--
