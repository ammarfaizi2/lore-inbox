Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262016AbVGVC1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbVGVC1F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 22:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262018AbVGVC1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 22:27:05 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:6301 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262016AbVGVC1E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 22:27:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=IO5hDthu5c2z5td1WG9KbSY0TjAg4ACbpvNg69K3CI611gzF8Qezr/9Gxu6yxH1SYUOM+J+DoboouaeuxzoVz/ch9FVL2UonpBaWC2YdALzF6wMKkNuItdv/SPGeWDHOR7GH+V6pNglQL4pVhPgddFABXrNFFl+2mBkCNnDlL4c=
Message-ID: <42E0594E.4060305@gmail.com>
Date: Fri, 22 Jul 2005 11:26:22 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050402)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: randy_dunlap <rdunlap@xenotime.net>
CC: lkml <linux-kernel@vger.kernel.org>, njw@osdl.org
Subject: Re: [announce] 'patchview' ver. 003
References: <20050721133058.791773b8.rdunlap@xenotime.net>
In-Reply-To: <20050721133058.791773b8.rdunlap@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

randy_dunlap wrote:
> Hi,
> 
> [version 003]
> 
> 'patchview' merges a patch file and a source tree to a set of
> temporary modified files.  This enables better patch (re)viewing
> and more viewable context.  (hopefully)
> 
> 
> The patchview script is here:
>   http://www.xenotime.net/linux/scripts/patchview
> 
> 
> usage: patchview [-f] patchfile srctree {ver. 003}
>   -f : force tkdiff even if 'patch' has errors
>   -s : single tkdiff even if patchfile contains multiple files
> 
> 
> It uses (requires) lsdiff (from patchutils) and tkdiff.
> 
> patchutils:  http://cyberelk.net/tim/patchutils/
> tkdiff:      http://sourceforge.net/projects/tkdiff/
> 
> ---
> ~Randy
> 
> 
> Changes for ver. 003:
> - handle patch making empty .orig files (for new files)
>   with permission of 000

  Hi, Randy.

  Here's a small modification to make it work with mtkdiff (my hacked 
version of tkdiff which supports multiple files).  mtkdiff+patchview 
tarball is available at the following url.


http://home-tj.org/mtkdiff/files/patchview-mtkdiff.tar.gz


--- patchview.orig	2005-07-22 11:19:26.000000000 +0900
+++ patchview/patchview	2005-07-22 11:21:01.000000000 +0900
@@ -5,7 +5,7 @@
  # uses patchutils (lsdiff) and tkdiff

  PROG=patchview
-VERSION=003
+VERSION=004

  # usage: help message and exit
  function usage()
@@ -40,7 +40,12 @@

  force=0
  single=0
+mtkdiff=0
  VIEWER="tkdiff"
+if [ -x "`which mtkdiff`" ]; then
+	VIEWER="mtkdiff"
+	mtkdiff=1
+fi
  # or maybe "sh -c colordiff" would work

  while [ -n "$1" ]
@@ -117,15 +122,29 @@
  	exit 1
  fi

-for pf in $pfiles ; do
-	$VIEWER $WORKDIR/$pf.orig $WORKDIR/$pf &
-	if [ ${single} -eq 1 ]; then
-		wait # for viewer to exit
-	fi
-done
+if [ $mtkdiff -ne 0 ]; then
+	i=0
+	argv[i++]="-gdesc"
+	argv[i++]=`diffstat $patchfile`
+	for pf in $pfiles ; do
+		argv[i++]="-fname"
+		argv[i++]="$pf"
+		argv[i++]="$WORKDIR/$pf.orig"
+		argv[i++]="$WORKDIR/$pf"
+	done

-if [ ${single} -eq 0 ]; then
-	wait # for all viewers to exit
+	mtkdiff "${argv[@]}"
+else
+	for pf in $pfiles ; do
+		$VIEWER $WORKDIR/$pf.orig $WORKDIR/$pf &
+		if [ ${single} -eq 1 ]; then
+			wait # for viewer to exit
+		fi
+	done
+
+	if [ ${single} -eq 0 ]; then
+		wait # for all viewers to exit
+	fi
  fi

  rm -rf $WORKDIR

