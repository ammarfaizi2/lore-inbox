Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131577AbRBWLWH>; Fri, 23 Feb 2001 06:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131611AbRBWLV5>; Fri, 23 Feb 2001 06:21:57 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:8684 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S131610AbRBWLVk>; Fri, 23 Feb 2001 06:21:40 -0500
Message-ID: <3A964836.35D577B1@redhat.com>
Date: Fri, 23 Feb 2001 06:23:34 -0500
From: Doug Ledford <dledford@redhat.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: cpu_has_fxsr or cpu_has_xmm?
In-Reply-To: <200102230538.VAA17793@mail23.bigmailbox.com> <974uv8$303$1@cesium.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" wrote:
> 
> Followup to:  <200102230538.VAA17793@mail23.bigmailbox.com>
> By author:    "Quim K Holland" <qkholland@my-deja.com>
> In newsgroup: linux.dev.kernel
> >
> > I've been looking at various -ac patches for the last couple of
> > weeks and have been wondering why only this piece of difference
> > still remains between Linus' 2.4.2 and Alan's -ac2.  All the other
> > diffs in i387.c from 2.4.1-ac2 seem to have been merged into Linus
> > tree at around 2.4.2-pre1.  Could anybody explain it for me please?
> >
> > --- linux.vanilla/arch/i386/kernel/i387.c       Thu Feb 22 09:05:35 2001
> > +++ linux.ac/arch/i386/kernel/i387.c    Sun Feb  4 10:58:36 2001
> > @@ -179,7 +179,7 @@
> >
> >  unsigned short get_fpu_mxcsr( struct task_struct *tsk )
> >  {
> > -       if ( cpu_has_fxsr ) {
> > +       if ( cpu_has_xmm ) {
> >                 return tsk->thread.i387.fxsave.mxcsr;
> >         } else {
> >                 return 0x1f80;
> >
> 
> IMO, XMM is correct here; FXSR is incorrect.  Linus?

I sent Linus a patch that changed that to xmm (along with the same in another
place or two, where needed).  Linus I guess dropped that one line out of the
patch while Alan kept it.  That's the reason for the difference.  As to the
correctness, the mxcsr register really only exists if you have xmm, so the xmm
is the correct test.  However, the memory location in the fxsr structure was
reserved by the time the fxsr was put together, so the worst this does is give
an undefined mxcsr value on machines where mxcsr doesn't exist, which is why I
didn't yell too loudly when Linus dropped that line out.  User space
programmers should be checking for xmm capability themselves before ever
paying attention to mxcsr anyway, so it's not an end of the world error.

-- 

 Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
      Please check my web site for aic7xxx updates/answers before
                      e-mailing me about problems
