Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262906AbVCWU2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbVCWU2Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 15:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262909AbVCWU1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 15:27:55 -0500
Received: from smtp-out.tiscali.no ([213.142.64.144]:12046 "EHLO
	smtp-out.tiscali.no") by vger.kernel.org with ESMTP id S262908AbVCWU06
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 15:26:58 -0500
Subject: Re: forkbombing Linux distributions
From: Natanael Copa <mlists@tanael.org>
To: Kyle Moffett <kmoffett@tjhsst.edu>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <fa82dfa71dabb4d0b3df9a6c2b776349@tjhsst.edu>
References: <e0716e9f05032019064c7b1cec@mail.gmail.com>
	 <20050322112628.GA18256@roll>
	 <Pine.LNX.4.61.0503221247450.5858@yvahk01.tjqt.qr>
	 <20050322124812.GB18256@roll> <20050322125025.GA9038@roll>
	 <9cde8bff050323025663637241@mail.gmail.com> <1111581459.27969.36.camel@nc>
	 <9cde8bff05032305044f55acf3@mail.gmail.com> <1111586058.27969.72.camel@nc>
	 <Pine.LNX.4.61.0503231543030.10048@yvahk01.tjqt.qr>
	 <fa82dfa71dabb4d0b3df9a6c2b776349@tjhsst.edu>
Content-Type: text/plain
Date: Wed, 23 Mar 2005 21:26:53 +0100
Message-Id: <1111609613.20101.24.camel@nc>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-23 at 14:38 -0500, Kyle Moffett wrote:
> On Mar 23, 2005, at 09:43, Jan Engelhardt wrote:
> >> brings down almost all linux distro's while other *nixes survives.
> >
> > Let's see if this can be confirmed.
> 
> Here at my school we have the workstations running Debian testing. We
> have edited /etc/security/limits.conf to have a much more restrictive
> startup environment for user processes, limiting to 100 processes per
> user and clamping maximum CPU time to 4 hours per process.

Thats great. I was was thinking of the default settings. (its even
possible to lock down a windows machine to be "secure")

Also the daemons started from bootscripts that is not aware of PAM is
not affected by those settings. So an exploited security flaw in a
service would allow an attacker to bring the system down even if the
service is running as non-root.

Try running this from a boot script and you'll see that even if this
process is setuid, it will be able to fork more than 100 processes per
user:

/* this program should be started as root but it changes uid */

#define TTL 300
#define MAX 65536
#define UID 65534

int pids[MAX];
int main(int argc, char *argv[]) {
        int count = 0; pid_t pid;
        if (setuid(UID) < 0) {
                perror("setuid");
                exit(1);
        }
        while ((pid = fork()) >= 0 && count < MAX) {
                if (pid == 0) sleep(TTL);
                pids[count++] = pid;
        }
        printf("Forked %i new processes\n", count);
        while (count--) kill(pids[count], SIGTERM);
        return 0;
}


> In any case, I think
> that while there could perhaps be a better interface for user-limits
> in the kernel, the existing one works fine for most purposes, when
> combined with appropriate administrative tools.

My point is, the default max allowed processes per user is too high. It
better to open up a restrictive default than locking down an generous
default.

--
Natanael Copa


