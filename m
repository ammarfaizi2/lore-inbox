Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030200AbWCTT7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030200AbWCTT7H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 14:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030196AbWCTT7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 14:59:06 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:22155 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030180AbWCTT7E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 14:59:04 -0500
Date: Mon, 20 Mar 2006 19:58:58 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, mingz@ele.uri.edu, mikado4vn@gmail.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
Subject: Re: Question regarding to store file system metadata in database
Message-ID: <20060320195858.GD27946@ftp.linux.org.uk>
References: <441CE71E.5090503@gmail.com> <4ae3c140603190948s4fcd135er370a15003a0143a8@mail.gmail.com> <1142791121.31358.21.camel@localhost.localdomain> <4ae3c140603191011r7b68f4aale01238202656d122@mail.gmail.com> <1142792787.31358.28.camel@localhost.localdomain> <4ae3c140603191050k3bf7e960q9b35fe098e2fbe35@mail.gmail.com> <20060319194723.GA27946@ftp.linux.org.uk> <20060320130950.GA9334@thunk.org> <4ae3c140603200713m24a5af0agd891a709286deb47@mail.gmail.com> <4ae3c140603201136q7e61963dy635bb2c6047f0bc2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ae3c140603201136q7e61963dy635bb2c6047f0bc2@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2006 at 02:36:51PM -0500, Xin Zhao wrote:
> OK. Now I have more experimental results.
> 
> After excluding the cost of reading file list and do stat(), the
> insertion rate becomes 587/sec, instead of 300/sec. The query rate is
> 2137/sec. I am runing mysql 4.1.11. FC4, 2.8G CPU and 1G mem.
> 
> 2137/sec seems to be good enough to handle pathname to inode
> resolving.  Anyone has some statistics how many file open in a busy
> file system?

This is still ridiculously slow.  From cold cache (i.e. with a lot of IO)
cp -rl linux-2.6 foo1 gives 1.2s here.  That's at least about 50000
operations.  On slower CPU, BTW, with half of the RAM you have.

Moreover,
al@duke:~/linux$ time mv foo1 foo2

real    0m0.002s
user    0m0.000s
sys     0m0.001s

Now, try _that_ on your setup.  If you are using entire pathname as key,
you are FUBAR - updating key in 20-odd thousand of records is going to
_hurt_.  If you are splitting the pathname into components, you've just
reproduced fs directory structure and had shown that your fs layout
is too fscking slow.  Not to mention the fun with symlink implementation,
or handling mountpoints.

You are at least an order of magnitude off by performance (more, actually)
and I still don't see any reason for what you are trying to do.
