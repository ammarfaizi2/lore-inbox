Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317400AbSHCBNx>; Fri, 2 Aug 2002 21:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317405AbSHCBNx>; Fri, 2 Aug 2002 21:13:53 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:52928 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S317400AbSHCBNw>; Fri, 2 Aug 2002 21:13:52 -0400
Date: Fri, 2 Aug 2002 20:17:17 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Sam Ravnborg <sam@ravnborg.org>
cc: Roman Zippel <zippel@linux-m68k.org>, <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] automatic module_init ordering
In-Reply-To: <20020802232232.A25583@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.44.0208022011490.24984-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Aug 2002, Sam Ravnborg wrote:

	> On Thu, Aug 01, 2002 at 10:19:04PM -0500, Kai Germaschewski wrote:
> > and the like, since otherwise my shell (bash) would complain about an
> > empty "for o in ; do". Maybe there's a less hacky way to handle that? 
> Found what I consider less hacky way to handle it.
> Test for non-empty string before executing the for loop.

Yeah. Still not exactly clean. Another suggestion I got was

+     objs="$(sort $(local-objs-y))"; for o in $$objs; do \

from Alex Riesen. This one looks the nicest to me.

> diff -Nru a/scripts/build-initcalls b/scripts/build-initcalls
> --- a/scripts/build-initcalls	Fri Aug  2 23:15:54 2002
> +++ b/scripts/build-initcalls	Fri Aug  2 23:15:54 2002
> @@ -7,7 +7,10 @@
>  
>  # get all global defined/undefined symbols and sort them into the right files
>  while read obj; do
> -  $NM $obj | sed -n "s,^[0-9a-f ]*\([UTD] .*\),\1 $(echo $obj | sed s/,/\\\\,/),p"
> +  if [ -f $obj ]; then
> +    $NM $obj |\
> +      sed -n "s,^[0-9a-f ]*\([UTD] .*\),\1 $(echo $obj | sed s/,/\\\\,/),p"
> +  fi
>  done < $list |
>  awk '/^U/ { print $2 " " $3 | "sort -u > .undefined.tmp" }
>       /^[TD]/ { print $2 " " $3 | "sort -u > .defined.tmp" }'

I think these should really not be necessary (didn't try, though). I would 
really hope that the body won't get executed when the file is empty, and 
I'd rather have it error out when one of the listed files magically 
disappeared instead of silently skipping some initcalls ;)

>  # finally write it
> -echo "#include <linux/init.h>" > $initsrc
> -echo $defs >> $initsrc
> -echo 'initcall_t generated_initcalls[] = {' >> $initsrc
> -echo $arr >> $initsrc
> -echo '0 };' >> $initsrc
> +(
> +echo "#include <linux/init.h>"
> +for i in $arr; do
> +  echo "extern int $i(void);"
> +done
> +echo
> +echo 'initcall_t generated_initcalls[] = {'
> +for i in $arr; do
> +  echo "$i, "
> +done
> +echo '0 };'
> +) > $initsrc

Looks good to me...

>  # clean up
> -rm .undefined.tmp .defined.tmp .sorted.tmp .other.tmp
> +#rm .undefined.tmp .defined.tmp .sorted.tmp .other.tmp

I guess you meant to remove that part before making the patch ;)

--Kai



