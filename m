Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263131AbTKKUIP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 15:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263408AbTKKUIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 15:08:15 -0500
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:33762 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S263131AbTKKUIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 15:08:13 -0500
Date: Tue, 11 Nov 2003 15:08:13 -0500
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: OT: why no file copy() libc/syscall ??
Message-ID: <20031111200812.GA23283@delft.aura.cs.cmu.edu>
Mail-Followup-To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <1068512710.722.161.camel@cube> <20031110205011.R10197@schatzie.adilger.int> <1068523406.4156.7.camel@localhost> <200311110414.hAB4EZA8007309@turing-police.cc.vt.edu> <20031110230055.S10197@schatzie.adilger.int> <20031111085806.GC11435@deneb.enyo.de> <20031111102742.GC17240@pegasys.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031111102742.GC17240@pegasys.ws>
User-Agent: Mutt/1.5.4i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 11, 2003 at 02:27:42AM -0800, jw schultz wrote:
> On Tue, Nov 11, 2003 at 09:58:06AM +0100, Florian Weimer wrote:
> > Andreas Dilger wrote:
> > 
> > > > This is fast turning into a creeping horror of aggregation.  I defy anybody
> > > > to create an API to cover all the options mentioned so far and *not* have it
> > > > look like the process_clone horror we so roundly derided a few weeks ago.
> > > 
> > > 	int sys_copy(int fd_src, int fd_dst)
> 
> That sounds a lot like a sendfile with a file as the
> destination.  Useful but still happening on the local system.
> My understanding was that this was to be sent to a remote
> system where the file descriptors might not be open.

It probably should be sendfile, where the destination fd is a local file
instead of a socket. We really do not want to pass pathnames down into
the filesystem layer. As far as I know, no existing VFS operation does
that and it probably isn't a good idea to start doing it now.

Somehow the filesystem that 'hosts' the src_fd object should get a
chance to see/intercept the sendfile syscall, and it can then decide
based on the dst_fd object what to do. If the destination happens to be
in the same filesystem it could possibly use a special internal copyfile
rpc call or CoW implementation.

The userspace/libc code could provide a copyfile(char* src, char* dst,
int flags, int mode) wrapper, which can also handle falling back to a
simple read/write loop when sendfile fails.

So we clearly don't need a new system call, sendfile would do fine and
interestingly the manual page I'm reading now mentions that the source
has to be a mmap-able object, but lists no such restrictions on the
destination fd. Maybe sendfile already works and we just need to give the
filesystems a chance to override it.

Jan

