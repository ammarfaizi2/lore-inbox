Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751584AbVJLVGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584AbVJLVGQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 17:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751585AbVJLVGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 17:06:16 -0400
Received: from qproxy.gmail.com ([72.14.204.205]:51237 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751583AbVJLVGP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 17:06:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hLVMObE7cJpmpnfWQyefRTnntzdj6CSIXMixrGzxeyJoeRCzY7c2xU3oHfWO2Qh8n8kEuOQe3Kqrx4W2RmSQ1V2NRm9qoudb7OPTgreljk9+zcDy7ZuSfTJYRUA8sxhFrrO8Tzis8wbPyu6S/QbpTH8/lPmR8vNL1s5RPfxM6v0=
Message-ID: <121a28810510120211s62ae88d6m@mail.gmail.com>
Date: Wed, 12 Oct 2005 11:11:08 +0200
From: Grzegorz Nosek <grzegorz.nosek@gmail.com>
To: Andy Isaacson <adi@hexapodia.org>
Subject: Re: sys_sendfile oops in 2.6.13?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051012040006.GA31099@hexapodia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <121a28810510110156q1369b9dg@mail.gmail.com>
	 <20051012040006.GA31099@hexapodia.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/10/12, Andy Isaacson <adi@hexapodia.org>:
> On Tue, Oct 11, 2005 at 10:56:43AM +0200, Grzegorz Nosek wrote:
> > I found an (IMHO) silly bug in do_sendfile in 2.6.13.x kernels (at
> > least in 2.6.13.3 and .4, didn't backtrack to find where it
> > originated). Without the patch all I apparently get from sys_sendfile
> > is an oops due to a call in sys_sendfile with ppos being NULL. With the
> > patch it works OK. Noticed in vsftpd.
> >
> > @@ -719,7 +719,7 @@
> >        current->syscr++;
> >        current->syscw++;
> >
> > -       if (*ppos > max)
> > +       if (ppos && *ppos > max)
>
> That change can't fix a bug in 2.6.13, because ppos is forced to be
> non-null further up the file:
>
>     622 static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
> ...
>     647         if (!ppos)
>     648                 ppos = &in_file->f_pos;
> ...
>     684         pos = *ppos;
> ...
>     701         current->syscr++;
>     702         current->syscw++;
>     703
>     704         if (*ppos > max)
>     705                 retval = -EOVERFLOW;
>
> (line numbers from 2.6.13.)
>
> So there must be something else at work.  Perhaps your patches?
>
> On Tue, Oct 11, 2005 at 04:53:47PM +0200, Jiri Slaby wrote:
> > I don't know the code surrounding this, but shouldn't be this
> > (!ppos || *ppos > max)?
>
> That would be wrong, too; if it were valid to call in with ppos==0, you
> wouldn't want to return EOVERFLOW; and if ppos==0 were not valid and you
> wanted to return an error, EOVERFLOW would be the wrong error to return.
>
> -andy
>

OK so I must have a broken kernel tree then. The lines you mention in
my version belong to vfs_sendfile function which indeed ensures ppos
is a valid pointer but do_sendfile is called from sys_sendfile(64).
I'll find the patch that did the change (some must have, obviously)
and report it there (probably linux-vserver is to blame)

This section of the file in vanilla 2.6.13.4 looks nothing like in my
file and the 2.6.13.3 and 2.6.13.4 patches have no changes there so at
least that's cleared up.

Regards,
 Greg
