Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932420AbWAWK1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbWAWK1h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 05:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932446AbWAWK1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 05:27:37 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:13618 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932420AbWAWK1g convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 05:27:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d0ylmR4qK409aV5HXQ4382PiN1QUqlQTAn7uWxxLNgwYqzDWmxy3E89TrmduiIxhFx1ZXYbTvr4PtGOa8uBN39r3fr10foaMlwPaKJ0dhxZNq3EP69BUW/8bdQSVf7wVFkJ6t14d/YBhHA1Z4ewvjdwEm4bwtdGUo8EoXZAom8s=
Message-ID: <787b0d920601230220r5c7df60dk142d1d637ab4ed48@mail.gmail.com>
Date: Mon, 23 Jan 2006 05:20:18 -0500
From: Albert Cahalan <acahalan@gmail.com>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH 4/4] pmap: reduced permissions
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>, Al Viro <viro@ftp.linux.org.uk>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <1138009305.2977.28.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200601222219.k0MMJ3Qg209555@saturn.cs.uml.edu>
	 <1137996654.2977.0.camel@laptopd505.fenrus.org>
	 <787b0d920601230128o5a12513fjae3708e3fb552dca@mail.gmail.com>
	 <1138009305.2977.28.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/06, Arjan van de Ven <arjan@infradead.org> wrote:
> On Mon, 2006-01-23 at 04:28 -0500, Albert Cahalan wrote:

> > I tend to think that glibc should not be reading this file.
> > What excuse is there?
>
> glibc needs to be able to find out if a certain address is writable. (eg
> mapped "w"). The only way available for that is... reading the maps
> file.

What the heck for? That's gross.

If glibc is just providing this info for apps, there should be a
system call for it. Otherwise, being the C library, glibc can
damn well remember what it did.

> > In any case, the many existing statically linked executables
> > do cause trouble. Setuid apps are the ones you'd most want
> > to protect.
>
> for this 0400 isn't enough;

because you might fool the app into reading it

> because you can open this file, send the fd
> over a unix socket, and then exec. The process you sent the fd to can
> then read the setuid's program maps file.

You exec what, the setuid executable? For other reasons,
that needs to sever all file descriptors to the /proc files.
They should be returning EBADF for all operations.

Oh dear. I think I see why /proc/*/mem reads are far too
restricted. The file descripters are NOT getting severed???
Hmmm, I'm not finding code to sever them.

Well, that's part of a general problem then, including lack
of the revoke() system call that BSD introduced. This hits
hard with device files. Memory mappings get interesting,
though /dev/zero might make a nice substitute mapping.
