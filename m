Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130820AbRCJBoA>; Fri, 9 Mar 2001 20:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130824AbRCJBnu>; Fri, 9 Mar 2001 20:43:50 -0500
Received: from monster.Stanford.EDU ([171.64.38.79]:53009 "EHLO
	monster.stanford.edu") by vger.kernel.org with ESMTP
	id <S130799AbRCJBni>; Fri, 9 Mar 2001 20:43:38 -0500
Date: Fri, 9 Mar 2001 17:42:45 -0800
From: Peter Blomgren <blomgren@monster.Stanford.EDU>
To: Nathan Dabney <smurf@osdlab.org>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, greg@ulima.unil.ch
Subject: Re: [PATCH] aicasm db3 fiasco
Message-ID: <20010309174245.A13762@monster.Stanford.EDU>
Reply-To: blomgren@math.Stanford.EDU
In-Reply-To: <20010309160145.H30901@osdlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010309160145.H30901@osdlab.org>; from smurf@osdlab.org on Fri, Mar 09, 2001 at 04:01:45PM -0800
Organization: High Latency R Us
X-OS: Linux 2.2.17-1smp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While we're at it, on my RH6.2 system db_185.h is in /usr/include,
i.e.

bash$ echo "`locate db_185.h` ($(rpm -qf `locate db_185.h`))"
/usr/include/db_185.h (glibc-devel-2.1.3-22)

FWIW, for my builds I've been using the following patch (hey, it works
for me):

--- linux/drivers/scsi/aic7xxx/aicasm/aicasm_symbol.c.orig      Thu Mar  8 17:09:00 2001
+++ linux/drivers/scsi/aic7xxx/aicasm/aicasm_symbol.c   Thu Mar  8 17:09:14 2001
@@ -36,7 +36,7 @@
 #include <sys/types.h>
 
 #ifdef __linux__
-#include <db/db_185.h>
+#include <db_185.h>
 #else
 #include <db.h>
 #endif

Maybe .../aic7xxx/aicasm/Makefile should do something like:

if [ ! -z `find /usr/include -name db_185.h` ]; then
   echo "#include <`find /usr/include -name db_185.h | sed \
   's+/usr/include/++g'`>" > aicdb.h
else
   echo "*** Install db development libraries ***";
   exit 1
fi

But what do I know? :-}


On Fri, Mar 09, 2001 at 04:01:45PM -0800, Nathan Dabney wrote:
> Debian does not use db3 at all, yet.
> 
> Applies against 2.4.2-ac17
> 
> -Nathan
> 
> diff -urN linux.orig/drivers/scsi/aic7xxx/aicasm/Makefile linux/drivers/scsi/aic7xxx/aicasm/Makefile
> --- linux.orig/drivers/scsi/aic7xxx/aicasm/Makefile	Fri Mar  9 15:38:13 2001
> +++ linux/drivers/scsi/aic7xxx/aicasm/Makefile	Fri Mar  9 15:52:27 2001
> @@ -28,10 +28,12 @@
>  aicdb.h:
>  	if [ -e "/usr/include/db3/db_185.h" ]; then		\
>  		echo "#include <db3/db_185.h>" > aicdb.h;	\
> +	elif [ -e "/usr/include/db2/db_185.h" ]; then		\
> +		echo "#include <db2/db_185.h>" > aicdb.h;	\
>  	elif [ -e "/usr/include/db/db_185.h" ]; then		\
>  		echo "#include <db/db_185.h>" >aicdb.h	;	\
>  	else							\
> -		echo "*** Install db3 development libraries";	\
> +		echo "*** Install db development libraries";	\
>  	fi
>  
>  clean:
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
\Peter.

