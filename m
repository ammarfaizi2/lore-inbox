Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261509AbVCYH2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbVCYH2m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 02:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbVCYH2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 02:28:42 -0500
Received: from smtp-out.tiscali.no ([213.142.64.144]:19473 "EHLO
	smtp-out.tiscali.no") by vger.kernel.org with ESMTP id S261509AbVCYH2c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 02:28:32 -0500
Subject: Re: fork()
From: Natanael Copa <mlists@tanael.org>
To: Triffid Hunter <triffid_hunter@funkmunch.net>
Cc: redoubtable <redoubtable@netcabo.pt>, linux-kernel@vger.kernel.org
In-Reply-To: <42430439.6090102@funkmunch.net>
References: <4242EEC3.2000605@netcabo.pt>  <42430439.6090102@funkmunch.net>
Content-Type: text/plain
Date: Fri, 25 Mar 2005 08:28:29 +0100
Message-Id: <1111735709.14150.12.camel@nc>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-25 at 04:17 +1000, Triffid Hunter wrote:
> you can limit the max number of processes by putting the following into /etc/security/limits.conf (on my distro, and quite a number of others according to google too)
> 
> *	hard	nproc	<max # processes>
> 
> you can also limit quite a number of other things in this file, and other files in that directory.

I bet your PAM nonaware daemons started at boot are not affected by
those settings. The point is that if you gain access through a non-root
daemon started from boot scripts, you are no longer limited
by /etc/security/limits.conf.

Try to set hard nproc limits for user UID and run this from your boot
script:

#define UID 65534
#define MAX 65535

int pids[MAX];
int main() {
        int count = 0; pid_t pid;
        if (setuid(UID) < 0) { perror("setuid"); exit(1); }
        while ((pid = fork()) >= 0 && count < MAX) {
                if (pid == 0) { sleep(300); exit(); }
                pids[count++] = pid;
        }
        printf("Forked %i new processes\n", count);
        while (count--) kill(pids[count], SIGTERM);
}

You will see that even if user UID is limited
in /etc/security/limits.conf it will be able to fork many more
processes.

> > It should exist a global limit in case someone could spawn 
> > a shell without limits through some flawed application.

I agree on this one. Or the RLIMIT_NPROC should be set to a lower value
by default.

--
Natanael Copa


