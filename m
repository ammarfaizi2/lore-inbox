Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbUCSIGO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 03:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbUCSIGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 03:06:14 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:18055
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S261772AbUCSIGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 03:06:07 -0500
Message-ID: <405AA9E0.4040102@redhat.com>
Date: Fri, 19 Mar 2004 00:05:52 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040317
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: sched_setaffinity usability
References: <40595842.5070708@redhat.com> <20040318112913.GA13981@elte.hu> <20040318120709.A27841@infradead.org> <20040318123103.GA21893@elte.hu>
In-Reply-To: <20040318123103.GA21893@elte.hu>
X-Enigmail-Version: 0.83.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

> i'm wondering how dangerous of an API idea it is to make these
> parameters part of the VDSO .data section (and make it/them versioned
> DSO symbols).

Exporting variables is never a good idea.  The interface is inflexible.
 If the variable size or layout changes or it needs to be dynamically
changed this is bad.

Even if this ticks off a certain LT, a sysconf()-like interface is the
most flexible.  The results would be stored in libc if the lookup is
likely to happen frequently.  The sysconf code in the vdso has all the
flexibility it could ever need.  For instance, a query as to how many
processors are online could do some computations or even make syscalls
if necessary.  Or it could just return a constant like 1 if this is
known at compile or startup time.  I cannot imagine why this isn't
something the kernel people like, you get full control of the way to
compute the values.  The exposed interface is minimal, as opposed to
exporting many individual variables.


> The only minor complication wrt. uname() would be sethostname: other
> CPUs could observe a transitional state of (the VDSO-equavalent of)
> system_utsname.nodename. Is this a problem? It's not like systems call
> sethostname all that often ...

Again, by exporting an interface to access the value you can get all the
control you need.  In this case it'd probably be a confstr()-like
interface which is just like sysconf(), but can return strings or
arbitrary data (it gets passed a memory pointer and size).

To implement gethostname() without races store the hostname as

   host name MAGIC

The read function can first read MAGIC, read barrier, then read the host
name, read barrier, then read MAGIC again.  If MAGIC changed, rinse and
repeat.  Doing this from libc would mean to hardcode all the processor
idiosyncrasies to do all this in the libc.  It has to be generic enough
to cover all versions of the CPU (maybe some need the MAGIC value to be
specially aligned) and then has to dynamically decide what version to
use.  In the vdso the kernel can decide at boot time which functions to
use since it knows at that time what CPUs are used.

Some other syscalls like uname() can be fully implemented in the vdso as
well.  The vdso is writable in the kernel so the mapped data can be
updated.  In the uname() case, the syscall would be a simple memcpy()
from the place in the vdso into the place designated by the parameter.

Even if it is not possible to implement the entire syscall at userlevel,
maybe just a part can be done in the vdso, in the prologue or epilogue
of the vdso function.


The kernel gets the opportunity to *OPTIONALLY* tweak every little
aspect of the syscall handling if it just wants to.  All this without
having to change the libc and waiting for the changes to be widely deployed.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
