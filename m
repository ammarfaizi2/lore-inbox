Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286843AbRLWJTT>; Sun, 23 Dec 2001 04:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283777AbRLWJTM>; Sun, 23 Dec 2001 04:19:12 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:26124 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S286843AbRLWJSH>;
	Sun, 23 Dec 2001 04:18:07 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: How to fix false positives on references to discarded text/data?
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 23 Dec 2001 20:17:51 +1100
Message-ID: <23259.1009099071@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When the .*.exit sections are discarded from vmlinux, any dangling
references from the rest of the code or data to the discarded sections
are potential problems.  Newer versions of binutils detect these
dangling references and complain.  Unfortunately we are getting some
false positives that I cannot see an easy way of fixing, I'm looking
for ideas.

References from one discarded section to another are not an issue,
binutils is smart enough to cope with those.  Pointer references to
__devexit code can be wrapped in __devexit_p, a bit of a kludge but it
works.  What is killing us at the moment is the out of line spinlock
code.

As an example, net/ipv4/netfilter/ip_nat_snmp_basic.c
static void __exit fini(void)
{
        ip_nat_helper_unregister(&snmp);
        ip_nat_helper_unregister(&snmp_trap);
        br_write_lock_bh(BR_NETPROTO_LOCK);
        br_write_unlock_bh(BR_NETPROTO_LOCK);
}

The lock operations generate a branch to out of line code in section
.text.lock which then branches back to fini.  When ip_nat_snmp_basic is
built into vmlinux, the fini section is discarded but the .text.lock
code is kept.  That has two problems, unused code in .text.lock (minor)
and an unresolved reference from .text.lock to .text.exit which makes
binutils complain (major).

I have several options, none of which I like :-

(1) Drop the ld check for discarded sections.

    I don't want to lose the ld check, it has already found several
    bits of buggy code.  For example, usb_uhci.c calls the exit routine
    from the init code on error, but the exit code has been discarded
    in vmlinux - oops.  New binutils flagged that bug and others.

(2) Tell ld which sections matter and which ones it can ignore, then
    ignore dangling refernces in .text.lock.

    Maybe, but it makes ld specific to vmlinux's design.  If this were
    done by an environment variable then it might be acceptable.

(3) Add _exit versions of locks that do noop when the code is
    discarded.

    br_write_lock_bh_exit(BR_NETPROTO_LOCK).  Barf-o-meter alert!

(4) Add #define/#undef EXIT_CODE around functions, EXIT_CODE tells
    the lock functions to become noop.

	#define EXIT_CODE
	static void __exit fini(void)
	{
		ip_nat_helper_unregister(&snmp);
		ip_nat_helper_unregister(&snmp_trap);
		br_write_lock_bh(BR_NETPROTO_LOCK);
		br_write_unlock_bh(BR_NETPROTO_LOCK);
	}
	#undef EXIT_CODE

    Barf-o-meter overflow!

(5) Post process the objects before ld sees them, remove the dangling
    references in safe sections.

    Will probably mess up timestamps on objects, as well as requiring
    yet another program for kernel build.  Cross compiling would be
    "interesting".

Number (2) is the least objectionable but I am hoping for any better
ideas.

