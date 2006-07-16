Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751332AbWGPXYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbWGPXYN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 19:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWGPXYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 19:24:13 -0400
Received: from mail.suse.de ([195.135.220.2]:19143 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751332AbWGPXYN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 19:24:13 -0400
From: Neil Brown <neilb@suse.de>
To: Janos Farkas <chexum+dev@gmail.com>
Date: Mon, 17 Jul 2006 09:23:38 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17594.51834.20365.820166@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: nfs problems with 2.6.18-rc1
In-Reply-To: message from Janos Farkas on Thursday July 13
References: <priv$8d118c145575$b19af6759a@200607.shadow.banki.hu>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday July 13, chexum+dev@gmail.com wrote:
> Hi!
> 
> I recently updated two (old) hosts to 2.6.18-rc1, and started noticing
> weird things with the nfs mounted /home s.

So this is both the client and the server that you upgraded?  That
makes is harder to point the finger of blame :-)

> 
> I frequently face EACCESs where a few minutes ago there wasn't any
> problem, and after a retry everything does work again.
> 

I wonder if that is pointing the finger at

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=8c7b389e532e964f07057dac8a56c43465544759

as that is a recent change that returns 'EACCES'... but I cannot see
that being relevant in this case as it only affects directories.

> 
> How can I help with tracing this?  git bisecting on these machines takes
> at least an hour per step, (and no reasonable connectivity either to
> compile elsewhere much quicker).

The standard answer for tracing nfs problems if 'tcpdump'.
e.g. 
  tcpdump -s 0 -w /tmp/trace host $CLIENT and host $SERVER and port 2049

that should show whether the error is coming from the server, or if
the client is generating it all by itself.
If you can get a reasonably small '/tmp/trace', compress it and attach
it to an email.

Also turn on tracing. Something like:
on server
   echo 32767 > /proc/sys/sunrpc/nfsd_debug
on client
   echo 32767 > /proc/sys/sunrpc/nfs_debug

You can be a bit more selective by only enabling individual flags.
For the server, these are in include/linux/nfsd/debug.h
You probably want FH, EXPORT AUTH PROC FILEOP

For the client, they are near the end of include/linux/nfs_fs.h
Not sure which to choose... maybe just all of them.

NeilBrown
