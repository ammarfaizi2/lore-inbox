Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262494AbTCMSk7>; Thu, 13 Mar 2003 13:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262495AbTCMSk7>; Thu, 13 Mar 2003 13:40:59 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:774 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S262494AbTCMSkw> convert rfc822-to-8bit; Thu, 13 Mar 2003 13:40:52 -0500
Date: Thu, 13 Mar 2003 10:50:59 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Willy Gardiol <gardiol@libero.it>
cc: Jens Axboe <axboe@suse.de>, James Stevenson <james@stev.org>,
       Stephan von Krawczynski <skraw@ithnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: OOPS in 2.4.21-pre5, ide-scsi
In-Reply-To: <200303131739.39991.gardiol@libero.it>
Message-ID: <Pine.LNX.4.10.10303131048370.391-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan,

Did we not fix this problem when HP addressed it with the ia64 stuff?

Additionally I have finally found a long outstanding bug in the
buildsgtable in ide-dma.c.  I just need to reverify the nature.  It has to
do with the execution of the EOT bit in the last segment.  This would also
explain why we are seeing expiry dma timeouts.

Cheers,

On Thu, 13 Mar 2003, Willy Gardiol wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> 
> Do you thnik this can have somthing to share with the oops i am getting with 
> ide-scsi, a cd burner, DMA, and a PCI IDE controller?
> I attach the oops decoded.
> 
> There is a thread about this on linux-ide, it seems a problem common at least 
> to another guy
> 
> 
> Alle 17:37, giovedì 13 marzo 2003, Jens Axboe ha scritto:
> > On Thu, Mar 13 2003, James Stevenson wrote:
> > > Hi
> > >
> > > strange looks alot like the ones i have seen though the whole 2.4.x tree.
> > >
> > > this was discussed before somebody said they would send a patch myself
> > > and sombody else were going to test it but the patch never happens.
> > >
> > > >From what i can work out an error occurs on the cd drive and the request
> > >
> > > queue is then empty and the ide-scsi driver then attempts to access the
> > > reuest queue that doesnt exist i never did manage to find out
> > > where the request get removed from the queue though.
> >
> > Your explanation doesn't quite make sense, but I can take a look at the
> > problem :-)
> >
> > What kernel is the below oops from? What compiler?
> >
> > > *pde = 00000000
> > > Oops: 0000
> > > CPU:    0
> > > EIP:    0010:[<c01e5783>]    Not tainted
> > > Using defaults from ksymoops -t elf32-i386 -a i386
> > > EFLAGS: 00010202
> > > eax: 00000000   ebx: c7a71000   ecx: c0327104   edx: 00000000
> > > esi: 00000001   edi: c13a4fc0   ebp: cb23df58   esp: cb23df44
> > > ds: 0018   es: 0018   ss: 0018
> > > Process klogd (pid: 381, stackpage=cb23d000)
> > > Stack: 00000000 c0327294 c13de260 c0327294 00000202 cb23df78 c01cdd11
> > > c0327294
> > >        c01e5700 c0327104 c121db00 04000001 0000000f cb23df98 c010a0bd
> > > 0000000f
> > >        c13de260 cb23dfc4 cb23dfc4 0000000f c02f8ae0 cb23dfbc c010a24d
> > > 0000000f
> > > Call Trace: [<c01cdd11>] [<c01e5700>] [<c010a0bd>] [<c010a24d>]
> > > [<c010c358>] Code: 8b 72 18 46 89 72 18 8b 55 f0 8b 82 f0 00 00 00 8b 58
> > > 04 53
> > >
> > > >>EIP; c01e5783 <idescsi_pc_intr+83/290>   <=====
> > >
> > > Trace; c01cdd11 <ide_intr+c1/120>
> > > Trace; c01e5700 <idescsi_pc_intr+0/290>
> > > Trace; c010a0bd <handle_IRQ_event+3d/70>
> > > Trace; c010a24d <do_IRQ+7d/c0>
> > > Trace; c010c358 <call_do_IRQ+5/d>
> > > Code;  c01e5783 <idescsi_pc_intr+83/290>
> > > 00000000 <_EIP>:
> > > Code;  c01e5783 <idescsi_pc_intr+83/290>   <=====
> > >    0:   8b 72 18                  mov    0x18(%edx),%esi   <=====
> > > Code;  c01e5786 <idescsi_pc_intr+86/290>
> > >    3:   46                        inc    %esi
> > > Code;  c01e5787 <idescsi_pc_intr+87/290>
> > >    4:   89 72 18                  mov    %esi,0x18(%edx)
> > > Code;  c01e578a <idescsi_pc_intr+8a/290>
> > >    7:   8b 55 f0                  mov    0xfffffff0(%ebp),%edx
> > > Code;  c01e578d <idescsi_pc_intr+8d/290>
> > >    a:   8b 82 f0 00 00 00         mov    0xf0(%edx),%eax
> > > Code;  c01e5793 <idescsi_pc_intr+93/290>
> > >   10:   8b 58 04                  mov    0x4(%eax),%ebx
> > > Code;  c01e5796 <idescsi_pc_intr+96/290>
> > >   13:   53                        push   %ebx
> > >
> > > <0>Kernel panic: Aiee, killing interrupt handler!
> > >
> > > 1 warning issued.  Results may not be reliable.
> 
> - -- 
> 
> ! 
>  Willy Gardiol - gardiol@libero.it
>  goemon.polito.it/~gardiol
>  Use linux for your freedom.
> 
>    "La GPL e il modello open source consentono
>     la creazione della tecologia migliore.
>     Tutto qui."
> 
>       Linus Torvalds
> 
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.1 (GNU/Linux)
> 
> iD8DBQE+cLRLQ9qolN/zUk4RAhf0AJ0QrCS37i1zp1HuKFurga1SS1q4IQCfUqS+
> bLL8Q7X5t2a967ANOs0i8iM=
> =AH5R
> -----END PGP SIGNATURE-----
> 

Andre Hedrick
LAD Storage Consulting Group

