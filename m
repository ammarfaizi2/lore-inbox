Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313563AbSHIOjR>; Fri, 9 Aug 2002 10:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313638AbSHIOjR>; Fri, 9 Aug 2002 10:39:17 -0400
Received: from mail3.alphalink.com.au ([202.161.124.59]:53770 "EHLO
	mail3.alphalink.com.au") by vger.kernel.org with ESMTP
	id <S313563AbSHIOjP>; Fri, 9 Aug 2002 10:39:15 -0400
Message-ID: <3D53D50D.7FA48644@alphalink.com.au>
Date: Sat, 10 Aug 2002 00:43:25 +1000
From: Greg Banks <gnb@alphalink.com.au>
Organization: Corpus Canem Pty Ltd.
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.2.15-4mdkfb i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Samuelson <peter@cadcamlab.org>
CC: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] [patch] config language dep_* enhancements
References: <20020808151432.GD380@cadcamlab.org> <Pine.LNX.4.44.0208081142390.23063-100000@chaos.physics.uiowa.edu> <20020808164742.GA5780@cadcamlab.org> <20020809041543.GA4818@cadcamlab.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

G'day,

I like the basic idea here, and I'm pleased that someone has the courage to
tackle some of the brokenness of the kconfig language (if only because it
will provide me with a precedent when I try to submit some of my patches ;-).

I was a bit worried when I first saw the patch (after all, kconfig is held
together with spit and string) but on careful reading it's mostly doing the
right thing.  Mostly.

Peter Samuelson wrote:
> 
>   [Kai Germaschewski]
> > > As you're hacking Configure anyway, what about "fixing"
> > >
> > >     dep_tristate ' ..' CONFIG_FOO $CONFIG_BAR,
> 
> [I wrote]
> > I've thought about that many times.  I think the cleanest solution is
> > to deprecate the '$' entirely:
> >
> >       dep_tristate ' ..' CONFIG_FOO CONFIG_BAR
> 
> This applies to 2.4.20pre and (except changelog bits) to 2.5.30 with
> offsets.  

You're willing to potentially perturb 2.4?

> I still haven't touched xconfig, because frankly it scares
> me.  The tkparse.c vs Peter match is well underway, stay tuned..

Good luck, it scares me too.

> --- 2.4.20pre1/Documentation/kbuild/config-language.txt 2002-02-25 13:37:51.000000000 -0600
> +++ 2.4.20pre1p/Documentation/kbuild/config-language.txt        2002-08-08 23:10:44.000000000 -0500
> @@ -84,8 +84,17 @@
>      to generate dependencies on individual CONFIG_* symbols instead of
>      making one massive dependency on include/linux/autoconf.h.
> 
> -    A /dep/ is a dependency.  Syntactically, it is a /word/.  At run
> -    time, a /dep/ must evaluate to "y", "m", "n", or "".
> +    A /tristate/ is a single character in the set {"y","m","n"}.
> +
> +    A /dep/ is a dependency.  Syntactically, it is a /word/.  It is
> +    either a /tristate/ or a /symbol/ (with an optional, but
> +    deprecated, prefix "$").  At run time, the /symbol/, if present,
> +    is expanded to produce a /tristate/.  If the /symbol/ has not been
> +    defined, the /tristate/ will be "n".

The last statement is inconsistent with the shell code and the explanations of 
the dep_* statements, which sensibly preserve the current semantics where
an undefined symbol has a distinct fourth value which is not y, m or n.

I'm pleased to see that you have preserved those semantics.  There are many
places in the corpus where a dep_* lists as a dependency a variable which is
not defined until later, or is only defined in some architectures, or is never
defined.  Earlier today I tweaked up gcml2 to detect them and found 260 in
2.5.29.


> +    In addition, the /dep/ may have a prefix "!", which negates the
> +    sense of the /tristate/: "!y" and "!m" reduce to "n", and "!n"
> +    reduces to "y".

Perhaps "negates" isn't quite the right word in four-state logic.

> --- 2.4.20pre1/scripts/Configure        2001-07-02 15:56:40.000000000 -0500
> +++ 2.4.20pre1p/scripts/Configure       2002-08-08 22:31:49.000000000 -0500
> @@ -232,6 +241,28 @@
>  }
> 
>  #
> +# dep_calc reduces a dependency line down to a single char [ymn]
> +#
> +function dep_calc () {
> +       local neg arg
> +       cur_dep=y       # return value
> +       for arg; do
> +         neg=;
> +         case "$arg" in
> +           !*) neg=N; arg=${arg#?} ;;
> +         esac
> +         case "$arg" in
> +           y|m|n) ;;
> +           *) arg=$(eval echo \$$arg) ;;

Don't you want to check at this point that arg starts with CONFIG_?
Also, how about quoting \$$arg  ?

> +         esac
> +         case "$neg$arg" in
> +           m) cur_dep=m ;;
> +           n|Ny|Nm) cur_dep=n; return ;;
> +         esac

When CONFIG_FOO is undefined, !CONFIG_FOO and CONFIG_FOO are both ignored,
which is not consistent with the mention of "!" in the explanations for the
dep_* statements.  Perhaps you need to more carefully define the semantics
of the ! prefix.

Greg.
-- 
the price of civilisation today is a courageous willingness to prevail,
with force, if necessary, against whatever vicious and uncomprehending
enemies try to strike it down.     - Roger Sandall, The Age, 28Sep2001.
