Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261623AbVC0Mpw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbVC0Mpw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 07:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbVC0Mpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 07:45:51 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:6662 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261623AbVC0Mpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 07:45:41 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Arjan van de Ven <arjan@infradead.org>, linux-os@analogic.com
Subject: Re: [PATCH] remove redundant NULL pointer checks prior to calling kfree() in fs/nfsd/
Date: Sun, 27 Mar 2005 15:45:27 +0300
User-Agent: KMail/1.5.4
Cc: Jesper Juhl <juhl-lkml@dif.dk>, Neil Brown <neilb@cse.unsw.edu.au>,
       nfs@lists.sourceforge.net, Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.62.0503252319220.2498@dragon.hyggekrogen.localhost> <Pine.LNX.4.61.0503251731240.6372@chaos.analogic.com> <1111826041.6293.31.camel@laptopd505.fenrus.org>
In-Reply-To: <1111826041.6293.31.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503271545.28335.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 26 March 2005 10:34, Arjan van de Ven wrote:
> On Fri, 2005-03-25 at 17:34 -0500, linux-os wrote:
> > On Fri, 25 Mar 2005, Jesper Juhl wrote:
> > 
> > > (please keep me on CC)
> > >
> > >
> > > checking for NULL before calling kfree() is redundant and needlessly
> > > enlarges the kernel image, let's get rid of those checks.
> > >
> > 
> > Hardly. ORing a value with itself and jumping on condition is
> > real cheap compared with pushing a value into the stack
> 
> which century are you from?
> "jumping on condition" can easily be 100+ cycles, depending on how
> effective the branch predictor is. Pushing a value onto the stack otoh
> is half a cycle.

linux-os is right because kfree does NULL check with exactly
the same code sequence, test and branch:

# objdump -d mm/slab.o
...
000012ef <kfree>:
    12ef:       55                      push   %ebp
    12f0:       89 e5                   mov    %esp,%ebp
    12f2:       57                      push   %edi
    12f3:       56                      push   %esi
    12f4:       53                      push   %ebx
    12f5:       51                      push   %ecx
    12f6:       8b 7d 08                mov    0x8(%ebp),%edi
    12f9:       85 ff                   test   %edi,%edi
    12fb:       74 46                   je     1343 <kfree+0x54>
...
...
...
    1343:       8d 65 f4                lea    0xfffffff4(%ebp),%esp
    1346:       5b                      pop    %ebx
    1347:       5e                      pop    %esi
    1348:       5f                      pop    %edi
    1349:       5d                      pop    %ebp
    134a:       c3                      ret

So kfree(p) indeed will spend time for doing a call,
for test-and-branch, *and* finally for ret,
while if(p) kfree(p) will do test-and-branch first
and won't do call/ret if p==NULL.

However, if p is not NULL, if(p) kfree(p) does:
1) test-and-branch (not taken)
2) call
3) another test-and-branch (not taken)!

I conclude that if(p) kfree(p) makes sense only if:
a) p is more often NULL than not, and
b) it's in the hot path (you don't want to save on code size)

Since (a) is not typical, I think Jesper's cleanups are ok.
--
vda

