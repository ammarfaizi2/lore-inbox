Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932570AbVJGNi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932570AbVJGNi0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 09:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932569AbVJGNi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 09:38:26 -0400
Received: from pat.uio.no ([129.240.130.16]:38370 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932532AbVJGNiZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 09:38:25 -0400
Subject: Re: [RFC] atomic create+open
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <E1ENlI2-0004Gt-00@dorka.pomaz.szeredi.hu>
References: <E1ENWt1-000363-00@dorka.pomaz.szeredi.hu>
	 <1128616864.8396.32.camel@lade.trondhjem.org>
	 <E1ENZ8u-0003JS-00@dorka.pomaz.szeredi.hu>
	 <E1ENZCQ-0003K3-00@dorka.pomaz.szeredi.hu>
	 <1128619526.16534.8.camel@lade.trondhjem.org>
	 <E1ENZZl-0003OO-00@dorka.pomaz.szeredi.hu>
	 <1128620528.16534.26.camel@lade.trondhjem.org>
	 <E1ENZu1-0003SP-00@dorka.pomaz.szeredi.hu>
	 <1128623899.31797.14.camel@lade.trondhjem.org>
	 <E1ENani-0003c4-00@dorka.pomaz.szeredi.hu>
	 <1128626258.31797.34.camel@lade.trondhjem.org>
	 <E1ENcAr-0003jz-00@dorka.pomaz.szeredi.hu>
	 <1128633138.31797.52.camel@lade.trondhjem.org>
	 <E1ENlI2-0004Gt-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Date: Fri, 07 Oct 2005 09:38:09 -0400
Message-Id: <1128692289.8519.75.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.707, required 12,
	autolearn=disabled, AWL 2.11, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fr den 07.10.2005 Klokka 08:01 (+0200) skreiv Miklos Szeredi:
> > > I just think that filesystem code should _never_ need to care about
> > > mounts.  If you want to do the lookup+open, you somehow will have to
> > > deal with mounts, which is ugly.
> > 
> > You appear to think that atomic lookup+open is a question of choice. It
> > is not.
> 
> Atomic lookup+open is an optimization, and as such a question of
> choice.  Atomic create+open is not.

Really? Under NFSv4, the one and only OPEN command does an atomic lookup
+open, It _has to_ in order to deal with all the races.

Once that is the case, then separating lookup and open into two
operations means that you need to worry about namespace changes on the
server too (since OPEN takes a name argument rather than a filehandle).
If you end up opening a different file to the one you looked up, things
can get very interesting.

> I know you are thinking of the non-exclusive create case when between
> the lookup and the open the file is removed or transmuted on the
> server..

> Yes, it's tricky to sovle, but by no means impossible without atomic
> lookup+open.  E.g. consider this pseudo-code (only the atomic
> open+create case) in open_namei():

Firstly, that pseudo-code doesn't deal at all with the race you describe
above. It only deals with lookup + file creation.

Secondly, it also fails to deal with the issue of propagation of open
context.
If you open a file, then that creates open context/state on the server.
Most protocols will then have some way of tracking that state using an
identifier (the equivalent of the POSIX open file descriptor). I see
absolutely nothing in your proposal that will allow me to save the state
identifier that results from atomic open+create and then propagate it to
the struct file.

Without that stateid/descriptor, it becomes impossible to actually READ,
WRITE, lock/unlock the file or even to CLOSE it when done.

This is why I added the struct file to the intent code in the first
place.

Trond

