Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965464AbWIRGQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965464AbWIRGQz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 02:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965466AbWIRGQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 02:16:55 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:22441 "EHLO pasmtpA.tele.dk")
	by vger.kernel.org with ESMTP id S965464AbWIRGQy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 02:16:54 -0400
Date: Mon, 18 Sep 2006 08:21:52 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-arch@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 1/8] extend make headers_check to detect more problems
Message-ID: <20060918062152.GA7088@uranus.ravnborg.org>
References: <20060918012740.407846000@klappe.arndb.de> <20060918013216.335200000@klappe.arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060918013216.335200000@klappe.arndb.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- linux-cg.orig/scripts/hdrcheck.sh	2006-09-18 02:04:44.000000000 +0200
> +++ linux-cg/scripts/hdrcheck.sh	2006-09-18 02:04:45.000000000 +0200
> @@ -1,8 +1,28 @@
>  #!/bin/sh
>  
> +# check if all included files exist
>  for FILE in `grep '^[ \t]*#[ \t]*include[ \t]*<' $2 | cut -f2 -d\< | cut -f1 -d\> | egrep ^linux\|^asm` ; do
>      if [ ! -r $1/$FILE ]; then
>  	echo $2 requires $FILE, which does not exist in exported headers
>  	exit 1
>      fi
>  done
> +
> +# try to compile in order to see CC warnings, show only the first few
> +CHECK_CFLAGS=`grep @headercheck: $2 | sed -e 's/^.*@headercheck:\([^@]*\)@.*$/\1/'`

The purpose of @headercheck: should be documented sonewhere.
A simple way to do so would be to paste the content of the changelog that
describe it in the top of this file.

> +CFLAGS="-Wall -std=gnu99 -xc -O2 -I$1 ${CHECK_CFLAGS}"
> +tmpfile=`mktemp`
Can't we do this with a hdrchk$$$ filename to avoid using
random entropy for each compile?

> +${CC:-gcc} ${CFLAGS} -c $2 -o $tmpfile 2>&1 | sed -e "s:$1:include:g" >&2
> +
> +# check if object file is empty
> +if [ "`nm $tmpfile`" ] ; then
Replace nm with {NM:-nm} to obtain correct NM when cross compiling.

> +    echo include${2#$1}: warning: non-empty output >&2
Paste output of nm so one can see what is defined?

	Sam
