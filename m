Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262060AbVATVvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbVATVvT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 16:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbVATVvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 16:51:18 -0500
Received: from fw.osdl.org ([65.172.181.6]:48868 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262060AbVATVtU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 16:49:20 -0500
Date: Thu, 20 Jan 2005 13:49:18 -0800
From: Chris Wright <chrisw@osdl.org>
To: jnf <jnf@innocence-lost.us>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux capabilities ?
Message-ID: <20050120134918.N469@build.pdx.osdl.net>
References: <Pine.LNX.4.61.0501201053070.24484@fhozvffvba.vaabprapr-ybfg.arg>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.61.0501201053070.24484@fhozvffvba.vaabprapr-ybfg.arg>; from jnf@innocence-lost.us on Thu, Jan 20, 2005 at 11:02:26AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* jnf (jnf@innocence-lost.us) wrote:
> I have been playing a little here and there with linux capabilities, and
> seem to be hitting a few snags so I was hoping to obtain some input on
> their current status. The kernel on the box in question is 2.6.10, with
> the CAP_INIT_EFF_SET macro modified to allow init to have CAP_SETPCAP.

This is not exactly safe.  It was removed on purpose.  See this paper:
http://www.cs.berkeley.edu/~daw/papers/setuid-usenix02.pdf

> I am mostly trying to accomplish this so that I can run syslog as a
> non-root user and as I understand it by digging through the source, one
> should be able to accomplish this with the CAP_SYS_ADMIN capability-
> however this does not appear to be true ?

BTW, CAP_SYS_ADMIN is a lot of privileges, so even this would not be as
secure as you might hope.

> in kernel/printk.c I see
> 
> error = security_syslog(type)
> if (error)
>         return error ;
> 
> which is defined in something like include/linux/security.h as a pointer
> to cap_syslog(), which in turn is defined in security/commoncap.c where I
> see:
> 
> if ((type != 3 && type != 10) && !capable(CAP_SYS_ADMIN))
>          return -EPERM
> return 0;
> 
> 
> Type 3 is:
> *      3 -- Read up to the last 4k of messages in the ring buffer.

3 doesn't require any permissions.  It's like doing 'dmesg.'

> So when I give the process CAP_SYS_ADMIN I still cannot seem to read from
> /proc/kmsg, I also tried giving it CAP_DAC_OVERRIDE just to test to see if
> DAC's were the problem but that didn't seem to help any.

Since /proc/kmsg is 0400 you need CAP_DAC_READ_SEARCH (don't necessarily
need full override).  Otherwise, you are right, you do need CAP_SYS_ADMIN.
Or just use syslog(2) directly, and you'll avoid the DAC requirement.

> So with that said, anyone have any idea's as to what I need to do and any
> details on the current state of the capabilities would be helpful.

The best way is to drop the caps from within the syslogd.  Otherwise
you will gain/lose all caps on execve() due to the way caps actually
effectively follow uids.  Here, I threw together an example of some
other bits of code I have laying around (run it as root).

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

--0OAP2g/MAC+5xKAE
Content-Type: text/x-c++src; charset=us-ascii
Content-Disposition: attachment; filename="read_syslog.c"

/* Copyright (c) Chris Wright <chrisw@osdl.org>
 * GPL v2
 * Drop uid/gid and caps and read syslog
 */
#include <unistd.h>
#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/prctl.h>
#include <sys/capability.h>


static void usage(void)
{
	printf("Usage: read_syslog options\n");
	printf("-u uid\n -p {use /proc/kmsg (default)}\n -s {use syslog(2)}\n");
}

static void dumpcred(void)
{
	uid_t ruid, euid, suid;
	gid_t rgid, egid, sgid;
	cap_t caps = cap_get_proc();

	getresuid(&ruid, &euid, &suid);
	getresgid(&rgid, &egid, &sgid);

	printf("      Real    Eff    Saved\n");
	printf("User  %-8d%-8d%-8d\n", ruid, euid, suid);
	printf("Group %-8d%-8d%-8d\n", rgid, egid, sgid);

	if (caps)
	{
		char *p = cap_to_text(caps, NULL);
		if (p) {
			printf("Caps: %s\n\n", p);
			cap_free(p);
		}
		cap_free(caps);
	}
}

static int usecap(const char *caps)
{
	int rc = -1;
	cap_t capset = cap_from_text(caps);
	if (capset)
	{
		rc = cap_set_proc(capset);
		if (rc) {
			perror("cap_set_proc");
		}
		cap_free(capset);
	}
	return rc;
}

static int drop_privs(uid_t uid, gid_t gid, const char *caps)
{
	int rc;
	dumpcred();
	prctl(PR_SET_KEEPCAPS, 1);
	rc = setresgid(gid, gid, gid);
	if (rc == -1) {
		perror("setresgid");
		goto out;
	}
	rc = setresuid(uid, uid, uid);
	if (rc == -1) {
		perror("setresuid");
		goto out;
	}
	rc = usecap(caps);
	if (rc == -1) {
		perror("usecap");
		goto out;
	}
out:
	dumpcred();
	return rc;
}

main(int argc, char *argv[])
{
	uid_t new_uid = 500;
	gid_t new_gid = 500;
	int c, fd, rc, use_proc = 1;
	char *caps = "cap_dac_read_search,cap_sys_admin=ep";
	char buf[1024];

	while ((c = getopt(argc, argv, "u:g:ps")) != -1) {
		switch(c) {
		case 'u':
			new_uid = atoi(optarg);
			break;
		case 'g':
			new_gid = atoi(optarg);
			break;
		case 'p':
			/* default */
			break;
		case 's':
			use_proc = 0;
			caps = "cap_sys_admin=ep";
			break;
		default:
			usage();
			exit(1);
			break;
		}
	}

	memset(buf, 0, sizeof(buf));
	if (drop_privs(new_uid, new_gid, caps) == -1) {
		exit(1);
	}
	if (use_proc) {
		fd = open("/proc/kmsg", O_RDONLY);
		if (fd == -1) {
			perror("open");
			exit(1);
		}
		rc = read(fd, buf, sizeof(buf));
		if (rc == -1) {
			perror("read");
			exit(1);
		}
	} else {
		rc = syslog(2, buf, sizeof(buf));
		if (rc == -1) {
			perror("syslog");
			exit(1);
		}
	}
	printf("%s\n", buf);
}

--0OAP2g/MAC+5xKAE--
