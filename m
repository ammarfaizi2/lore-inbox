Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269974AbSKEDv2>; Mon, 4 Nov 2002 22:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275547AbSKEDv1>; Mon, 4 Nov 2002 22:51:27 -0500
Received: from almesberger.net ([63.105.73.239]:24329 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S277480AbSKEDv0>; Mon, 4 Nov 2002 22:51:26 -0500
Date: Tue, 5 Nov 2002 00:57:45 -0300
From: Werner Almesberger <wa@almesberger.net>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: jw schultz <jw@pegasys.ws>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: ps performance sucks (was Re: dcache_rcu [performance results])
Message-ID: <20021105005745.E1407@almesberger.net>
References: <20021030161912.E2613@in.ibm.com> <20021031162330.B12797@in.ibm.com> <3DC32C03.C3910128@digeo.com> <20021102144306.A6736@dikhow> <1025970000.1036430954@flay> <20021105000010.GA21914@pegasys.ws> <1118170000.1036458859@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118170000.1036458859@flay>; from mbligh@aracnet.com on Mon, Nov 04, 2002 at 05:14:19PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> I had a very brief think about this at the weekend, seeing
> if I could make a big melting pot /proc/psinfo file

You could take a more radical approach. Since the goal of such
a psinfo file would be to accelerate access to information
that's already available elsewhere, you can do away with many
of the niceties of procfs, e.g.

 - no need to be human-readable (e.g. binary or hex dump may
   make sense in this case)
 - may use other operations than just open and read (e.g.
   do an initial write to select what should be read)
 - you may cache previous responses and only output deltas
   (not sure if this is useful - all you'd safe is the
   actual copy to user space)

Actually, I think attempting to just make it brutally efficient,
no matter how much nastiness you amass doing that, might be
good approach for a first version. Then, if people are
digusted, you can make things nicer, and keep track of how
much performance you're losing.

Example:

First write says "pid,comm". Internally, this gets translated
to 0x8c+0x04, 0x2ee+0x10 (offset+length). Next read returns
"pid 4,comm 16" (include the name, so you can indicate fields
the kernel doesn't recognize). Then, kmalloc 20*tasks bytes,
lock, copy the fields from struct task_struct, unlock, let the
stuff be read by user space, kfree. Adjacent fields can be
optimized to single byte strings at setup time.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
