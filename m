Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316529AbSEUGW3>; Tue, 21 May 2002 02:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316531AbSEUGW1>; Tue, 21 May 2002 02:22:27 -0400
Received: from panda.sul.com.br ([200.219.150.4]:56324 "EHLO ns.sul.com.br")
	by vger.kernel.org with ESMTP id <S316529AbSEUGWW>;
	Tue, 21 May 2002 02:22:22 -0400
Date: Tue, 21 May 2002 03:21:18 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>,
        Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: AUDIT: copy_from_user is a deathtrap.
Message-ID: <20020521062118.GA13117@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>,
	Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <mailman.1021642692.12772.linux-kernel2news@redhat.com> <200205191212.g4JCCLY25867@Port.imtp.ilyichevsk.odessa.ua> <20020520112232.A8983@devserv.devel.redhat.com> <200205210555.g4L5tfY29889@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 21, 2002 at 08:57:28AM -0200, Denis Vlasenko escreveu:
> On 20 May 2002 13:22, you wrote:
> > > Can you tell me what's wrong with copy_from_user? How did you used it
> > > wrongly?
> >
> > Denis, I agree with the essense of Rusty's argument, which is that
> > copy_to_user is easy to misuse in the following way:
> >
> > xxx_ioctl (..., cmd, arg) {
> > 	return copy_to_user(....);
> > }
> >
> > Since copy_to_user returns a number of residue bytes instead of
> > -EINVAL, such statement confuses the caller.
> > Rusty found something about 54 instances of this.
> 
> Oh. Do you think a pair of
> 
> copy_to_user_or_EINVAL(...)
> copy_to_user_return_residue(...)
> 
> will help avoid such bugs?
> It is possible to audit kernel once, move it to new functions
> and deprecate/delete old one.

As Linus and others pointed out, copy_{to_from}_user has its uses and will
stay, but something like:

#define copyin(...) (copy_from_user(...) ? -EFAULT : 0)
#define copyout(...) (copy_to_user(...) ? -EFAULT : 0)

Like several drivers already have (with these names or with other names)
would be something interesting, that way we could clean up the ones that
use this construct and all the others that use the longer
'copy_{to,from}_user(...) ? -EFAULT : 0' construct. If the powers that be
accept this, I'd do the work 8)

Is it *BSD that have copyin/copyout with this semantic? If so it'd even
have an extra bonus to make porting a little bit faster... 8)

- Arnaldo
