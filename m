Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261703AbULBRzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbULBRzm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 12:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbULBRzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 12:55:41 -0500
Received: from users.ccur.com ([208.248.32.211]:27424 "EHLO gamx.iccur.com")
	by vger.kernel.org with ESMTP id S261703AbULBRye (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 12:54:34 -0500
Date: Thu, 2 Dec 2004 12:54:18 -0500
From: Joe Korty <joe.korty@ccur.com>
To: Roland McGrath <roland@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: waitid breaks telnet
Message-ID: <20041202175418.GA9716@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <20041201232204.GA29829@tsunami.ccur.com> <200412012358.iB1Nwk3C002166@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412012358.iB1Nwk3C002166@magilla.sf.frob.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2004 at 03:58:46PM -0800, Roland McGrath wrote:
> Since I can only manage so far to see this once in a blue moon, and you can
> produce it frequently, it would be helpful if you can diagnose the problem
> some.  That is, figure out exactly what wrong results from a wait* call is
> at fault.

Hi Roland,
I've been playing with this most of the morning, finally got strace attached
to the telnet daemon, but it did me no good .. everything works when straced.

My technique was to replace /usr/sbin/in.telnetd with a script that invokes
the original binary under strace:

	# cd /usr/sbin
	# mv in.telnetd in.telnet.d.orig
	# cat <<EOF >in.telnetd
	/usr/bin/strace -ff -o /tmp/telnet.log.$$ /usr/sbin/in.telnetd.orig "$@"
	EOF
	# chmod 755 in.telnetd

Earlier this morning I systematically repeated my earlier, haphazard
experiments.  I built three kernels from two sources: the first source
was the pure 2.6.7-rc1-bk7 tree, the second the same tree with the suspect
waitid patch applied.  From these I built various kernels with and without
SMP and PREEMPT and ran at least seven 'telnet' tests on each.  The results:

   kernel       smp preempt | 1 2 3 4 5 6 7 8 9
   ======================================================
   bk7          Y   Y       | g g g g g g g
   bk7+waitid   Y   Y       | F F F F F F F
   bk7+waitid   N   N       | F g F F g g g F g

