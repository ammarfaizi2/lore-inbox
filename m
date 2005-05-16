Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261904AbVEPW0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261904AbVEPW0o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 18:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbVEPWZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 18:25:26 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:29645 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S261904AbVEPWSZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 18:18:25 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 7/8] ppc64: SPU file system
Date: Tue, 17 May 2005 00:01:05 +0200
User-Agent: KMail/1.7.2
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <200505132117.37461.arnd@arndb.de> <200505141505.08999.arnd@arndb.de> <20050516205825.GB11938@kroah.com>
In-Reply-To: <20050516205825.GB11938@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505170001.10405.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maandag 16 Mai 2005 22:58, Greg KH wrote:
> On Sat, May 14, 2005 at 03:05:06PM +0200, Arnd Bergmann wrote:

> > 2. sys_spufs_run(int fd, __u32 pc, __u32 *new_pc, __u32 *status):
> >  pro:
> >      - strong types
> >      - can have both input and output arguments
> >  contra:
> >      - does not fit file system semantics well
> >      - bad for prototyping
> 
> I suggest you do this.  Based on what you say you want the code to do, I
> agree, write() doesn't really work out well

The syscall approach has another small disadvantage in that I need to
do a callback registration mechanism for it if I want to have spufs as
a loadable module. I could of course require spufs to be builtin, but
that complicates prototype testing (as mentioned) and enlarges combined
pSeries/powermac/BPA distro kernels.

I think I'll leave the ioctl for now and add a note saying that I need
to replace it with a syscall or the write/read or lseek/read based
approach when I arrive at a more feature complete point.

> (but it might, and if you 
> want an example of how to do it, look at the ibmasm driver, it
> implements write() in a way much like what you are wanting to do.)

That would be the same write/read combination as Ben's second
proposal and the nfsctl file system, right?

> > My solution was to force the dentries in each directory to be
> > present. When the directory is created, the files are already
> > there and unlinking a single file is impossible. To destroy the
> > spu context, the user has to rmdir it, which will either remove
> > all files in there as well or fail in the case that any file is
> > still open.
> 
> Ick.
> 
> > Of course that is not really Posix behavior, but it avoids some
> > other pitfalls.
> 
> Go with a syscall :)

Sorry, I'm not following that reasoning. How does a syscall help
with the problem of atomic context destruction?

	Arnd <><
