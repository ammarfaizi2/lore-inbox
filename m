Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbWIYCJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWIYCJE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 22:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbWIYCJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 22:09:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41152 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750710AbWIYCJB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 22:09:01 -0400
Date: Sun, 24 Sep 2006 19:05:39 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, junkio@cox.net
Subject: Re: git diff <-> diffstat
In-Reply-To: <20060925011436.GC4547@stusta.de>
Message-ID: <Pine.LNX.4.64.0609241858380.3952@g5.osdl.org>
References: <20060924161809.GA13423@havoc.gtf.org> <Pine.LNX.4.64.0609241005290.4388@g5.osdl.org>
 <45172297.6070108@garzik.org> <Pine.LNX.4.64.0609241732580.3952@g5.osdl.org>
 <20060925011436.GC4547@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 Sep 2006, Adrian Bunk wrote:
> 
> Is there any way for "git diff" to handle additional options diffstat 
> handles? I'm a big fan of the -w72 diffstat option.

No, I think we've got the width fixed at 80 columns.

> Oh, and with git 1.4.2.1,
>   git diff -M --stat --summary v2.6.18..master
> in your tree gives me some funny lines like:
> 
>  .../netlabel/draft-ietf-cipso-ipsecurity-01.txt    |  791 +
>  .../{cpu_setup_power4.S => cpu_setup_ppc970.S}     |  103 
>  .../powerpc/platforms}/iseries/it_exp_vpd_panel.h  |    6 
>  .../powerpc/platforms}/iseries/it_lp_naca.h        |    6 
> 
> I don't know what's going wrong here, but diffstat doesn't produce this.

Nothing is going wrong, and diffstat doesn't produce it, exactly because 
diffstat cannot understand renames.

So what happened is that you had files (and directories) that got renamed, 
and "git diff --stat" will show that.

For example, one was just a rename within one directory: that's the

	.../{cpu_setup_power4.S => cpu_setup_ppc970.S}

thing. In the other cases, the file got renamed at the directory level 
(the two final pathnames remained the same, but the file got moved from 
one directory to another). That's what he

	prefix/{dir => dir2}/file.c

syntax means. It's renaming "file.c" from "prefix/dir/file.c" to 
"prefix/dir2/file.c".

With long path-names, it can get a bit confusing, since we then truncate 
the end result and just show the last parts to make it fit, of course.

This is _hugely_ superior to a regular diffstat, btw. If you have a 
regular diffstat, and you moved a file and made some changes, it will look 
something like

	one/dir/file.c            |  278 -------------
	another/file.c            |  280 ++++++++++++++

but with rename detection on (remember, you need "-M" to enable it in 
git), you'd get

	{one/dir => another}/file.c  | 7 +++--

ie it would show the rename and the (much smaller) change that was 
associated with it.

		Linus
