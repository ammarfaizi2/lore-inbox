Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161262AbWBUBs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161262AbWBUBs0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 20:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161269AbWBUBs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 20:48:26 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:26088 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1161262AbWBUBsZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 20:48:25 -0500
Date: Tue, 21 Feb 2006 02:48:24 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: [RFC] duplicate #include check for build system
Message-ID: <20060221014824.GA19998@MAIL.13thfloor.at>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Sam! Folks!

recently had the idea to utilize cpp or sparse to
do some automated #include checking, and I came up
with the following proof of concept:

I just replaced the sparse binary by the following
script (basically hijacking the make C=1 system)

it would allow kernel developers to easily identify
duplicate includes, which in turn, might reduce
dependancies and thus build time ...


----------------
#!/bin/bash

while [ $# -gt 1 ]; do
  case $1 in
        -D*) DEF="$DEF $1";;
        -W*) ;;
          *) OPT="$OPT $1";;
  esac
  shift
done

# ( $CPP $DEF -H -dI $OPT $1 1>&2 ) 2>&1 | grep "^[#.]"
$CPP $DEF -H  $OPT $1 2>&1 >/dev/null | gawk -vFILE="$1" '

BEGIN	{ I[0]=FILE; }

/^[.]+/ { D=length($1);

	  for (i=0; i<D; i++)
    	    C[i,$2]++; 
	    
	  I[D]=$2;

	  for (i=0; i<D; i++)
	    M[i,$2]=I[i];

	  if (C[D-1,$2]>1) {
	    printf "··· %s in %s ",$2,I[D-1];

	    for (i=D; M[i,$2]; i++) 
	      printf "%c%s", (i==D)?"[":"·", M[i,$2];

	    printf (i>D) ? "]\n" :
	    	((X[D,$2]==I[D-1]) ? "(dup)\n" : "\n");
	  }

          X[D,$2]=I[D-1];
        }
' 1>&2

true
----------------

of course, most of it would not be required if
there was support in the kernel build system,
and, if there is any preference for perl over
bash/gawk it could be easily rewritten ...

please let me know what you think of this and if
you could imagine adding something similar to the
build system 

TIA,
Herbert

