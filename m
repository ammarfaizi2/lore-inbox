Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264782AbUGBSp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264782AbUGBSp7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 14:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264853AbUGBSp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 14:45:58 -0400
Received: from mail-ext.curl.com ([66.228.88.132]:32271 "HELO
	mail-ext.curl.com") by vger.kernel.org with SMTP id S264782AbUGBSpx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 14:45:53 -0400
To: Szakacsits Szabolcs <szaka@sienet.hu>
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>, bug-parted@gnu.org,
       "K.G." <k_guillaume@libertysurf.fr>,
       Steffen Winterfeldt <snwint@suse.de>, Thomas Fehr <fehr@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Restoring HDIO_GETGEO semantics (was: Re: workaround for BIOS / CHS stuff)
References: <Pine.LNX.4.21.0407021936550.30622-100000@mlf.linux.rulez.org>
From: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Message-ID: <s5gzn6iz2or.fsf@patl=users.sf.net>
Date: 02 Jul 2004 14:45:50 -0400
In-Reply-To: <Pine.LNX.4.21.0407021936550.30622-100000@mlf.linux.rulez.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here we go again.

Szakacsits Szabolcs <szaka@sienet.hu> writes:

> Two choices to "fix" this guess game:
> 
>     1) return error ("I don't know") but providing compatibility
>        functionality for things that the kernel knows (e.g. where the
>        partition starts). 

As you point out, this will require changes to several userspace
programs.  It is the correct long term solution, but a deprecation
period would be nice.

>     2) use EDD, it does a much better job -- maybe this suggestions
>        doesn't make much sense overall, so only 1) left if you don't 
>        want to keep guessing.

Using EDD to deduce the geometry is the "right" answer.  But this is
sufficiently complex and special-purpose that it has no place in the
kernel.

> Unfortunately it seems it's more messed up. You didn't write any
> specific why the current situation would be better. What does
> HDIO_GETGEO returns at present? Hard coded values? Random values?

Values used by the controller itself.  Also the values you will get
from the "extended INT13" BIOS interface.  As good a geometry as any,
unless you plan to dual-boot Windows.

> Then why not error instead?

Fine idea in the long term, but start by declaring the HDIO_GETGEO
interface "obsolescent" and spit a warning to syslog when it is used.
Finding and fixing all the userspace invocations will take some time.

Right now, HDIO_GETGEO is the only way some applications (e.g., mine)
can convince Parted to use the right geometry.  So, fix Parted to
allow the user (i.e., the higher-level partitioning machinery) to
specify the geometry.  This is the first and last necessary task
before eliminating Parted's use of HDIO_GETGEO.

> On Fri, 2 Jul 2004, Andries Brouwer wrote:
>
> > The only case I see where absolutely something is needed is the
> > case of partitioning an empty disk.
> 
> Recovery, cloning, ...

...moving a drive between machines...

Why does this stupid idea keep coming up?  Inferring the geometry from
the existing partition table is just plain wrong.  It is even more
wrong than the old 2.4 behavior, because it is still a guess, just a
worse guess.

 - Pat
