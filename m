Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161184AbWJRPol@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161184AbWJRPol (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 11:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161088AbWJRPol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 11:44:41 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:19882 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1161184AbWJRPok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 11:44:40 -0400
Date: Wed, 18 Oct 2006 11:44:26 -0400
From: Chris Mason <chris.mason@oracle.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Zach Brown <zach.brown@oracle.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: AIO, DIO fsx tests failures on 2.6.19-rc1-mm1
Message-ID: <20061018154426.GE16570@think.oraclecorp.com>
References: <1161013338.32606.2.camel@dyn9047017100.beaverton.ibm.com> <4533C6A1.40203@oracle.com> <1161021586.32606.6.camel@dyn9047017100.beaverton.ibm.com> <4533E7E2.6010506@oracle.com> <1161031099.32606.14.camel@dyn9047017100.beaverton.ibm.com> <20061016135910.be11a2dc.akpm@osdl.org> <453559D5.4000809@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <453559D5.4000809@us.ibm.com>
User-Agent: Mutt/1.5.12-2006-07-14
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2006 at 03:31:49PM -0700, Badari Pulavarty wrote:
> Okay. Finally tracked down the problem I am running into.
> This happens only on reiserfs
> 
> # /root/fsx-linux -N 10000 -o 128000 -r 2048 -w 4096 -Z -R -W
> jnk
> mapped writes DISABLED
> doread: read: Invalid argument
> Segmentation fault
> 
> Here is the strace for it
> ..
> ftruncate(3, 2721)                      = 0
> fstat(3, {st_mode=S_IFREG|0644, st_size=2721, ...}) = 0
> lseek(3, 0, SEEK_END)                   = 2721
> fstat(3, {st_mode=S_IFREG|0644, st_size=2721, ...}) = 0
> lseek(3, 0, SEEK_END)                   = 2721
> fstat(3, {st_mode=S_IFREG|0644, st_size=2721, ...}) = 0
> lseek(3, 0, SEEK_END)                   = 2721
> lseek(3, 0, SEEK_SET)                   = 0
> read(3, 0x50a800, 2048)                 = -1 EINVAL (Invalid argument)
> 
> reiserfs getblock() is returing -EINVAL. There is comment in the code
> about tail handling and returning EINVAL. BTW, this is not a -mm
> issue, it happens on mainline too...

Yes, reiserfs doesn't allow O_DIRECT on tails.  You'll have to mount -o
notail for this test.

-chris
