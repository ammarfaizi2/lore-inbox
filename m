Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbUFVIeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbUFVIeI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 04:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbUFVIeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 04:34:08 -0400
Received: from cantor.suse.de ([195.135.220.2]:64398 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261347AbUFVIeB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 04:34:01 -0400
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SUSE Labs
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 0/2] kbuild updates
Date: Tue, 22 Jun 2004 10:36:10 +0200
User-Agent: KMail/1.6.2
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
References: <539000871@toto.iv> <16599.36319.269156.432040@wombat.chubb.wattle.id.au> <20040622052037.GA2722@mars.ravnborg.org>
In-Reply-To: <20040622052037.GA2722@mars.ravnborg.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_69+1A1uC3Lmd0l8"
Message-Id: <200406221036.10062.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_69+1A1uC3Lmd0l8
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 22 June 2004 07:20, Sam Ravnborg wrote:
> On Tue, Jun 22, 2004 at 11:39:43AM +1000, Peter Chubb wrote:
> > But can the include2/asm symlink be made a relative one, please?  I
> > frequently build on one machine, then NFS-mount the build tree and run
> > make modules_install somewhere else; I always at present have to convert
> > that link to a relative symlink before doing so.
>
> Patch is welcome. I recall having trouble with it when introducing it. But
> that can have been caused by other issues.

The same issue exists with the KERNELSRC and KERNELOUTPUT paths in 
$(objtree)/Makefile: they would also better be relative to each other. In our 
case we have something like:

	KERNELSRC    := /usr/src/linux-2.6.5-7.79
	KERNELOUTPUT := /usr/src/linux-2.6.5-7.79-obj/i386/default

this would become:

	KERNELSRC    := ../../../linux-2.6.5-7.79
	KERNELOUTPUT := ../linux-2.6.5-7.79-obj/i386/default

I am currently regenerating $(objtree)/Makefile by hand by invoking mkmakefile 
with the appropriate parameters. The attached script could be used to 
automate this; it would work equally well for the asm symlink.

Regards,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX AG

--Boundary-00=_69+1A1uC3Lmd0l8
Content-Type: application/x-shellscript;
  name="relpath"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="relpath"

#! /bin/sh
# Generate a relative path between two absolute paths

# Usage
# $1 - Base path to start from
# $2 - Target path

source=${1#/}
target=${2#/}

first() {
	local IFS=/
	set -- $*
	echo $1
}

rest() {
	local IFS=/
	set -- $*
	shift
	echo "$*"
}

relative_dir() {
	local dir=$1
	if [ -z "$dir" ]; then
		echo .
	else
		echo $dir | sed 's:[^/]\+:..:g'
	fi
}

while [ -n "$(first $source)" -a \
	"$(first $source)" = "$(first $target)" ]; do
	source="$(rest $source)"
	target="$(rest $target)"
done

echo -n $(relative_dir $source)
[ -n "$target" ] && echo -n /
echo $target

--Boundary-00=_69+1A1uC3Lmd0l8--
