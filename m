Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266116AbSK1RGZ>; Thu, 28 Nov 2002 12:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266210AbSK1RGZ>; Thu, 28 Nov 2002 12:06:25 -0500
Received: from pc-62-31-66-70-ed.blueyonder.co.uk ([62.31.66.70]:48259 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S266116AbSK1RGW>; Thu, 28 Nov 2002 12:06:22 -0500
Date: Thu, 28 Nov 2002 17:13:24 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
       Jeremy Fitzhardinge <jeremy@goop.org>,
       Ext2 devel <ext2-devel@lists.sourceforge.net>,
       NFS maillist <nfs@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [Ext2-devel] Re: [NFS] htree+NFS (NFS client bug?)
Message-ID: <20021128171324.G2362@redhat.com>
References: <1038354285.1302.144.camel@sherkaner.pao.digeo.com> <shsptsrd761.fsf@charged.uio.no> <1038387522.31021.188.camel@ixodes.goop.org> <20021127150053.A2948@redhat.com> <15845.10815.450247.316196@charged.uio.no> <20021127205554.J2948@redhat.com> <20021128164439.E2362@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021128164439.E2362@redhat.com>; from sct@redhat.com on Thu, Nov 28, 2002 at 04:44:39PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 28, 2002 at 04:44:39PM +0000, Stephen C. Tweedie wrote:
 
> And it's ext3's fault.  Reproducer below.  Run the attached readdir
> against an htree directory and you get something like:
> ...
> getdents at f_pos 0X0000007060CF8B returned 4080.
> getdents at f_pos 0X0000007B9213FA returned 1464.
> getdents at f_pos 0X0000007B9213FA returned 0.
> Final f_pos is 0X0000007B9213FA.
> [root@host1 htest]# 
> 
> The problem is that the htree readdir code is not updating f_pos after
> returning the very last chunk of data to the caller.  That doesn't
> hurt most callers because the location is cached in the filp->private
> data, but it really upsets NFS.

In fact, it's not clear what we _can_ return as f_pos after the last
dirent.

We're only using 31-bit hashes right now.  Trond, how will other NFS
clients react if we return an NFS cookie 32-bits wide?  We could
easily use something like 0x80000000 as an f_pos to represent EOF in
the Linux side of things, but will that cookie work if passed over the
wire on NFSv2?

The alternative is to hack in a special case so that (for example) we
consider a major htree hash of 0x7fffffff to map to an f_pos of
0x7ffffffe and just consider that a possible collision, so that
0x7fffffff is a unique EOF for the htree tree walker.

--Stephen
