Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262566AbSJBSon>; Wed, 2 Oct 2002 14:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262568AbSJBSon>; Wed, 2 Oct 2002 14:44:43 -0400
Received: from surf.cadcamlab.org ([156.26.20.182]:35795 "EHLO
	surf.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S262566AbSJBSom>; Wed, 2 Oct 2002 14:44:42 -0400
Date: Wed, 2 Oct 2002 13:49:11 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: a problem report
Message-ID: <20021002184911.GG1536@cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Refernces: <20021002144929.C1369@mars.ravnborg.org>
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Sam Ravnborg]
> --- linux/sound/Config.in 2002-10-01 12:09:44.000000000 +0200
> +++ linux/sound/Config.in 2002-10-01 12:21:05.000000000 +0200
> @@ -31,10 +31,7 @@
>  if [ "$CONFIG_SND" != "n" -a "$CONFIG_ARM" = "y" ]; then
>    source sound/arm/Config.in
>  fi
> -if [ "$CONFIG_SND" != "n" -a "$CONFIG_SPARC32" = "y" ]; then
> -  source sound/sparc/Config.in
> -fi
> -if [ "$CONFIG_SND" != "n" -a "$CONFIG_SPARC64" = "y" ]; then
> +if [ "$CONFIG_SND" != "n" -a "$CONFIG_SPARC32" = "y" ] || [ "$CONFIG_SND" != "n" -a "$CONFIG_SPARC64" = "y" ] ; then
>    source sound/sparc/Config.in
>  fi

That's not right.  You can't use '||' in config language.  (Try it
with xconfig some time.)  You have to either nest if statements or
make use of precedence.  Documentation/kbuild/config-language.txt
doesn't actually specify the precedence, but in the Unix test(1) from
which it is derived, AND binds tighter than OR.  Thus:

  if [ "$CONFIG_SND" != "n" ]; then
     if [ "$CONFIG_SPARC32" = "y" -o "$CONFIG_SPARC64" = "y" ]; then
        source sound/sparc/Config.in
     fi
  fi

-- or --

  if [ "$CONFIG_SND" != "n" -a "$CONFIG_SPARC32" = "y" -o \
       "$CONFIG_SND" != "n" -a "$CONFIG_SPARC64" = "y" ]; then
     source sound/sparc/Config.in
  fi

This 'if' statement syntax has *got* to go.  I posted an incomplete
replacement syntax some time ago, but abandoned it because it appeared
Roman was almost ready to merge his new config stuff....

Peter
