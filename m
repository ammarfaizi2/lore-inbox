Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266243AbUHTKmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266243AbUHTKmh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 06:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266248AbUHTKmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 06:42:37 -0400
Received: from herkules.viasys.com ([194.100.28.129]:15796 "HELO
	mail.viasys.com") by vger.kernel.org with SMTP id S266243AbUHTKmd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 06:42:33 -0400
Date: Fri, 20 Aug 2004 13:42:30 +0300
From: Ville Herva <vherva@viasys.com>
To: petr@vandrovec.name
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: 2.6.8.1-mm2 breaks vmware
Message-ID: <20040820104230.GH23741@viasys.com>
Reply-To: vherva@viasys.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux herkules.viasys.com 2.4.27
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, I know you are not interested in closed source vmware, I'm just
blatantly Cc'ing you in case you would have some suggestion of the top of
your head. As stuff slowly trickles from -mm to mainline, this could
eventually end up biting more people.

In short, there are two (afaict) separate problem:

(1) vmmon.ko gives this:

	vmmon: Your kernel is br0ken. get_user_pages(current, current->mm, b7dd1000, 1, 1, 0, &page, NULL) returned -14.
	vmmon: I'll try accessing page tables directly, but you should know that your
	vmmon: kernel is br0ken and you should uninstall all additional patches you
	vmmon: have installed!
	vmmon: FYI, copy_from_user(b7dd1000) returns 0 (if not 0 maybe your kernel is not br0ken)

(2) vmware fails to start any guest os, telling it cannot allocate memory:

	VMX|[msg.msg.noMem] Cannot allocate memory.


(1) happened with 2.6.6-mm4 and with 2.6.8.1-mm2.
(2) only happened with 2.6.8.1-mm2 (with 2.6.6-mm4 vmware worked despite the
warning.

So I backed out these patches from 2.6.8.1-mm2:

	flexible-mmap-2.6.7-mm3-A8.patch
	flex-mmap-for-ppc64.patch
	flex-mmap-for-s390x.patch
	sysctl-tunable-for-flexmmap.patch
	get_user_pages-latency-fix.patch
	increase-mlock-limit-to-32k.patch
	mlock-as-user-for-268-rc2-mm2.patch
	(All conveniently available for reference at ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8.1/2.6.8.1-mm2/broken-out/
         if anyone is interested)

I had a vague hunch that flex-mmap stuff might affect (2) and
get_user_pages patch perhaps (1).

After this, problem (1) went away for 2.6.8.1-mm2, but problem (2) remained.

Then I tried 2.6.8.1 vanilla. It does NOT suffer from either (1) or (2).

All experiments are done with Petr Vandrovec's newest
vmware-any-any-update81 (apart from 2.6.6-mm4 that had some older any-to-any
patch) and VMwareWorkstation-3.2.0-2230.

Before I continue backing stuff out: does anyone have ideas or suggestions
what -mm patches might be suspectible problem (2)? 2.6.8.1 -> 2.6.8.1-mm2 is
rather large patch and so is 2.6.6-mm4 -> 2.6.8.1-mm2, and the patches
listed above were everything I thought might be suspectible.

Could get_user_pages-latency-fix.patch explain (1)? My kernel expertise is
not sufficient to tell.


-- v -- 

v@iki.fi

