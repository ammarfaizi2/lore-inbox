Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136214AbREDLJS>; Fri, 4 May 2001 07:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136189AbREDLJI>; Fri, 4 May 2001 07:09:08 -0400
Received: from smtp01.web.de ([194.45.170.210]:27908 "HELO smtp.web.de")
	by vger.kernel.org with SMTP id <S136139AbREDLIv>;
	Fri, 4 May 2001 07:08:51 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Rene Scharfe <l.s.r@web.de>
Reply-To: l.s.r@web.de
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] strtok -> strsep (The Easy Cases)
Date: Fri, 4 May 2001 13:07:56 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m14vTua-001QLyC@mozart>
In-Reply-To: <m14vTua-001QLyC@mozart>
MIME-Version: 1.0
Message-Id: <01050413055100.00907@golmepha>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag,  4. Mai 2001 02:57 schrieb Rusty Russell:
> In message <01050120580701.01713@golmepha> you write:
> > Hello,

Hi!

> >
> > the patch at the bottom does the bulk job of strtok replacement. It's a
> > very boring patch, containing easy cases, only. It became a bit big, too,
> > but I trust you can digest it nevertheless. It's made against kernel
> > version 2.4.4.
>
> There are two cases where the substitution is problematic:

Yes, but...

The cases which my patch modifies are of a different kind:

	int parse_options(char *options)
	{
		char *p;

		/* for (p = strtok(options, ","); p; p = strtok(NULL, ",")) { */
		while (p = strsep(&options, ",")) {
			/* ... */
		}
		return 0;
	}

No temporary array, no kfree(). Our variable "options" is used for strtsep,
only. Notice btw. how we destoy the string content to which "options"
points with both strtok and strsep.

That said, it's possible I made a stupid mistake, of course. Or two. Do
you agree on the correctness of the code above? If not, forget the whole
thing and I'll try again later.


>
> Array:
> 	char tmparray[500];
> 	strcpy(tmparray, str);
>
> 	/* for (p = strtok(tmparray, "n"); p; p = strtok(NULL, "n")) { */
> 	while ((p = strsep(&tmparray, ","))) {
>
> This is clearly wrong, and invokes a compiler warning.  &tmparray ==
> tmparray (a cute C oddity I've never really liked).  You are blowing
> away the first few characters in tmparray, and your parser won't work
> properly.
>
> Dynamic:
>
> 	char *tmp = strdup(str);
>
> 	/* for (p = strtok(tmp, "n"); p; p = strtok(NULL, "n")) { */
> 	while ((p = strsep(&tmp, ","))) {
> 	...
> 	}
>
> 	kfree(tmp);
>
> Here, tmp has changed in the strsep implementation, and kfree will do
> bad things.
>
> There is a real reason to avoid strtok, and that is SMP and multple
> threads calling it at once (that said, I don't know of a problem yet).
> But this patch is a step backwards.
>
> Rusty.
> --
> Premature optmztion is rt of all evl. --DK


René

