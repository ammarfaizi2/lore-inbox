Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265059AbSKEET4>; Mon, 4 Nov 2002 23:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265260AbSKEET4>; Mon, 4 Nov 2002 23:19:56 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:44805 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S265059AbSKEETu>; Mon, 4 Nov 2002 23:19:50 -0500
Date: Mon, 4 Nov 2002 20:26:17 -0800
From: jw schultz <jw@pegasys.ws>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: ps performance sucks (was Re: dcache_rcu [performance results])
Message-ID: <20021105042616.GB21914@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	LKML <linux-kernel@vger.kernel.org>
References: <20021030161912.E2613@in.ibm.com> <20021031162330.B12797@in.ibm.com> <3DC32C03.C3910128@digeo.com> <20021102144306.A6736@dikhow> <1025970000.1036430954@flay> <20021105000010.GA21914@pegasys.ws> <1118170000.1036458859@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118170000.1036458859@flay>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2002 at 05:14:19PM -0800, Martin J. Bligh wrote:
> I think it's pretty trivial to make /proc/<pid>/psinfo, which
> dumps the garbage from all five files in one place. Which makes
> it 5 times better, but it still sucks.

And i'd still keep environ seperate.  I'm inclined to think
ps should never have presented it in the first place.
This is the direction i (for what it's worth) favor.

> > Don't get me wrong.  I believe in the one field per file
> > rule but ps &co are the exception that proves (tests) the
> > rule.  Especially on the heavily laden systems with
> > tens of thousands of tasks.  We could do with a something
> > between /dev/kmem and five files per pid.
> 
> I had a very brief think about this at the weekend, seeing
> if I could make a big melting pot /proc/psinfo file that did
> seqfile and read everything out in one go, using seq_file
> internally to interate over the tasklist. The most obvious
> problem that sprung to mind seems to be the tasklist locking -
> you obviously can't just hold a lock over the whole thing.
> As I know very little about that, I'll let someone else suggest
> how to do this, but I'm prepared to do the grunt work of implementing
> it if need be.

Yep, can't hold the lock across syscalls.  That would be
quite a bit of data to hold in a per fd buffer.  Think of
the big iron with tons of processes.

The other way i could see this working is to present it as a
sparse file.  ps (or whatever) would first get a list of
pids then iterate over them using lseek to set the file
offset to pid * CONSTANT_SIZE and read would return
something smaller than CONSTANT_SIZE bytes.  If the pid no
longer exists return 0.

I really hate this idea.  It stinks almost as much as
/dev/kmem.


-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
