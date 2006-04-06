Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbWDFRDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWDFRDH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 13:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbWDFRDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 13:03:07 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:10382 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S932200AbWDFRDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 13:03:04 -0400
Date: Thu, 6 Apr 2006 19:02:44 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Mike Hearn <mike@plan99.net>
cc: 7eggert@gmx.de, Neil Brown <neilb@suse.de>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] Add a /proc/self/exedir link
In-Reply-To: <443515E1.1000600@plan99.net>
Message-ID: <Pine.LNX.4.58.0604061841150.1941@be1.lrz>
References: <5XGlt-GY-23@gated-at.bofh.it> <5XGOz-1eP-35@gated-at.bofh.it>
 <E1FRSqP-0000g3-9i@be1.lrz> <443515E1.1000600@plan99.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Apr 2006, Mike Hearn wrote:

> > IMO the program must be aware of the get-my-exedir feature, just configuring
> > --prefix=/proc/... is aiming for your feet.
> 
> I disagree, though /proc/self/exedir may not be the right answer. The 
> problem with the original proposal is there's no concept of a group 
> leader to which files are resolved relative to so there is this problem 
> with child processes.

The problem ist the word 'the'. If parent and child are using 'the foo',
they will clash.

> I sent a mail outlining a scheme that used file descriptor passing to 
> achieve the same effect but with the needed "inheritance" of the path, 
> but, vger seems to have munched it! At least I don't see it on the gmane 
> archives. But the scheme is simple enough:
> 
>   * get_prefix() reads /proc/self/exe and turns it into the correct
>     directory
> 
>   * dup2(open(get_my_exedir()), 999)
>
>   * ./configure --prefix=/proc/self/fd/999

bin/foo calls bin/bar refering to /proc/self/fd/999
bin_2/bar does dup2(open(get_my_exedir()), 999)  ***FUBAR***

possible solution:

don't dup2, and only close fds you opened yourself.

Disadvantage: Leaky (too), may break scripts.

.oO(Can you chroot a single filedescriptor or somehow make 
    /proc/self/fd/$n/.. be unavailable?)

> It also restricts the problem to passing paths to other processes that 
> are not subprocesses (eg via rpc). But as each process can have its own 
> namespace this will always be an issue that needs careful treatment, and 
> the pain of adjusting software to realpath() it is much lower than 
> modifying every path in every piece of software. That approach was 
> already tried and sucks.

There may be no "real path" corresponding to /proc/self/fd/4711.

IMO it's still best to just symlink the program directory to the correct 
place and make the programs search in e.g. ~/opt/ and /opt/.
-- 
Fun things to slip into your budget
An abacus
