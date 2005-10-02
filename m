Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751026AbVJBIr2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbVJBIr2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 04:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbVJBIr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 04:47:28 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:54929 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751020AbVJBIr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 04:47:27 -0400
From: Junio C Hamano <junkio@cox.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
Subject: Re: [howto] Kernel hacker's guide to git, updated
References: <433BC9E9.6050907@pobox.com> <20050929200252.GA31516@redhat.com>
	<433C4B6D.6030701@pobox.com> <7virwjegb5.fsf@assigned-by-dhcp.cox.net>
	<433D1E5D.20303@pobox.com> <7v64si4von.fsf@assigned-by-dhcp.cox.net>
	<433D477A.4010009@pobox.com>
Date: Sun, 02 Oct 2005 01:47:24 -0700
Message-ID: <7vr7b41f1f.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> writes:

> Junio C Hamano wrote:
>> Jeff Garzik <jgarzik@pobox.com> writes:

>>> 2) What is the easiest way to obtain a list of changes present in
>>> repository B, that are not present in repository A?  I used to use
>>> git-changes-script [hacked cg-log script] for this:

I haven't really *read* that script, but I think it is trying to
make a list of commits from both repositories and trying to find
the set that are in one side and not in the other using diff (a
real shell programer probably would have used "comm" for this
kind of task, not "diff"), then doing a handcrafted git-log on
each of them.

Attached is my quick hack, based on your original question,
without really trying to understand what the script is doing, so
I cannot claim it is a rewrite nor even attempting to be
compatible.  Please take a look at it and tell me if this is
any close to what you need.

I have a suspition that this might be better done as a natural
extension of git-log, though.

------------
#!/bin/sh
#
# Copyright (c) 2005 Junio C Hamano
#

. git-sh-setup || die "Not a git archive"

usage () {
	echo >&2 "$0 ( -L | -R ) <dir> [<ref>] [<ref>]

-L shows changes in local not in remote.
-R shows changes in remote not in local.
<dir> names the remote repository.

If given no refs, local and remote HEADs are compared.
If given one ref, local HEAD and named remote ref are compared.
If given two refs, the first names a local ref, and the second names
remote ref to be compared.
"
	exit 1
}

case "$1" in
-L | -R)
	;;
*)
	usage ;;
esac

other="$2"

(
	unset GIT_DIR GIT_OBJECT_DIRECTORY
	cd "$other" && . git-sh-setup ||
	die "$other is not a valid git repository."
)

local=${3:-HEAD}
remote=${4:-HEAD}

# Basic validation.
local=$(git-rev-parse --verify "$local^0" 2>/dev/null) ||
die "local ref $local is not valid."
remote=$(GIT_DIR="$other" git-rev-parse --verify "$remote^0" 2>/dev/null) ||
die "remote ref $remote is not valid."

case "$1" in
-L)
	list_args="$local ^$remote" ;;
-R)
	list_args="^$local $remote" ;;
esac

GAOD="$GIT_ALTERNATE_OBJECT_DIRECTORIES"

GIT_ALTERNATE_OBJECT_DIRECTORIES="$other/.git/objects:$GAOD" \
git-rev-list --pretty $list_args |
LESS=-S ${PAGER:-less}

