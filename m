Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261595AbVADJyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbVADJyJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 04:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbVADJyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 04:54:09 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:35740 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S261595AbVADJx5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 04:53:57 -0500
Date: Tue, 4 Jan 2005 10:53:56 +0100
From: bert hubert <ahu@ds9a.nl>
To: linux-kernel@vger.kernel.org
Cc: drepper@gmail.com, viro@parcelfarce.linux.theplanet.co.uk,
       wli@holomorphy.com
Subject: struct rusage::ru_wtime - "sys time, user time, iowait time"
Message-ID: <20050104095356.GA29101@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	linux-kernel@vger.kernel.org, drepper@gmail.com,
	viro@parcelfarce.linux.theplanet.co.uk, wli@holomorphy.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd love to have 'time' to be able to print out the amount of time spent
waiting for io. getrusage nor wait4 currently pass this information and,
worse, there is no place for it in struct rusage.

What would the preferred way of adding this ability be? To make things
interesting, some parts of struct rusage are unused, and the majority of
them not standardised by SuS:

            struct rusage {
mandatory       struct timeval ru_utime; /* user time used */
mandatory       struct timeval ru_stime; /* system time used */
                long   ru_maxrss;        /* maximum resident set size */
                long   ru_ixrss;         /* integral shared memory size */
                long   ru_idrss;         /* integral unshared data size */
                long   ru_isrss;         /* integral unshared stack size */
filled          long   ru_minflt;        /* page reclaims */
filled          long   ru_majflt;        /* page faults */
filled (untrue) long   ru_nswap;         /* swaps */
  ^             long   ru_inblock;       /* block input operations */
  |             long   ru_oublock;       /* block output operations */
space to fiddle long   ru_msgsnd;        /* messages sent */
  |             long   ru_msgrcv;        /* messages received */
  |             long   ru_nsignals;      /* signals received */
  |             long   ru_nvcsw;         /* voluntary context switches */
  v             long   ru_nivcsw;        /* involuntary context switches */
            };

SUSv3 says:
 The <sys/resource.h> header defines the rusage structure that includes at
 least the following members:
 
 struct timeval ru_utime   user time used
 struct timeval ru_stime   system time used

Our own manpage: 
	The above struct was taken from BSD 4.3 Reno.  Not all fields are
	meaningful under Linux.  Right now (Linux 2.4, 2.6) only the fields
	ru_utime, ru_stime, ru_minflt, ru_majflt, and ru_nswap are
	maintained.

So we have some liberty, constrained by the need to keep sizeof(rusage)
constant. On different architectures sizeof(struct timeval)-2*sizeof(long)
will not be the same, I bet. On 386, it is zero, but conceivably time_t (and
'suseconds_t' brr) could be 32 bit while long is 64 on other platforms.

The other good news is that at least 2.6.10 zeroes rusage before returning
it, so userspace can be fairly confident that if it finds non-zero values in
ru_wtime that they represent something.

Ideas? My favorite would be to nuke 'messages sent' and 'messages received':

            struct rusage {
                struct timeval ru_utime; /* user time used */
                struct timeval ru_stime; /* system time used */
                long   ru_maxrss;        /* maximum resident set size */
                long   ru_ixrss;         /* integral shared memory size */
                long   ru_idrss;         /* integral unshared data size */
                long   ru_isrss;         /* integral unshared stack size */
                long   ru_minflt;        /* page reclaims */
                long   ru_majflt;        /* page faults */
                long   ru_nswap;         /* swaps */
                long   ru_inblock;       /* block input operations */
                long   ru_oublock;       /* block output operations */
                struct timeval ru_wtime; /* time spent waiting on i/o */
#if sizeof(struct timeval) != 2 * sizeof(long)
		char pad[2 * sizeof(long) - sizeof(struct timeval)];
#endif       
                long   ru_nsignals;      /* signals received */
                long   ru_nvcsw;         /* voluntary context switches */
                long   ru_nivcsw;        /* involuntary context switches */
            };

Bert (keeping fingers crossed on alignment issues).

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
