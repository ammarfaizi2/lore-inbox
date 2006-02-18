Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751272AbWBROz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbWBROz1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 09:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbWBROz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 09:55:27 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:36289 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1751272AbWBROz0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 09:55:26 -0500
Date: Sat, 18 Feb 2006 15:55:25 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Bastian Blank <bastian@waldi.eu.org>,
       Arthur Othieno <apgo@patchbomb.org>, Jean Delvare <khali@linux-fr.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [PATCH/RFC] remove duplicate #includes, take II
Message-ID: <20060218145525.GA32618@MAIL.13thfloor.at>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>,
	Bastian Blank <bastian@waldi.eu.org>,
	Arthur Othieno <apgo@patchbomb.org>,
	Jean Delvare <khali@linux-fr.org>,
	Russell King <rmk+lkml@arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew! Folks!

after the response to the first (cruel?) approach
here is a different one (probably as incomplete
and imperfect as the previous, but it seems that
there is a solution in reach)

this time I utilized the checkincludes.pl script
to identify and automatically remove duplicates. 
this was done with the following command sequence:

find . -type f -name '*.[hcS]' \
	-exec scripts/checkincludes.pl {} \; \
	| gawk -F"[: ]" '
	  { printf "egrep -nH \"#\\W*include\\W*<%s>\" %s\n",$3,$1 }' \
	| sh \
	| gawk -F: '{ X[$1]=$2; } 
          END { for (i in X) printf "%s %d\n",i, X[i] }' \
	| gawk '{ printf "mv %s %s.orig && sed -ne \"%dd;p\" %s.orig >%s && echo %s\n",$1,$1,$2,$1,$1,$1; }' \
	| sh

which basically executes checkincludes.pl on all
.c, .h and .S files, then greps for '<'*'>' type
includes (to avoid the "*" type ones, which are
usually local includes) and then removes the last
occurence of the identified include from the file

I then splitted it into three categories:

 A) probably correct
 B) probably wrong
 C) definitely wrong 

so if folks want to cherry pick and/or comment on
the first two categories, please do so, I will
collect all the feedback and produce a patch to
get rid of the duplicates later ...

best,
Herbert

