Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757343AbWKWK13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757343AbWKWK13 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 05:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757346AbWKWK13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 05:27:29 -0500
Received: from nz-out-0102.google.com ([64.233.162.203]:52939 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1757343AbWKWK11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 05:27:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=il0clXkYbsFhKU7I3veiWxJNeEydnhu+55EtNYIGF819QnSRQqc5WGs2DYpxyo0vG609rLb4euf2LQqAyKYLOf5TwuZoJ1WbdUS6UGOPfIxMYiogRhkb+80ZwhCNhaSjsxjzprAhmXL2nX/SaYyv56kwkRW80zd1hpgtPAtc6iQ=
Message-ID: <9a8748490611230227x79247715h9e47a4e96bb7f915@mail.gmail.com>
Date: Thu, 23 Nov 2006 11:27:26 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Stephen Hemminger" <shemminger@osdl.org>
Subject: Re: 2.6.19-rc6 : Spontaneous reboots, stack overflows - seems to implicate xfs, scsi, networking, SMP
Cc: "David Chinner" <dgc@sgi.com>, chatz@melbourne.sgi.com,
       LKML <linux-kernel@vger.kernel.org>, xfs@oss.sgi.com,
       xfs-masters@oss.sgi.com, netdev@vger.kernel.org,
       linux-scsi@vger.kernel.org
In-Reply-To: <20061122120119.416901c7@freekitty>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200611211027.41971.jesper.juhl@gmail.com>
	 <45637566.5020802@melbourne.sgi.com>
	 <9a8748490611211402xdc2822fqbc95a77fe54d49b1@mail.gmail.com>
	 <20061121233141.GP37654165@melbourne.sgi.com>
	 <9a8748490611211551v2ebe88fel2bcf25af004c338a@mail.gmail.com>
	 <9a8748490611220458w4d94d953v21f7a29a9f1bdb72@mail.gmail.com>
	 <20061122120119.416901c7@freekitty>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/06, Stephen Hemminger <shemminger@osdl.org> wrote:
> On Wed, 22 Nov 2006 13:58:11 +0100
> "Jesper Juhl" <jesper.juhl@gmail.com> wrote:
>
> > On 22/11/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> > > On 22/11/06, David Chinner <dgc@sgi.com> wrote:
> > > > On Tue, Nov 21, 2006 at 11:02:23PM +0100, Jesper Juhl wrote:
> > > > > On 21/11/06, David Chatterton <chatz@melbourne.sgi.com> wrote:
> > ...
> > > > > >Thanks for traces, I've captured this information.
> > > > > >
> > > > > You are welcome. If you want/need more traces then I've got ~2.1G
> > > > > worth of traces that you can have :)
> > > >
> > > > Well, we don't need that many, but it would be nice to have a
> > > > set of unique traces that lead to overflows - could you process
> > > > them in some way just to extract just the unique XFS traces that
> > > > occur?
> > > >
> > > I'll try to extract a copy of each unique trace that involves xfs,
> > > sometime tomorrow or the day after, and then send you the result.
> > >
> >
> > Attached are two files. The one named stack_overflows.txt.gz contains
> > one instance of each unique stack overflow + trace that I've got.  The
> > other file named kernel_BUG.txt.gz contains a few BUG() messages that
> > were also in the logs.
> >
>
> You have a kind of worst case scenario there:
>         XFS + Block layer
>         TCP receive/transmit
>         VLAN
>
> It is hard to know who to blame, there is no information about stack
> level at each call. Since it doesn't show up for filesystems other than
> XFS, I would pick on that. Perhaps the following:
>
Well, there's a very good explanation for that. The server has nothing
but XFS file systems (well, /boot is ext3, but that doesn't get used
for anything but the kernel image and System.map file).

>
> --- 2.6.19-rc6.orig/arch/i386/Kconfig.debug     2006-11-22 11:59:32.000000000 -0800
> +++ 2.6.19-rc6/arch/i386/Kconfig.debug  2006-11-22 12:00:28.000000000 -0800
> @@ -58,7 +58,7 @@
>
>  config 4KSTACKS
>         bool "Use 4Kb for kernel stacks instead of 8Kb"
> -       depends on DEBUG_KERNEL
> +       depends on DEBUG_KERNEL && !XFS_FS
>         help
>           If you say Y here the kernel will use a 4Kb stacksize for the
>           kernel stack attached to each process/thread. This facilitates
>
Using 8K stacks works arround the problem, so for now the above patch
may well make sense. But, it would be better to get XFS fixed rather
than start adding dependencies for 4KSTACKS - it might be troublesome
getting rid of it again.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
